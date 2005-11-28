Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVK1TzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVK1TzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVK1TzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:55:11 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:40873 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932220AbVK1TzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:55:09 -0500
Date: Mon, 28 Nov 2005 11:55:03 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Keith Owens <kaos@sgi.com>, Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Douglas_Warzecha@dell.com,
       Abhay_Salunke@dell.com, achim_leubner@adaptec.com,
       dmp@davidmpye.dyndns.org
Subject: Re: [Lse-tech] Re: [PATCH 0/7]: Fix for unsafe notifier chain
Message-ID: <20051128195503.GC11000@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051128045922.GK20775@brahms.suse.de> <4544.1133166696@ocs3.ocs.com.au> <20051128120711.GP20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128120711.GP20775@brahms.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 01:07:11PM +0100, Andi Kleen wrote:
> On Mon, Nov 28, 2005 at 07:31:36PM +1100, Keith Owens wrote:
> > On Mon, 28 Nov 2005 05:59:22 +0100, 
> > Andi Kleen <ak@suse.de> wrote:
> > >On Sun, Nov 27, 2005 at 08:57:45PM -0800, Andrew Morton wrote:
> > >> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> > >> >
> > >> > Any options I missed?
> > >> 
> > >> Stop using the notifier chains from NMI context - it's too hard.  Use a
> > >> fixed-size array in the NMI code instead.
> > >
> > >Or just don't unregister. That is what I did for the debug notifiers.
> > 
> > Unregister is not the only problem.  Chain traversal races with
> > register as well.
> 
> Either it follows the old next or the new next. Both are valid.
> The only problem is that there isn't a write barrier between
> 
>  n->next = *list;
>  *list=n;
> 
> in notifier_chain_register, which might hit on non i386 architectures. 

Coding as follows:

	n->next = *list;
	rcu_assign_pointer(*list, n);

will provide memory barriers as needed, even if you are never removing
elements.

						Thanx, Paul
