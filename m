Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTLWS60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTLWSv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:51:28 -0500
Received: from mailwasher.lanl.gov ([192.16.0.25]:51332 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262352AbTLWSt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:49:59 -0500
Subject: Re: SCO's infringing files list
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
In-Reply-To: <Pine.LNX.4.58.0312230914090.14184@home.osdl.org>
References: <1072125736.1286.170.camel@duergar>
	 <200312221519.04677.tcfelker@mtco.com>
	 <Pine.LNX.4.58.0312221337010.6868@home.osdl.org>
	 <20031223002641.GD28269@pegasys.ws> <20031223092847.GA3169@deneb.enyo.de>
	 <3FE811E3.6010708@debian.org>
	 <Pine.LNX.4.58.0312230317450.12483@home.osdl.org> <3FE862E7.1@pixelized.ch>
	 <20031223160425.GB45620@gaz.sfgoth.com>
	 <20031223163926.GC45620@gaz.sfgoth.com>
	 <Pine.LNX.4.58.0312230914090.14184@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1072205246.1702.36.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 23 Dec 2003 11:47:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 10:25, Linus Torvalds wrote:
> Bingo!
> 
> On Tue, 23 Dec 2003, Mitchell Blank Jr wrote:
> > 
> > This does seem to be the case - from an FAQ that H J Lu posted about that time:
> > 
> > | From: hlu@yoda.eecs.wsu.edu (H.J. Lu)
> > | Subject: FAQ about gcc (how to compile program under Linux)
> > | Date: Sun, 19 Jul 92 06:40:05 GMT
> > | [...]
> > | Another file, XXXXinc.tar.Z, where XXXX is the current version number
> > | of Linux kernel, has all the header files to replace the header files 
> > | from kernel. YOU MUST INSTALL IT. Please read README for details.
> 
> Ok, this is the source.
> 
> In particular, I can re-create _exactly_ the linux-0.97 "errno.h" file by 
> using the "sys_errlist[]" contents from "libc-2.2.2". In particular, this 
> trivial loop will generate the exact (byte-for-byte) list that is in the 
> kernel:
> 
>         int i;
> 
>         for (i = 1; i < 122; i++) {
>                 const char *name = names[i];
>                 int n = strlen(name);
>                 char *tabs = "\t\t"+(n > 7);
>                 const char *expl = libc222_errlist[i];
>                 printf("#define\t%s%s%2d\t/* %s */\n",
>                         name, tabs, i, expl);
>         }
> 
> here, the "names[]" array was filled in with the error names, ie
> 
> 	const char *names[] = { "none",
> 	"EPERM", "ENOENT", "ESRCH", "EINTR", "EIO", "ENXIO", "E2BIG",
> 	...
> 
> and the "libc222_errlist[]" array was filled in with the strings found by 
> just downloading the old "libc-2.2.2" binary that can still be found at
> 
> 	http://www.ibiblio.org/pub/Linux/libs/oldlibs/libc-2.2.2/
> 
> and then just doing a "strings - libc-2.2.2" and "sys_errlist[]" will be 
> obvious:
> 
> 	static char *libc222_errlist[] = {
> 	        "Unknown error",
> 	        "Operation not permitted",
> 	...
> 
> This was literally a five-minute hack (I wrote the silly loop yesterday to
> see what it does with the current "strerror()" - there is very good
> correlation even today, but using the libc-2.2.2 sys_nerrlist[] you get
> _exactly_ the same result).
> 
> So this is definitely the source of the kernel error header. It's either a
> file from the libc sources, or it is literally auto-generated like the
> above (I actually suspect the latter - now that I did the auto-generation
> it all felt very familiar, but that may just be my brain rationalizing
> things. Humans are good at rationalizing reality.).
> 
> Can anybody find the actual libc _sources_? Not the kernel headers that
> hjl mentions (those are the old ones from _before_ the change), but the
> file "libc-2.2.2.tar.Z"?
> 
> Anyway, we know where the kernel header comes from. Let's figure out where 
> the libc data comes from.
> 
> 				Linus

The earliest tarballs here may be of interest:
http://www.pell.portland.or.us/~orc/Code/libc/

[steven@spc9 libc-linux]$ head -n 20 jumptable1/string/_errlist.c
#include <ansidecl.h>
#include <stddef.h>
#include <errno.h>

/* This is a list of all known signal numbers.  */

CONST char *CONST _sys_errlist[] = {
        "Unknown error",                        /* 0 */
        "Operation not permitted",              /* EPERM */
        "No such file or directory",            /* ENOENT */
        "No such process",                      /* ESRCH */
        "Interrupted system call",              /* EINTR */
        "I/O error",                            /* EIO */
        "No such device or address",            /* ENXIO */
        "Arg list too long",                    /* E2BIG */
        "Exec format error",                    /* ENOEXEC */
        "Bad file number",                      /* EBADF */
        "No child processes",                   /* ECHILD */
        "Try again",                            /* EAGAIN */
        "Out of memory",                        /* ENOMEM */

That file dates from Nov 20 1992.

Steven

