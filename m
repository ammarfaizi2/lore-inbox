Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264711AbUEOTgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264711AbUEOTgD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 15:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264715AbUEOTgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 15:36:03 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:6117 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264711AbUEOTf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 15:35:58 -0400
Message-ID: <40A670D9.5010409@colorfullife.com>
Date: Sat, 15 May 2004 21:34:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alec H. Peterson" <ahp@hilander.com>
CC: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>,
       netdev@oss.sgi.com
Subject: Re: PCI memory reservation failure - 2.4/2.6
References: <BDD74A21E0B47FEAC3AB8A10@[192.168.0.100]> <40A29211.2010707@colorfullife.com> <9C9F57570B19C8A682D96940@[192.168.0.100]>
In-Reply-To: <9C9F57570B19C8A682D96940@[192.168.0.100]>
Content-Type: multipart/mixed;
 boundary="------------090502040709030809050103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090502040709030809050103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alec H. Peterson wrote:

>
> A module parameter sounds like a grand idea.  I'd be happy to take a 
> stab at it if others feel it is the way to go.

There are two possible approaches:
- just a module parameter. Probably something for 2.4.
- a combination of a dmi detection of buggy bios versions plus a pci 
quirk that resets start and end to 0.

Attached is the module parameter patch against 2.6. If it works I can 
write a backport to 2.4 and try to convince Marcelo to merge it.
Could you send me the output of dmidecode? I'll try to write the 
autodetection patch for 2.6.

--
    Manfred


--------------090502040709030809050103
Content-Type: text/plain;
 name="patch-yenta"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-yenta"

--- 2.6/drivers/pcmcia/yenta_socket.c	2004-05-15 11:21:38.000000000 +0200
+++ build-2.6/drivers/pcmcia/yenta_socket.c	2004-05-15 15:00:22.000000000 +0200
@@ -40,7 +40,7 @@
 #define to_ns(cycles)	((cycles)*120)
 
 static int yenta_probe_cb_irq(struct yenta_socket *socket);
-
+static int override_bios;
 
 /*
  * Generate easy-to-use ways of reading a cardbus sockets
@@ -548,7 +548,7 @@
 
 	start = config_readl(socket, offset) & mask;
 	end = config_readl(socket, offset+4) | ~mask;
-	if (start && end > start) {
+	if (start && end > start && !override_bios) {
 		res->start = start;
 		res->end = end;
 		if (request_resource(root, res) == 0)
@@ -1105,6 +1105,8 @@
 };
 MODULE_DEVICE_TABLE(pci, yenta_table);
 
+MODULE_PARM (override_bios, "i");
+MODULE_PARM_DESC (override_bios, "yenta ignore bios resource allocation");
 
 static struct pci_driver yenta_cardbus_driver = {
 	.name		= "yenta_cardbus",

--------------090502040709030809050103--

