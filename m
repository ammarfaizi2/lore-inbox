Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUBJJUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 04:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUBJJUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 04:20:24 -0500
Received: from gate.in-addr.de ([212.8.193.158]:55784 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265789AbUBJJUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 04:20:18 -0500
Date: Tue, 10 Feb 2004 10:20:52 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: siginfo_t si_band type mismatch between kernel & glibc
Message-ID: <20040210092052.GL31312@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morning,

it turns out that on some archs, si_band is defined as long in the glibc
headers and as int in the kernel, leading to a 'nice' struct mismatch
and quite interesting behaviour - ie, breaking SIGPOLL & SIGIO on most
64bit archs.

In 2.6, we find:

#ifndef __ARCH_SI_BAND_T
#define __ARCH_SI_BAND_T int
#endif
...
                /* SIGPOLL */
                struct {
                        __ARCH_SI_BAND_T _band; /* POLL_IN, POLL_OUT, POLL_MSG */
                        int _fd;
                } _sigpoll;


Alas, for all archs but x86_64, __ARCH_SI_BAND_T is not defined, thus
defaulting to int, which is still not matching the user space expectations.

http://linux.bkbits.net:8080/linux-2.5/diffs/include/asm-generic/siginfo.h@1.10?nav=index.html|src/|src/include|src/include/asm-generic|hist/include/asm-generic/siginfo.h
suggests that Linus believes _band should be int on all archs but x86_64.

However, the glibc has had it as 'long' on mips, ia64 and x86_64 in the
kernel-headers; the glibc/sysdeps differs from this further, as it is
long only on linux(generic), ia64, s390. And the manpage says it to be
int, fwiw.

So is this a kernel bug or a glibc one? ;-)

Most user-land seems to expect it to be long, and right now (in 2.4 +
2.6), it seems SIGIO is definetely broken on ppc64 / s390x.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

