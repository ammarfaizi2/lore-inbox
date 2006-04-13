Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWDMTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWDMTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWDMTrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:47:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14279 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750845AbWDMTrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:47:08 -0400
Date: Thu, 13 Apr 2006 14:46:44 -0500
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Keith Owens <kaos@americas.sgi.com>, Dean Nelson <dcn@americas.sgi.com>
Subject: Is notify_die being overloaded?
Message-ID: <20060413194643.GC25701@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

notify_die seems to be called to indicate the machine is going down as
well as there are trapped events for the process.

Specifically, the following call notify_die when there are machine
related events:
ia64_mca_rendez_int_handler (DIE_MCA_RENDZVOUS_ENTER,
	DIE_MCA_RENDZVOUS_PROCESS, DIE_MCA_RENDZVOUS_LEAVE)
ia64_mca_handler (DIE_MCA_MONARCH_ENTER, DIE_MCA_MONARCH_PROCESS,
	DIE_MCA_MONARCH_LEAVE)
ia64_init_handler (DIE_INIT_ENTER,
	DIE_INIT_{SLAVE|MONARCH}_{ENTER|PROCESS|LEAVE})
ia64_mca_init (DIE_MCA_NEW_TIMEOUT)
machine_restart (DIE_MACHINE_RESTART)
machine_halt (DIE_MACHINE_HALT)
die (DIE_OOPS)


The following seem to be process related:
ia64_bad_break (DIE_BREAK, DIE_FAULT)
ia64_do_page_fault (DIE_PAGE_FAULT)


Shouldn't these really be seperated into two seperate notifier chains?
One for OS level die() type activity and another for process faults
which a debugger et. al. would want to know about?

The specific concern is some testing we have been doing with an upcoming
OSD release.  We see notify_die being called from ia64_do_page_fault
frequently in our performance samples.  On these machines, xpc has
registers a die notifier and therefore callouts are occuring which have
no relationship to a processes page faulting.  XPC is looking for events
which indicate the OS is stopping.  Additionally, kdb is installed on
this machine as well and it has registered a die notifier as well.

Thanks,
Robin Holt
