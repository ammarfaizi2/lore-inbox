Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVB0Arh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVB0Arh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVB0Arh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:47:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63237 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261316AbVB0Ar0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:47:26 -0500
Date: Sun, 27 Feb 2005 01:47:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/pcmcia/: possible cleanups
Message-ID: <20050227004723.GR3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the following unneeded EXPORT_SYMBOL's:
  - ds.c: pcmcia_report_error
  - ds.c: pcmcia_bus_type

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/pcmcia/ds.c             |   10 +++++-----
 drivers/pcmcia/rsrc_nonstatic.c |    4 ++--
 include/pcmcia/cs.h             |    1 -
 include/pcmcia/ds.h             |    2 --
 4 files changed, 7 insertions(+), 10 deletions(-)

--- linux-2.6.11-rc4-mm1-full/include/pcmcia/cs.h.old	2005-02-26 15:49:49.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/pcmcia/cs.h	2005-02-26 15:50:07.000000000 +0100
@@ -417,7 +417,6 @@
 int pcmcia_resume_card(struct pcmcia_socket *skt);
 int pcmcia_eject_card(struct pcmcia_socket *skt);
 int pcmcia_insert_card(struct pcmcia_socket *skt);
-int pcmcia_report_error(client_handle_t handle, error_info_t *err);
 
 struct pcmcia_socket * pcmcia_get_socket(struct pcmcia_socket *skt);
 void pcmcia_put_socket(struct pcmcia_socket *skt);
--- linux-2.6.11-rc4-mm1-full/include/pcmcia/ds.h.old	2005-02-26 15:45:28.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/pcmcia/ds.h	2005-02-26 15:45:32.000000000 +0100
@@ -129,8 +129,6 @@
 
 struct pcmcia_socket;
 
-extern struct bus_type pcmcia_bus_type;
-
 struct pcmcia_driver {
 	dev_link_t		*(*attach)(void);
 	void			(*detach)(dev_link_t *);
--- linux-2.6.11-rc4-mm1-full/drivers/pcmcia/ds.c.old	2005-02-26 15:44:48.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pcmcia/ds.c	2005-02-26 15:49:33.000000000 +0100
@@ -58,7 +58,7 @@
 MODULE_LICENSE("GPL");
 
 #ifdef DEBUG
-int ds_pc_debug;
+static int ds_pc_debug;
 
 module_param_named(pc_debug, ds_pc_debug, int, 0644);
 
@@ -214,7 +214,7 @@
 };
 
 
-int pcmcia_report_error(client_handle_t handle, error_info_t *err)
+static int pcmcia_report_error(client_handle_t handle, error_info_t *err)
 {
 	int i;
 	char *serv;
@@ -244,7 +244,6 @@
 
 	return CS_SUCCESS;
 } /* report_error */
-EXPORT_SYMBOL(pcmcia_report_error);
 
 /* end of code which was in cs.c before */
 
@@ -262,6 +261,8 @@
 static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
 static struct pcmcia_bus_socket * get_socket_info_by_nr(unsigned int nr);
 
+static struct bus_type pcmcia_bus_type;
+
 static void pcmcia_release_bus_socket(struct kref *refcount)
 {
 	struct pcmcia_bus_socket *s = container_of(refcount, struct pcmcia_bus_socket, refcount);
@@ -1610,12 +1611,11 @@
 };
 
 
-struct bus_type pcmcia_bus_type = {
+static struct bus_type pcmcia_bus_type = {
 	.name = "pcmcia",
 	.match = pcmcia_bus_match,
 	.dev_attrs = pcmcia_dev_attrs,
 };
-EXPORT_SYMBOL(pcmcia_bus_type);
 
 
 static int __init init_pcmcia_bus(void)
--- linux-2.6.11-rc4-mm1-full/drivers/pcmcia/rsrc_nonstatic.c.old	2005-02-26 18:41:19.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/pcmcia/rsrc_nonstatic.c	2005-02-26 18:41:34.000000000 +0100
@@ -606,7 +606,7 @@
 
 ======================================================================*/
 
-struct resource *nonstatic_find_io_region(unsigned long base, int num,
+static struct resource *nonstatic_find_io_region(unsigned long base, int num,
 		   unsigned long align, struct pcmcia_socket *s)
 {
 	struct resource *res = make_resource(0, num, IORESOURCE_IO, s->dev.class_id);
@@ -640,7 +640,7 @@
 	return res;
 }
 
-struct resource * nonstatic_find_mem_region(u_long base, u_long num, u_long align,
+static struct resource * nonstatic_find_mem_region(u_long base, u_long num, u_long align,
 				 int low, struct pcmcia_socket *s)
 {
 	struct resource *res = make_resource(0, num, IORESOURCE_MEM, s->dev.class_id);

