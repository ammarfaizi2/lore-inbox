Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947316AbWKKVtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947316AbWKKVtB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 16:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947311AbWKKVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 16:49:01 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:4522 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1947313AbWKKVsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 16:48:51 -0500
Message-id: <129784351190324394@wsc.cz>
In-reply-to: <196416110522272@wsc.cz>
Subject: [PATCH 4/5] Char: istallion, dynamic tty device
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 11 Nov 2006 22:49:02 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, dynamic tty device

register tty device dynamically according to the count of board ports.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 010cb3032661418012dd0949ff3566927ed430cd
tree 3da0c21735d8a6e32c59dde2ec2979c9dc9680c7
parent 92452a22c4ada362e991cbf0de84c8914525672a
author Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 02:29:24 +0100
committer Jiri Slaby <jirislaby@gmail.com> Sat, 11 Nov 2006 22:23:36 +0100

 drivers/char/istallion.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index bf58938..cbbc3cd 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -3846,6 +3846,10 @@ static int stli_findeisabrds(void)
 
 		stli_brds[brdp->brdnr] = brdp;
 		found++;
+
+		for (i = 0; i < brdp->nrports; i++)
+			tty_register_device(stli_serial,
+					brdp->brdnr * STL_MAXPORTS + i, NULL);
 	}
 
 	return found;
@@ -3872,6 +3876,7 @@ static int __devinit stli_pciprobe(struc
 		const struct pci_device_id *ent)
 {
 	struct stlibrd *brdp;
+	unsigned int i;
 	int brdnr, retval = -EIO;
 
 	retval = pci_enable_device(pdev);
@@ -3912,6 +3917,10 @@ static int __devinit stli_pciprobe(struc
 	brdp->enable = NULL;
 	brdp->disable = NULL;
 
+	for (i = 0; i < brdp->nrports; i++)
+		tty_register_device(stli_serial, brdp->brdnr * STL_MAXPORTS + i,
+				&pdev->dev);
+
 	return 0;
 err_null:
 	stli_brds[brdp->brdnr] = NULL;
@@ -3992,6 +4001,10 @@ static int stli_initbrds(void)
 		}
 		stli_brds[brdp->brdnr] = brdp;
 		found++;
+
+		for (i = 0; i < brdp->nrports; i++)
+			tty_register_device(stli_serial,
+					brdp->brdnr * STL_MAXPORTS + i, NULL);
 	}
 
 	retval = stli_findeisabrds();
@@ -4596,7 +4609,7 @@ static int __init istallion_module_init(
 	stli_serial->type = TTY_DRIVER_TYPE_SERIAL;
 	stli_serial->subtype = SERIAL_TYPE_NORMAL;
 	stli_serial->init_termios = stli_deftermios;
-	stli_serial->flags = TTY_DRIVER_REAL_RAW;
+	stli_serial->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(stli_serial, &stli_ops);
 
 	retval = tty_register_driver(stli_serial);
