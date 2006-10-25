Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWJYCjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWJYCjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 22:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422894AbWJYCjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 22:39:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:45794 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422810AbWJYCjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 22:39:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=pdid/KeFNl8yz6qssdrBpRX85Dzj1YNKDamItMRSjRLk+5/4cHKs+ajp71MOuwoX03g/GL2apFpOXc/QAqY9xZg9lu6+hCxB42oZPsnx+sbnj7aSdIsoKMRoV2sCyk/7i2ZzXNecVJgKMMptijOT65reWWtLYOyd775v6W+Khkw=
Date: Wed, 25 Oct 2006 11:39:14 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: [PATCH] appletalk: handle errors during module_init
Message-ID: <20061025023914.GA12488@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	David Rientjes <rientjes@cs.washington.edu>
References: <20061024085357.GB7703@localhost> <20061024102711.GA27382@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024102711.GA27382@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:27:11PM +0400, Alexey Dobriyan wrote:

> Make sure that module won't load if sysctl table can't be registered,
> instead.

I fixed the patch to do so and handle another errors, too.

Subject: [PATCH] appletalk: handle errors during module_init

This patch makes aarp_proto_init() and atalk_register_sysctl()
return error value to catch ENOMEM errors from module init call.
Then it handles several errors in module_init and makes happen fail.

Also unnessesary SYSCTL ifdef in module_cleanup was removed.

Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 include/linux/atalk.h            |    6 ++---
 net/appletalk/aarp.c             |   12 ++++++----
 net/appletalk/ddp.c              |   45 ++++++++++++++++++++++++++++++++-------
 net/appletalk/sysctl_net_atalk.c |    3 +-
 4 files changed, 49 insertions(+), 17 deletions(-)

Index: work-fault-inject/net/appletalk/sysctl_net_atalk.c
===================================================================
--- work-fault-inject.orig/net/appletalk/sysctl_net_atalk.c
+++ work-fault-inject/net/appletalk/sysctl_net_atalk.c
@@ -71,9 +71,10 @@ static struct ctl_table atalk_root_table
 
 static struct ctl_table_header *atalk_table_header;
 
-void atalk_register_sysctl(void)
+int atalk_register_sysctl(void)
 {
 	atalk_table_header = register_sysctl_table(atalk_root_table, 1);
+	return (atalk_table_header == NULL) ? -ENOMEM : 0;
 }
 
 void atalk_unregister_sysctl(void)
Index: work-fault-inject/net/appletalk/ddp.c
===================================================================
--- work-fault-inject.orig/net/appletalk/ddp.c
+++ work-fault-inject/net/appletalk/ddp.c
@@ -1871,21 +1871,52 @@ static int __init atalk_init(void)
 {
 	int rc = proto_register(&ddp_proto, 0);
 
-	if (rc != 0)
+	if (rc)
 		goto out;
 
-	(void)sock_register(&atalk_family_ops);
+	rc = sock_register(&atalk_family_ops);
+	if (rc)
+		goto out1;
+
 	ddp_dl = register_snap_client(ddp_snap_id, atalk_rcv);
-	if (!ddp_dl)
+	if (!ddp_dl) {
 		printk(atalk_err_snap);
+		rc = -ENOMEM;
+		goto out2;
+	}
 
 	dev_add_pack(&ltalk_packet_type);
 	dev_add_pack(&ppptalk_packet_type);
 
 	register_netdevice_notifier(&ddp_notifier);
-	aarp_proto_init();
-	atalk_proc_init();
-	atalk_register_sysctl();
+
+	rc = aarp_proto_init();
+	if (rc)
+		goto out3;
+
+	rc = atalk_proc_init();
+	if (rc)
+		goto out4;
+
+	rc = atalk_register_sysctl();
+	if (rc)
+		goto out5;
+
+	return 0;
+
+out5:
+	atalk_proc_exit();
+out4:
+	aarp_cleanup_module();	/* General aarp clean-up. */
+out3:
+	unregister_netdevice_notifier(&ddp_notifier);
+	dev_remove_pack(&ltalk_packet_type);
+	dev_remove_pack(&ppptalk_packet_type);
+	unregister_snap_client(ddp_dl);
+out2:
+	sock_unregister(PF_APPLETALK);
+out1:
+	proto_unregister(&ddp_proto);
 out:
 	return rc;
 }
@@ -1902,9 +1933,7 @@ module_init(atalk_init);
  */
 static void __exit atalk_exit(void)
 {
-#ifdef CONFIG_SYSCTL
 	atalk_unregister_sysctl();
-#endif /* CONFIG_SYSCTL */
 	atalk_proc_exit();
 	aarp_cleanup_module();	/* General aarp clean-up. */
 	unregister_netdevice_notifier(&ddp_notifier);
Index: work-fault-inject/include/linux/atalk.h
===================================================================
--- work-fault-inject.orig/include/linux/atalk.h
+++ work-fault-inject/include/linux/atalk.h
@@ -147,7 +147,7 @@ static __inline__ struct elapaarp *aarp_
 #define AARP_RESOLVE_TIME	(10 * HZ)
 
 extern struct datalink_proto *ddp_dl, *aarp_dl;
-extern void aarp_proto_init(void);
+extern int aarp_proto_init(void);
 
 /* Inter module exports */
 
@@ -190,10 +190,10 @@ extern int sysctl_aarp_retransmit_limit;
 extern int sysctl_aarp_resolve_time;
 
 #ifdef CONFIG_SYSCTL
-extern void atalk_register_sysctl(void);
+extern int atalk_register_sysctl(void);
 extern void atalk_unregister_sysctl(void);
 #else
-#define atalk_register_sysctl()		do { } while(0)
+#define atalk_register_sysctl()		({ 0; })
 #define atalk_unregister_sysctl()	do { } while(0)
 #endif
 
Index: work-fault-inject/net/appletalk/aarp.c
===================================================================
--- work-fault-inject.orig/net/appletalk/aarp.c
+++ work-fault-inject/net/appletalk/aarp.c
@@ -858,17 +858,19 @@ static struct notifier_block aarp_notifi
 
 static unsigned char aarp_snap_id[] = { 0x00, 0x00, 0x00, 0x80, 0xF3 };
 
-void __init aarp_proto_init(void)
+int __init aarp_proto_init(void)
 {
 	aarp_dl = register_snap_client(aarp_snap_id, aarp_rcv);
-	if (!aarp_dl)
+	if (!aarp_dl) {
 		printk(KERN_CRIT "Unable to register AARP with SNAP.\n");
-	init_timer(&aarp_timer);
-	aarp_timer.function = aarp_expire_timeout;
-	aarp_timer.data	    = 0;
+		return -ENOMEM;
+	}
+	setup_timer(&aarp_timer, aarp_expire_timeout, 0);
 	aarp_timer.expires  = jiffies + sysctl_aarp_expiry_time;
 	add_timer(&aarp_timer);
 	register_netdevice_notifier(&aarp_notifier);
+
+	return 0;
 }
 
 /* Remove the AARP entries associated with a device. */
