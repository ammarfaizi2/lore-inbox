Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTJORfp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTJORfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:35:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:386 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263759AbTJORf0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:35:26 -0400
Date: Wed, 15 Oct 2003 13:37:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Hartmut Zybell <u_zybell@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: ld-Script needed OR (predicted) Architecture of Kernel 3.0 ;-)
In-Reply-To: <m1u16aeaej.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.53.0310151319480.7576@chaos>
References: <20031014114135.68297.qmail@web80702.mail.yahoo.com>
 <Pine.LNX.4.53.0310140821110.19781@chaos> <m1u16aeaej.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Eric W. Biederman wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> >
> > Also, we have a module loader and unloader that allows modules
> > to be inserted and removed from a running system. There are
> > even experimental systems that allow the whole kernel to be
> > changed without (apparent) re-booting.
>
> Any pointers.  I have heard rumors but I have never seen an actual
> implementation.  Even one that failed in a lot of cases.
>
> Eric

I heard rumors, too. Something going on, on source-forge, but
I haven't looked. I surmise that, if it works, it uses hooks
for the "suspend-to-disk" code that is also supposed to work
but I haven't ever seen either.

In principle, it should not be too hard to do on Intel.

(1) User-mode code opens a module and writes the new kernel
into kernel space using ordinary read or write module function
calls. The module kernel code saves the data in a temporary
kmalloc()ed buffer.

(2) User mode code kills everybody except itself and dismounts
all file-systems.

(3) User-mode code, via an ioctl() signals the module code
to restart.

(4) The kernel-mode code disables all interrupts, then writes
the saved data to a physical location, outside the normal kernel
space.

(5) The kernel-mode code then copies some code to low RAM where
there is a 1:1 virtual to physical translation below 1 megabyte.
It then jumps there. The code needs to be relocatable, not
a problem for the simple stuff it needs to do.

(6) Since the virtual:physical transation is 1:1, it can now
disable paging.

(7) With paging disabled, it copies the saved data from the
physical location used in (4) to offset 1 megabyte, the normal
relocation address.

(8) It jumps to the kernel startup code at the normal relocated
address.

FYI, I did something like this to non-distructively find the
physical address of bad RAM a few years ago. I made a module
that transitioned to 1:1 translation with paging disabled to
find the real bad RAM (the test program had written some tokens
to both sides of the failed area). It then transitioned back
to paged mode and, ultimately, back to user-mode code, with
the answer.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


