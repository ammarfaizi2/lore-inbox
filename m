Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTGAOLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 10:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTGAOLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 10:11:41 -0400
Received: from ee.oulu.fi ([130.231.61.23]:3729 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S261944AbTGAOL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 10:11:28 -0400
Date: Tue, 1 Jul 2003 17:25:48 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: linux-kernel@vger.kernel.org
Subject: preventing module unload when entering open()?
Message-ID: <Pine.GSO.4.55.0307011716580.19966@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At which times a kernel module can be unloaded if the use count is zero?

Let's say I have a device driver with my_open() function call. Initially,
device is not open, module use count is zero, and the module can be
unloaded. Then user opens the device with open() syscall.

Just after the open() syscall, but before the first line of my_open()
function has been executed, can the module be unloaded?

Linux Device Drivers by Alessandro Rubini, 2nd ed, ch. 3, hints in a source
code comment that MOD_INC_USE_COUNT must be done before the my_open() call
might sleep, implying that when kernel executes the my_open() function, it
will not unload the module even if use count is zero. However, I really
doubt if this is still true especially with SMP.

I'm interested in 2.2 and 2.4 kernels, with or without SMP.

Also note that I can't use the owner=THIS_MODULE thing, because I want to
support older V4L interface which doesn't have it.

I tested 2.2 and 2.4 inserting a long 10 sec sleep in the beginning of
my_open() before doing MOD_INC_USE_COUNT and when it slept tried to rmmod
the module. As expected, 2.2 crashed, for 2.4 rmmod hanged indefinitely and
/proc/modules shows "quickcam 1 (deleted)". So neither works properly if
MOD_INC_USE_COUNT is done _after_ sleeping, but it's difficult to test what
happens _before_ sleeping.
