Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWCJDYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWCJDYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWCJDYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:24:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932157AbWCJDYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:24:37 -0500
Date: Thu, 9 Mar 2006 19:22:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Markus Gutschke <markus@google.com>
Cc: linux-kernel@vger.kernel.org, dkegel@google.com
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on
 i386
Message-Id: <20060309192232.2fd4767c.akpm@osdl.org>
In-Reply-To: <4410EC8A.4020808@google.com>
References: <4410BB32.1020905@google.com>
	<20060309184759.591e3551.akpm@osdl.org>
	<4410EC8A.4020808@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Gutschke <markus@google.com> wrote:
>
> Andrew Morton wrote:
> > But we don't compile the kernel with -fpic...  We might want to, for kdump
> > convenience at some stage, perhaps.
> 
> Unless I am really confused, there should be no place in the kernel that 
> uses any of the _syscallX() macros. These macros are for the benefit of 
> userspace, and they get picked up by and distributed with glibc. They 
> just happen to be shipped and maintained with the kernel.

Nope, there's an int-80-based execve() implemented in
include/asm-i386/unistd.h.  It's called from init/do_mounts_initrd.c
and kernel/kmod.c (at least).

> > If we do, it'd be better to simply replace those _syscallX functions with
> > versions which work in either mode, rather than having two versions.
> 
> That is certainly possible. The new macros work in both modes, but they 
> are slightly less efficient than the old macros, if you have access to 
> %ebx (i.e. in non-PIC code). If you prefer, we could just remove the old 
> macros and unconditionally replace them with the new ones.

I'd be OK with that - the kernel doesn't (shouldn't) care about the
performance of __KERNEL_SYSCALLS__ stuff.  I doubt if glibc is borrowing
the kernel's macros.

> > The syscallX() macros are almost obsolete - it's preferred that code simply
> > include syscalls.h and call sys_foo() directly.  But there are a few
> > hard-to-convert places, iirc.
> 
> Are you thinking of the code that jumps through the vdso entry point? 
> That is not always an easy option for user-space applications which need 
> to remain backwards compatible to older versions of the kernel and of libc.
> 

afaik, execve() is the only reason for retaining __KERNEL_SYSCALLS__
support on x86.
