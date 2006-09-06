Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWIFBaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWIFBaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 21:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbWIFBaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 21:30:00 -0400
Received: from mga06.intel.com ([134.134.136.21]:11581 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S965250AbWIFB36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 21:29:58 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,217,1154934000"; 
   d="scan'208"; a="121458753:sNHT3365309101"
Subject: Re: pci error recovery procedure
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Yanmin Zhang <yanmin.zhang@intel.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>
In-Reply-To: <20060905190115.GE7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	 <20060831175001.GE8704@austin.ibm.com>
	 <1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	 <20060901212548.GS8704@austin.ibm.com>
	 <1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	 <1157360592.22705.46.camel@localhost.localdomain>
	 <1157423528.20092.365.camel@ymzhang-perf.sh.intel.com>
	 <20060905190115.GE7139@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1157506016.20092.386.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 06 Sep 2006 09:26:56 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 03:01, Linas Vepstas wrote:
> On Tue, Sep 05, 2006 at 10:32:08AM +0800, Zhang, Yanmin wrote:
> > Is it the exclusive reason to have multi-steps?
> 
> I don't understand the question. A previous email explained the reason
> to have mutiple steps.
The question is against Ben's comments. Pls. don't delete his comments
in your reply. 

> 
> > 1) Here link reset and hard reset are hardware operations, not the
> > link_reset and slot_reset callback in pci_error_handlers.
> 
> I don't understand the comment.
I wanted to clarify that we need differentiate link/hard reset from
callback link_reset and slot_reset when discussing the API.

> 
> > 2) Callback error_detected will notify drivers there is PCI errors. Drivers
> > shouldn't do any I/O in error_detected.
> 
> It shouldn't matter. If it is truly important for a particular platform
> to make sure that there is no i/o, then the low-level i/o routines
> could be modified to drop any accidentally issued i/o on the floor.
> This doesn't require a change to either the API or the policy.
> > 3) If both the link and slot are reset after all error_detected are called,
> > the device should go back to initial status and all DMA should be stopped
> > automatically. Why does the driver still need a chance to stop DMA? 
> 
> As explained previously, not all drivers may want to have a full
> electrical device reset.
I need repeat my idea.
1) My new pci_error_handlers doesn't always choose to reset slot. It
still depends on the return value of error_detected.
2) As a matter of fact, most cases of specific device's error_detected callback
will choose to return PCI_ERS_RESULT_NEED_RESET. Like what you did for
e100/e1000/ipr.

> 
> > The
> > error_detected of the drivers in the latest kernel who support err handlers
> > always returns PCI_ERS_RESULT_NEED_RESET. They are typical examples.
> 
> Just because the current drivers do it this way does not mean that this is
> the best way to do things.
If it's not the best way, why did you choose to reset slot for e1000/e100/ipr
error handlers? They are typical widely-used devices. To make it easier to
add error handlers?


>  A full reset is time-consuming. Some drivers
> may want to implement a faster and quicker reset.
> 
> --linas
