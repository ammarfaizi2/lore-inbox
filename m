Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVALTYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVALTYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVALTW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:22:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:37331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261305AbVALTUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:20:16 -0500
Date: Wed, 12 Jan 2005 11:20:15 -0800
From: Chris Wright <chrisw@osdl.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: node_online_map patch kills x86_64
Message-ID: <20050112112015.P24171@build.pdx.osdl.net>
References: <20050111151656.A24171@build.pdx.osdl.net> <20050112000726.GD14443@holomorphy.com> <20050111163504.D24171@build.pdx.osdl.net> <1105555323.8266.2.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105555323.8266.2.camel@arrakis>; from colpatch@us.ibm.com on Wed, Jan 12, 2005 at 10:42:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Dobson (colpatch@us.ibm.com) wrote:
> On Tue, 2005-01-11 at 16:35, Chris Wright wrote:
> > Thanks wli.  Seems Andi understands the issue despite my unintelligible
> > bug report ;-)
> > 
> > thanks,
> > -chris
> 
> So I assume you were trying to saying that backing out the patches makes
> the machine boot, and leaving them in kills it, right?

Yes, exactly.  Not sure which part of my brain was misfiring when I
wrote that gibberish ;-)

> And does Andi's
> "[PATCH] x86_64: Optimize nodemask operations slightly" fix your
> problem?  I'm assuming that's what the reference to "Andi understanding
> the issue" meant?  Or is there still a problem booting x86_64 with the
> numnodes -> node_online_map patches?

The patch from Andi that I tested which fixed the issue for me was:

Index: linux/arch/x86_64/mm/srat.c
===================================================================
--- linux.orig/arch/x86_64/mm/srat.c	2005-01-09 18:19:17.%N +0100
+++ linux/arch/x86_64/mm/srat.c	2005-01-12 02:43:54.%N +0100
@@ -29,8 +29,8 @@
 	if (pxm2node[pxm] == 0xff) {
 		if (num_online_nodes() >= MAX_NUMNODES)
 			return -1;
-		pxm2node[pxm] = num_online_nodes();
-		node_set_online(num_online_nodes());
+		pxm2node[pxm] = num_online_nodes() - 1;
+		node_set_online(pxm2node[pxm]);
 	}
 	return pxm2node[pxm];
 }


This looks like just a straight fix for the following from your patch (AFAICT):

-		pxm2node[pxm] = numnodes - 1;
-		numnodes++;
+		pxm2node[pxm] = num_online_nodes();
+		node_set_online(num_online_nodes());

However, what's in bk is a bit different and it too is working well:

http://linux.bkbits.net:8080/linux-2.6/gnupatch@41e543d4Ujgg-Hk9pyWGiXvs7oXkBw

Hope that clarifies.  Thanks.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
