Return-Path: <linux-kernel-owner+w=401wt.eu-S932247AbXADDeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXADDeo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 22:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbXADDeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 22:34:44 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:46162 "EHLO
	mta11.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbXADDen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 22:34:43 -0500
Date: Wed, 3 Jan 2007 21:34:40 -0600
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Carol Hebert <cah@us.ibm.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Developers <openipmi-developer@lists.sourceforge.net>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       OpenIPMI@sc8-sf-spam2-b.sourceforge.net
Subject: Re: [Openipmi-developer] [PATCH] IPMI: Fix some RCU problems
Message-ID: <20070104033440.GA27532@localdomain>
Reply-To: minyard@acm.org
References: <20070103153130.GB16063@localdomain> <20070103132232.f924227e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103132232.f924227e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 01:22:32PM -0800, Andrew Morton wrote:
> It's nice to always have a comment explaining the use of open-coded
> barriers.  Because often the reader is left wondered what on earth it's
> barriering against what on earth else.
> 

Ok, here it is...


Andrew asked that the open-coded barriers be commented, so here it
is.  I also realized that one of the read barriers was in an area
where the protecting mutex was held, so no read barrier was needed.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
===================================================================
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_msghandler.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
@@ -839,7 +839,6 @@ int ipmi_create_user(unsigned int       
 	goto out_kfree;
 
  found:
-	smp_rmb();
 	/* Note that each existing user holds a refcount to the interface. */
 	kref_get(&intf->refcount);
 
@@ -2762,10 +2761,15 @@ int ipmi_register_smi(struct ipmi_smi_ha
 		synchronize_rcu();
 		kref_put(&intf->refcount, intf_free);
 	} else {
-		/* After this point the interface is legal to use. */
-		smp_wmb(); /* Keep memory order straight for RCU readers. */
+		/*
+		 * Keep memory order straight for RCU readers.  Make
+		 * sure everything else is committed to memory before
+		 * setting intf_num to mark the interface valid.
+		 */
+		smp_wmb();
 		intf->intf_num = i;
 		mutex_unlock(&ipmi_interfaces_mutex);
+		/* After this point the interface is legal to use. */
 		call_smi_watchers(i, intf->si_dev);
 		mutex_unlock(&smi_watchers_mutex);
 	}
@@ -3927,6 +3931,12 @@ static void send_panic_events(char *str)
 			/* Interface was not ready yet. */
 			continue;
 
+		/*
+		 * intf_num is used as an marker to tell if the
+		 * interface is valid.  Thus we need a read barrier to
+		 * make sure data fetched before checking intf_num
+		 * won't be used.
+		 */
 		smp_rmb();
 
 		/* First job here is to figure out where to send the
