Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbSIZV6q>; Thu, 26 Sep 2002 17:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSIZV6q>; Thu, 26 Sep 2002 17:58:46 -0400
Received: from jalon.able.es ([212.97.163.2]:61103 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S261552AbSIZV6p>;
	Thu, 26 Sep 2002 17:58:45 -0400
Date: Fri, 27 Sep 2002 00:03:23 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Distributing drivers independent of the kernel source tree
Message-ID: <20020926220323.GA2773@werewolf.able.es>
References: <A9713061F01AD411B0F700D0B746CA6802FC14D6@vacho6misge.cho.ge.com> <1033074519.2698.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1033074519.2698.5.camel@localhost.localdomain>; from arjanv@redhat.com on Thu, Sep 26, 2002 at 23:08:39 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.09.26 Arjan van de Ven wrote:
>On Thu, 2002-09-26 at 22:55, Heater, Daniel (IndSys, GEFanuc, VMIC) 
>> 2. Assuming the kernel source is in /usr/src/linux is not always valid.
>> 
>> 3. I currently use /usr/src/linux-`uname -r` to locate the kernel source
>> which is just as broken as method #2.
>
>you have to use
>
>/lib/modules/`uname -r`/build
>(yes it's a symlink usually, but that doesn't matter)
>
>
>that's what Linus decreed and that's what all distributions honor, and
>that's that make install does for manual builds.
>

And that does not work if you build against a non-running kernel.
You force a two step (two reboots!!) procedure for a kernel upgrade.
Say I use alsa drivers. If I jump from kernel 2.4.18 to 2.4.19
I have to:

- build 2.4.19
- boot on 2.4.19 (without alsa and a ton of messages about failed
  sound services)
- build alsa
- boot again

I really hate that 'uname -r'. As far as /usr/src/linux has _nothing_
to do with current system (glibc has its own headers), you can always
suppose that /usr/src/linux is the source of the kernel you are working
with (building, hacking, wahtever), and that it is different from what
you run. So a kernel upgrade is just
- build 2.4.19 (on /usr/src/linux-2.4.19, and /usr/src/linux symlinks to it)
- build alsa against /usr/src/linux
- reboot and alehop, done in _one_ step.

Where to install the out-of-tree module ? Get the version you are building
against from /usr/src/linux/include/version.h:

KREL:=$(shell grep UTS_RELEASE /usr/src/linux/include/linux/version.h | cut -d\" -f2)

You can always not-to-hardcode kernel location using something like:
LINUX=/usr/src/linux
KREL=$(shell grep UTS_RELEASE $(LINUX)/include/linux/version.h | cut -d\" -f2)
CFLAGS=-nostdinc -I$(LINUX)/include
MODDIR=/lib/modules/$(LINUX)/my_private_dir

I use this for adding nvidia and bproc to a kernel and works fine.
Just one reboot per upgrade.

/juan

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (Cooker) for i586
Linux 2.4.20-pre7-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
