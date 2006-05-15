Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWEOPzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWEOPzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWEOPzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:55:40 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:32656 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1751581AbWEOPzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:55:39 -0400
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="276828638:sNHT224656582"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 41 of 53] ipath - disable interrupts while holding spinlock in RWQE get
X-Message-Flag: Warning: May contain useful information
References: <83f1832c601594846868.1147477406@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 15 May 2006 08:55:37 -0700
In-Reply-To: <83f1832c601594846868.1147477406@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 12 May 2006 16:43:26 -0700")
Message-ID: <ada4pzruvt2.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 15 May 2006 15:55:38.0127 (UTC) FILETIME=[027399F0:01C67838]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > @@ -171,12 +171,13 @@ int ipath_get_rwqe(struct ipath_qp *qp, 
 >  			n = rq->head - rq->tail;
 >  		if (n < srq->limit) {
 >  			srq->limit = 0;
 > -			spin_unlock(&rq->lock);
 > +			spin_unlock_irqrestore(&rq->lock, flags);
 >  			ev.device = qp->ibqp.device;
 >  			ev.element.srq = qp->ibqp.srq;
 >  			ev.event = IB_EVENT_SRQ_LIMIT_REACHED;
 >  			srq->ibsrq.event_handler(&ev,
 >  						 srq->ibsrq.srq_context);
 > +			spin_lock_irqsave(&rq->lock, flags);

ipath_get_rwqe() in the kernel now doesn't even have a flags
variable.  So this looks like a bug introduced earlier in this patch
series.  Please roll the fix up into the place where you added the bug.

 - R.
