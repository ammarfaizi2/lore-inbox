Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269193AbTCBMJG>; Sun, 2 Mar 2003 07:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269194AbTCBMJG>; Sun, 2 Mar 2003 07:09:06 -0500
Received: from mail.tbdnetworks.com ([63.209.25.99]:48823 "EHLO
	tbdnetworks.com") by vger.kernel.org with ESMTP id <S269193AbTCBMJE>;
	Sun, 2 Mar 2003 07:09:04 -0500
Date: Sun, 2 Mar 2003 04:19:23 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Multiple & vs. && and | vs. || bugs in 2.5.63
Message-ID: <20030302121923.GA27074@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are patches for some | vs. || and & vs. && bugs I found with
find ${1:-.} -name \*.c | xargs grep -En \
 '![a-zA-Z0-9_ ]+(\|[^|]|\&[^&])|([^|]\||[^&]\&) *!'

I also emailed them to the maintainers/authors if I could find them, but
failed for some (e.g. uart00.c).

so long
	Norbert

--- linux-2.5.63/drivers/pnp/pnpbios/core.c~	2003-02-24 11:05:05.000000000 -0800
+++ linux-2.5.63/drivers/pnp/pnpbios/core.c	2003-03-02 03:03:34.000000000 -0800
@@ -322,7 +322,7 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	if ( !boot & pnpbios_dont_use_current_config )
+	if ( !boot && pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_GET_SYS_DEV_NODE, 0, PNP_TS1, 0, PNP_TS2, boot ? 2 : 1, PNP_DS, 0,
 			       nodenum, sizeof(char), data, 65536);
@@ -350,7 +350,7 @@
 	u16 status;
 	if (!pnp_bios_present())
 		return PNP_FUNCTION_NOT_SUPPORTED;
-	if ( !boot & pnpbios_dont_use_current_config )
+	if ( !boot && pnpbios_dont_use_current_config )
 		return PNP_FUNCTION_NOT_SUPPORTED;
 	status = call_pnp_bios(PNP_SET_SYS_DEV_NODE, nodenum, 0, PNP_TS1, boot ? 2 : 1, PNP_DS, 0, 0,
 			       data, 65536, 0, 0);
--- linux-2.5.63/drivers/media/dvb/dvb-core/dvb_demux.c~	2003-02-24 11:05:11.000000000 -0800
+++ linux-2.5.63/drivers/media/dvb/dvb-core/dvb_demux.c	2003-03-02 03:26:22.000000000 -0800
@@ -221,7 +221,7 @@
 			return 0;
 		neq|=f->maskandnotmode[i]&xor;
 	}
-	if (f->doneq & !neq)
+	if (f->doneq && !neq)
 		return 0;
 
         return dvbdmxfeed->cb.sec(dvbdmxfeed->secbuf, dvbdmxfeed->seclen, 
--- linux-2.5.63/drivers/video/console/fbcon.c~	2003-02-24 11:05:37.000000000 -0800
+++ linux-2.5.63/drivers/video/console/fbcon.c	2003-03-02 03:03:34.000000000 -0800
@@ -456,7 +456,7 @@
 	region.color = attr_bgcol_ec(p, vc);
 	region.rop = ROP_COPY;
 
-	if (rw & !bottom_only) {
+	if (rw && !bottom_only) {
 		region.dx = info->var.xoffset + rs;
 		region.dy = 0;
 		region.width = rw;
--- linux-2.5.63/sound/oss/gus_midi.c~	2003-03-02 01:33:31.000000000 -0800
+++ linux-2.5.63/sound/oss/gus_midi.c	2003-03-02 03:03:33.000000000 -0800
@@ -179,7 +179,7 @@
 		qhead++;
 	}
 	spin_unlock_irqrestore(&lock,flags);
-	return (qlen > 0) | !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
+	return (qlen > 0) || !(GUS_MIDI_STATUS() & MIDI_XMIT_EMPTY);
 }
 
 #define MIDI_SYNTH_NAME	"Gravis Ultrasound Midi"
--- linux-2.5.63/mm/slab.c~	2003-02-24 11:05:39.000000000 -0800
+++ linux-2.5.63/mm/slab.c	2003-03-02 03:03:33.000000000 -0800
@@ -1643,7 +1643,7 @@
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
 		unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 
-		if (!flags & __GFP_WAIT)
+		if (!(flags & __GFP_WAIT))
 			ctor_flags |= SLAB_CTOR_ATOMIC;
 
 		cachep->ctor(objp, cachep, ctor_flags);
--- linux-2.5.63/net/sctp/tsnmap.c~	2003-02-24 11:06:01.000000000 -0800
+++ linux-2.5.63/net/sctp/tsnmap.c	2003-03-02 03:03:34.000000000 -0800
@@ -246,7 +246,7 @@
 	/* The Gap Ack Block happens to end at the end of the
 	 * overflow map.
 	 */
-	if (started & !ended) {
+	if (started && !ended) {
 		ended++;
 		_end = map->len + map->len - 1;
 	}
--- linux-2.5.63/drivers/serial/uart00.c~	2003-02-24 11:05:16.000000000 -0800
+++ linux-2.5.63/drivers/serial/uart00.c	2003-03-02 03:03:34.000000000 -0800
@@ -235,8 +235,8 @@
 
 	status = UART_GET_MSR(port);
 
-	if (!status & (UART_MSR_DCTS_MSK | UART_MSR_DDSR_MSK | 
-		       UART_MSR_TERI_MSK | UART_MSR_DDCD_MSK))
+	if (!(status & (UART_MSR_DCTS_MSK | UART_MSR_DDSR_MSK | 
+			UART_MSR_TERI_MSK | UART_MSR_DDCD_MSK)))
 		return;
 
 	if (status & UART_MSR_DDCD_MSK)
