Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTICPUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTICPUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:20:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53888 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263488AbTICPUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:20:10 -0400
Date: Wed, 3 Sep 2003 11:22:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stuart MacDonald <stuartm@connecttech.com>
cc: "'James Clark'" <jimwclark@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: RE: Driver Model
In-Reply-To: <002301c37228$bbc89950$294b82ce@stuartm>
Message-ID: <Pine.LNX.4.53.0309031106100.9527@chaos>
References: <002301c37228$bbc89950$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Stuart MacDonald wrote:

> From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of
> > Richard B. Johnson
> > sources are available. If the driver does not contain the appropriate
> > MODULE_LICENSE() string, then several tools will show "tainted" so
>
> If the MODULE_LICENSE() macro is what determines taint, what's to
> prevent a company from compiling their driver in their own kernel tree
> with that macro and releasing it binary-only? Wouldn't that module
> then be taint-free?
>
> ..Stu
>

Well yes! You can do:

File: License.c
/*
 *
 *   Everything in this file (only) is released under the so-called
 *   GNU Public License, incorporated herein by reference.
 *
 *   Now, we just link this with any proprietary code and everybody
 *   but the lawyers are happy.
 */
#ifndef __KERNEL__
#define __KERNEL__
#endif
#ifndef MODULE
#define MODULE
#endif
#include <linux/module.h>
#if defined(MODULE_LICENSE)
MODULE_LICENSE("GPL");
#endif

You can link the output of this file with the binary-only file
and get rid of the 'tainted' message.

gcc -I./usr/src/linux/`uname-r` -o license.o License.c
ld -i -o driver.o binary.o license.o

....bbuutttt.... Now, if the kernel gets dorked because
a binary-only module is broken, the binary-only module will
not get fixed! The kernel developers need to know if the
source-code is available for everything that's in the kernel
when the kernel croaks. They need to examine the code of
every suspect module as well as the kernel code in the area
of interest. Note that a module inside the kernel is free to
destroy __everything__. A wild pointer in user-mode just
seg-faults, in kernel mode it can scribble over your hard-
disk and you won't even know it until you try to edit your
movie script that you've been working on for 20 years.

Currently, once an oops is reported and developers see the
'tainted' message, they ask the reporter to remove the module
that is producing that message. If the machine can't run without
it, they ask the person to get the help of the module provider.
Often "ask" is not too kind. Usually, it's a snide remark
by persons who are not trained in public affairs so this
may tend to cause some friction. However, remember that the
wizards that gave a lot of their time and effort to kernel
development don't really like to have some secret module
screwing up their work.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


