Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWDOGT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWDOGT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 02:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWDOGT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 02:19:57 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:48581 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030268AbWDOGT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 02:19:57 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Robin Holt <holt@sgi.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Dean Nelson <dcn@sgi.com>
Subject: Re: Is notify_die being overloaded? 
In-reply-to: Your message of "Thu, 13 Apr 2006 14:46:44 EST."
             <20060413194643.GC25701@lnx-holt.americas.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 15 Apr 2006 16:19:55 +1000
Message-ID: <22910.1145081995@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt (on Thu, 13 Apr 2006 14:46:44 -0500) wrote:
>notify_die seems to be called to indicate the machine is going down as
>well as there are trapped events for the process.
>
>Specifically, the following call notify_die when there are machine
>related events:
>ia64_mca_rendez_int_handler (DIE_MCA_RENDZVOUS_ENTER,
>	DIE_MCA_RENDZVOUS_PROCESS, DIE_MCA_RENDZVOUS_LEAVE)
>ia64_mca_handler (DIE_MCA_MONARCH_ENTER, DIE_MCA_MONARCH_PROCESS,
>	DIE_MCA_MONARCH_LEAVE)
>ia64_init_handler (DIE_INIT_ENTER,
>	DIE_INIT_{SLAVE|MONARCH}_{ENTER|PROCESS|LEAVE})
>ia64_mca_init (DIE_MCA_NEW_TIMEOUT)
>machine_restart (DIE_MACHINE_RESTART)
>machine_halt (DIE_MACHINE_HALT)
>die (DIE_OOPS)
>
>
>The following seem to be process related:
>ia64_bad_break (DIE_BREAK, DIE_FAULT)
>ia64_do_page_fault (DIE_PAGE_FAULT)
>
>
>Shouldn't these really be seperated into two seperate notifier chains?
>One for OS level die() type activity and another for process faults
>which a debugger et. al. would want to know about?

The only real problem is the page fault handler event.  All the other
calls to notify_die() are for rare events (MCA, INIT, restarts, halt,
oops) or for debugging events, none of which are performance critical.
DIE_PAGE_FAULT is only called because kprobes needs it, but that call
is on a performance critical path and it can significantly slow down
the rest of the system.

kprobes should be using its own notify chain to trap page faults, and
the handler for that chain should be optimized away when
CONFIG_KPROBES=n or there are no active probes.

