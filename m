Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWGLAGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWGLAGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWGLAGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:06:14 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:47390 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S932277AbWGLAGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:06:13 -0400
X-IronPort-AV: i="4.06,230,1149490800"; 
   d="scan'208"; a="305030599:sNHT32938448"
To: Zach Brown <zach.brown@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] ipoib lockdep warning
X-Message-Flag: Warning: May contain useful information
References: <44B405C8.4040706@oracle.com> <adawtajzra5.fsf@cisco.com>
	<44B433CE.1030103@oracle.com> <adasll7zp0p.fsf@cisco.com>
	<44B439F7.3090008@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 11 Jul 2006 17:06:10 -0700
In-Reply-To: <44B439F7.3090008@oracle.com> (Zach Brown's message of "Tue, 11 Jul 2006 16:53:27 -0700")
Message-ID: <adafyh7znyl.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jul 2006 00:06:11.0483 (UTC) FILETIME=[FBA50EB0:01C6A546]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > So, ugh... maybe the best thing to do is change lib/idr.c to use
 > > spin_lock_irqsave() internally?
 > 
 > I dunno, it seems to have had _irq() locking in the past?  From the
 > comment at the top:
 > 
 >  * Modified by George Anzinger to reuse immediately and to use
 >  * find bit instructions.  Also removed _irq on spinlocks.

Well, _irq would be no good, because we might want to call idr stuff
with interrupts disabled.  But making idr internally _irqsave seems
like the right fix to me.

I think the real issue here is that the sa_query.c stuff wants to use
the idr mechanism to assign "query ids", and other modules want to be
able to start queries from any context.  So if idr uses bare spin_lock
internally, then sa_query.c has no choice but to wrap all idr calls
inside spin_lock_irqsave and do all allocation with GFP_ATOMIC, which
doesn't seem very nice.

 - R.
