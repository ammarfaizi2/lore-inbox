Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTIPW4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 18:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbTIPW4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 18:56:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59153 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262540AbTIPW4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 18:56:11 -0400
Date: Tue, 16 Sep 2003 23:56:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Diehl <lists@mdiehl.de>
Cc: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Omnibook PCMCIA slots unusable after suspend.
Message-ID: <20030916235607.H20141@flint.arm.linux.org.uk>
Mail-Followup-To: Martin Diehl <lists@mdiehl.de>,
	Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>,
	linux-kernel@vger.kernel.org
References: <7839.1063471929@cl.cam.ac.uk> <Pine.LNX.4.44.0309140058440.16165-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309140058440.16165-100000@notebook.home.mdiehl.de>; from lists@mdiehl.de on Tue, Sep 16, 2003 at 11:13:54PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 11:13:54PM +0200, Martin Diehl wrote:
> Of course I personally have no objections wrt. including it in the 
> official tree. Russel, what do you think - do you want to apply it? Or 
> shall I send it to Greg directly?

I think it would be a good idea to forward it to Greg, especially if
Linus seemed to think the current behaviour is wrong.  Certainly
allocating the yenta resources in the memory hole seems like a silly
thing to do.

> On Sat, 13 Sep 2003, Jon Fairbairn wrote:
> > I think I got that too, at least, reinserting the card caused
> > a lockup.  With the patch applied I can eject and reinsert,
> > which is fortunate because there seems to be another problem
> > where the card switches off when I switch VCs, but it's hard
> > to reproduce. (and inconvenient because /usr is on nfs on
> > this machine)
> 
> No idea - sounds strange to me. No such problem here with any of 
> serial_cs, pcnet_cs or orinoco_cs with my ob800 (neither 2.4 nor 2.6).

