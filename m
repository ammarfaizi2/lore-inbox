Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVGOWM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVGOWM2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGOWM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:12:27 -0400
Received: from smtp06.auna.com ([62.81.186.16]:9436 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261799AbVGOWLr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:11:47 -0400
Date: Fri, 15 Jul 2005 22:11:46 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: [PATCH] fix kmalloc in IDE
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1121465068l.13352l.0l@werewolf.able.es> (from
	jamagallon@able.es on Sat Jul 16 00:04:28 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1121465506l.13352l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.11] Login:jamagallon@able.es Fecha:Sat, 16 Jul 2005 00:11:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, J.A. Magallon wrote:
> 
> On 07.15, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
> > 

--- linux-2.6.git.orig/drivers/ide/ide-probe.c	2005-06-23 11:38:02.000000000 -0700
+++ linux-2.6.git/drivers/ide/ide-probe.c	2005-07-07 10:22:02.000000000 -0700
@@ -960,6 +960,15 @@
 }
 #endif /* MAX_HWIFS > 1 */
 
+static inline int hwif_to_node(ide_hwif_t *hwif)
+{
+	if (hwif && hwif->pci_dev)
+		return pcibus_to_node(hwif->pci_dev->bus);
+	else
+		/* Add ways to determine the node of other busses here */
+		return -1;
+}
+
 /*
  * init request queue
  */
@@ -978,8 +987,7 @@
 	 *	do not.
 	 */
 
-	q = blk_init_queue_node(do_ide_request, &ide_lock,
-				pcibus_to_node(drive->hwif->pci_dev->bus));
+	q = blk_init_queue_node(do_ide_request, &ide_lock, hwif_to_node(hwif));
 	if (!q)
 		return 1;
 
@@ -1097,7 +1105,7 @@
 		spin_unlock_irq(&ide_lock);
 	} else {
 		hwgroup = kmalloc_node(sizeof(ide_hwgroup_t), GFP_KERNEL,
-			pcibus_to_node(hwif->drives[0].hwif->pci_dev->bus));
+					hwif_to_node(hwif->drives[0].hwif));
 		if (!hwgroup)
 	       		goto out_up;
 


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.12-jam9 (gcc 4.0.1 (4.0.1-0.2mdk for Mandriva Linux release 2006.0))


