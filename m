Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267801AbTANFnW>; Tue, 14 Jan 2003 00:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267826AbTANFnW>; Tue, 14 Jan 2003 00:43:22 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.216.3.1]:62993 "HELO
	unix144.hosting-network.com") by vger.kernel.org with SMTP
	id <S267801AbTANFnS>; Tue, 14 Jan 2003 00:43:18 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 4.47.79.86
X-Authenticated-Timestamp: 00:51:58(EST) on January 14, 2003
X-HELO-From: [192.168.123.89]
X-Mail-From: <michael@hbaum.com>
X-Sender-IP-Address: 4.47.79.86
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
From: Michael Hohnbaum <michael@hbaum.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Erich Focht <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <000201c2bb97$02bc35e0$29060e09@andrewhcsltgw8>
References: <52570000.1042156448@flay><200301101734.56182.efocht@ess.nec.de>
	<967810000.1042217859@titus> <200301130055.28005.efocht@ess.nec.de>
	<1042507438.24867.153.camel@dyn9-47-17-164.beaverton.ibm.com> 
	<000201c2bb97$02bc35e0$29060e09@andrewhcsltgw8>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Jan 2003 21:50:46 -0800
Message-Id: <1042523478.30434.164.camel@kenai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 20:45, Andrew Theurer wrote:
> > Erich,
> > 
> > I played with this today on my 4 node (16 CPU) NUMAQ.  Spent most
> > of the time working with the first three patches.  What I found was
> > that rebalancing was happening too much between nodes.  I tried a
> > few things to change this, but have not yet settled on the best
> > approach.  A key item to work with is the check in find_busiest_node
> > to determine if the found node is busier enough to warrant stealing
> > from it.  Currently the check is that the node has 125% of the load
> > of the current node.  I think that, for my system at least, we need
> > to add in a constant to this equation.  I tried using 4 and that
> > helped a little.  
> 
> Michael,
> 
> in:
> 
> +static int find_busiest_node(int this_node)
> +{
> + int i, node = this_node, load, this_load, maxload;
> + 
> + this_load = maxload = atomic_read(&node_nr_running[this_node]);
> + for (i = 0; i < numnodes; i++) {
> +  if (i == this_node)
> +   continue;
> +  load = atomic_read(&node_nr_running[i]);
> +  if (load > maxload && (4*load > ((5*4*this_load)/4))) {
> +   maxload = load;
> +   node = i;
> +  }
> + }
> + return node;
> +}
> 
> You changed ((5*4*this_load)/4) to:
>   (5*4*(this_load+4)/4)
> or
>   (4+(5*4*(this_load)/4))  ?

I suppose I should not have been so dang lazy and cut-n-pasted
the line I changed.  The change was (((5*4*this_load)/4) + 4)
which should be the same as your second choice.
> 
> We def need some constant to avoid low load ping pong, right?

Yep.  Without the constant, one could have 6 processes on node
A and 4 on node B, and node B would end up stealing.  While making
a perfect balance, the expense of the off-node traffic does not
justify it.  At least on the NUMAQ box.  It might be justified
for a different NUMA architecture, which is why I propose putting
this check in a macro that can be defined in topology.h for each
architecture.
> 
> Finally I added in the 04 patch, and that helped
> > a lot.  Still, there is too much process movement between nodes.
> 
> perhaps increase INTERNODE_LB?

That is on the list to try.  Martin was mumbling something about
use the system wide load average to help make the inter-node
balance decision.  I'd like to give that a try before tweaking
ITERNODE_LB.
> 
> -Andrew Theurer
> 
            Michael Hohnbaum
            hohnbaum@us.ibm.com

