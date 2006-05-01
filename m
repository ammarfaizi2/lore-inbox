Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWEANtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWEANtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 09:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWEANtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 09:49:42 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:64985 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932106AbWEANtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 09:49:40 -0400
Date: Mon, 1 May 2006 15:49:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2/4] Use of capable_light()
In-Reply-To: <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0605011549000.31804@yvahk01.tjqt.qr>
References: <20060417162345.GA9609@infradead.org>
 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
 <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH 2/4] Use of capable_light()

capable() now behaves like (capable_light() && is_superadm). Since some
operations are allowed by subadmins too, it suffices to use
capable_light().


Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/arch/alpha/kernel/pci-noop.c linux-2.6.17-rc3+/arch/alpha/kernel/pci-noop.c
--- linux-2.6.17-rc3~/arch/alpha/kernel/pci-noop.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/arch/alpha/kernel/pci-noop.c	2006-04-30 22:05:33.263048000 +0200
@@ -89,7 +89,7 @@ asmlinkage long
 sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 		   unsigned long off, unsigned long len, void *buf)
 {
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable_light(CAP_SYS_ADMIN))
 		return -EPERM;
 	else
 		return -ENODEV;
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/drivers/char/lp.c linux-2.6.17-rc3+/drivers/char/lp.c
--- linux-2.6.17-rc3~/drivers/char/lp.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/drivers/char/lp.c	2006-04-30 22:28:53.433048000 +0200
@@ -633,7 +633,7 @@ static int lp_ioctl(struct inode *inode,
 			if (copy_to_user(argp, &LP_STAT(minor),
 					sizeof(struct lp_stats)))
 				return -EFAULT;
-			if (capable(CAP_SYS_ADMIN))
+			if (capable_light(CAP_SYS_ADMIN))
 				memset(&LP_STAT(minor), 0,
 						sizeof(struct lp_stats));
 			break;
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/drivers/firmware/efivars.c linux-2.6.17-rc3+/drivers/firmware/efivars.c
--- linux-2.6.17-rc3~/drivers/firmware/efivars.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/drivers/firmware/efivars.c	2006-04-30 22:29:38.913048000 +0200
@@ -354,7 +354,7 @@ static ssize_t efivar_attr_show(struct k
 	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
 	ssize_t ret = -EIO;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable_light(CAP_SYS_ADMIN))
 		return -EACCES;
 
 	if (efivar_attr->show) {
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/drivers/pci/pci-sysfs.c linux-2.6.17-rc3+/drivers/pci/pci-sysfs.c
--- linux-2.6.17-rc3~/drivers/pci/pci-sysfs.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/drivers/pci/pci-sysfs.c	2006-04-30 22:31:33.873048000 +0200
@@ -113,7 +113,7 @@ pci_read_config(struct kobject *kobj, ch
 	u8 *data = (u8*) buf;
 
 	/* Several chips lock up trying to read undefined config space */
-	if (capable(CAP_SYS_ADMIN)) {
+	if (capable_light(CAP_SYS_ADMIN)) {
 		size = dev->cfg_size;
 	} else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 		size = 128;
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/drivers/pci/proc.c linux-2.6.17-rc3+/drivers/pci/proc.c
--- linux-2.6.17-rc3~/drivers/pci/proc.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/drivers/pci/proc.c	2006-04-30 22:31:42.213048000 +0200
@@ -60,7 +60,7 @@ proc_bus_pci_read(struct file *file, cha
 	 * undefined locations (think of Intel PIIX4 as a typical example).
 	 */
 
-	if (capable(CAP_SYS_ADMIN))
+	if (capable_light(CAP_SYS_ADMIN))
 		size = dev->cfg_size;
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/drivers/pci/syscall.c linux-2.6.17-rc3+/drivers/pci/syscall.c
--- linux-2.6.17-rc3~/drivers/pci/syscall.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/drivers/pci/syscall.c	2006-04-30 22:31:51.863048000 +0200
@@ -27,7 +27,7 @@ sys_pciconfig_read(unsigned long bus, un
 	long err, cfg_ret;
 
 	err = -EPERM;
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable_light(CAP_SYS_ADMIN))
 		goto error;
 
 	err = -ENODEV;
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/fs/quota.c linux-2.6.17-rc3+/fs/quota.c
--- linux-2.6.17-rc3~/fs/quota.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/fs/quota.c	2006-04-30 22:40:03.483048000 +0200
@@ -81,11 +81,11 @@ static int generic_quotactl_valid(struct
 	if (cmd == Q_GETQUOTA) {
 		if (((type == USRQUOTA && current->euid != id) ||
 		     (type == GRPQUOTA && !in_egroup_p(id))) &&
-		    !capable(CAP_SYS_ADMIN))
+		    !capable_light(CAP_SYS_ADMIN))
 			return -EPERM;
 	}
 	else if (cmd != Q_GETFMT && cmd != Q_SYNC && cmd != Q_GETINFO)
-		if (!capable(CAP_SYS_ADMIN))
+		if (!capable_light(CAP_SYS_ADMIN))
 			return -EPERM;
 
 	return 0;
@@ -132,10 +132,10 @@ static int xqm_quotactl_valid(struct sup
 	if (cmd == Q_XGETQUOTA) {
 		if (((type == XQM_USRQUOTA && current->euid != id) ||
 		     (type == XQM_GRPQUOTA && !in_egroup_p(id))) &&
-		     !capable(CAP_SYS_ADMIN))
+		     !capable_light(CAP_SYS_ADMIN))
 			return -EPERM;
 	} else if (cmd != Q_XGETQSTAT && cmd != Q_XQUOTASYNC) {
-		if (!capable(CAP_SYS_ADMIN))
+		if (!capable_light(CAP_SYS_ADMIN))
 			return -EPERM;
 	}
 
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/ipc/msg.c linux-2.6.17-rc3+/ipc/msg.c
--- linux-2.6.17-rc3~/ipc/msg.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/ipc/msg.c	2006-04-30 22:52:53.383048000 +0200
@@ -449,7 +449,7 @@ asmlinkage long sys_msgctl (int msqid, i
 	ipcp = &msq->q_perm;
 	err = -EPERM;
 	if (current->euid != ipcp->cuid && 
-	    current->euid != ipcp->uid && !capable(CAP_SYS_ADMIN))
+	    current->euid != ipcp->uid && !capable_light(CAP_SYS_ADMIN))
 	    /* We _could_ check for CAP_CHOWN above, but we don't */
 		goto out_unlock_up;
 
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/ipc/sem.c linux-2.6.17-rc3+/ipc/sem.c
--- linux-2.6.17-rc3~/ipc/sem.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/ipc/sem.c	2006-04-30 22:54:15.703048000 +0200
@@ -821,7 +821,7 @@ static int semctl_down(int semid, int se
 	}	
 	ipcp = &sma->sem_perm;
 	if (current->euid != ipcp->cuid && 
-	    current->euid != ipcp->uid && !capable(CAP_SYS_ADMIN)) {
+	    current->euid != ipcp->uid && !capable_light(CAP_SYS_ADMIN)) {
 	    	err=-EPERM;
 		goto out_unlock;
 	}
diff --fast -Ndpru -X dontdiff linux-2.6.17-rc3~/ipc/shm.c linux-2.6.17-rc3+/ipc/shm.c
--- linux-2.6.17-rc3~/ipc/shm.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/ipc/shm.c	2006-04-30 22:55:10.413048000 +0200
@@ -596,7 +596,7 @@ asmlinkage long sys_shmctl (int shmid, i
 
 		if (current->euid != shp->shm_perm.uid &&
 		    current->euid != shp->shm_perm.cuid && 
-		    !capable(CAP_SYS_ADMIN)) {
+		    !capable_light(CAP_SYS_ADMIN)) {
 			err=-EPERM;
 			goto out_unlock_up;
 		}
@@ -636,7 +636,7 @@ asmlinkage long sys_shmctl (int shmid, i
 		err=-EPERM;
 		if (current->euid != shp->shm_perm.uid &&
 		    current->euid != shp->shm_perm.cuid && 
-		    !capable(CAP_SYS_ADMIN)) {
+		    !capable_light(CAP_SYS_ADMIN)) {
 			goto out_unlock_up;
 		}
 
#<<eof>>


Jan Engelhardt
-- 
