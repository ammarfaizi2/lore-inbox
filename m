Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVAVAbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVAVAbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVAVAay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 19:30:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:35523 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262636AbVAVA2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 19:28:42 -0500
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft
	rt	scheduling
From: utz lehmann <lkml@s2y4n2c.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>,
       alexn@dsv.su.se
In-Reply-To: <41F194DC.40603@kolivas.org>
References: <41EEE1B1.9080909@kolivas.org>
	 <1106350245.4442.5.camel@segv.aura.of.mankind> <41F194DC.40603@kolivas.org>
Content-Type: text/plain
Date: Sat, 22 Jan 2005 01:28:35 +0100
Message-Id: <1106353715.4442.20.camel@segv.aura.of.mankind>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a3828f1c4d839cf12e8a3b808f7ed34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-22 at 10:48 +1100, Con Kolivas wrote:
> utz lehmann wrote:
> > Hi
> > 
> > I dislike the behavior of the SCHED_ISO patch that iso tasks are
> > degraded to SCHED_NORMAL if they exceed the limit.
> > IMHO it's better to throttle them at the iso_cpu limit.
> > 
> > I have modified Con's iso2 patch to do this. If iso_cpu > 50 iso tasks
> > only get stalled for 1 tick (1ms on x86).
> 
> Some tasks are so cache intensive they would make almost no forward 
> progress running for only 1ms.

Ok. The throttle duration can be exceed.
What is a good value? 5ms, 10ms?
 
> 
> > Fortunately there is a currently unused task prio (MAX_RT_PRIO-1) [1]. I
> 
> Your implementation is not correct. The "prio" field of real time tasks 
> is determined by MAX_RT_PRIO-1-rt_priority. Therefore you're limiting 
> the best real time priority, not the other way around.

Really? The task prios are (lower value is higher priority):

0
..			For SCHED_FIFO/SCHED_RR (rt_priority 99..1)
98	MAX_RT_PRIO-2

99	MAX_RT_PRIO-1 	ISO_PRIO (rt_priority 0)	

100	MAX_RT_PRIO
..			For SCHED_NORMAL
139	MAX_PRIO-1

ISO_PRIO is between the SCHED_FIFO/SCHED_RR and the SCHED_NORMAL range.

> 
> Throttling them for only 1ms will make it very easy to starve the system 
>   with 1 or more short running (<1ms) SCHED_NORMAL tasks running. Lower 
> priority tasks will never run.
> 
> Cheers,
> Con

