Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVGGAXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVGGAXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVGFUBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:01:16 -0400
Received: from graphe.net ([209.204.138.32]:22736 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262378AbVGFRHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:07:15 -0400
Date: Wed, 6 Jul 2005 10:07:08 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <20050706164533.GK21330@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0507061006190.20554@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507060933330.20107@graphe.net>
 <20050706164533.GK21330@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Andi Kleen wrote:

> On Wed, Jul 06, 2005 at 09:34:28AM -0700, Christoph Lameter wrote:
> > On Wed, 6 Jul 2005, Andi Kleen wrote:
> > 
> > > -	q = blk_init_queue_node(do_ide_request, &ide_lock,
> > > -				pcibus_to_node(drive->hwif->pci_dev->bus));
> > > +	int node = 0; /* Should be -1 */
> > 
> > Why is this not -1?
> 
> Because there is no code in rc3 that handles -1 in kmalloc_node.
> 
> If you add a patch that handles it then feel free to change.
> But fixing the bootup has the highest priority.
> 
> > 
> > > +		int node = 0; 
> > > +		if (hwif->drives[0].hwif) { 
> > 
> > Also needs to be -1.
> 
> Then it would crash again.

The patch follows. Maybe add that and include a signoff by me?:

Index: linux-2.6.git/mm/slab.c
===================================================================
--- linux-2.6.git.orig/mm/slab.c	2005-07-05 17:03:30.000000000 -0700
+++ linux-2.6.git/mm/slab.c	2005-07-05 18:25:20.000000000 -0700
@@ -2372,6 +2372,9 @@
 	struct slab *slabp;
 	kmem_bufctl_t next;
 
+	if (nodeid == -1)
+		return kmem_cache_alloc_node(cachep, flags);
+
 	for (loop = 0;;loop++) {
 		struct list_head *q;
 
