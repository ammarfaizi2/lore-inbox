Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVGGNyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVGGNyB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVGGNxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:53:54 -0400
Received: from graphe.net ([209.204.138.32]:3716 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261558AbVGGNxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:53:00 -0400
Date: Thu, 7 Jul 2005 06:52:58 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH] Run PCI driver initialization on local node
In-Reply-To: <20050707103918.GV21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507070642370.22915@graphe.net>
References: <20050706133248.GG21330@wotan.suse.de> <Pine.LNX.4.62.0507060934360.20107@graphe.net>
 <20050706175603.GL21330@wotan.suse.de> <Pine.LNX.4.62.0507061232040.720@graphe.net>
 <20050707103918.GV21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Andi Kleen wrote:

> > The slab allocator will do the right thing with the numa slab allocator in 
> > Andrew's tree but not with the one in Linus'tree. The one is Linus tree
> > will just pickup whatever slab is available irregardless of the node.
> 
> It should usually do the right thing because it
> runs on the correct CPUs. The only case that doesn't work 
> is freeing on different CPUs than it was allocated, but hopefully
> that is not too common during system startup.

The current slab wont do that unless you allocate enough entries so 
that a new page is retrieved from the page allocator. Then you may have 
local memory from the slab (if the memory policy is not on round robin).

If you allocate some slab entries on one node then you typically have a 
partially used page from that node. If you then switch to a different 
processor on a different node and then use the slab allocator to get an 
entry for that slab then that partially used page will be used! The
slab allocator will return an entry from the *prior* node.

> And then at some point NUMA aware slab will make it into mainline > I guess.

Hopefully.

> > Only kmalloc_node will make a reasonable attempt to locate the memory on 
> > a specific node.
> 
> You forgot __get_free_pages.

The slab allocator uses alloc_pages and alloc_pages_node
