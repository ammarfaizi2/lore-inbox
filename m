Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbUDLR6M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 13:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUDLR6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 13:58:12 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:1733 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262990AbUDLR6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 13:58:09 -0400
Date: Mon, 12 Apr 2004 13:58:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
In-Reply-To: <452548B29F0CCE48B8ABB094307EBA1C0422014B@USRV-EXCH2.na.uis.unisys.com>
Message-ID: <Pine.LNX.4.58.0404121318510.18930@montezuma.fsmlabs.com>
References: <452548B29F0CCE48B8ABB094307EBA1C0422014B@USRV-EXCH2.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Protasevich, Natalie wrote:

> Since it is a valid entry, find_irq_entry() in setup_IO_APIC_irqs() searches the mp_irqs[] by the pin number and runs into this element first. It uses it to program the pin and never gets to the element down below that contains modified entry with a correct overwrite in it.
> I was able to get rid of this problem on the ES7000 with the following code:
>
>         for (i = 0; i < mp_irq_entries; i++) {
>                 if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus)
>                       && (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
>                         mp_irqs[i] = intsrc;
>   +                     if (intsrc.mpc_srcbusirq > pin) {
>   +                            int j;
>   +                            for (j = 0; j < i; j++)
>   +                                   if (mp_irqs[j].mpc_dstirq == intsrc.mpc_dstirq)
>   +                                         mp_irqs[j].mpc_irqtype = -1;
>   +                     }
>                         found = 1;
>                         break;
>                 }
>         }
> I will appreciate any feedback and suggestions.

Out of interest, doesn't this have the same effect?

Index: linux-2.6.5-mc3/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-mc3/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mpparse.c
--- linux-2.6.5-mc3/arch/i386/kernel/mpparse.c	9 Apr 2004 17:53:27 -0000	1.1.1.1
+++ linux-2.6.5-mc3/arch/i386/kernel/mpparse.c	12 Apr 2004 17:49:18 -0000
@@ -968,8 +968,7 @@ void __init mp_override_legacy_irq (
 	 * Otherwise create a new entry (e.g. gsi == 2).
 	 */
 	for (i = 0; i < mp_irq_entries; i++) {
-		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus)
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
+		if (mp_irqs[i].mpc_dstirq == pin) {
 			mp_irqs[i] = intsrc;
 			found = 1;
 			break;
