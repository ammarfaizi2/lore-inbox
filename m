Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVATJBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVATJBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 04:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVATJBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 04:01:10 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:2238 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262080AbVATJBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 04:01:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
Date: Thu, 20 Jan 2005 19:59:53 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu, peterc@gelato.unsw.edu.au,
       tony.luck@intel.com, dsw@gelato.unsw.edu.au, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org, hch@infradead.org,
       wli@holomorphy.com, jbarnes@sgi.com
Subject: Re: [PATCH RFC] 'spinlock/rwlock fixes' V3 [1/1]
In-Reply-To: <20050120031854.GA8538@taniwha.stupidest.org>
References: <20050116230922.7274f9a2.akpm@osdl.org>
	<20050117143301.GA10341@elte.hu>
	<20050118014752.GA14709@cse.unsw.EDU.AU>
	<16877.42598.336096.561224@wombat.chubb.wattle.id.au>
	<20050119080403.GB29037@elte.hu>
	<16878.9678.73202.771962@wombat.chubb.wattle.id.au>
	<20050119092013.GA2045@elte.hu>
	<16878.54402.344079.528038@cargo.ozlabs.ibm.com>
	<20050120023445.GA3475@taniwha.stupidest.org>
	<20050119190104.71f0a76f.akpm@osdl.org>
	<20050120031854.GA8538@taniwha.stupidest.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Wedgwood <cw@f00f.org> writes:

Chris> On Wed, Jan 19, 2005 at 07:01:04PM -0800, Andrew Morton wrote:

Chris> It still isn't enough to rid of the rwlock_read_locked and
Chris> rwlock_write_locked usage in kernel/spinlock.c as those are
Chris> needed for the cpu_relax() calls so we have to decide on
Chris> suitable names still...  

I suggest reversing the sense of the macros, and having read_can_lock()
and write_can_lock()

Meaning:
	read_can_lock() --- a read_lock() would have succeeded
	write_can_lock() --- a write_lock() would have succeeded.

IA64 implementation:

#define read_can_lock(x)  (*(volatile int *)x >= 0)
#define write_can_lock(x) (*(volatile int *)x == 0)

Then use them as
     !read_can_lock(x)
where you want the old semantics.  The compiler ought to be smart
enough to optimise the boolean ops.

---
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*



