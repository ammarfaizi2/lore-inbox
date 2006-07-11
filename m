Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWGKPU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWGKPU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWGKPU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:20:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:6592 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751283AbWGKPUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:20:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=VGgkLtA+1JLSxd9Eaoi/TeAlYgo999WQO+RHtMhNyJKNoYuM3lucAt3xANatplbpMxlPdYE/Y2MHiINbV2v5vSZqMFdYSKGO+TD8neu3+N/XeBVAMIbAotEPqAigJdvDahkT5TMGUYscL21Anud0FL1j/tB6kkUD2qRGqsP+YVU=
Message-ID: <44B3C1BE.4080707@gmail.com>
Date: Tue, 11 Jul 2006 09:20:30 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 00/02 ] scx200_gpio: use 1 cdev for N minors, not  N
 for N
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this pair of patches switches the driver to share 1 cdev across N pins,
thus decreasing memory usage, and simplifying code ( no kzalloc, or its 
undo ).

Q:  For some reason I havent figured, the cdev_put below breaks:

static void __exit scx200_gpio_cleanup(void)
{
    cdev_del(&scx200_gpio_cdev);
    cdev_put(&scx200_gpio_cdev);    <<<<<<<<  HERE
   
    unregister_chrdev_region(MKDEV(major, 0), MAX_PINS);
    platform_device_unregister(pdev);
}

  CC [M]  drivers/char/scx200_gpio.o
Kernel: arch/i386/boot/bzImage is ready  (#6)
  Building modules, stage 2.
  MODPOST
WARNING: "cdev_put" [drivers/char/scx200_gpio.ko] undefined!
  LD [M]  drivers/char/scx200_gpio.ko


It seems odd that it isnt available, esp since cdev_init()
is also used wo errors ( in -mm1 currently ), and its defined in same
source-file: fs/char_dev.c

At any rate, I commented out the call in the 2nd patch and it works.
I left it to mark the question.


thanks
Jim Cromie
