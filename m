Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWIVXfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWIVXfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWIVXfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:35:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8913 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964930AbWIVXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:35:06 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: More thoughts on getting rid of ZONE_DMA
Date: Sat, 23 Sep 2006 01:34:45 +0200
User-Agent: KMail/1.9.3
Cc: Martin Bligh <mbligh@mbligh.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       akpm@google.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@steeleye.com>, linux-mm@kvack.org
References: <Pine.LNX.4.64.0609212052280.4736@schroedinger.engr.sgi.com> <4514441E.70207@mbligh.org> <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609221321280.9181@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609230134.45355.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 September 2006 22:23, Christoph Lameter wrote:
> Here is an iniitial patch of alloc_pages_range (untested, compiles). 
> Directed reclaim missing. Feedback wanted. There are some comments in the 
> patch where I am at the boundary of my knowledge and it would be good if 
> someone could supply the info needed.


Christoph,

I thought a little more about the problem.

Currently I don't think we can get rid of ZONE_DMA even with your patch.

The problem is that if someone has a workload with lots of pinned pages
(e.g. lots of mlock) then the first 16MB might fill up completely and there 
is no chance at all to free it because it's pinned

This is not theoretical: Andrea originally implemented the keep lower zones free 
heuristics exactly because this happened in the field.

So we need some way to reserve some low memory pages (a "low mem mempool" so to
say). Otherwise it could always run into deadlocks later under load.

As I understand it your goal is to remove knowledge of the DMA zones from
the generic VM to save some cache lines in hot paths.

First ZONE_DMA32 likely needs to be kept in the normal allocator because there 
are just too many potential users of it, and some of them even need fast memory allocation.

But AFAIK all 16MB ZONE_DMA don't need fast allocation, so being a bit
slower for them is ok.

What we could do instead is to have a configurable pool starting at zero with
a special allocator that can allocate ranges in there. This wouldn't need to 
be a 16MB pool, but could be a kernel boot parameter.  This would keep
it completely out of the fast VM path and reach your original goals.

This would also fix aacraid because users of it could just configure a larger 
pool (we could potentially even have a heuristic to size it based on PCI IDs;
this wouldn't deal with hotplug but would be still much better than shifting
it completely to the user) 

-Andi

