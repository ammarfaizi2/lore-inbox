Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVCKIjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVCKIjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 03:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVCKIjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 03:39:42 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:29090 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262604AbVCKIjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 03:39:39 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.22849.301714.529165@wombat.chubb.wattle.id.au>
Date: Fri, 11 Mar 2005 19:39:29 +1100
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       peterc@gelato.unsw.edu.au
Subject: Re: Microstate Accounting for 2.6.11
In-Reply-To: <m1acpazmb2.fsf@muc.de>
References: <16945.5058.251259.828855@berry.gelato.unsw.EDU.AU>
	<20050310200808.306caf98.akpm@osdl.org>
	<m1acpazmb2.fsf@muc.de>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@muc.de> writes:

Andi> Andrew Morton <akpm@osdl.org> writes:
>> Why does the kernel need this feature?
>> 
>> Have you any numbers on the overhead?

Andi> It does RDTSC and lots of complicated stuff twice for each
Andi> system call.  On P4 this will be extremly slow (> 1000cycles
Andi> combined) It is pretty unlikely that whatever it does justifies
Andi> this extreme overhead in a critical fast path.

Not really `lots of complicated stuff'.  Just swap a timer and set a
flag on entry:

    msp->timers[msp->laststate] += now - msp->lastchange
    msp->lastchange = now
    msp->laststate = ONCPU_SYS
    msp->cflags |= MSA_SYS


And swap timers and clear the flag on exit.  The flag's needed to
force return to ONCPU_SYS rather than ONCPU_USR if the task preempted or
interrupted while in a system call.

If there's a simpler, cheaper, faster way to track time spent in
system calls (as opposed to time spent in interrupt handlers, or on
the run queue)  thn I'd like to know what it is.

And I recognise there're are lots of people who don't want this ---
but there are some who do.  I've maintained this patch since mid 2003,
and have seen a steady trickle of downloads --- one or two a week.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
