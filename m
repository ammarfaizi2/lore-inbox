Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTBUN60>; Fri, 21 Feb 2003 08:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBUN60>; Fri, 21 Feb 2003 08:58:26 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62909 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267443AbTBUN6Z>;
	Fri, 21 Feb 2003 08:58:25 -0500
Date: Fri, 21 Feb 2003 14:20:39 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w ith flush_tlb_all()
Message-ID: <20030221142039.GA21532@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0302211217390.1531-100000@localhost.localdomain> <200302211342.19007.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302211342.19007.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 01:42:12PM +0100, Thomas Schlichter wrote:

 > > No.  All that does is make sure that the cpu you start out on is
 > > flushed, once or twice, and the cpu you end up on may be missed.
 > > Use preempt_disable and preempt_enable.
 > 
 > Oh, you are right! I think I am totally stupid this morning...!
 > Now finally I hope this is the correct patch...

That would appear to do what you want, but its an ugly construct to
be repeating everywhere that wants to call a function on all CPUs.
It would probably clean things up a lot if we had a function to do..

static inline void on_each_cpu(void *func)
{      
#ifdef CONFIG_SMP
	preempt_disable();
	smp_call_function(func, NULL, 1, 1);
	func(NULL);
	preempt_enable();
#else
	func(NULL);
#endif
}

Bluesmoke and agpgart could both use this to cleanup some mess,
and no doubt there are others

Comments?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
