Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWAYPeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWAYPeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 10:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWAYPeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 10:34:12 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:12783 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751234AbWAYPeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 10:34:11 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 16:33:06 +0100
To: tytso@mit.edu, arjan@infradead.org
Cc: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <43D79A32.nailD78B9E1B5@burner>
References: <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner>
 <20060123203010.GB1820@merlin.emma.line.org>
 <1138092761.2977.32.camel@laptopd505.fenrus.org>
 <43D5EEA2.nailCE7111GPO@burner>
 <1138094141.2977.34.camel@laptopd505.fenrus.org>
 <20060124212843.GA15543@thunk.org>
In-Reply-To: <20060124212843.GA15543@thunk.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> wrote:

> I thought in the case we were talking about, the problem is that we
> have a setuid program which calls mlockall() but then later drops its
> privileges.  So when it tries to allocate memories, RLIMIT_MEMLOCK
> applies again, and so all future memory allocations would fail.  
>
> What I proposed is a hack, but strictly speaking not necessary
> according to the POSIX standards, but the problem is that a portable
> program can't be expected to know that Linux has a RLIMIT_MEMLOCK
> resource limit, such that a program which calls mlockall() and then
> drops privileges will work under Solaris and fail under Linux.  Hence
> I why proposed a hack where mlockall() would adjust RLIMIT_MEMLOCK.
> Yes, no question it's a hack and a special case; the question is
> whether cure or the disease is worse.

Maybe, I should give some hints...

RLIMIT_MEMLOCK did first apear in BSD-4.4 around 1994.
The iplementation is incomplete since then and partially disabled (size check 
for mmap() in the kernel) on FreeBSD as it has been 1994 on BSD-4.4

FreeBSD currently uses a default value of RLIMIT_INFINITY for users.

I could add this piece of code to the euid == 0 part of cdrecord:

LOCAL void 
raise_memlock() 
{ 
#ifdef  RLIMIT_MEMLOCK 
        struct rlimit rlim; 
 
        rlim.rlim_cur = rlim.rlim_max = RLIM_INFINITY; 
 
        if (setrlimit(RLIMIT_MEMLOCK, &rlim) < 0) 
                errmsg("Warning: Cannot raise RLIMIT_MEMLOCK limits."); 
#endif  /* RLIMIT_NOFILE */ 
} 

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
