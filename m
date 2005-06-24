Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVFXOsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVFXOsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 10:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVFXOsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 10:48:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56993 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261535AbVFXOsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 10:48:46 -0400
Date: Fri, 24 Jun 2005 10:48:22 -0400
From: Neil Horman <nhorman@redhat.com>
To: Julian Anastasov <ja@ssi.bg>
Cc: Neil Horman <nhorman@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Wensong Zhang <wensong@linux-vs.org>, akpm@osdl.org, netdev@oss.sgi.com
Subject: Re: [Patch] ipvs: close race conditions on ip_vs_conn_tab list modification
Message-ID: <20050624144822.GD21499@hmsendeavour.rdu.redhat.com>
References: <20050623183926.GI16783@hmsendeavour.rdu.redhat.com> <Pine.LNX.4.58.0506241046280.1690@u.domain.uli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506241046280.1690@u.domain.uli>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 11:46:21AM +0300, Julian Anastasov wrote:
> 
> 	Hello,
> 
> 	adding netdev to CC
> 
> On Thu, 23 Jun 2005, Neil Horman wrote:
><snip> 
> 	Looks ok but can you test an extended version:
> 
> - remove these atomic_inc for cp and ct and the corresponding
> __ip_vs_conn_put from ip_vs_conn_expire_now
> 
> - do the same for ip_vs_random_dropentry, it looks wrong in the same
> way because it is not running anymore together with the connection 
> expiration in same sltimer_handler
> 
> 	Also, 2.4 needs the same changes, I hope you can continue?
> 
> Regards
> 
> --
> Julian Anastasov <ja@ssi.bg>

No problem.  New patch attached with the above corrections/enhancements made.
I've tested them here, and had good results.

Signed-off-by: Neil Horman <nhorman@redhat.com>

 ip_vs_conn.c |   15 ---------------
 1 files changed, 15 deletions(-)


--- linux-2.6.git/net/ipv4/ipvs/ip_vs_conn.c.orig	2005-06-23 13:11:00.000000000 -0400
+++ linux-2.6.git/net/ipv4/ipvs/ip_vs_conn.c	2005-06-24 08:57:30.000000000 -0400
@@ -548,7 +548,6 @@
 {
 	if (del_timer(&cp->timer))
 		mod_timer(&cp->timer, jiffies);
-	__ip_vs_conn_put(cp);
 }
 
 
@@ -801,21 +800,12 @@
 					continue;
 			}
 
-			/*
-			 * Drop the entry, and drop its ct if not referenced
-			 */
-			atomic_inc(&cp->refcnt);
-			ct_write_unlock(hash);
-
-			if ((ct = cp->control))
-				atomic_inc(&ct->refcnt);
 			IP_VS_DBG(4, "del connection\n");
 			ip_vs_conn_expire_now(cp);
 			if (ct) {
 				IP_VS_DBG(4, "del conn template\n");
 				ip_vs_conn_expire_now(ct);
 			}
-			ct_write_lock(hash);
 		}
 		ct_write_unlock(hash);
 	}
@@ -839,18 +829,13 @@
 		ct_write_lock_bh(idx);
 
 		list_for_each_entry(cp, &ip_vs_conn_tab[idx], c_list) {
-			atomic_inc(&cp->refcnt);
-			ct_write_unlock(idx);
 
-			if ((ct = cp->control))
-				atomic_inc(&ct->refcnt);
 			IP_VS_DBG(4, "del connection\n");
 			ip_vs_conn_expire_now(cp);
 			if (ct) {
 				IP_VS_DBG(4, "del conn template\n");
 				ip_vs_conn_expire_now(ct);
 			}
-			ct_write_lock(idx);
 		}
 		ct_write_unlock_bh(idx);
 	}
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
