Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVAMAii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVAMAii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVAMAgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:36:09 -0500
Received: from ns.suse.de ([195.135.220.2]:57068 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261513AbVALWA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:00:59 -0500
Date: Wed, 12 Jan 2005 23:00:55 +0100
From: Andi Kleen <ak@suse.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       discuss@x86-64.org, vandrove@vc.cvut.cz,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86_64: Fix ACPI NUMA parsing
Message-ID: <20050112220055.GA590@wotan.suse.de>
References: <20050112070130.GB532@wotan.suse.de> <1105567009.8266.11.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105567009.8266.11.camel@arrakis>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 01:56:49PM -0800, Matthew Dobson wrote:
> On Tue, 2005-01-11 at 23:01, Andi Kleen wrote:
> > Fix SRAT NUMA parsing
> > 
> > Fix fallout from the recent nodemask_t changes. The node ids assigned 
> > in the SRAT parser were off by one.
> > 
> > I added a new first_unset_node() function to nodemask.h to allocate
> > IDs sanely.
> > 
> > Signed-off-by: Andi Kleen <ak@suse.de>
> > 
> > Index: linux/arch/x86_64/mm/srat.c
> > ===================================================================
> > --- linux.orig/arch/x86_64/mm/srat.c	2005-01-09 18:19:17.%N +0100
> > +++ linux/arch/x86_64/mm/srat.c	2005-01-12 04:15:43.%N +0100
> > @@ -20,17 +20,20 @@
> >  
> >  static struct acpi_table_slit *acpi_slit;
> >  
> > -static DECLARE_BITMAP(nodes_parsed, MAX_NUMNODES) __initdata;
> > +static nodemask_t nodes_parsed __initdata;
> > +static nodemask_t nodes_found __initdata;
> >  static struct node nodes[MAX_NUMNODES] __initdata;
> >  static __u8  pxm2node[256] __initdata = { [0 ... 255] = 0xff };
> >  
> >  static __init int setup_node(int pxm)
> >  {
> > -	if (pxm2node[pxm] == 0xff) {
> > -		if (num_online_nodes() >= MAX_NUMNODES)
> > +	unsigned node = pxm2node[pxm];
> > +	if (node == 0xff) {
> > +		if (nodes_weight(nodes_found) >= MAX_NUMNODES)
> >  			return -1;
> > -		pxm2node[pxm] = num_online_nodes();
> > -		node_set_online(num_online_nodes());
> > +		node = first_unset_node(nodes_found); 
> > +		node_set(node, nodes_found);
> > +		pxm2node[pxm] = node;
> >  	}
> >  	return pxm2node[pxm];
> >  }
> 
> This snippet looks incorrect because first_unset_node() can return
> MAX_NUMNODES, which isn't a valid node number, nor is it valid to set a
> bit >= MAX_NUMNODES in a nodemask.  Although, this is init code, so

The nodes_weight check handles this. 

> there shouldn't be other CPUs messing with the nodes_found mask at the
> same time, and you do check that there are unset bits in nodes_found
> before the first_unset_node() call, so I'm probably wrong.  Is there any
> reason you don't just do all these checks on node_online_map?  ie:
> 
> 	if (nodes_weight(node_online_map) >= MAX_NUMNODES)
> 		return -1;
> 	node = first_unset_node(node_online_map); 
> 	node_set(node, nodes_found);
> 	pxm2node[pxm] = node;
> 
> The extra nodes_found bitmask seems unnecessary?  I like the idea of the
> first_unset_node() function, though.

It keeps clean global state in case there is an error and we fall 
back to non NUMA.

-Andi
