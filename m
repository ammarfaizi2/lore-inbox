Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264796AbTE1Qqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbTE1Qqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:46:52 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:28321 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S264796AbTE1Qqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:46:51 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Date: Wed, 28 May 2003 19:02:35 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@suse.de>, LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200305271031.55554.efocht@hpce.nec.com> <200305272328.27269.efocht@hpce.nec.com> <2640000.1054072312@[10.10.2.4]>
In-Reply-To: <2640000.1054072312@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305281902.35511.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 23:51, Martin J. Bligh wrote:
> > Do you think of something like:
> >
> ># define CAN_MIGRATE_TASK(p,rq,this_cpu)				\
> > 	(HOMENODE_UNSET(p) &&					\ //<--
> > 	 (jiffies - (p)->last_run > cache_decay_ticks) &&	\
> > 		!task_running(rq, p) &&				\
> > 		((p)->cpus_allowed & (1UL << (this_cpu))))
> >
...
>
> My instinct would tell me the first expression should be ||, not &&
> but I'm not 100% sure. 

You're right.

> And is this restricted to just clones? Doesn't
> seem to be, unless that's implicit in homenode_unset?

Hmmm... That's actually the difficult issue with fork vs. clone and
migrating or not. When you clone a small task, you'd usually like to
keep it on the same node. If it's a big task and fault-in a lot of
memory, it could make sense to let it migrate to another node. For
forked tasks it's the same, you mighthave some more COW memory
movement but after that you'll usually be happy if the child went away
from the parent's node if it is a long-running child. Not so for a
short running child. The current compromise:
- start children (no matter whether forked or cloned) on the same CPU
- allow other CPUs to steal freshly forked children by reducing the
cache affinity until the first steal/migration
- ok with chidren who exec soon, they might exec before anyone can
steal them, drop all the pages and find anew life on the optimal node

This way exec'd tasks get properly baklanced, forked/cloned ones get a
better start than in the current scheduler. I'll post a patch on top
of the node affine scheduler doing this in 1-2 days.

Regards,
Erich


