Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbULESnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbULESnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbULESnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:43:11 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34018 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261346AbULESnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:43:02 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: bcollins@debian.org
Subject: [PATCH] ohci1394.c - Correct kmalloc usage in interrupt
Date: Sun, 5 Dec 2004 13:42:53 -0500
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3406541.hUXLbitJY3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412051343.06452.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3406541.hUXLbitJY3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

alloc_dma_rcv_ctx is called in interrupt and Kernel Spinlock debugging code cribs about it via "Debug: sleeping function called in interrupt context". See sample stack traces below.
The patch below corrects ohci1394.c to use GFP_ATOMIC instead of GFP_KERNEL. Tested to work fine with 2 different Camcorder devices for fairly long periods and connect/disconnects.

Parag

===================================================
DMESG

 ----------------------------
 ieee1394: raw1394: /dev/raw1394 device initialized
 ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
 ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0800460102e81a7c]
 ieee1394: Node changed: 0-00:1023 -> 0-01:1023
 Debug: sleeping function called from invalid context at mm/slab.c:2063
 in_atomic():0[expected: 0], irqs_disabled():1
  [<0211cbcb>] __might_sleep+0x7d/0x8a
  [<0214bf9f>] __kmalloc+0x42/0x7d
  [<32b9abf2>] alloc_dma_rcv_ctx+0x5f/0x3a3 [ohci1394]
  [<32b980ad>] ohci_devctl+0x1dc/0x799 [ohci1394]
  [<0215222e>] follow_page_pte+0xec/0xfd
  [<32bec615>] hpsb_listen_channel+0x3f/0x46 [ieee1394]
  [<32ddd2ac>] handle_iso_listen+0x11c/0x268 [raw1394]
  [<32de0c47>] state_connected+0xf1/0x1c7 [raw1394]
  [<32de0d9b>] raw1394_write+0x7e/0x92 [raw1394]
  [<02165c82>] vfs_write+0xb6/0xe2
  [<02165d4c>] sys_write+0x3c/0x62
===================================================

PATCH
===================================================
Signed-off-by: Parag Warudkar <kernel-stuff@comcast.net>

--- linux-mod/drivers/ieee1394/ohci1394.c.orig  2004-12-05 13:21:27.419193936 -0500
+++ linux-mod/drivers/ieee1394/ohci1394.c       2004-12-05 13:28:36.011038072 -0500
@@ -2933,8 +2933,8 @@ alloc_dma_rcv_ctx(struct ti_ohci *ohci,
        d->ctrlClear = 0;
        d->cmdPtr = 0;

-       d->buf_cpu = kmalloc(d->num_desc * sizeof(quadlet_t*), GFP_KERNEL);
-       d->buf_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_KERNEL);
+       d->buf_cpu = kmalloc(d->num_desc * sizeof(quadlet_t*), GFP_ATOMIC);
+       d->buf_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);

        if (d->buf_cpu == NULL || d->buf_bus == NULL) {
                PRINT(KERN_ERR, "Failed to allocate dma buffer");
@@ -2945,8 +2945,8 @@ alloc_dma_rcv_ctx(struct ti_ohci *ohci,
        memset(d->buf_bus, 0, d->num_desc * sizeof(dma_addr_t));

        d->prg_cpu = kmalloc(d->num_desc * sizeof(struct dma_cmd*),
-                            GFP_KERNEL);
-       d->prg_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_KERNEL);
+                            GFP_ATOMIC);
+       d->prg_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);

        if (d->prg_cpu == NULL || d->prg_bus == NULL) {
                PRINT(KERN_ERR, "Failed to allocate dma prg");
@@ -2956,7 +2956,7 @@ alloc_dma_rcv_ctx(struct ti_ohci *ohci,
        memset(d->prg_cpu, 0, d->num_desc * sizeof(struct dma_cmd*));
        memset(d->prg_bus, 0, d->num_desc * sizeof(dma_addr_t));

-       d->spb = kmalloc(d->split_buf_size, GFP_KERNEL);
+       d->spb = kmalloc(d->split_buf_size, GFP_ATOMIC);

        if (d->spb == NULL) {
                PRINT(KERN_ERR, "Failed to allocate split buffer");

--nextPart3406541.hUXLbitJY3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBs1a6pDoTEvtc05sRAiu3AKDAdvTbsqxLTj9PRCzVOrdhYrHjWACePWPK
aYLliT4cvnEBJVZjuv4LcTk=
=65CC
-----END PGP SIGNATURE-----

--nextPart3406541.hUXLbitJY3--
