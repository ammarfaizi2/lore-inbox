Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTKPWCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTKPWCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 17:02:04 -0500
Received: from continuum.cm.nu ([216.113.193.225]:14976 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S262575AbTKPWCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 17:02:01 -0500
Date: Sun, 16 Nov 2003 14:02:00 -0800
From: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
Message-ID: <20031116220200.GA1446@cm.nu>
References: <20031112182219.GA2921@cm.nu> <Pine.LNX.4.44.0311151029310.10014-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311151029310.10014-100000@logos.cnet>
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's a database machine running MySQL and Postgres.  The
> > MySQL server runs about 4 queries/sec and PostGres only as
> > needed.  It also does some minor mail service, say 2
> > messages per minute and runs apache at about 10 requests
> > per minute.
> > 
> > > > There are no significant driver changes in -pre4 that could affect you.
> > > > 
> > > > Can you please try with mem=900M? I suspect something in the VM changes
> > > > might be causing this.
> > 
> > Just tried with mem=900m and subsequently mem=850m so as no
> > himem pages were available with no effect.  Machine still
> > crashed.

Hi,

Well, I tried backing out the vm changes from pre4, no
luck so started disabling things.  So far, it seems my
firewall script is at fault.  I looked through the
pre3-pre4 diff and the only change to the nat code is a
one-liner.

# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/04	laforge@netfilter.org	1.1063.41.4
# [NETFILTER]: NAT range calculation fix.
# 
# This patch fixes a logic bug in NAT range calculations, which also
# causes a large slowdown when ICMP floods go through NAT.
# 
# Author: Karlis Piesenieks
# --------------------------------------------
diff -Nru a/net/ipv4/netfilter/ip_nat_core.c b/net/ipv4/netfilter/ip_nat_core.c
--- a/net/ipv4/netfilter/ip_nat_core.c	Sun Nov 16 13:41:25 2003
+++ b/net/ipv4/netfilter/ip_nat_core.c	Sun Nov 16 13:41:25 2003
@@ -157,8 +157,8 @@
 				continue;
 		}
 
-		if ((mr->range[i].flags & IP_NAT_RANGE_PROTO_SPECIFIED)
-		    && proto->in_range(&newtuple, IP_NAT_MANIP_SRC,
+		if (!(mr->range[i].flags & IP_NAT_RANGE_PROTO_SPECIFIED)
+		    || proto->in_range(&newtuple, IP_NAT_MANIP_SRC,
 				       &mr->range[i].min, &mr->range[i].max))
 			return 1;
 	}

Reversing that change has thus far fixed things over here
but time will tell.  Is there any possible way that that
particular change is somehow not smp safe?

Shane
