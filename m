Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966558AbWKOG7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966558AbWKOG7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 01:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966559AbWKOG7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 01:59:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:12715 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S966558AbWKOG7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 01:59:11 -0500
X-Authenticated: #14349625
Subject: Re: [patch] sched: optimize activate_task for RT task - v2
From: Mike Galbraith <efault@gmx.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: nickpiggin@yahoo.com.au, "'Ingo Molnar'" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <000401c70848$520252e0$d834030a@amr.corp.intel.com>
References: <000401c70848$520252e0$d834030a@amr.corp.intel.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 08:00:19 +0100
Message-Id: <1163574019.6175.30.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 15:55 -0800, Chen, Kenneth W wrote:
> Perhaps the following is a better patch compare to earlier one.
> The p->sleep_type are only for SCHED_NORMAL as well, so we can
> bypass them altogether in one shot.
> 
> 
> 
> 
> RT task does not participate in interactiveness priority and thus
> shouldn't be bothered with timestamp and p->sleep_type manipulation
> when task is being put on run queue.  Bypass all of the them with
> a single if (rt_task) test.

Personally, I think it's best to leave it as it is.  With that change,
if someone changes policy while the task is waiting to get cpu, it will
be requeued, and the on-runqueue bonus logic will then end up using
wildly inaccurate information.  Unlikely, true (hmm, what about PI...
afaik, works both ways), but from the correctness standpoint, I think
the information we use in heuristics should always be kept as accurate
as possible.

If you want to shave cycles, IMHO the better investment would be to get
rid of the division in schedule().

	-Mike

