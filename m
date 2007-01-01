Return-Path: <linux-kernel-owner+w=401wt.eu-S1753712AbXAATor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbXAATor (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754094AbXAAToq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:44:46 -0500
Received: from mx5.mail.ru ([194.67.23.25]:5341 "EHLO mx5.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712AbXAAToq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:44:46 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20 regression: suspend to disk no more works
Date: Mon, 1 Jan 2007 22:44:42 +0300
User-Agent: KMail/1.9.5
Cc: linux-pm@osdl.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701012244.42781.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

In *the same* configuration STD now fails with "Cannot find swap device". The 
reason is changes in kernel/power/swap.c. In 2.6.19 it did not require valid 
swsusp_resume_device at all - it took first available swap device and saved 
image. Later during resume swsusp_resume_device was set either by command 
line or sysfs and everything worked nicely.

Now swsusp_swap_check() unfortunately checks for swsusp_resume_device at 
*suspend* time:

        res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
        if (res < 0)
                return res;

        root_swap = res;
        resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_WRITE);
        if (IS_ERR(resume_bdev))
                return PTR_ERR(resume_bdev);

but in case of modular driver for swap device this is likely to be undefined. 
This is as of 2.6.20-rc3.

I already have seen these reports. While 'echo a:b > /sys/power/resume' before 
suspend is a workaround, this still breaks perfectly valid setup that worked 
before. Also 'echo a:b > /sys/power/resume' is actually wrong - we are not 
going to resume at this point; but there is no way to just tell kernel "use 
this device for next STD" ... also the error message is misleading, it should 
complaint "no resume device found". Swap is there all right.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFmWSqR6LMutpd94wRAu61AJ9mdbF4W6RNQ848PU0e4n/3MKtNnwCgzwOh
HkZ9e8lHPMH1tRNzCw/2O58=
=HlW4
-----END PGP SIGNATURE-----
