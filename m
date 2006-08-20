Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWHTUd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWHTUd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWHTUd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:33:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:4607 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751207AbWHTUd5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:33:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Date: Sun, 20 Aug 2006 22:33:31 +0200
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <1156103446.23756.60.camel@laptopd505.fenrus.org> <20060820201118.GC11843@atjola.homenet>
In-Reply-To: <20060820201118.GC11843@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608202233.33464.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 22:11, Björn Steinbrink wrote:
> Only one in unistd.h, but throughout the kernel there are quite a few
> unless I'm missing something here:
> doener@atjola:~/src/kernel/linux-2.6$ grep \ _syscall * -R | \
> > grep -v define\\\|undef\\\|clobber | wc -l
> 116

there are only a few direct calls that managed to sneak in after we removed
them all some time ago:

| arch/sh64/kernel/process.c:     _syscall0(int, getpid)
| arch/sh64/kernel/process.c:     _syscall1(int, getpgid, int, pid)
| arch/sh64/kernel/process.c:static __inline__ _syscall2(int,clone,unsigned long,flags,unsigned long,newsp)
| arch/sh64/kernel/process.c:static __inline__ _syscall1(int,exit,int,ret)

These should be replaced with calls to sys_*, or whatever the other
architectures do in order to implement the respective functions.

| arch/um/os-Linux/sys-i386/tls.c:static _syscall1(int, get_thread_area, user_desc_t *, u_info);
| arch/um/os-Linux/process.c:inline _syscall0(pid_t, getpid)
| arch/um/os-Linux/tls.c:static _syscall1(int, get_thread_area, user_desc_t *, u_info);
| arch/um/os-Linux/tls.c:static _syscall1(int, set_thread_area, user_desc_t *, u_info);
| arch/um/sys-i386/unmap.c:static inline _syscall2(int,munmap,void *,start,size_t,len)
| arch/um/sys-i386/unmap.c:static inline _syscall6(void *,mmap2,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)
| arch/um/sys-x86_64/unmap.c:static inline _syscall2(int,munmap,void *,start,size_t,len)
| arch/um/sys-x86_64/unmap.c:static inline _syscall6(void *,mmap,void *,addr,size_t,len,int,prot,int,flags,int,fd,off_t,offset)

UML is special, there may be a good reason to use them, if they are not
actually kernel syscalls, but instead calls to the host OS.

	Arnd <><
