Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264765AbUD1MqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264765AbUD1MqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 08:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUD1MqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 08:46:21 -0400
Received: from mx2.redhat.com ([66.187.237.31]:45197 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264765AbUD1MqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 08:46:18 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16527.42815.447695.474344@segfault.boston.redhat.com>
Date: Wed, 28 Apr 2004 08:44:47 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
In-Reply-To: <20040425191543.GV28459@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
	<20040425191543.GV28459@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

mpm> On Thu, Apr 22, 2004 at 11:29:33AM -0400, Jeff Moyer wrote:
>> If netconsole is enabled, and you hit Alt-Sysrq-t, then it will print a
>> small amount of output to the console(s) and then hang the system.  In
>> this case, I'm using the e100 driver, and we end up exhausting the
>> available cbs.  Since we are in interrupt context, the driver's poll
>> routine is never run, and we loop infinitely waiting for resources to
>> free up that never will.  Kernel version is 2.6.5.

mpm> Can you try 2.6.6-rc2? It has a fix to congestion handling that should
mpm> address this.

Is the attached patch the change you are referring to?  If so, I don't see
how this would fix the problem.  I ended up deferring netpoll writes to
process context, which has been working fine for me.  Have I missed
something?

-Jeff

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/13 14:07:53-04:00 mpm@selenic.com 
#   [PATCH] netpoll transmit busy bugfix
#   
#   Fix for handling of full transmit queue when netpoll trap is enabled.
#   
#   From Stelian Pop <stelian@popies.net>
# 
# net/core/netpoll.c
#   2004/04/10 16:19:31-04:00 mpm@selenic.com +3 -9
#   netpoll transmit busy bugfix
# 
diff -Nru a/net/core/netpoll.c b/net/core/netpoll.c
--- a/net/core/netpoll.c	Wed Apr 28 05:43:08 2004
+++ b/net/core/netpoll.c	Wed Apr 28 05:43:08 2004
@@ -163,21 +163,15 @@
 	spin_lock(&np->dev->xmit_lock);
 	np->dev->xmit_lock_owner = smp_processor_id();
 
-	if (netif_queue_stopped(np->dev)) {
-		np->dev->xmit_lock_owner = -1;
-		spin_unlock(&np->dev->xmit_lock);
-
-		netpoll_poll(np);
-		goto repeat;
-	}
-
 	status = np->dev->hard_start_xmit(skb, np->dev);
 	np->dev->xmit_lock_owner = -1;
 	spin_unlock(&np->dev->xmit_lock);
 
 	/* transmit busy */
-	if(status)
+	if(status) {
+		netpoll_poll(np);
 		goto repeat;
+	}
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
