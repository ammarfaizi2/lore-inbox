Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSJSJaS>; Sat, 19 Oct 2002 05:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSJSJaS>; Sat, 19 Oct 2002 05:30:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25386 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265580AbSJSJaR>; Sat, 19 Oct 2002 05:30:17 -0400
To: Werner Almesberger <wa@almesberger.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<20021018173248.E14894@almesberger.net>
	<m1bs5rz1d6.fsf@frodo.biederman.org>
	<20021018231540.C7951@almesberger.net>
	<20021019025309.A24579@almesberger.net>
	<m17kgfyltc.fsf@frodo.biederman.org>
	<20021019040600.D7951@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Oct 2002 03:34:42 -0600
In-Reply-To: <20021019040600.D7951@almesberger.net>
Message-ID: <m13cr2zs99.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

I am CC'ing the kernel list so perhaps I don't have to answer these 
questions too many times.

> Eric W. Biederman wrote:
> > This is fixed in the bk2 snapshot of 43, but I guess since 44 is out
> > I should do build another patch against that.  
> 
> Your .43 patch applies flawlessly to .44 - and kexec even works :-)
> Not surprisingly, it doesn't like rebooting out of X11, though.

Cool.  What fails with X11.  Fixing it might be as simple as calling
int 0x10 early in the new image.
 
> Shouldn't ELF images work too ?  

Try kexec_test it is a valid static ELF executable.
Other valid static elf executables I know of:
memtest86-3.0.
etherboot-5.1 (make bin32/*.elf)

> kexec linux/.../bzImage  is okay,
> but  kexec linux/vmlinux  yields
> Invalid memory segment 0xc0100000 - 0xc03f3d7c
> Cannot load linux-2.5.44/vmlinux

Yep.  vmlinux wants to load where you don't have memory, and I have
a sanity check in there to prevent that.  If you had > 3GB of ram it
might have succeeded.  Unfortunately vmlinux on x86 has a number of
barriers to working correctly.   It specifies incorrect physical
addresses, and it expects to be passed a whole host of strange values,
in weird places.  Loading an arbitrary segment without first setting
the GDT is rude.  And vmlinux has not distinguishing marks other than
it's name to same it is something special.

My mkelfImage code will fix it up vmlinux so it is usable.  And I have
some old patches that will correct the kernel build but when I was
submitting them earlier they were not picked up.

kexec when presented with a static elf executable will:
-1) TODO: query the ELF note segment to see if there is anything
    special it needs to do.
0) Sanity check the elf headers to see if their requests are reasonable.
1) Load each segment from the program header to the physical
   address it specifies.
2) Setup a stack somewhere in ram outside of the image segments in the
   elf program header.
3) Jump to the entry point address in the elf program header

This all happens in 32bit protected mode with paging disabled, and
all of the segments registers set to a flat 32bit segment, with a base
address of zero.

For practical purposes the above is the raw interface to sys_kexec but
presented in a flat file.  

References:
memtest86: http://www.memtest86.com/
etherboot: http://www.etherboot.org
mkelfImage: ftp://www.lnxi.com/pub/src/mkelfImage/

Eric
