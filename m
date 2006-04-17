Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWDQQsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWDQQsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWDQQsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:48:45 -0400
Received: from mga07.intel.com ([143.182.124.22]:30517 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751037AbWDQQso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:48:44 -0400
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24056804:sNHT74617886"
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24056785:sNHT472685885"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,126,1144047600"; 
   d="scan'208"; a="24056720:sNHT55850774"
Date: Mon, 17 Apr 2006 09:45:32 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dcn@americas.sgi.com>
Subject: Re: Is notify_die being overloaded?
Message-ID: <20060417094531.A20168@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060413194643.GC25701@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060413194643.GC25701@lnx-holt.americas.sgi.com>; from holt@sgi.com on Thu, Apr 13, 2006 at 02:46:44PM -0500
X-OriginalArrivalTime: 17 Apr 2006 16:47:34.0072 (UTC) FILETIME=[A0221380:01C6623E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 02:46:44PM -0500, Robin Holt wrote:
> notify_die seems to be called to indicate the machine is going down as
> well as there are trapped events for the process.
> 
> Specifically, the following call notify_die when there are machine
> related events:
> ia64_mca_rendez_int_handler (DIE_MCA_RENDZVOUS_ENTER,
> 	DIE_MCA_RENDZVOUS_PROCESS, DIE_MCA_RENDZVOUS_LEAVE)
> ia64_mca_handler (DIE_MCA_MONARCH_ENTER, DIE_MCA_MONARCH_PROCESS,
> 	DIE_MCA_MONARCH_LEAVE)
> ia64_init_handler (DIE_INIT_ENTER,
> 	DIE_INIT_{SLAVE|MONARCH}_{ENTER|PROCESS|LEAVE})
> ia64_mca_init (DIE_MCA_NEW_TIMEOUT)
> machine_restart (DIE_MACHINE_RESTART)
> machine_halt (DIE_MACHINE_HALT)
> die (DIE_OOPS)
> 
> 
> The following seem to be process related:
> ia64_bad_break (DIE_BREAK, DIE_FAULT)
> ia64_do_page_fault (DIE_PAGE_FAULT)
> 
> 
> Shouldn't these really be seperated into two seperate notifier chains?
> One for OS level die() type activity and another for process faults
> which a debugger et. al. would want to know about?
> 
> The specific concern is some testing we have been doing with an upcoming
> OSD release.  We see notify_die being called from ia64_do_page_fault
> frequently in our performance samples.  On these machines, xpc has
> registers a die notifier and therefore callouts are occuring which have
> no relationship to a processes page faulting.  XPC is looking for events
> which indicate the OS is stopping.  Additionally, kdb is installed on
> this machine as well and it has registered a die notifier as well.

Since DIE_PAGE_FAULT is the one which come in performance path, I think
this should be optimised and I would suggest just making 
notify_die(DIE_PAGE_FAULT,..) into a seperate notifier chains (something like
notify_page_fault() which calls just the registered handlers).
In this way, in the performance critical path, we will be calling only the
required handlers(probally only the kprobes handlers) and not the whole world
registered on notify_die() call chain.

-thanks,
Anil
