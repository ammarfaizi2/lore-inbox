Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTLIDNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbTLIDNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:13:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:34454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262652AbTLIDNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:13:01 -0500
Date: Mon, 8 Dec 2003 19:12:58 -0800
From: Mark Wong <markw@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org, osdldbt-general@lists.sourceforge.net
Subject: Re: hyperthreading performance with dbt-2 on 2.6.0-test11
Message-ID: <20031208191258.A6933@osdlab.pdx.osdl.net>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	linux-kernel@vger.kernel.org, osdldbt-general@lists.sourceforge.net
References: <200312082354.hB8NsqZ17359@mail.osdl.org> <3FD51496.5000500@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3FD51496.5000500@cyberone.com.au>; from piggin@cyberone.com.au on Tue, Dec 09, 2003 at 11:17:26AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 11:17:26AM +1100, Nick Piggin wrote:
> 
> 
> markw@osdl.org wrote:
> 
> >Hello, I have some data with hyperthreading I wanted to share.
> >
> >I've seen about a 15% performance decrease in performance on a 4-way
> >Xeon system when I enable hyperthreading for my DBT-2 workload.  I also
> >gave Ingo's test11-C1 patch that someone pointed me to a try and only
> >saw a 12% decrease. Has anyone found this to be common with any specific
> >workloads?
> >
> >I'm not really sure what to look for, but I do see some changes in the
> >readprofile data, which I've copied in part below.  It appears that the
> >count of schedule, __make_request, and try_to_wake_up are the only
> >functions at the top of the profile that are significantly different.
> >The links I have posted also have pointers to oprofile data as well as
> >annotated assembly source output, if that interests anyone.  If I can
> >provide any other details, let me know.
> >
> 
> Hi Mark,
> It could be cache contention which I think is typically the reason
> hyperthreading can hurt performance. Its basically impossible for
> the scheduler to correct this automatically (access to performance
> counters might make it slightly less impossible).
> 
> Probably the CPU hotplug interface would enable a tool to effectively
> turn HT on or off and it would be up to an administrator to tune
> performance.
> 
> You could try my scheduler patchset if you like. I have recently got
> HT support working (its against test11, you need to turn CONFIG_SMT
> on), although if Ingo's patch doesn't help much, mine probably won't
> either.

Hi Nick,

Went ahead and tried your patch, but it looks like something's wrong.  If
this helps any:

Process postmaster (pid: 1086, threadinfo=f5c40000 task=f5c586b0)
Stack: f5c5007b 0000007b ffffffff c011f488 00000060 00010046 00000005 c322ccc0 
       c322c060 00000002 f5c5bdbc f686cb90 f686cb90 f5c41d4c f7f93940 f5ca6080 
       00000007 00000000 c322ccc0 00006f12 03d99f34 0000033d f5c586b0 f5c41dbc 
Call Trace:                                                                      [<c011f488>] schedule+0x380/0x705
 [<c01ff412>] sys_semtimedop+0x460/0x530
 [<c011e5bb>] find_busiest_group+0x2bc/0x2e3
 [<c02c69ea>] p4_check_ctrs+0xab/0x11b      
 [<c011e5bb>] find_busiest_group+0x2bc/0x2e3
 [<c02c5a5d>] nmi_callback+0x25/0x29        
 [<c014218d>] buffered_rmqueue+0xea/0x199
 [<c010b8f5>] nmi_stack_correct+0x1e/0x2e
 [<c01422eb>] __alloc_pages+0xaf/0x334   
 [<c014007b>] generic_file_aio_write_nolock+0x298/0xa9e
 [<c014d0c2>] do_anonymous_page+0x16a/0x28b            
 [<c014d80b>] handle_mm_fault+0x101/0x1ad  
 [<c011c4f5>] do_page_fault+0x2fa/0x4fc  
 [<c011eb6d>] rebalance_tick+0x8a/0x91 
 [<c02c4368>] oprofile_add_sample+0x9b/0x117
 [<c02c69ea>] p4_check_ctrs+0xab/0x11b      
 [<c0111ec4>] sys_ipc+0x61/0x2ae      
 [<c02c5a5d>] nmi_callback+0x25/0x29
 [<c010c839>] do_nmi+0x39/0x5a      
 [<c010ad4d>] sysenter_past_esp+0x52/0x71
                                         
Code:  Bad EIP value.

