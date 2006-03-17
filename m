Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWCQFXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWCQFXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 00:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWCQFXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 00:23:43 -0500
Received: from rtr.ca ([64.26.128.89]:41678 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751024AbWCQFXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 00:23:43 -0500
Message-ID: <441A47DB.9000001@rtr.ca>
Date: Fri, 17 Mar 2006 00:23:39 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc6:  swsusp cannot find swap partition
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060315103711.GA31317@suse.de> <20060315175948.GB2423@ucw.cz> <200603162133.26771.kernel@kolivas.org> <20060316104630.GA9399@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060316104630.GA9399@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------080704030901040503050602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704030901040503050602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel,

I have two nearly identical Kubuntu-5.10 notebooks here,
both of which work perfectly with suspend-to-RAM and
just about everything else.

Both of them also did swsusp until today.
Now one of them fails, but the other still works.
The one that failed was just upgraded from a 2.6.12-based kernel
to the stock 2.6.16-rc6-git7, same kernel as the one that works.

I instrumented the swsusp code to try and see why it fails,
and here (attached) is the result.  It's skipping over the swap
partition for some reason.

Why?

Cheers

--------------080704030901040503050602
Content-Type: text/x-log;
 name="swsusp.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp.log"


$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$ fdisk -l
Disk /dev/sda: 100.0 GB, 100030242816 bytes
255 heads, 63 sectors/track, 12161 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1        2432    19535008+   c  W95 FAT32 (LBA)
/dev/sda2            2433        2675     1951897+  82  Linux swap / Solaris
/dev/sda3            2676       12161    76196295   83  Linux

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$ free
             total       used       free     shared    buffers     cached
Mem:       2074508     223948    1850560          0      12168     118144
-/+ buffers/cache:      93636    1980872
Swap:      1951888          0    1951888

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$ patched swsusp_swap_check() function:
static int swsusp_swap_check(void) /* This is called before saving image */
{
	int i;

	spin_lock(&swap_lock);
	for (i = 0; i < MAX_SWAPFILES; i++) {
  printk("swsusp_swap_check(): test%d.1: SWP_WRITE_OK=%d\n", i, !!(swap_info[i].flags & SWP_WRITEOK));
		if (!(swap_info[i].flags & SWP_WRITEOK))
			continue;
  printk("swsusp_swap_check(): test%d.2: swsup_resume_device=%d\n", i, swsusp_resume_device);
		if (!swsusp_resume_device) {
			spin_unlock(&swap_lock);
			root_swap = i;
			return 0;
		}
  printk("swsusp_swap_check(): test%d.3: is_resume_device=%d\n", i, is_resume_device(swap_info + i));
		if (!swsusp_resume_device || is_resume_device(swap_info + i)) {
			spin_unlock(&swap_lock);
			root_swap = i;
			return 0;
		}
	}
	spin_unlock(&swap_lock);
	return -ENODEV;
}

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$ extract from /var/log/messages, after failed hibernate:

Mar 16 23:49:56 localhost kernel: ata2: dev 0 configured for UDMA/33
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test0.1: SWP_WRITE_OK=1
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test0.2: swsup_resume_device=8388614
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test0.3: is_resume_device=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test1.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test2.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test3.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test4.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test5.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test6.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test7.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test8.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test9.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test10.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test11.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test12.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test13.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test14.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test15.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test16.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test17.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test18.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test19.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test20.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test21.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test22.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test23.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test24.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test25.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test26.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test27.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test28.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test29.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test30.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp_swap_check(): test31.1: SWP_WRITE_OK=0
Mar 16 23:49:56 localhost kernel: swsusp: Cannot find swap device, try swapon -a.
Mar 16 23:49:56 localhost kernel: Restarting tasks... done


--------------080704030901040503050602--
