Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbTIJWc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTIJWc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:32:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:65285 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265877AbTIJWZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:25:39 -0400
Date: Wed, 10 Sep 2003 23:25:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: What happened to SUSPEND_SAVE_STATE?
Message-ID: <20030910232527.O30046@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Patrick Mochel <mochel@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20030910201124.GA11449@elf.ucw.cz> <20030910204940.GA11571@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030910204940.GA11571@elf.ucw.cz>; from pavel@ucw.cz on Wed, Sep 10, 2003 at 10:49:43PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 10:49:43PM +0200, Pavel Machek wrote:
> Hi!
> 
> > What happened to SUSPEND_SAVE_STATE?
> 
> SUSPEND_NOTIFY seems dead, too. Should I simply ignore level parameter
> in pcmcia_socket_dev_suspend?

No.  Apply this patch (it's cut down from the stuff which is pending
for Linus - I hope I didn't make any mistakes doing that 8))

diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Wed Sep 10 23:18:32 2003
+++ b/drivers/pcmcia/cs.c	Wed Sep 10 23:18:32 2003
@@ -244,13 +244,10 @@
 static int socket_resume(struct pcmcia_socket *skt);
 static int socket_suspend(struct pcmcia_socket *skt);
 
-int pcmcia_socket_dev_suspend(struct device *dev, u32 state, u32 level)
+int pcmcia_socket_dev_suspend(struct device *dev, u32 state)
 {
 	struct pcmcia_socket *socket;
 
-	if (level != SUSPEND_SAVE_STATE)
-		return 0;
-
 	down_read(&pcmcia_socket_list_rwsem);
 	list_for_each_entry(socket, &pcmcia_socket_list, socket_list) {
 		if (socket->dev.dev != dev)
@@ -265,13 +262,10 @@
 }
 EXPORT_SYMBOL(pcmcia_socket_dev_suspend);
 
-int pcmcia_socket_dev_resume(struct device *dev, u32 level)
+int pcmcia_socket_dev_resume(struct device *dev)
 {
 	struct pcmcia_socket *socket;
 
-	if (level != RESUME_RESTORE_STATE)
-		return 0;
-
 	down_read(&pcmcia_socket_list_rwsem);
 	list_for_each_entry(socket, &pcmcia_socket_list, socket_list) {
 		if (socket->dev.dev != dev)
diff -Nru a/drivers/pcmcia/hd64465_ss.c b/drivers/pcmcia/hd64465_ss.c
--- a/drivers/pcmcia/hd64465_ss.c	Wed Sep 10 23:18:33 2003
+++ b/drivers/pcmcia/hd64465_ss.c	Wed Sep 10 23:18:33 2003
@@ -867,19 +867,32 @@
 	local_irq_restore(flags);
 }
 
+static int hd64465_suspend(struct device *dev, u32 state, u32 level)
+{
+	int ret = 0;
+	if (level == SUSPEND_SAVE_STATE)
+		ret = pcmcia_socket_dev_suspend(dev, state);
+	return ret;
+}
+
+static int hd64465_resume(struct device *dev, u32 level)
+{
+	int ret = 0;
+	if (level == RESUME_RESTORE_STATE)
+		ret = pcmcia_socket_dev_resume(dev);
+	return ret;
+}
+
 static struct device_driver hd64465_driver = {
 	.name = "hd64465-pcmcia",
 	.bus = &platform_bus_type,
-	.suspend = pcmcia_socket_dev_suspend,
-	.resume = pcmcia_socket_dev_resume,
+	.suspend = hd64465_suspend,
+	.resume = hd64465_resume,
 };
 
 static struct platform_device hd64465_device = {
 	.name = "hd64465-pcmcia",
 	.id = 0,
-	.dev = {
-		.name = "hd64465-pcmcia",
-	},
 };
 
 static int __init init_hs(void)
diff -Nru a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
--- a/drivers/pcmcia/i82092.c	Wed Sep 10 23:18:34 2003
+++ b/drivers/pcmcia/i82092.c	Wed Sep 10 23:18:34 2003
@@ -44,12 +44,12 @@
 
 static int i82092aa_socket_suspend (struct pci_dev *dev, u32 state)
 {
-	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
+	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
 
 static int i82092aa_socket_resume (struct pci_dev *dev)
 {
-	return pcmcia_socket_dev_resume(&dev->dev, RESUME_RESTORE_STATE);
+	return pcmcia_socket_dev_resume(&dev->dev);
 }
 
 static struct pci_driver i82092aa_pci_drv = {
diff -Nru a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
--- a/drivers/pcmcia/i82365.c	Wed Sep 10 23:18:34 2003
+++ b/drivers/pcmcia/i82365.c	Wed Sep 10 23:18:34 2003
@@ -1351,11 +1351,27 @@
 
 /*====================================================================*/
 
+static int i82365_suspend(struct device *dev, u32 state, u32 level)
+{
+	int ret = 0;
+	if (level == SUSPEND_SAVE_STATE)
+		ret = pcmcia_socket_dev_suspend(dev, state);
+	return ret;
+}
+
+static int i82365_resume(struct device *dev, u32 level)
+{
+	int ret = 0;
+	if (level == RESUME_RESTORE_STATE)
+		ret = pcmcia_socket_dev_resume(dev);
+	return ret;
+}
+
 static struct device_driver i82365_driver = {
 	.name = "i82365",
 	.bus = &platform_bus_type,
-	.suspend = pcmcia_socket_dev_suspend,
-	.resume = pcmcia_socket_dev_resume,
+	.suspend = i82365_suspend,
+	.resume = i82365_resume,
 };
 
 static struct platform_device i82365_device = {
diff -Nru a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
--- a/drivers/pcmcia/sa1100_generic.c	Wed Sep 10 23:18:33 2003
+++ b/drivers/pcmcia/sa1100_generic.c	Wed Sep 10 23:18:33 2003
@@ -100,13 +100,29 @@
 	return ret;
 }
 
+static int sa11x0_drv_pcmcia_suspend(struct device *dev, u32 state, u32 level)
+{
+	int ret = 0;
+	if (level == SUSPEND_SAVE_STATE)
+		ret = pcmcia_socket_dev_suspend(dev, state);
+	return ret;
+}
+
+static int sa11x0_drv_pcmcia_resume(struct device *dev, u32 level)
+{
+	int ret = 0;
+	if (level == RESUME_RESTORE_STATE)
+		ret = pcmcia_socket_dev_resume(dev);
+	return ret;
+}
+
 static struct device_driver sa11x0_pcmcia_driver = {
 	.probe		= sa11x0_drv_pcmcia_probe,
 	.remove		= sa11xx_drv_pcmcia_remove,
 	.name		= "sa11x0-pcmcia",
 	.bus		= &platform_bus_type,
-	.suspend 	= pcmcia_socket_dev_suspend,
-	.resume 	= pcmcia_socket_dev_resume,
+	.suspend 	= sa11x0_drv_pcmcia_suspend,
+	.resume 	= sa11x0_drv_pcmcia_resume,
 };
 
 /* sa11x0_pcmcia_init()
diff -Nru a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
--- a/drivers/pcmcia/sa1111_generic.c	Wed Sep 10 23:18:32 2003
+++ b/drivers/pcmcia/sa1111_generic.c	Wed Sep 10 23:18:32 2003
@@ -171,12 +171,12 @@
 
 static int pcmcia_suspend(struct sa1111_dev *dev, u32 state)
 {
-	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
+	return pcmcia_socket_dev_suspend(&dev->dev, state);
 }
 
 static int pcmcia_resume(struct sa1111_dev *dev)
 {
-	return pcmcia_socket_dev_resume(&dev->dev, RESUME_RESTORE_STATE);
+	return pcmcia_socket_dev_resume(&dev->dev);
 }
 
 static struct sa1111_driver pcmcia_driver = {
diff -Nru a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
--- a/drivers/pcmcia/tcic.c	Wed Sep 10 23:18:33 2003
+++ b/drivers/pcmcia/tcic.c	Wed Sep 10 23:18:33 2003
@@ -362,11 +362,27 @@
 
 /*====================================================================*/
 
+static int tcic_drv_suspend(struct device *dev, u32 state, u32 level)
+{
+	int ret = 0;
+	if (level == SUSPEND_SAVE_STATE)
+		ret = pcmcia_socket_dev_suspend(dev, state);
+	return ret;
+}
+
+static int tcic_drv_resume(struct device *dev, u32 level)
+{
+	int ret = 0;
+	if (level == RESUME_RESTORE_STATE)
+		ret = pcmcia_socket_dev_resume(dev);
+	return ret;
+}
+
 static struct device_driver tcic_driver = {
 	.name = "tcic-pcmcia",
 	.bus = &platform_bus_type,
-	.suspend = pcmcia_socket_dev_suspend,
-	.resume = pcmcia_socket_dev_resume,
+	.suspend = tcic_drv_suspend,
+	.resume = tcic_drv_resume,
 };
 
 static struct platform_device tcic_device = {
diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	Wed Sep 10 23:18:33 2003
+++ b/drivers/pcmcia/yenta_socket.c	Wed Sep 10 23:18:33 2003
@@ -937,7 +933,7 @@
 	struct yenta_socket *socket = pci_get_drvdata(dev);
 	int ret;
 
-	ret = pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
+	ret = pcmcia_socket_dev_suspend(&dev->dev, state);
 
 	if (socket) {
 		if (socket->type && socket->type->save_state)
@@ -969,7 +965,7 @@
 			socket->type->restore_state(socket);
 	}
 
-	return pcmcia_socket_dev_resume(&dev->dev, RESUME_RESTORE_STATE);
+	return pcmcia_socket_dev_resume(&dev->dev);
 }
 
 
diff -Nru a/include/pcmcia/ss.h b/include/pcmcia/ss.h
--- a/include/pcmcia/ss.h	Wed Sep 10 23:18:34 2003
+++ b/include/pcmcia/ss.h	Wed Sep 10 23:18:34 2003
@@ -249,7 +249,7 @@
 extern struct class pcmcia_socket_class;
 
 /* socket drivers are expected to use these callbacks in their .drv struct */
-extern int pcmcia_socket_dev_suspend(struct device *dev, u32 state, u32 level);
-extern int pcmcia_socket_dev_resume(struct device *dev, u32 level);
+extern int pcmcia_socket_dev_suspend(struct device *dev, u32 state);
+extern int pcmcia_socket_dev_resume(struct device *dev);
 
 #endif /* _LINUX_SS_H */


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
