Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVACBSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVACBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 20:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVACBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 20:18:16 -0500
Received: from [83.132.194.216] ([83.132.194.216]:41402 "EHLO pad")
	by vger.kernel.org with ESMTP id S261377AbVACBRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 20:17:52 -0500
Subject: Suspend/resume to disk problem
From: Francisco Martins <fmartins@di.fc.ul.pt>
To: linux-kernel@vger.kernel.org
Cc: Francisco Martins <fmartins@di.fc.ul.pt>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 01:20:28 +0000
Message-Id: <1104715228.8402.34.camel@pad.di.fc.ul.pt>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm using Debian GNU/linux 3.1 with kernel 2.6.10 on my IBM Thinkpad
R40, and I'm experiencing a strange problem with suspend to disk.

If I configure the kernel options 
#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda5",

issuing 

echo platform > /sys/kernel/disk
echo disk > /sys/kernel/state

always results in error:
swsusp: FATAL: cannot find swap device, try swapon -a!


My swap partition was on, as can be confirmed by

(output from free)
             total       used       free     shared    buffers    cached
Mem:        515836     469716      46120          0      35588    220672
-/+ buffers/cache:     213456     302380
Swap:       763520          0     763520


(cat /proc/swaps)
Filename                                Type            Size    Used
Priority
/dev/hda5                               partition       763520  0
-1

So, after searching with no luck for help in google, I looked at in the
source code for kernel/power/swsusp.c

The problem seems to be in function "is_resume_device"

static int is_resume_device(const struct swap_info_struct *swap_info)
...
        return S_ISBLK(inode->i_mode) &&
              resume_device == MKDEV(imajor(inode), iminor(inode));
}

The resume_device variable is not initialised at this stage and
has the value zero, which is different from MKDEV(...)

Can you please check this out?

I was able to suspend to disk by setting CONFIG_PM_STD_PARTITION="", but
I cannot resume. 
Again, resume_device is set to 0 in function swsusp_read after
      resume_device = name_to_dev_t(resume_file);
and therefore, it is not possible to open the swap device and
      resume_bdev = open_by_devnum(resume_device, FMODE_READ);
returns an error, aborting the resume process.

I check that resume_file is correctly set to "/dev/hda5" by
the resume_setup function form disk.c


Thanks for you attention,

Cheers,

Francisco


