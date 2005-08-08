Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVHHUzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVHHUzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVHHUzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:55:32 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:24928 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932221AbVHHUzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:55:31 -0400
Date: Mon, 8 Aug 2005 22:57:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: sparse warnings in initramfs - question?
Message-ID: <20050808205754.GA26770@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I decided to take a closer look at initramfs after playing around with
klibc for a while.
When I ran sparse on it I received a lot of address space warnings like
this:

init/initramfs.c:234:21: warning: incorrect type in argument 1 (different address spaces)
init/initramfs.c:234:21:    expected char const [noderef] *oldname<asn:1>
init/initramfs.c:234:21:    got char *old
init/initramfs.c:234:26: warning: incorrect type in argument 2 (different address spaces)
init/initramfs.c:234:26:    expected char const [noderef] *newname<asn:1>
init/initramfs.c:234:26:    got char *static [toplevel] [assigned] collected

Several more of the same type followed. They were all rasied due to
pointers supplied to sys_* function properly marked with __user.

In the above case we see a call to:
sys_link(old, collected)

And neither old, not collected is marked __user.

So I looked at how they are assinged.

collected is assigned in read_info at line 142.
It is assigned a value stored in victim.

victim is assigned a value in write_buffer in line 312, assinged from
buf wich is a parameter to the function flush_buffer and
unpack_to_rootfs.

Following flush_buffer I see that flush_buffer is called with the global
variable window as parameter. window is assigned the value of a
malloc'ed buffer in unpack_to_rootfs - so window is not a __user
pointer.

Following the other track where write_buffer is used in unpack_to_rootfs
I see that buf is assinged a value equal __initramfs_start - a linker
defined symbol.

This may make a bit more sense, bt I'm not sure if this qualifies as a
_user pointer.

My basic question is if the various functions in namei is able to deal
with pointer that is not __user pointers?

I tried to follow and hit _strncpy_from_userspace, defined in
arch/i386/lib/usercopy.c. But in the end it was some inline assembler I
did not understand.

I would be gald if someone could sched some ligth on this matter -
thanks!

	Sam
