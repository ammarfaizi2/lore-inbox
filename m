Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265660AbUFDGma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265660AbUFDGma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 02:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265659AbUFDGma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 02:42:30 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:9496 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265661AbUFDGmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 02:42:18 -0400
Date: Thu, 3 Jun 2004 23:47:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, mikpe@csd.uu.se,
       Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603234740.1d3aafde.pj@sgi.com>
In-Reply-To: <20040603224033.2dc5da9f.akpm@osdl.org>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603223005.01bbab21.pj@sgi.com>
	<40C00A2B.1040606@yahoo.com.au>
	<20040603224033.2dc5da9f.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where do we stand wrt pass-by-reference?

I haven't found any place yet that I noticed this to be a problem.

Of course it's not a problem in the internals of the cpumask
implementation, because the very first layer of implementation, the
#define's, converts pass by value to pass by reference (and adds the
NR_CPUS where that helps).  Then the bitmap ops in the next layer down
convert right back to single word operations by value, in the usual
NR_CPUS <= BITS_PER_LONG case, all within the scope of the compiler
code-generator.

If there was a place where it was important to pass a cpumask argument
by reference for efficiency, then I would claim that this should be done
by explicitly making the argument in question a (cpumask_t *) pointer,
instead of a cpumask_t value.  This is the usual technique when passing
potentially large structures, when a local private copy is not needed.

If further such a place was in generic kernel code, where the vast
majority running on more reasonably sized hardware would object to
such, either because of esthetics, or efficiency (wasting a pointer
dereference) then ...  cross that bridge when the water rises.

Hopefully, localized solutions could be developed for such needs,
without dragging back in all the complexity of the generalized
variability we had before.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
