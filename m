Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVCUW6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVCUW6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVCUW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:56:22 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:48847 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262124AbVCUWyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:54:06 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Andrew Morton <akpm@osdl.org>, Ron Gage <ron@rongage.org>
Subject: Re: Fw: Major problem with PCMCIA/Yenta system
Date: Mon, 21 Mar 2005 23:53:22 +0100
User-Agent: KMail/1.5.4
References: <20050320164619.565f4470.akpm@osdl.org>
In-Reply-To: <20050320164619.565f4470.akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Wolf <webmaster@checkpoint-computer.de>,
       Jonas Oreland <jonas.oreland@mysql.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503212353.22924.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 01:46, Andrew Morton wrote:
> 
> Do you think your recent work on ti12xx_hook() will help this guy?

may be. it really sounds like the exact same problem..
> 
> (Did a patch come out of that, btw?)

the one i sent was buggy for those reasons:
- the TI hook function override that of yenta which does the very wrong
  thing in a system with mixed TI/non TI bridges (which actually exists)
- it can only handle TI's with just one slot
- it fails on older TI's (125x series)

another problem is that those things can have 1001 configurations.
single slot devices are not a problem but dual-slot are. with recent
bridges in "normal" mode (function 0 uses INTA, function 1 uses INTB)
it's also not a problem. but the modes INTRTIE and ALL_SERIAL are
because disabling that will cause regressions with a working card
inserted. and the older bridges habe more that one pin that can
be configured as INTA / INTB. i can code it up, no problem (minus
ALL_SERIAL and INTRTIE for dual-slots)

a slightly different approach is just to return IRQ_HANDLED for
every interrupt durning power-on of the card. doesn't solve the
interrupt storm of course...the kernel 2.4 behavior...patch attached...
it compiles and boots here but is otherwise untested (i don't have a TI
bridge around anymore)

rgds
-daniel


> 
> Begin forwarded message:
> 
> Date: Sun, 20 Mar 2005 18:53:47 -0500
> From: Ron Gage <ron@rongage.org>
> To: linux-kernel@vger.kernel.org
> Subject: Major problem with PCMCIA/Yenta system
> 
> 
> Greetings:
> 
> I have been trying to get a recently acquired Cardbus based USB 2.0 card 
> working under 2.6 for the past weekend.  It's not going well.
> 
> Everytime I plug the card into the computer, the entire PCMCIA system just 
> dies, taking my network connectivity with it.  I have to do a power off reset 
> to recover.
> 
> The cardbus card is based on the ALI USB chipset.  This shows up as both an 
> EHCI and an OHCI device under 2.6.11.5.  My laptop, an older HP Pavilion 
> N5150 has a UHCI based chipset:
> 
> 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 
> 03)
> 00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 
> 03)
> 00:04.0 CardBus bridge: Texas Instruments PCI1420
> 00:04.1 CardBus bridge: Texas Instruments PCI1420
> 00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
> 00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
> 01:01.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 11)
> 02:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 
> (rev 41)
> 
> 
> My ethernet card is a generic cardbus device.
> 
> When I insert the new USB 2.0 card, the kernel reports that it's killing off 
> IRQ 11.  Here is the actual dump from dmesg:
> 
[...]
> 
> Again, when the USB card in inserted, the entire PCMCIA system shuts down and 
> remains unusuable until powered off.
> 
> Kernel is stock 2.6.11.5.  I also tried with 2.6.11, 2.6.10, 2.6.9 and 2.6.7 - 
> same result.  Distribution is Slackware 9.1 - gcc is 3.2.3
> 
> HELP!!!
> 
> 

--- 1.70/drivers/pcmcia/yenta_socket.c	2005-03-11 21:32:12 +01:00
+++ edited/drivers/pcmcia/yenta_socket.c	2005-03-20 17:33:27 +01:00
@@ -405,6 +405,30 @@
 }
 
 
+static int yenta_generic_hook(struct pcmcia_socket *sock, int operation)
+{
+	struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);
+
+	switch (operation) {
+	case HOOK_POWER_PRE:
+		/*
+		 * re-user probe_status to tell the interrupt handler to ack
+		 * everything
+		 */
+		socket->probe_status = 0x0f0f0f0f;
+		break;
+
+	case HOOK_POWER_POST:
+		socket->probe_status = 0;
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static unsigned int yenta_events(struct yenta_socket *socket)
 {
 	u8 csc;
@@ -440,6 +464,10 @@
 		pcmcia_parse_events(&socket->socket, events);
 		return IRQ_HANDLED;
 	}
+	
+	if (socket->probe_status == 0x0f0f0f0f)
+		return IRQ_HANDLED;
+
 	return IRQ_NONE;
 }
 
@@ -673,6 +701,7 @@
 	.set_socket		= yenta_set_socket,
 	.set_io_map		= yenta_set_io_map,
 	.set_mem_map		= yenta_set_mem_map,
+	.generic_hook		= yenta_generic_hook,
 };
 
 
--- 1.125/drivers/pcmcia/cs.c	2005-03-11 21:32:13 +01:00
+++ edited/drivers/pcmcia/cs.c	2005-03-12 21:22:38 +01:00
@@ -508,6 +508,10 @@
 		cs_err(skt, "unsupported voltage key.\n");
 		return CS_BAD_TYPE;
 	}
+
+	if (skt->ops->generic_hook)
+		skt->ops->generic_hook(skt, HOOK_POWER_PRE);
+
 	skt->socket.flags = 0;
 	skt->ops->set_socket(skt, &skt->socket);
 
@@ -522,7 +526,12 @@
 		return CS_BAD_TYPE;
 	}
 
-	return socket_reset(skt);
+	status = socket_reset(skt);
+
+	if (skt->ops->generic_hook)
+		skt->ops->generic_hook(skt, HOOK_POWER_POST);
+
+	return status;
 }
 
 /*
--- 1.48/include/pcmcia/ss.h	2005-03-11 21:32:13 +01:00
+++ edited/include/pcmcia/ss.h	2005-03-12 21:22:39 +01:00
@@ -77,6 +77,11 @@
 /* Use this just for bridge windows */
 #define MAP_IOSPACE	0x20
 
+/* generic hook operations */
+#define HOOK_POWER_PRE	0x01
+#define HOOK_POWER_POST	0x02
+
+
 typedef struct pccard_io_map {
     u_char	map;
     u_char	flags;
@@ -113,6 +118,7 @@
 	int (*set_socket)(struct pcmcia_socket *sock, socket_state_t *state);
 	int (*set_io_map)(struct pcmcia_socket *sock, struct pccard_io_map *io);
 	int (*set_mem_map)(struct pcmcia_socket *sock, struct pccard_mem_map *mem);
+	int (*generic_hook)(struct pcmcia_socket *sock, int operation);
 };
 
 struct pccard_resource_ops {

