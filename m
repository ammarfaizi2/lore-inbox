Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267715AbTBRIid>; Tue, 18 Feb 2003 03:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTBRIid>; Tue, 18 Feb 2003 03:38:33 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:33454 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267715AbTBRIic>; Tue, 18 Feb 2003 03:38:32 -0500
Date: Tue, 18 Feb 2003 09:15:29 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: stuff-up in pcmcia/cardbus stuff
Message-ID: <20030218081529.GA2334@brodo.de>
References: <15953.37244.263505.214325@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15953.37244.263505.214325@argo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 12:50:52PM +1100, Paul Mackerras wrote:
> Recent 2.5 kernels will crash with a null pointer dereference on my
> powerbook (PowerPC laptop) when I try to suspend.  I tracked it down
> to cardbus_suspend() in drivers/pcmcia/pci-socket.c calling
> pcmcia_suspend_socket() with a NULL argument.  It turns out that
> socket->pcmcia_socket is never set in the current code.

Indeed. socket->pcmcia_socket (old) == socket->cls_d.s_info[0] (new)
Could you please check whether this patch helps?

	Dominik

diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-18 09:08:00.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.c	2003-02-18 09:12:02.000000000 +0100
@@ -230,14 +230,16 @@
 static int cardbus_suspend (struct pci_dev *dev, u32 state)
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
-	pcmcia_suspend_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info[0])
+		pcmcia_suspend_socket (socket->cls_d.s_info[0]);
 	return 0;
 }
 
 static int cardbus_resume (struct pci_dev *dev)
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
-	pcmcia_resume_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info[0])
+		pcmcia_resume_socket (socket->cls_d.s_info[0]);
 	return 0;
 }
 
diff -ruN linux-original/drivers/pcmcia/pci_socket.h linux/drivers/pcmcia/pci_socket.h
--- linux-original/drivers/pcmcia/pci_socket.h	2003-02-18 09:08:00.000000000 +0100
+++ linux/drivers/pcmcia/pci_socket.h	2003-02-18 09:10:29.000000000 +0100
@@ -20,7 +20,6 @@
 	socket_cap_t cap;
 	spinlock_t event_lock;
 	unsigned int events;
-	struct socket_info_t *pcmcia_socket;
 	struct work_struct tq_task;
 	struct timer_list poll_timer;
 
