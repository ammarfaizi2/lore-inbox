Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWCaAmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWCaAmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWCaAmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:42:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14792 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751180AbWCaAmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:42:38 -0500
Date: Thu, 30 Mar 2006 16:42:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603310038.k2V0crg26704@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603301639530.2068@schroedinger.engr.sgi.com>
References: <200603310038.k2V0crg26704@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Chen, Kenneth W wrote:

> Christoph Lameter wrote on Thursday, March 30, 2006 4:18 PM
> > Note that the current semantics for bitops IA64 are broken. Both
> > smp_mb__after/before_clear_bit are now set to full memory barriers
> > to compensate
> 
> Why you say that?  clear_bit has built-in acq or rel semantic depends
> on how you define it. I think only one of smp_mb__after/before need to
> be smp_mb?

clear_bit has no barrier semantics just acquire. Therefore both smp_mb_* 
need to be barriers or they need to add some form of "release".


> > +static __inline__ void
> > +set_bit_mode (int nr, volatile void *addr, int mode)
> > +{
> > +	__u32 bit, old, new;
> > +	volatile __u32 *m;
> > +	CMPXCHG_BUGCHECK_DECL
> > +
> > +	m = (volatile __u32 *) addr + (nr >> 5);
> > +	bit = 1 << (nr & 31);
> > +
> > +	if (mode == MODE_NON_ATOMIC) {
> > +		*m |= bit;
> > +		return;
> > +	}
> 
> Please kill all volatile declaration, because for non-atomic version,
> you don't need to do any memory ordering, but compiler automatically
> adds memory order because of volatile.  It's safe to kill them because
> cmpxchg later has explicit mode in there.

Ok. V3 will have that.
