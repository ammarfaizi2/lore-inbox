Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265727AbUFUCJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265727AbUFUCJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 22:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266001AbUFUCJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 22:09:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:56752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265727AbUFUCJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 22:09:11 -0400
Date: Sun, 20 Jun 2004 19:08:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org, nemesis-lists@icequake.net,
       willy@w.ods.org, twaugh@redhat.com
Subject: Re: Netmos 9835 in 2.6.x was Request: Netmos support in
 parport_serial for 2.4.27
Message-Id: <20040620190813.40ee166c.akpm@osdl.org>
In-Reply-To: <20040621014910.GC9359@logos.cnet>
References: <20040613111949.GB6564@dbz.icequake.net>
	<20040613123950.GA3332@logos.cnet>
	<Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk>
	<20040613220727.GB4771@logos.cnet>
	<20040614045104.GE27622@dbz.icequake.net>
	<20040621014910.GC9359@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> > http://seclists.org/lists/linux-kernel/2003/Dec/0654.html
> 
>  Andrew, the patch in the URL looks fine to me, it adds support for 
>  Netmos 9835 based cards. Tim Waugh ACKed the 2.4 version of the patch. 

OK, thanks.  I queued the below patch.



From: Christoph Lameter <christoph@graphe.net>

Attached a patch to support a variety of PCI based serial and parallel port
I/O ports (typically labeled 222N-2 or 9835).

I think this should go into 2.6.0 since it has been out there for a long
time and is just some additional driver support that somehow fell through
the cracks in 2.4.X. Tim Waugh submitted it in the 2.4.X series.

See also http://winterwolf.co.uk/pciio

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/parport/ChangeLog        |    4 ++++
 25-akpm/drivers/parport/parport_pc.c     |   17 +++++++++++++++++
 25-akpm/drivers/parport/parport_serial.c |   10 ++++++++++
 25-akpm/include/linux/pci_ids.h          |    4 ++++
 4 files changed, 35 insertions(+)

diff -puN drivers/parport/ChangeLog~for-netmos-based-pci-cards-providing-serial-and-parallel-ports drivers/parport/ChangeLog
--- 25/drivers/parport/ChangeLog~for-netmos-based-pci-cards-providing-serial-and-parallel-ports	2004-06-20 19:07:08.187268320 -0700
+++ 25-akpm/drivers/parport/ChangeLog	2004-06-20 19:07:08.196266952 -0700
@@ -1,3 +1,7 @@
+2001-10-11  Tim Waugh  <twaugh@redhat.com>
+	* parport_pc.c, parport_serial.c: Support for NetMos cards.
+	+ Patch originally from Michael Reinelt <reinelt@eunet.at>.
+
 2002-04-25  Tim Waugh  <twaugh@redhat.com>
 
 	* parport_serial.c, parport_pc.c: Move some SIIG cards around.
diff -puN drivers/parport/parport_pc.c~for-netmos-based-pci-cards-providing-serial-and-parallel-ports drivers/parport/parport_pc.c
--- 25/drivers/parport/parport_pc.c~for-netmos-based-pci-cards-providing-serial-and-parallel-ports	2004-06-20 19:07:08.189268016 -0700
+++ 25-akpm/drivers/parport/parport_pc.c	2004-06-20 19:07:08.198266648 -0700
@@ -2632,6 +2632,10 @@ enum parport_pc_pci_cards {
 	oxsemi_840,
 	aks_0100,
 	mobility_pp,
+	netmos_9705,
+	netmos_9805,
+	netmos_9815,
+	netmos_9855,
 };
 
 
@@ -2701,6 +2705,10 @@ static struct parport_pc_pci {
 	/* oxsemi_840 */		{ 1, { { 0, -1 }, } },
 	/* aks_0100 */                  { 1, { { 0, -1 }, } },
 	/* mobility_pp */		{ 1, { { 0, 1 }, } },
+	/* netmos_9705 */               { 1, { { 0, -1 }, } }, /* untested */
+	/* netmos_9805 */               { 1, { { 0, -1 }, } }, /* untested */
+	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
+	/* netmos_9855 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
 };
 
 static struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2769,6 +2777,15 @@ static struct pci_device_id parport_pc_p
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_840 },
 	{ PCI_VENDOR_ID_AKS, PCI_DEVICE_ID_AKS_ALADDINCARD,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, aks_0100 },
+	/* NetMos communication controllers */
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9705,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9805,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9805 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9815,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
diff -puN drivers/parport/parport_serial.c~for-netmos-based-pci-cards-providing-serial-and-parallel-ports drivers/parport/parport_serial.c
--- 25/drivers/parport/parport_serial.c~for-netmos-based-pci-cards-providing-serial-and-parallel-ports	2004-06-20 19:07:08.190267864 -0700
+++ 25-akpm/drivers/parport/parport_serial.c	2004-06-20 19:07:08.199266496 -0700
@@ -33,6 +33,8 @@
 enum parport_pc_pci_cards {
 	titan_110l = 0,
 	titan_210l,
+	netmos_9735,
+	netmos_9835,
 	avlab_1s1p,
 	avlab_1s1p_650,
 	avlab_1s1p_850,
@@ -71,6 +73,8 @@ static struct parport_pc_pci {
 } cards[] __devinitdata = {
 	/* titan_110l */		{ 1, { { 3, -1 }, } },
 	/* titan_210l */		{ 1, { { 3, -1 }, } },
+	/* netmos_9735 (not tested) */	{ 1, { { 2, -1 }, } },
+	/* netmos_9835 */		{ 1, { { 2, -1 }, } },
 	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
@@ -93,6 +97,10 @@ static struct pci_device_id parport_seri
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
 	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
@@ -172,6 +180,8 @@ static struct pci_board_no_ids pci_board
 
 /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
 /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
+/* netmos_9735 (n/t)*/	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9835 */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
diff -puN include/linux/pci_ids.h~for-netmos-based-pci-cards-providing-serial-and-parallel-ports include/linux/pci_ids.h
--- 25/include/linux/pci_ids.h~for-netmos-based-pci-cards-providing-serial-and-parallel-ports	2004-06-20 19:07:08.192267560 -0700
+++ 25-akpm/include/linux/pci_ids.h	2004-06-20 19:07:08.201266192 -0700
@@ -2254,8 +2254,12 @@
 #define PCI_DEVICE_ID_HOLTEK_6565	0x6565
 
 #define PCI_VENDOR_ID_NETMOS		0x9710
+#define PCI_DEVICE_ID_NETMOS_9705	0x9705
 #define PCI_DEVICE_ID_NETMOS_9735	0x9735
+#define PCI_DEVICE_ID_NETMOS_9805	0x9805
+#define PCI_DEVICE_ID_NETMOS_9815	0x9815
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
+#define PCI_DEVICE_ID_NETMOS_9855	0x9855
 
 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
 #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014
_

