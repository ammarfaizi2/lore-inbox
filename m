Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUDLUZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUDLUZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:25:48 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:65035 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S263057AbUDLUZq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:25:46 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
Date: Mon, 12 Apr 2004 15:25:34 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C0422014D@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.5- es7000 subarch update
Thread-Index: AcQgvFqc1FngrvT/SF+R/Z3tlbe0RwAAlvXQ
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>
Cc: "Andrew Morton" <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "LSE" <lse-tech@lists.sourceforge.net>
X-OriginalArrivalTime: 12 Apr 2004 20:25:35.0270 (UTC) FILETIME=[4F843C60:01C420CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Since it is a valid entry, find_irq_entry() in setup_IO_APIC_irqs() searches the mp_irqs[] by the pin number and runs into this element first. It uses it to program the pin and never gets to the element down below that contains modified entry with a correct overwrite in it.
> > I was able to get rid of this problem on the ES7000 with the following code:
> >
> >         for (i = 0; i < mp_irq_entries; i++) {
> >                 if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus)
> >                       && (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
> >                         mp_irqs[i] = intsrc;
> >   +                     if (intsrc.mpc_srcbusirq > pin) {
> >   +                            int j;
> >   +                            for (j = 0; j < i; j++)
> >   +                                   if (mp_irqs[j].mpc_dstirq == intsrc.mpc_dstirq)
> >   +                                         mp_irqs[j].mpc_irqtype = -1;
> >   +                     }
> >                         found = 1;
> >                         break;
> >                 }
> >         }
> > I will appreciate any feedback and suggestions.
>
> Out of interest, doesn't this have the same effect?

Hi Zwane,
It is actually close to what I had in my initial patch when I posted it (and got in trouble with the timer IRQ0):

			...
			intsrc.mpc_dstirq = pin;
			...			
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
+			&& (mp_irqs[i].mpc_dstirq == intsrc.mpc_dstirq)) {

This code indexes mp_irqs[] by the pin, but has a similar "miscounting" problem and adds a second element with the same bus irq. I think this code could work either way being indexed by the pin or by the bus irq, but it has to be fixed in either case. (As I understand, with srcbusirq it doesn't work as is for much fewer people than with dstirq :)

Regards,
--Natalie 

>Forgot the bus check;

>Index: linux-2.6.5-mc3/arch/i386/kernel/mpparse.c
>===================================================================
>RCS file: /home/cvsroot/linux-2.6.5-mc3/arch/i386/kernel/mpparse.c,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 mpparse.c
>--- linux-2.6.5-mc3/arch/i386/kernel/mpparse.c	9 Apr 2004 17:53:27 -0000	1.1.1.1
>+++ linux-2.6.5-mc3/arch/i386/kernel/mpparse.c	12 Apr 2004 18:31:22 -0000
>@@ -968,8 +968,9 @@ void __init mp_override_legacy_irq (
> 	 * Otherwise create a new entry (e.g. gsi == 2).
> 	 */
> 	for (i = 0; i < mp_irq_entries; i++) {
>-		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus)
>-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
>+		if ((mp_irqs[i].srcbus == MP_ISA_BUS) &&
>+			mp_irqs[i].mpc_dstirq == pin) {
>+
> 			mp_irqs[i] = intsrc;
> 			found = 1;
> 			break;
