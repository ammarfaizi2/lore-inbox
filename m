Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWGHUUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWGHUUE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWGHUUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:20:03 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54791 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030318AbWGHUUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:20:01 -0400
Date: Sat, 8 Jul 2006 22:20:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.n
Subject: [2.6 patch] net/atm/clip.c: fix PROC_FS=n compile
Message-ID: <20060708202000.GC5020@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_PROC_FS=n by 
reverting commit dcdb02752ff13a64433c36f2937a58d93ae7a19e:

<--  snip  -->

...
  CC      net/atm/clip.o
net/atm/clip.c: In function ‘atm_clip_init’:
net/atm/clip.c:975: error: ‘atm_proc_root’ undeclared (first use in this function)
net/atm/clip.c:975: error: (Each undeclared identifier is reported only once
net/atm/clip.c:975: error: for each function it appears in.)
net/atm/clip.c:977: error: ‘arp_seq_fops’ undeclared (first use in this function)
make[2]: *** [net/atm/clip.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/atm/clip.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- linux-2.6.17-mm6-full/net/atm/clip.c.old	2006-07-08 13:58:07.000000000 +0200
+++ linux-2.6.17-mm6-full/net/atm/clip.c	2006-07-08 13:55:48.000000000 +0200
@@ -962,7 +962,6 @@
 
 static int __init atm_clip_init(void)
 {
-	struct proc_dir_entry *p;
 	neigh_table_init_no_netlink(&clip_tbl);
 
 	clip_tbl_hook = &clip_tbl;
@@ -972,9 +971,15 @@
 
 	setup_timer(&idle_timer, idle_timer_check, 0);
 
-	p = create_proc_entry("arp", S_IRUGO, atm_proc_root);
-	if (p)
-		p->proc_fops = &arp_seq_fops;
+#ifdef CONFIG_PROC_FS
+	{
+		struct proc_dir_entry *p;
+
+		p = create_proc_entry("arp", S_IRUGO, atm_proc_root);
+		if (p)
+			p->proc_fops = &arp_seq_fops;
+	}
+#endif
 
 	return 0;
 }

