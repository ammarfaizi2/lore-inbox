Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVBPTDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVBPTDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 14:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVBPTDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 14:03:31 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:45522 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261380AbVBPTDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 14:03:23 -0500
Message-ID: <421398FA.7030906@am.sony.com>
Date: Wed, 16 Feb 2005 11:03:22 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: [TIP] Getting started with reducing bootup time
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you are interested in reducing bootup time for the Linux kernel,
or want to get started in this area, please read the following:

Where to start
--------------
If you are going to put some of the CELF bootup time patches on your
platform, I recommend starting with the printk-times and KFI
patches.  Once you have these measurement tools on your platform,
then it's very helpful to find the delays that are useful to reduce
for your product.  This will probably help your product group, in
the long run, more than some of the individual bootup time patches
available from CELF.

Supporting printk-times and KFI is usually very easy.  It's already
supported on x86.  It should also compile for all other architectures,
but there may be problems using it, depending on the architecture
support.

Providing a good sched-clock()
------------------------------
To use either printk-times or KFI, you basically just have to
provide an arch-specific, high granularity sched_clock() routine.
Several platforms have this already, so you
might already be in luck.  If yours doesn't, it really just boils
down to using some available timer that can be polled quickly, and
that has resolution better than 1 microsecond.  There are examples
lying around in the kernel source for many platforms.  Note that
many platforms have a sched_clock which defaults to jiffy-resolution.
This is NOT adequate for KFI, but may help you find extremely long
delays with printk-times.  Jiffies are usually either 1 millisecond
or 10 milliseconds, depending on the platform.

Since both printk-times and KFI use sched_clock() very early in
the boot sequence, the routine needs to be safe to call (even if
it returns invalid data) at any time and in any context (i.e.
interrupt context).  For the TI OMAP, sched_clock was present,
but hung the machine if called before time_init(). The timer it used
was memory-mapped and thus was unavailable until after the memory
was initialized. I fixed this on my machine by simply returning
0 from sched_clock() until after time_init() was
called (I added a static "is_initialized" variable.)  While this
was crude, and missed the first few milliseconds of data,
it still allowed me to focus on the rest of the bootup sequence.

printk-times and KFI information and patches are available at:

http://tree.celinuxforum.org/CelfPubWiki/InstrumentedPrintk
(printk-times used to be called "instrumented printk")
and
http://tree.celinuxforum.org/CelfPubWiki/KernelFunctionInstrumentation

General resources for reducing bootup time for the Linux kernel
are available at:
http://tree.celinuxforum.org/CelfPubWiki/BootupTimeResources

Regards, and good luck with your bootup time,
 -- Tim

P.S. I have been working on an improvement to KFI which
does not require a target-side device node or control utility.
This should make it simpler to use, and possible to use
when you can't even get user-space up on your board. This
might have some debug value since KFI can provide full call
tracing when configured properly.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
