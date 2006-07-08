Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWGHAFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWGHAFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWGHAFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:05:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9154 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932423AbWGHAFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:14 -0400
Date: Fri, 7 Jul 2006 17:05:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 0/8] Optional ZONE_DMA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optional ZONE_DMA

ZONE_DMA is usually used for ISA DMA devices. Typically modern hardware
does not have any of these anymore. We frequently do not need
the zone anymore.

This patch allows to make the configuration of the kernel for
ZONE_DMA dependend on the user choosing to support ISA DMA.
If ISA DMA is not supported then i386 systems f.e. can be
configured using a single ZONE_NORMAL. The overhead of maintaining
multiple zones and balancing page use between the different
zone is then gone. My i386 system now runs with a single zone.

On x86_64 systems also usually we do not need ZONE_DMA since there
are barely any ISA DMA devices around (or are you still using a floppy?).
So for most cases the zone can be dropped. Also if the x86_64 systems
has less than 4G RAM or DMA controllers that actually can do 64 bit
then we also do not need ZONE_DMA32. My x86_64 system has 1G of
memory therefore I can run with a single zone.

SGI's ia64 systems only use one zone. A numa system with a single
zone will have one zone per node which makes the association between
nodes and zones simpler.

This patchset is build on top of the "Reduce Zones" patchset V1 that was
posted earlier today. It will make ZONE_DMA configurable like
the other zones. Then it introduces a SINGLE_ZONE macro that is set
if the system has only a single zone.

Single zone systems do no need the loops over all zones. We can also return
constants for a lot of important VM macros. Finally the policy zone
determination in the mempolicy layer becomes trivial.

Note that this is an RFC only. In order for this to work cleanly we need to
mark all device drives according to what type of DMA controller they support.
If its a ISA DMA controller then we would need to enable ZONE_DMA. If its
a 32 bit controller and we support >4G of memory then we need to enable ZONE_DMA32.

This was tested on i386 and x86_64 in UP and SMP mode.

