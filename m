Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbUCWWzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbUCWWzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:55:25 -0500
Received: from port-212-202-52-228.reverse.qsc.de ([212.202.52.228]:55227 "EHLO
	gw.localnet") by vger.kernel.org with ESMTP id S262936AbUCWWzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:55:09 -0500
Message-ID: <4060C0A5.40402@trash.net>
Date: Tue, 23 Mar 2004 23:56:37 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Gianfranco Delli Carri <gf.dellicarri@ncc.itgate.net>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Kernel 2.4.25 + VLAN + CBQ disc broken ?
References: <4008E74134355D43998FFFC3D637BB030463DF@starsky.ncc.itgate.net>
In-Reply-To: <4008E74134355D43998FFFC3D637BB030463DF@starsky.ncc.itgate.net>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090502020107040702010806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502020107040702010806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gianfranco Delli Carri wrote:
> Greetigs,
> 
> seems that in a 2.4.25 kernel, with VLAN configured, if you try tu use CBQ disc on VLAN subIf no more traffic can be passed. (NO ARP, NO IP)
> 
> Just after: 
> /sbin/tc qdisc add dev eth1.10 root handle 1 cbq bandwidth 100Mbit avpkt 1000 cell 8
> 
> traffic was dropped.
> 
> Seems that in the same server enviroment the CBQ disc attached to the untagged interface can work without problems.

Please try this patch.

Dave, the txqueuelen=0 fix for pfifo_fast apparently didn't went in
2.4, this is the patch from 2.6, it applies with minor offset.

Best regards
Patrick

--------------090502020107040702010806
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

ChangeSet 1.1561.2.5, 2004/02/18 13:18:53-08:00, kaber@trash.net

	[PKTSCHED]: Use queue limit of 1 when tx_queue_len is zero.


# This patch includes the following deltas:
#	           ChangeSet	1.1561.2.4 -> 1.1561.2.5
#	net/sched/sch_fifo.c	1.7     -> 1.8    
#	net/sched/sch_gred.c	1.13    -> 1.14   
#

 sch_fifo.c |    6 ++++--
 sch_gred.c |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
--- a/net/sched/sch_fifo.c	Wed Feb 18 18:09:39 2004
+++ b/net/sched/sch_fifo.c	Wed Feb 18 18:09:39 2004
@@ -141,10 +141,12 @@
 	struct fifo_sched_data *q = (void*)sch->data;
 
 	if (opt == NULL) {
+		unsigned int limit = sch->dev->tx_queue_len ? : 1;
+
 		if (sch->ops == &bfifo_qdisc_ops)
-			q->limit = sch->dev->tx_queue_len*sch->dev->mtu;
+			q->limit = limit*sch->dev->mtu;
 		else	
-			q->limit = sch->dev->tx_queue_len;
+			q->limit = limit;
 	} else {
 		struct tc_fifo_qopt *ctl = RTA_DATA(opt);
 		if (opt->rta_len < RTA_LENGTH(sizeof(*ctl)))
diff -Nru a/net/sched/sch_gred.c b/net/sched/sch_gred.c
--- a/net/sched/sch_gred.c	Wed Feb 18 18:09:39 2004
+++ b/net/sched/sch_gred.c	Wed Feb 18 18:09:39 2004
@@ -110,7 +110,7 @@
 	unsigned long	qave=0;	
 	int i=0;
 
-	if (!t->initd && skb_queue_len(&sch->q) < sch->dev->tx_queue_len) {
+	if (!t->initd && skb_queue_len(&sch->q) < (sch->dev->tx_queue_len ? : 1)) {
 		D2PRINTK("NO GRED Queues setup yet! Enqueued anyway\n");
 		goto do_enqueue;
 	}

--------------090502020107040702010806--
