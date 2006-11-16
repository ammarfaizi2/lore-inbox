Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162108AbWKPA0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162108AbWKPA0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162112AbWKPA0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:26:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:30160 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1162108AbWKPA0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:26:20 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have no memory
Date: Thu, 16 Nov 2006 01:26:01 +0100
User-Agent: KMail/1.9.5
Cc: Martin Bligh <mbligh@mbligh.org>, Christian Krafft <krafft@de.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20061115193049.3457b44c@localhost> <455B8F3A.6030503@mbligh.org> <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0611151440400.23201@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611160126.02016.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 23:41, Christoph Lameter wrote:
> On Wed, 15 Nov 2006, Martin Bligh wrote:
> > A node is an arbitrary container object containing one or more of:
> >
> > CPUs
> > Memory
> > IO bus

+ SPUs on a Cell processor

> > It does not have to contain memory.
>
> I have never seen a node on Linux without memory. I have seen nodes
> without processors and without I/O but not without memory.This seems to be
> something new?

In this particular case, we have a dual-socket Cell/B.E. blade server,
where each of the two CPU-socket/south-bridge/memory combinations is
treated as a separate node. The two points that make this tricky
are:

- we want to be able to boot with the 'mem=512M' option, which effectively
  disables the memory on the second node (each node has 512MiB).
- Each node has 8 SPUs, all of which we want to use. In order to use an
  SPU, we call __add_pages to register the local memory on it, so we have
  struct page pointers we can hand out to user mappings with ->nopage().

The __add_pages call needs to do node local allocations (there are
probably more allocations that have the same problem, but this is the
first one that crashes), which oops when there is no memory registered
at all for that node, instead of returning an error or falling back
on a non-local allocation.

	Arnd <><
