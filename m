Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268041AbTBRWFG>; Tue, 18 Feb 2003 17:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268042AbTBRWFG>; Tue, 18 Feb 2003 17:05:06 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:33015 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S268041AbTBRWE5>; Tue, 18 Feb 2003 17:04:57 -0500
Date: Tue, 18 Feb 2003 23:14:16 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH, updated] Re: stuff-up in pcmcia/cardbus stuff
Message-ID: <20030218221415.GA7212@brodo.de>
References: <15953.37244.263505.214325@argo.ozlabs.ibm.com> <20030218081529.GA2334@brodo.de> <3E51FBA1.7020208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E51FBA1.7020208@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 04:23:45AM -0500, Jeff Garzik wrote:
> Dominik Brodowski wrote:
> >Indeed. socket->pcmcia_socket (old) == socket->cls_d.s_info[0] (new)
> 
> If this is true...
<snip>
> 
> 2) why are multiple s_info records allocated, when you hardcode use of 
> record #0 ?

Indeed, the allocation of MAX_SOCK_PER_DEV s_info[] pointers is pointless.

	Dominik

diff -ruN linux-original/drivers/pcmcia/cs.c linux-pcmcia/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-18 09:08:00.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/cs.c	2003-02-18 23:10:56.000000000 +0100
@@ -330,11 +330,12 @@
 		return -ENOMEM;
 	memset(s_info, 0, cls_d->nsock * sizeof(socket_info_t));
 
+	cls_d->s_info = s_info;
+
 	/* socket initialization */
 	for (i = 0; i < cls_d->nsock; i++) {
 		socket_info_t *s = &s_info[i];
 
-		cls_d->s_info[i] = s;
 		s->ss_entry = cls_d->ops;
 		s->sock = i;
 
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux-pcmcia/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-18 22:54:34.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/pci_socket.c	2003-02-18 23:10:10.000000000 +0100
@@ -230,14 +230,16 @@
 static int cardbus_suspend (struct pci_dev *dev, u32 state)
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
-	pcmcia_suspend_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info)
+		pcmcia_suspend_socket (socket->cls_d.s_info);
 	return 0;
 }
 
 static int cardbus_resume (struct pci_dev *dev)
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
-	pcmcia_resume_socket (socket->pcmcia_socket);
+	if (socket && socket->cls_d.s_info)
+		pcmcia_resume_socket (socket->cls_d.s_info);
 	return 0;
 }
 
diff -ruN linux-original/drivers/pcmcia/pci_socket.h linux-pcmcia/drivers/pcmcia/pci_socket.h
--- linux-original/drivers/pcmcia/pci_socket.h	2003-02-18 22:54:34.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/pci_socket.h	2003-02-18 23:10:42.000000000 +0100
@@ -20,7 +20,6 @@
 	socket_cap_t cap;
 	spinlock_t event_lock;
 	unsigned int events;
-	struct socket_info_t *pcmcia_socket;
 	struct work_struct tq_task;
 	struct timer_list poll_timer;
 
diff -ruN linux-original/include/pcmcia/ss.h linux-pcmcia/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-02-18 09:08:02.000000000 +0100
+++ linux-pcmcia/include/pcmcia/ss.h	2003-02-18 23:09:55.000000000 +0100
@@ -144,12 +144,10 @@
  *  Calls to set up low-level "Socket Services" drivers
  */
 
-#define MAX_SOCKETS_PER_DEV 8
-
 struct pcmcia_socket_class_data {
 	unsigned int nsock;			/* number of sockets */
 	struct pccard_operations *ops;		/* see above */
-	void *s_info[MAX_SOCKETS_PER_DEV];	/* socket_info_t */
+	void *s_info;				/* socket_info_t */
 	unsigned int use_bus_pm;
 };
 
