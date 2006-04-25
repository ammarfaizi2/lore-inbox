Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWDYFqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWDYFqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWDYFqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:46:19 -0400
Received: from mga06.intel.com ([134.134.136.21]:42582 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751292AbWDYFqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:46:19 -0400
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="27306354:sNHT16826348"
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="27352984:sNHT24832626"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="28132177:sNHT18599469"
Date: Mon, 24 Apr 2006 22:43:14 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: bibo mao <bibo_mao@linux.intel.com>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 7/7] Notify page fault call chain
Message-ID: <20060424224313.A19542@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <444C9805.4060303@linux.intel.com> <19634.1145927459@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <19634.1145927459@ocs3.ocs.com.au>; from kaos@sgi.com on Tue, Apr 25, 2006 at 11:10:59AM +1000
X-OriginalArrivalTime: 25 Apr 2006 05:46:18.0151 (UTC) FILETIME=[92BEFB70:01C6682B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 11:10:59AM +1000, Keith Owens wrote:
> bibo mao (on Mon, 24 Apr 2006 17:19:01 +0800) wrote:
> >I have some questions about page fault call chain.
> >1) Can kprobe_exceptions_notify be divided into two sub-functions, one 
> >is for die call chain, which handles DIE_BREAK/DIE_FAULT trap, the other 
> >is specially for DIE_PAGE_FAULT trap.
> 
> I asked the same question, Anil said that would/could be done in a
> later set of patches, but did not want to change too much code in one
> go.

I don't think it is necessary to split kprobe_exception_notify(). All it is 
having is a simple switch case and based on the swich case it takes appropriate
actions.

> 
> >2) page_fault_notifier is conditionally registered/unregistered in this 
> >patch, notify_page_fault(DIE_PAGE_FAULT...) is unconditionally called in 
> >  ia64_do_page_fault() function. I do not know whether it is possible to 
> >unconditionally register page_fault_notifier() call chain, but 
> >conditionally call notify_page_fault(DIE_PAGE_FAULT...) function.
> 
> Only by putting extra code at the site of notify_page_fault().  That
> would introduce a race against kprobes unregistering a user space
> probe.  The race is probably safe, but why risk it?

Their is no race while we call unregister_page_fault_notifier(), as we unregister
only after the last probe is removed and after synchronized_sched() is done which
guarantees that all the probes have completly finished executing.
> 
> >3) I do know whether there are other conditions like kdb/kgdb which need
> >call page fault call chain when page fault happens. If only kprobe need 
> >handle page fault, then I think kprobe_exceptions_notify can be called 
> >directly in ia64_do_page_fault() function. Of course,  the call chain 
> >method is more convenient and easy to extend for other fault causes(like 
> >kdb/kgdb).
> 
> Only kprobes needs the page fault handler.
> 
> Calling kprobe_exceptions_notify() directly would work but again it
> introduces races.  The register and unregister are atomic, and remember

Calling kprobe_exception_notify() directly can be made to work with
out any races if needed. Not sure if calling directly  will have 
any significant performance improvement over current non-overloaded
call chain notifications.

-Anil
