Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWDYBLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWDYBLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWDYBLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 21:11:00 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:18116 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751300AbWDYBK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 21:10:59 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: bibo mao <bibo_mao@linux.intel.com>
cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 7/7] Notify page fault call chain 
In-reply-to: Your message of "Mon, 24 Apr 2006 17:19:01 +0800."
             <444C9805.4060303@linux.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Apr 2006 11:10:59 +1000
Message-ID: <19634.1145927459@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bibo mao (on Mon, 24 Apr 2006 17:19:01 +0800) wrote:
>I have some questions about page fault call chain.
>1) Can kprobe_exceptions_notify be divided into two sub-functions, one 
>is for die call chain, which handles DIE_BREAK/DIE_FAULT trap, the other 
>is specially for DIE_PAGE_FAULT trap.

I asked the same question, Anil said that would/could be done in a
later set of patches, but did not want to change too much code in one
go.

>2) page_fault_notifier is conditionally registered/unregistered in this 
>patch, notify_page_fault(DIE_PAGE_FAULT...) is unconditionally called in 
>  ia64_do_page_fault() function. I do not know whether it is possible to 
>unconditionally register page_fault_notifier() call chain, but 
>conditionally call notify_page_fault(DIE_PAGE_FAULT...) function.

Only by putting extra code at the site of notify_page_fault().  That
would introduce a race against kprobes unregistering a user space
probe.  The race is probably safe, but why risk it?

>3) I do know whether there are other conditions like kdb/kgdb which need
>call page fault call chain when page fault happens. If only kprobe need 
>handle page fault, then I think kprobe_exceptions_notify can be called 
>directly in ia64_do_page_fault() function. Of course,  the call chain 
>method is more convenient and easy to extend for other fault causes(like 
>kdb/kgdb).

Only kprobes needs the page fault handler.

Calling kprobe_exceptions_notify() directly would work but again it
introduces races.  The register and unregister are atomic, and remember
how long it took us to agree on how to make atomic register and
unregister race safe.  Using the existing notify chain code gives us
race safe register, call and unregister without having to verify that
any hand written replacement code is also race safe.

You would need to demonstrate that any hand crafted code was race safe
and had enough speed improvement to make the coding and debugging effort
worthwhile.
