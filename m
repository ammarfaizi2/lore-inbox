Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTF3HWT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTF3HWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:22:19 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:58177 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261561AbTF3HWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:22:18 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B0140536F@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trying to improve /proc/filesystems
Date: Mon, 30 Jun 2003 09:21:00 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I'm trying to do 

nodev		xxx	0
		yyy	2
(or replace nodev by 0->x)

with the following but Linux complains : VFS : unable to mount
root....Someone could help ?

--- linux-2.5.72/fs/filesystems.c	2003-06-22 20:33:07.000000000 +0200
+++ linux-2.5.72FF/fs/filesystems.c	2003-06-29 18:53:08.000000000 +0200
@@ -194,15 +194,25 @@
 
 int get_filesystem_list(char * buf)
 {
-	int len = 0;
+	int len = 0, dev = 0;
 	struct file_system_type * tmp;
+	struct list_head *p;
+	char buf2[6];
 
 	read_lock(&file_systems_lock);
 	tmp = file_systems;
 	while (tmp && len < PAGE_SIZE - 80) {
-		len += sprintf(buf+len, "%s\t%s\n",
+		dev=0;
+		list_for_each(p,&tmp->fs_supers){
+			dev++;
+		} 
+		len += sprintf(buf+len, "%s\t%s\t%d\n",
 			(tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
-			tmp->name);
+			tmp->name,
+			dev);
 		tmp = tmp->next;
 	}
 	read_unlock(&file_systems_lock);

