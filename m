Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTJ1V14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTJ1V14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:27:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38149 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261586AbTJ1V1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:27:55 -0500
Date: Tue, 28 Oct 2003 21:27:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-pcmcia@lists.infradead.org
Subject: [PATCH] Fix PCMCIA card detection
Message-ID: <20031028212749.B31337@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm intending sending Linus the following patch to fix PCMCIA card
detection about 24 hours (on 21:26 GMT on Oct 29th.)  A couple of
people have tested it and reported that it fixes their card detection
problems.  I'd like people _without_ this problem to try the patch
and report if they see any breakages.


Idea from David Hinds.

Some PCMCIA/Cardbus controllers seem to get upset when we ask
them to re-do card interrogation - they miss the next insertion
event.

We therefore avoid forcing needless card interrogations if a
card has already been succesfully detected and interrogated.

diff -Nru a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
--- a/drivers/pcmcia/yenta_socket.c	Mon Oct 27 23:27:19 2003
+++ b/drivers/pcmcia/yenta_socket.c	Mon Oct 27 23:27:19 2003
@@ -461,6 +461,7 @@
 static int yenta_sock_init(struct pcmcia_socket *sock)
 {
 	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+	u32 state;
 	u16 bridge;
 
 	bridge = config_readw(socket, CB_BRIDGE_CONTROL) & ~CB_BRIDGE_INTR;
@@ -472,7 +473,10 @@
 	exca_writeb(socket, I365_GENCTL, 0x00);
 
 	/* Redo card voltage interrogation */
-	cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
+	state = cb_readl(socket, CB_SOCKET_STATE);
+	if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
+	               CB_3VCARD | CB_XVCARD | CB_YVCARD)))
+		cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
 
 	yenta_clear_maps(socket);
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
