Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVDKOvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVDKOvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDKOvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:51:18 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:59564 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261788AbVDKOvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:51:12 -0400
Date: Mon, 11 Apr 2005 18:49:52 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Thomas Graf <tgraf@suug.ch>
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>
Subject: [2/1] connector/CBUS: new messaging subsystem. Revision number
 next.
Message-ID: <20050411184952.259ec639@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050411133239.GM26731@postel.suug.ch>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	<20050411133239.GM26731@postel.suug.ch>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Mon, 11 Apr 2005 18:50:06 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some nlmsg alignment cleanups. Documentation module cleanups.

Thanks, Thomas.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

* looking for johnpol@2ka.mipt.ru-2004/connector--main--0--patch-47 to compare with
* comparing to johnpol@2ka.mipt.ru-2004/connector--main--0--patch-47
M  cn_test.c
M  connector.c

* modified files

--- orig/Documentation/connector/cn_test.c
+++ mod/Documentation/connector/cn_test.c
@@ -55,14 +55,14 @@
 	
 	size = NLMSG_SPACE(size0);
 
-	skb = alloc_skb(size, GFP_ATOMIC);
+	skb = alloc_skb(size, GFP_KERNEL);
 	if (!skb) {
 		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
 
 		return -ENOMEM;
 	}
 
-	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size - sizeof(*nlh));
+	nlh = NLMSG_PUT(skb, 0, 0x123, NLMSG_DONE, size0);
 
 	msg = (struct cn_msg *)NLMSG_DATA(nlh);
 
@@ -104,7 +104,6 @@
 	req->range = 10;
 	
 	NETLINK_CB(skb).dst_groups = ctl->group;
-	//netlink_broadcast(nls, skb, 0, ctl->group, GFP_ATOMIC);
 	netlink_unicast(nls, skb, 0, 0);
 
 	printk(KERN_INFO "Request was sent. Group=0x%x.\n", ctl->group);
@@ -124,8 +123,7 @@
 	char data[32];
 
 	m = kmalloc(sizeof(*m) + sizeof(data), GFP_ATOMIC);
-	if (m)
-	{
+	if (m) {
 		memset(m, 0, sizeof(*m) + sizeof(data));
 
 		memcpy(&m->id, &cn_test_id, sizeof(m->id));
@@ -136,8 +134,8 @@
 
 		memcpy(m+1, data, m->len);
 		
-		cbus_insert(m);
-		//cn_netlink_send(m, 0);
+		cbus_insert(m, GFP_ATOMIC);
+		//cn_netlink_send(m, 0, GFP_ATOMIC);
 		kfree(m);
 	}
 


--- orig/drivers/connector/connector.c
+++ mod/drivers/connector/connector.c
@@ -100,15 +100,15 @@
 	else
 		groups = __groups;
 
-	size = NLMSG_SPACE(sizeof(*msg) + msg->len);
+	size = sizeof(*msg) + msg->len;
 
-	skb = alloc_skb(size, gfp_mask);
+	skb = alloc_skb(NLMSG_SPACE(size), gfp_mask);
 	if (!skb) {
-		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", size);
+		printk(KERN_ERR "Failed to allocate new skb with size=%u.\n", NLMSG_SPACE(size));
 		return -ENOMEM;
 	}
 
-	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - NLMSG_ALIGN(sizeof(*nlh)));
+	nlh = NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size);
 
 	data = (struct cn_msg *)NLMSG_DATA(nlh);
 





	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
