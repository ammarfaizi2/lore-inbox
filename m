Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWDYGER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWDYGER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 02:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWDYGER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 02:04:17 -0400
Received: from mga06.intel.com ([134.134.136.21]:62279 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751020AbWDYGEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 02:04:16 -0400
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="27312993:sNHT48725740"
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="27312975:sNHT51729762"
TrustInternalSourcedMail: True
X-IronPort-AV: i="4.04,153,1144047600"; 
   d="scan'208"; a="28138697:sNHT56971579"
Date: Mon, 24 Apr 2006 23:01:16 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Robin Holt <holt@sgi.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dnc@americas.sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 0/7] Notify page fault call chain
Message-ID: <20060424230115.B19542@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060420232456.712271992@csdlinux-2.jf.intel.com> <20060424192824.GA10893@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060424192824.GA10893@lnx-holt.americas.sgi.com>; from holt@sgi.com on Mon, Apr 24, 2006 at 02:28:24PM -0500
X-OriginalArrivalTime: 25 Apr 2006 06:04:14.0357 (UTC) FILETIME=[1436FC50:01C6682E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:28:24PM -0500, Robin Holt wrote:
> Anil,
> 
> This set definitely improves things.  My timings from last week must
> have been off.  I think I may have still had the notify_die() call in
> the fault path.  This week, I see a 35 nSec slowdown between with/without
> KRPOBES.  Last week, I thought they were roughly equivalent.
The non-overloaded call chain notification with dynamic registeration/unregistration 
is much better than earlier one. But if you still want to improve the 35 nSec
slowdown, then the only other alternative is to eliminate the call chain and 
try calling kprobe_exceptions_notify() directly with the kprobe_running() around it.
i.e
static inline int notify_page_fault(enum die_val val, const char *str,
                        struct pt_regs *regs, long err, int trap, int sig)
{
	if(kprobe_running())
	{
        	struct die_args args = {
               	 .regs = regs,
               	 .str = str,
               	 .err = err,
               	 .trapnr = trap,
               	 .signr = sig

		return kprobe_exceptions_notify(NULL, &die_args, DIE_PAGE_FAULT);
	}
}

Anyone has any other comments/suggestion?

-thanks,
Anil



