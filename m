Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268683AbUJTR3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268683AbUJTR3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 13:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUJTR3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 13:29:05 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:31456 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S268690AbUJTRXC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 13:23:02 -0400
Date: Wed, 20 Oct 2004 20:23:00 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] exec-shield-nx-2.6.9-A1
Message-ID: <20041020172300.GA7608@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041017095343.GA7976@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017095343.GA7976@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 11:53:43AM +0200, Ingo Molnar wrote:
> 
> i've released the latest exec-shield patch:
> 
>    http://redhat.com/~mingo/exec-shield/exec-shield-nx-2.6.9-A1
> 
> this is a merge of the exec-shield patches used in FC2/FC3 to mainline.
> (The patch is smaller than earlier exec-shield patches or the 2.4 patch
> because a sub-functionality related to exec-shield (flexmmap) got merged
> to 2.6.9.)
> 
> This version of exec-shield makes use of NX too, if available (and PAE),
> and falls back to the segment-limit method on CPUs that have no NX.

Well, I tried it.
Can you tell am I doing something wrong?
 
Without any special flags into paxtest-0.9.6 [1] Makefile.generic
I get "Vulnerable" and "No randomisation" for all of the tests.

When I add "-fPIC":
Executable shared library bss            : Killed
Executable shared library data           : Killed
When I add "-fomit-frame-pointer" (!!?):
Executable stack                         : Killed

Also, sbrk(0) always returns 0x804a000.

non-NX UP i386 (Celeron Mendocino), gcc-3.4.2
(gcc-2.95.3 used for the kernel),
Fedora's binutils-2.15.92.0.2-4 and glibc-2.3.3-67,
exec-shield-nx-2.6.9-A2, Linux-2.6.9, .config at
http://safari.iki.fi/config-2.6.9-20041020-1.txt

Previous attempt: with 2.6.9-rc4 + linux-2.6.0-exec-shield.patch +
4G4G patches from Fedora's kernel-2.6.8-1.603 I had _some_ working
randomisations:
Anonymous mapping randomisation test     : 12 bits (guessed)
Heap randomisation test (ET_EXEC)        : No randomisation
Heap randomisation test (ET_DYN)         : 12 bits (guessed)
Main executable randomisation (ET_EXEC)  : No randomisation
Main executable randomisation (ET_DYN)   : 12 bits (guessed)
Shared library randomisation test        : No randomisation
Stack randomisation test (SEGMEXEC)      : No randomisation
Stack randomisation test (PAGEEXEC)      : No randomisation

Without 4G4G patches none of the randomisations were working (!!?).

$ cat /proc/sys/kernel/exec-shield{,-randomize}
2
1

$ cat /proc/self/maps 
03bc7000-03bdc000 r-xp 00000000 16:46 399658     /lib/ld-2.3.3.so
03bdc000-03bdd000 r-xp 00014000 16:46 399658     /lib/ld-2.3.3.so
03bdd000-03bde000 rwxp 00015000 16:46 399658     /lib/ld-2.3.3.so
03c69000-03d88000 r-xp 00000000 16:46 399659     /lib/tls/libc-2.3.3.so
03d88000-03d89000 ---p 0011f000 16:46 399659     /lib/tls/libc-2.3.3.so
03d89000-03d8b000 r-xp 0011f000 16:46 399659     /lib/tls/libc-2.3.3.so
03d8b000-03d8d000 rwxp 00121000 16:46 399659     /lib/tls/libc-2.3.3.so
03d8d000-03d8f000 rwxp 03d8d000 00:00 0 
08048000-0804c000 r-xp 00000000 16:46 398963     /bin/cat
0804c000-0804d000 rwxp 00004000 16:46 398963     /bin/cat
0804d000-0806e000 rwxp 0804d000 00:00 0 
b7ddf000-b7de0000 r-xp 0077d000 16:03 441105     /usr/lib/locale/locale-archive
b7de0000-b7fe0000 r-xp 00000000 16:03 441105     /usr/lib/locale/locale-archive
b7fe0000-b7fe1000 rwxp b7fe0000 00:00 0 
bfffd000-c0000000 rw-p bfffd000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 

(output is always the same)

[1] ftp://ftp.fi.debian.org/pub/debian/pool/main/p/paxtest/paxtest_0.9.6.orig.tar.gz
    + paxtest_0.9.6-2.diff.gz

-- 

