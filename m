Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTANE2P>; Mon, 13 Jan 2003 23:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267447AbTANE2P>; Mon, 13 Jan 2003 23:28:15 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7050 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267444AbTANE2O>;
	Mon, 13 Jan 2003 23:28:14 -0500
Message-ID: <000201c2bb97$02bc35e0$29060e09@andrewhcsltgw8>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Michael Hohnbaum" <hohnbaum@us.ibm.com>,
       "Erich Focht" <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, "Robert Love" <rml@tech9.net>,
       "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "lse-tech" <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay><200301101734.56182.efocht@ess.nec.de> <967810000.1042217859@titus> <200301130055.28005.efocht@ess.nec.de> <1042507438.24867.153.camel@dyn9-47-17-164.beaverton.ibm.com>
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
Date: Mon, 13 Jan 2003 20:45:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erich,
> 
> I played with this today on my 4 node (16 CPU) NUMAQ.  Spent most
> of the time working with the first three patches.  What I found was
> that rebalancing was happening too much between nodes.  I tried a
> few things to change this, but have not yet settled on the best
> approach.  A key item to work with is the check in find_busiest_node
> to determine if the found node is busier enough to warrant stealing
> from it.  Currently the check is that the node has 125% of the load
> of the current node.  I think that, for my system at least, we need
> to add in a constant to this equation.  I tried using 4 and that
> helped a little.  

Michael,

in:

+static int find_busiest_node(int this_node)
+{
+ int i, node = this_node, load, this_load, maxload;
+ 
+ this_load = maxload = atomic_read(&node_nr_running[this_node]);
+ for (i = 0; i < numnodes; i++) {
+  if (i == this_node)
+   continue;
+  load = atomic_read(&node_nr_running[i]);
+  if (load > maxload && (4*load > ((5*4*this_load)/4))) {
+   maxload = load;
+   node = i;
+  }
+ }
+ return node;
+}

You changed ((5*4*this_load)/4) to:
  (5*4*(this_load+4)/4)
or
  (4+(5*4*(this_load)/4))  ?

We def need some constant to avoid low load ping pong, right?

Finally I added in the 04 patch, and that helped
> a lot.  Still, there is too much process movement between nodes.

perhaps increase INTERNODE_LB?

-Andrew Theurer


