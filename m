Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUJHWkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUJHWkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJHWkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:40:15 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:33160 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S266127AbUJHWjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:39:33 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Sat, 9 Oct 2004 00:37:25 +0200
User-Agent: KMail/1.6.2
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200410081123.45762.efocht@hpce.nec.com> <1382270000.1097245476@[10.10.2.4]>
In-Reply-To: <1382270000.1097245476@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410090037.25128.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 16:24, Martin J. Bligh wrote:
> > On Thursday 07 October 2004 20:13, Martin J. Bligh wrote:
> >> It all just seems like a lot of complexity for a fairly obscure set of
> >> requirements for a very limited group of users, to be honest. Some bits
> >> (eg partitioning system resources hard in exclusive sets) would seem likely
> >> to be used by a much broader audience, and thus are rather more attractive.
> > 
> > May I translate the first sentence to: the requirements and usage
> > models described by Paul (SGI), Simon (Bull) and myself (NEC) are
> > "fairly obscure" and the group of users addressed (those mainly
> > running high performance computing (AKA HPC) applications) is "very
> > limited"? If this is what you want to say then it's you whose view is
> > very limited. Maybe I'm wrong with what you really wanted to say but I
> > remember similar arguing from your side when discussing benchmark
> > results in the context of the node affine scheduler.
> 
> No, I was talking about the non-exclusive part of cpusets that wouldn't
> fit inside another mechanism. The basic partitioning I have no problem
> with, and that seemed to cover most of the requirements, AFAICS.

I was hoping that I did misunderstand you ;-)

> As I've said before, the exclusive stuff makes sense, and is useful to
> a wider audience, I think. Having non-exclusive stuff whilst still 
> requiring physical partioning is what I think is obscure, won't work
> well (cpus_allowed is problematic) and could be done in userspace anyway.

Do you mean non-exclusive or simply overlapping? If you think at the
implementation through sched_domains you really don't need a 1 to 1
mapping between them and cpusets. IMO one could map sched domains
structure from the toplevel cpuset down only as far as the
non-overlapping sets go. Below you just don't use sched domains any
more and leave it to the affinity masks. The logical setup would
anyhow have a first (uppermost) level soft-partitioning the machine,
overlaps don't make sense to me here. Then sched domains already buy
you something. If soft partition 1 allows overlap in the lower levels
(because we want to overcommit the machine here and fear the OpenMP
jobs which pin themselves blindly in their cpuset), just don't
continue mapping sched domains deeper. In soft-partition 2 you may not
allow overlapping subpartitions, so go ahead and map them to sched
domains. It doesn't really add complexity this way, just some IF
statement.

Regards,
Erich