The following patch may help to track down this problem.  Assuming
Jon has sysfs mounted on /sys, there should be a bunch of files in
/sys/class/pcmcia_socket/*/* - if Jon could get those to me after
its gone wrong, it may be helpful.

I'll also see about merging a patch which fixes up the debugging
(and adds some more) so we can see what's going on.

--- orig/drivers/pcmcia/Makefile	Mon Jun 23 11:51:13 2003
+++ linux/drivers/pcmcia/Makefile	Sat Sep  6 16:39:24 2003
@@ -2,7 +2,7 @@
 # Makefile for the kernel pcmcia subsystem (c/o David Hinds)
 #
 
-obj-$(CONFIG_PCMCIA)				+= pcmcia_core.o ds.o
+obj-$(CONFIG_PCMCIA)				+= pcmcia_core.o ds.o pcmcia_debug.o
 obj-$(CONFIG_YENTA) 				+= yenta_socket.o
 
 obj-$(CONFIG_I82365)				+= i82365.o
--- /dev/null	Sat Apr 26 08:56:46 1997
+++ linux/drivers/pcmcia/pcmcia_debug.c	Sat Sep  6 19:27:30 2003
@@ -0,0 +1,153 @@
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
+#include <pcmcia/cs_types.h>
+#include <pcmcia/ss.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/cistpl.h>
+
+#include "cs_internal.h"
+
+struct bittbl {
+	unsigned int mask;
+	const char *name;
+};
+
+#define BIT(x) { x, #x }
+
+static struct bittbl state_bits[] = {
+	BIT(SOCKET_PRESENT),
+	BIT(SOCKET_INUSE),
+	BIT(SOCKET_SUSPEND),
+	BIT(SOCKET_WIN_REQ(0)),
+	BIT(SOCKET_WIN_REQ(1)),
+	BIT(SOCKET_WIN_REQ(2)),
+	BIT(SOCKET_WIN_REQ(3)),
+	BIT(SOCKET_REGION_INFO),
+	BIT(SOCKET_CARDBUS),
+	BIT(SOCKET_CARDBUS_CONFIG),
+};
+
+static struct bittbl status_bits[] = {
+	BIT(SS_WRPROT),
+	BIT(SS_CARDLOCK),
+	BIT(SS_EJECTION),
+	BIT(SS_INSERTION),
+	BIT(SS_BATDEAD),
+	BIT(SS_BATWARN),
+	BIT(SS_READY),
+	BIT(SS_DETECT),
+	BIT(SS_POWERON),
+	BIT(SS_GPI),
+	BIT(SS_STSCHG),
+	BIT(SS_CARDBUS),
+	BIT(SS_3VCARD),
+	BIT(SS_XVCARD),
+	BIT(SS_PENDING),
+	BIT(SS_ZVCARD),
+};
+
+static struct bittbl conf_bits[] = {
+	BIT(SS_PWR_AUTO),
+	BIT(SS_IOCARD),
+	BIT(SS_RESET),
+	BIT(SS_DMA_MODE),
+	BIT(SS_SPKR_ENA),
+	BIT(SS_OUTPUT_ENA),
+};
+
+static int dump_bits(char *p, unsigned int val, struct bittbl *bits, int sz)
+{
+	char *b = p;
+	int i;
+
+	for (i = 0; i < sz; i++)
+		if (val & bits[i].mask)
+			b += sprintf(b, "%s ", bits[i].name);
+	*b++ = '\n';
+	return b - p;
+}
+
+static ssize_t show_skt_socket_vpp(struct class_device *dev, char *buf)
+{
+	struct pcmcia_socket *skt = dev->class_data;
+	return sprintf(buf, "%d\n", skt->socket.Vpp);
+}
+static CLASS_DEVICE_ATTR(socket_vpp, S_IRUSR, show_skt_socket_vpp, NULL);
+
+static ssize_t show_skt_socket_vcc(struct class_device *dev, char *buf)
+{
+	struct pcmcia_socket *skt = dev->class_data;
+	return sprintf(buf, "%d\n", skt->socket.Vcc);
+}
+static CLASS_DEVICE_ATTR(socket_vcc, S_IRUSR, show_skt_socket_vcc, NULL);
+
+static ssize_t show_skt_socket_flags(struct class_device *dev, char *buf)
+{
+	struct pcmcia_socket *skt = dev->class_data;
+	return dump_bits(buf, skt->socket.flags, conf_bits, ARRAY_SIZE(conf_bits));
+}
+static CLASS_DEVICE_ATTR(socket_flags, S_IRUSR, show_skt_socket_flags, NULL);
+
+static ssize_t show_skt_status(struct class_device *dev, char *buf)
+{
+	struct pcmcia_socket *skt = dev->class_data;
+	int status;
+
+	skt->ops->get_status(skt, &status);
+	return dump_bits(buf, status, status_bits, ARRAY_SIZE(status_bits));
+}
+static CLASS_DEVICE_ATTR(status, S_IRUSR, show_skt_status, NULL);
+
+static ssize_t show_skt_state(struct class_device *dev, char *buf)
+{
+	struct pcmcia_socket *skt = dev->class_data;
+	return dump_bits(buf, skt->state, state_bits, ARRAY_SIZE(state_bits));
+}
+static CLASS_DEVICE_ATTR(state, S_IRUSR, show_skt_state, NULL);
+
+static struct class_device_attribute *attrs[] = {
+	&class_device_attr_socket_vpp,
+	&class_device_attr_socket_vcc,
+	&class_device_attr_socket_flags,
+	&class_device_attr_status,
+	&class_device_attr_state,
+};
+
+static int pcmcia_debug_add_socket(struct class_device *class_dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(attrs); i++)
+		class_device_create_file(class_dev, attrs[i]);
+
+	return 0;
+}
+
+static void pcmcia_debug_remove_socket(struct class_device *class_dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(attrs); i++)
+		class_device_remove_file(class_dev, attrs[i]);
+}
+
+static struct class_interface pcmcia_debug_interface = {
+	.class	= &pcmcia_socket_class,
+	.add	= &pcmcia_debug_add_socket,
+	.remove	= &pcmcia_debug_remove_socket,
+};
+
+static int __init pcmcia_debug_init(void)
+{
+	return class_interface_register(&pcmcia_debug_interface);
+}
+
+static void __exit pcmcia_debug_exit(void)
+{
+	return class_interface_unregister(&pcmcia_debug_interface);
+}
+
+fs_initcall(pcmcia_debug_init);
+module_exit(pcmcia_debug_exit);

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
