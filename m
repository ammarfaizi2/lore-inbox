Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132261AbRCVXja>; Thu, 22 Mar 2001 18:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132255AbRCVXhl>; Thu, 22 Mar 2001 18:37:41 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:19964 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132257AbRCVXgo>;
	Thu, 22 Mar 2001 18:36:44 -0500
Date: Fri, 23 Mar 2001 00:35:29 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200103222335.AAA22466@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Prevent OOM from killing init
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001 21:23:54 +0000 (GMT), Alan Cox wrote:

>> Really the whole oom_kill process seems bass-ackwards to me.  I can't in my mind
>> logically justify annihilating large-VM processes that have been running for 
>> days or weeks instead of just returning ENOMEM to a process that just started 
>> up.
>
>How do you return an out of memory error to a C program that is out of memory
>due to a stack growth fault. There is actually not a language construct for it

SIGSEGV.
Stack overflow for a language like C using standard implementation techniques
is the same as a page fault while accessing a page for which there is no backing
store. SIGSEGV is the logical choice, and the one I'd expect on other Unices.

oom_kill should simply fail the current allocation which cannot be satisfied,
either by having {s,}brk/mmap return error or by posting a SIGSEGV. This would
actually also be the correct answer, if Linux didn't overcommit memory ...

Remove the overcommit crap and oom_kill can go away; this entails ensuring
that mmap() honors MAP_RESERVE/MAP_NORESERVE.

/Mikael
