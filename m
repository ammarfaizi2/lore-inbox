Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262395AbSL2Xsl>; Sun, 29 Dec 2002 18:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSL2Xsl>; Sun, 29 Dec 2002 18:48:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262395AbSL2Xsi>; Sun, 29 Dec 2002 18:48:38 -0500
Date: Sun, 29 Dec 2002 15:51:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: glibc binaries w/ sysenter support
In-Reply-To: <3E0F5233.5050209@redhat.com>
Message-ID: <Pine.LNX.4.44.0212291543140.1414-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Dec 2002, Ulrich Drepper wrote:
>
> After quite some fiddling we finally have some glibc binaries with
> sysenter support.  The problems were not in the sysenter code but in
> coordinating everything in ld.so so that it works on old kernels
> (without TLS support).
> 
> Anyway, the result can be downloaded from
> 
>   ftp://people.redhat.com/drepper/glibc/2.3.1-25/

Thanks. 

Having a full system like this showed a few special cases in sysenter
handling, where some system calls really depend on the old "iret" return
path.

Notably, "sys_iopl()" requires the iret path because that's the only way
to restore the full eflags, and "execve()" requires the iret return path
because it needs to start up the new process with fixed values in
%edx/%ebx, and the stack has a new layout and no longer contains the
required sysexit fixup code.

I've pushed the fix for both of these issues to the kernel -bk trees. 

Without the fix, a system with sysenter support would not boot up cleanly
with these libraries due to the execve() issues, and X wouldn't start
because of the iopl() problem.

With this in place, I've not seen any strange behaviour, and "lmbench" 
reports

	Processor, Processes - times in microseconds - smaller is better
	----------------------------------------------------------------
	Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
	                             call  I/O stat clos       inst hndl proc proc proc
	--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
	i686-linu  Linux 2.5.53 2380  0.7  1.1    5    7 0.04K  1.2    3 0.2K   1K   3K
	i686-linu  Linux 2.5.53 2380  0.7  1.1    5    7 0.04K  1.2    3 0.2K   1K   3K
	i686-linu  Linux 2.5.53 2380  0.7  1.1    5    7 0.04K  1.2    3 0.2K   1K   3K
	i686-linu  Linux 2.5.53 2380  0.2  0.6    5    6 0.04K  0.7    3 0.2K   1K   3K
	i686-linu  Linux 2.5.53 2380  0.2  0.6    5    6 0.04K  0.7    3 0.2K   1K   3K
	i686-linu  Linux 2.5.53 2380  0.2  0.6    5    6 0.04K  0.7    3 0.2K   1K   3K

(the three first entries are with the old glibc, three last entries are
with the new one - note the null call/io and signal install improvements).

		Linus

