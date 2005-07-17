Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVGQTDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVGQTDC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 15:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVGQTDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 15:03:02 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:64197 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261320AbVGQTDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 15:03:01 -0400
Date: Sun, 17 Jul 2005 15:02:59 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
In-Reply-To: <20050717082000.349b391f.pj@sgi.com>
Message-ID: <Pine.LNX.4.44.0507171330030.4074-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.17.22
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect that the main problem is that this patch is not a mainstream
> kernel feature that will gain multiple uses, but rather provides
> support for a specific vendor middleware product used by that
> vendor and a few closely allied vendors.  If it were smaller or
> less intrusive, such as a driver, this would not be a big problem.
> That's not the case.

yes, that's the crux.  CKRM is all about resolving conflicting resource 
demands in a multi-user, multi-server, multi-purpose machine.  this is a 
huge undertaking, and I'd argue that it's completely inappropriate for 
*most* servers.  that is, computers are generally so damn cheap that 
the clear trend is towards dedicating a machine to a specific purpose, 
rather than running eg, shell/MUA/MTA/FS/DB/etc all on a single machine.  

this is *directly* in conflict with certain prominent products, such as 
the Altix and various less-prominent Linux-based mainframes.  they're all
about partitioning/virtualization - the big-iron aesthetic of splitting up 
a single machine.  note that it's not just about "big", since cluster-based 
approaches can clearly scale far past big-iron, and are in effect statically
partitioned.  yes, buying a hideously expensive single box, and then chopping 
it into little pieces is more than a little bizarre, and is mainly based
on a couple assumptions:

	- that clusters are hard.  really, they aren't.  they are not 
	necessarily higher-maintenance, can be far more robust, usually
	do cost less.  just about the only bad thing about clusters is 
	that they tend to be somewhat larger in size.

	- that partitioning actually makes sense.  the appeal is that if 
	you have a partition to yourself, you can only hurt yourself.
	but it also follows that burstiness in resource demand cannot be 
	overlapped without either constantly tuning the partitions or 
	infringing on the guarantee.

CKRM is one of those things that could be done to Linux, and will benefit a
few, but which will almost certainly hurt *most* of the community.

let me say that the CKRM design is actually quite good.  the issue is whether 
the extensive hooks it requires can be done (at all) in a way which does 
not disporportionately hurt maintainability or efficiency.

CKRM requires hooks into every resource-allocation decision fastpath:
	- if CKRM is not CONFIG, the only overhead is software maintenance.
	- if CKRM is CONFIG but not loaded, the overhead is a pointer check.
	- if CKRM is CONFIG and loaded, the overhead is a pointer check
	and a nontrivial callback.

but really, this is only for CKRM-enforced limits.  CKRM really wants to
change behavior in a more "weighted" way, not just causing an
allocation/fork/packet to fail.  a really meaningful CKRM needs to 
be tightly integrated into each resource manager - effecting each scheduler
(process, memory, IO, net).  I don't really see how full-on CKRM can be 
compiled out, unless these schedulers are made fully pluggable.

finally, I observe that pluggable, class-based resource _limits_ could 
probably be done without callbacks and potentially with low overhead.
but mere limits doesn't meet CKRM's goal of flexible, wide-spread resource 
partitioning within a large, shared machine.

regards, mark hahn.

