Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267203AbUBSLWn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 06:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267204AbUBSLWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 06:22:43 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:57556 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S267203AbUBSLWl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 06:22:41 -0500
From: Silla Rizzoli <silla@netvalley.it>
Organization: Communication Valley spa
To: linux-kernel@vger.kernel.org
Subject: 2.4.25 yenta problem and small fix/workaround
Date: Thu, 19 Feb 2004 12:22:42 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402191222.45709.silla@netvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Inserting a PC Card in my laptop (IMB R40 2681) with kernel 2.4.25 results in 
the following message:

Feb 19 11:10:16 [kernel] cs: socket d603e000 voltage interrogation timed out

This sometimes happens with 2.6.x too, but issuing cardctl insert 0 usually 
solves the problem, however in this case it didn't. I tried to modify all the 
pcmcia_core module parameters but to no avail, the socket remained dead.

Examining the sources I noticed that 2.4.25 introduced this three line check; 
I suppose that the socket state read returns a valid state and 
cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST) is not executed.
Removing the check and executing the last line regardless fixes the problem.
I am probably experiencing a hardware bug limited to my laptop, but I'm 
posting this small patch here just in case someone has the same problem.

Regards,
Silla Rizzoli



--- ./drivers/pcmcia/yenta.c.orig       2004-02-19 11:44:29.000000000 +0100
+++ ./drivers/pcmcia/yenta.c    2004-02-19 11:43:45.000000000 +0100
@@ -676,9 +676,6 @@
        exca_writeb(socket, I365_GENCTL, 0x00);

        /* Redo card voltage interrogation */
-       state = cb_readl(socket, CB_SOCKET_STATE);
-       if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
-                       CB_3VCARD | CB_XVCARD | CB_YVCARD)))

        cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
 }
