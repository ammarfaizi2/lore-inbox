Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031812AbWLGHuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031812AbWLGHuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 02:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031814AbWLGHuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 02:50:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58079 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031812AbWLGHuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 02:50:10 -0500
Date: Wed, 6 Dec 2006 23:49:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061206234942.79d6db01.akpm@osdl.org>
In-Reply-To: <20061206224207.8a8335ee.akpm@osdl.org>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
	<20061206075729.b2b6aa52.akpm@osdl.org>
	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
	<20061206224207.8a8335ee.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 22:42:07 -0800
Andrew Morton <akpm@osdl.org> wrote:

> But I wouldn't want to think about an implementation as long as we have
> that WORK_STRUCT_NOAUTOREL horror in there.  Can we just nuke that?  Only
> three drivers need it and I bet they can be modified to use the usual
> mechanisms.

I guess I don't understand exactly what problem the noautorel stuff is
trying to solve.  It _seems_ to me that in all cases we can simply stuff
the old `data' field in alongside the controlling work_struct or
delayed_work which wants to operate on it.

Bridge is the simple case..

diff -puN net/bridge/br_private.h~bridge-avoid-using-noautorel-workqueues net/bridge/br_private.h
--- a/net/bridge/br_private.h~bridge-avoid-using-noautorel-workqueues
+++ a/net/bridge/br_private.h
@@ -83,6 +83,7 @@ struct net_bridge_port
 	struct timer_list		message_age_timer;
 	struct kobject			kobj;
 	struct delayed_work		carrier_check;
+	struct net_device		*carrier_check_dev;
 	struct rcu_head			rcu;
 };
 
diff -puN net/bridge/br_if.c~bridge-avoid-using-noautorel-workqueues net/bridge/br_if.c
--- a/net/bridge/br_if.c~bridge-avoid-using-noautorel-workqueues
+++ a/net/bridge/br_if.c
@@ -83,14 +83,11 @@ static void port_carrier_check(struct wo
 	struct net_device *dev;
 	struct net_bridge *br;
 
-	dev = container_of(work, struct net_bridge_port,
-			   carrier_check.work)->dev;
-	work_release(work);
-
+	p = container_of(work, struct net_bridge_port, carrier_check.work);
+	dev = p->carrier_check_dev;
 	rtnl_lock();
-	p = dev->br_port;
-	if (!p)
-		goto done;
+	if (!dev->br_port)
+		goto done;	/* Can this happen? */
 	br = p->br;
 
 	if (netif_carrier_ok(dev))
@@ -280,7 +277,8 @@ static struct net_bridge_port *new_nbp(s
 	p->port_no = index;
 	br_init_port(p);
 	p->state = BR_STATE_DISABLED;
-	INIT_DELAYED_WORK_NAR(&p->carrier_check, port_carrier_check);
+	p->carrier_check_dev = dev;
+	INIT_DELAYED_WORK(&p->carrier_check, port_carrier_check);
 	br_stp_port_timer_init(p);
 
 	kobject_init(&p->kobj);
_


What am I missing?
