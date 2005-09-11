Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVIKRDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVIKRDs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 13:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVIKRDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 13:03:44 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:39908 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751102AbVIKRDn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 13:03:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm2
Date: Sun, 11 Sep 2005 19:03:38 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050908053042.6e05882f.akpm@osdl.org>
In-Reply-To: <20050908053042.6e05882f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qNGJDxgVE2HANth"
Message-Id: <200509111903.38938.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_qNGJDxgVE2HANth
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday, 8 of September 2005 14:30, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm2/
> 
> (kernel.org propagation is slow.  There's a temp copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.13-mm2.bz2)

Could you please reintroduce the yenta-free_irq-on-suspend.patch (attached)
into -mm?  My box does not resume from disk without it.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_qNGJDxgVE2HANth
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="yenta-free_irq-on-suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="yenta-free_irq-on-suspend.patch"


From: Daniel Ritz <daniel.ritz@gmx.ch>

Resume doesn't seem to work without.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pcmcia/yenta_socket.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN drivers/pcmcia/yenta_socket.c~yenta-free_irq-on-suspend drivers/pcmcia/yenta_socket.c
--- devel/drivers/pcmcia/yenta_socket.c~yenta-free_irq-on-suspend	2005-07-28 01:05:52.000000000 -0700
+++ devel-akpm/drivers/pcmcia/yenta_socket.c	2005-07-28 01:05:52.000000000 -0700
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
_

--Boundary-00=_qNGJDxgVE2HANth--
