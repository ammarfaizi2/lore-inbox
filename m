Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270073AbUJSXfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270073AbUJSXfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270139AbUJSXeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:34:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:9866 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270073AbUJSWqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:33 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <109822573458@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <10982257351131@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.22, 2004/10/06 12:11:10-07:00, janitor@sternwelten.at

[PATCH] PCI list_for_each: arch-ppc-kernel-pci.c

s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/ppc/kernel/pci.c |   28 +++++++++-------------------
 1 files changed, 9 insertions(+), 19 deletions(-)


diff -Nru a/arch/ppc/kernel/pci.c b/arch/ppc/kernel/pci.c
--- a/arch/ppc/kernel/pci.c	2004-10-19 15:25:48 -07:00
+++ b/arch/ppc/kernel/pci.c	2004-10-19 15:25:48 -07:00
@@ -231,14 +231,12 @@
 static void __init
 pcibios_allocate_bus_resources(struct list_head *bus_list)
 {
-	struct list_head *ln;
 	struct pci_bus *bus;
 	int i;
 	struct resource *res, *pr;
 
 	/* Depth-First Search on bus tree */
-	for (ln = bus_list->next; ln != bus_list; ln=ln->next) {
-		bus = pci_bus_b(ln);
+	list_for_each_entry(bus, bus_list, node) {
 		for (i = 0; i < 4; ++i) {
 			if ((res = bus->resource[i]) == NULL || !res->flags
 			    || res->start > res->end)
@@ -381,7 +379,6 @@
 	struct pci_bus *bus;
 	struct pci_dev *dev;
 	struct resource *r;
-	struct list_head *ln;
 	int i;
 
 	for (r = pr->child; r != NULL; r = r->sibling) {
@@ -390,9 +387,7 @@
 			return 1;
 		}
 	}
-	for (ln = parent->children.next; ln != &parent->children;
-	     ln = ln->next) {
-		bus = pci_bus_b(ln);
+	list_for_each_entry(bus, &parent->children, node) {
 		for (i = 0; i < 4; ++i) {
 			if ((r = bus->resource[i]) == NULL)
 				continue;
@@ -406,8 +401,7 @@
 			}
 		}
 	}
-	for (ln = parent->devices.next; ln != &parent->devices; ln=ln->next) {
-		dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &parent->devices, bus_list) {
 		for (i = 0; i < 6; ++i) {
 			r = &dev->resource[i];
 			if (!r->flags || (r->flags & IORESOURCE_UNSET))
@@ -1102,7 +1096,7 @@
 static int __init
 check_for_io_childs(struct pci_bus *bus, struct resource* res, int *found_vga)
 {
-	struct list_head *ln;
+	struct pci_dev *dev;
 	int	i;
 	int	rc = 0;
 
@@ -1110,8 +1104,7 @@
 	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
     } while (0)
 
-	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
-		struct pci_dev *dev = pci_dev_b(ln);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
 		u16 class = dev->class >> 8;
 
 		if (class == PCI_CLASS_DISPLAY_VGA ||
@@ -1152,7 +1145,7 @@
 static void __init
 do_fixup_p2p_level(struct pci_bus *bus)
 {
-	struct list_head *ln;
+	struct pci_bus *b;
 	int i, parent_io;
 	int has_vga = 0;
 
@@ -1163,8 +1156,7 @@
 	if (parent_io >= 4)
 		return;
 
-	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
-		struct pci_bus *b = pci_bus_b(ln);
+	list_for_each_entry(b, &bus->children, node) {
 		struct pci_dev *d = b->self;
 		struct pci_controller* hose = (struct pci_controller *)d->sysdata;
 		struct resource *res = b->resource[0];
@@ -1237,12 +1229,10 @@
 static void
 pcibios_fixup_p2p_bridges(void)
 {
-	struct list_head *ln;
+	struct pci_bus *b;
 
-	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
-		struct pci_bus *b = pci_bus_b(ln);
+	list_for_each_entry(b, &pci_root_buses, node)
 		do_fixup_p2p_level(b);
-	}
 }
 
 #endif /* CONFIG_PPC_PMAC */

