Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUHKXH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUHKXH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUHKXEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:04:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7126 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268296AbUHKWr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:47:58 -0400
Date: Thu, 12 Aug 2004 00:47:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, netdev@oss.sgi.com
Subject: [2.6 patch] atalk compile errors with SYSCTL=n
Message-ID: <20040811224747.GQ26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error in 2.6.8-rc4-mm1 (but it 
doesn't seem to be specific to -mm) with CONFIG_SYSCTL=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o(.init.text+0x74db): In function `atalk_init':
: undefined reference to `atalk_register_sysctl'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes this issue:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1-full/net/appletalk/ddp.c.old	2004-08-12 00:44:33.000000000 +0200
+++ linux-2.6.8-rc4-mm1-full/net/appletalk/ddp.c	2004-08-12 00:45:08.000000000 +0200
@@ -68,8 +68,10 @@
 				     struct atalk_addr *sa);
 extern void aarp_proxy_remove(struct net_device *dev, struct atalk_addr *sa);
 
+#ifdef CONFIG_SYSCTL
 extern void atalk_register_sysctl(void);
 extern void atalk_unregister_sysctl(void);
+#endif
 
 struct datalink_proto *ddp_dl, *aarp_dl;
 static struct proto_ops atalk_dgram_ops;
@@ -1905,7 +1907,9 @@
 	register_netdevice_notifier(&ddp_notifier);
 	aarp_proto_init();
 	atalk_proc_init();
+#ifdef CONFIG_SYSCTL
 	atalk_register_sysctl();
+#endif
 	return 0;
 }
 module_init(atalk_init);

