Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVGWXpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVGWXpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 19:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVGWXpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 19:45:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:22945 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262089AbVGWXpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 19:45:35 -0400
X-Authenticated: #2813124
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: fix suspend/resume irq request free for yenta..
Date: Sun, 24 Jul 2005 01:46:29 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507240146.30670.daniel.ritz@gmx.ch>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

the patch is wrong. yenta_request_irq() registers the wrong handler.
plus yenta_probe_cb_irq() has nothing to do with suspend/resume
(besides it frees the irq in the very same function). correct patch below.

somebody cares to explain me why the free_irq() is necessary before
a suspend?

rgds
-daniel

---------------

[PATCH] yenta: free_irq() on suspend.

Resume doesn't seem to work without.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1107,6 +1107,8 @@ static int yenta_dev_suspend (struct pci
 		pci_read_config_dword(dev, 17*4, &socket->saved_state[1]);
 		pci_disable_device(dev);
 
+		free_irq(dev->irq, socket);
+
 		/*
 		 * Some laptops (IBM T22) do not like us putting the Cardbus
 		 * bridge into D3.  At a guess, some other laptop will
@@ -1132,6 +1134,13 @@ static int yenta_dev_resume (struct pci_
 		pci_enable_device(dev);
 		pci_set_master(dev);
 
+		if (socket->cb_irq)
+			if (request_irq(socket->cb_irq, yenta_interrupt,
+			                SA_SHIRQ, "yenta", socket)) {
+				printk(KERN_WARNING "Yenta: request_irq() failed on resume!\n");
+				socket->cb_irq = 0;
+			}
+
 		if (socket->type && socket->type->restore_state)
 			socket->type->restore_state(socket);
 	}
