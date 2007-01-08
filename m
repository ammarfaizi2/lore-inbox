Return-Path: <linux-kernel-owner+w=401wt.eu-S964915AbXAHVuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbXAHVuR (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbXAHVuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:50:16 -0500
Received: from outbound-fra.frontbridge.com ([62.209.45.174]:30596 "EHLO
	outbound3-fra-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964906AbXAHVuO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:50:14 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq
Date: Mon, 8 Jan 2007 13:46:49 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA490736D@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq
Thread-Index: AcczbJn1Nu0sUOc1SqStABAMOPQhrwAAGmSA
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2007 21:46:50.0704 (UTC)
 FILETIME=[81002D00:01C7336E]
X-WSS-ID: 69BC64400T04191349-03-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: ebiederm@xmission.com [mailto:ebiederm@xmission.com] 
Sent: Monday, January 08, 2007 1:31 PM
To: Lu, Yinghai
Cc: Linus Torvalds; Tobias Diedrich; Andrew Morton; Adrian Bunk; Andi
Kleen; Linux Kernel Mailing List
Subject: Re: [PATCH 1/4] x86_64 io_apic: Implement remove_pin_to_irq

>Any updates to add_pin_to_irq are wrong.  It works fine.  If there
>is something wrong we need to fix remove_pin_to_irq.

>What is the problem you see?  Sorry I'm dense at the moment.

+static int check_timer_pin(int apic, int pin) {
+	int irq, idx;
+	/* 
+	 * Test the architecture default i8254 timer pin
+	 * of apic 0 pin 2.
+	 */
+
+
+	/* If the apic pin pair is in use by another irq fail */
+	irq = irq_from_pin(apic, pin);
+	if ((irq != -1) && (irq != 0)) {
+		apic_printk(APIC_VERBOSE,KERN_INFO "...apic %d pin % in
use by irq %d\n",
+			apic, pin, irq);
+		return 0; 
+	}
+
+	/* Add an entry in mp_irqs for irq 0 */
+	idx = update_irq0_entry(apic, pin);
+
+	/* Add an entry in irq_to_pin */
+	add_pin_to_irq(0, apic, pin);
+
+	/* Now setup the irq */
+	setup_IO_APIC_irq(apic, pin, idx, 0);
+
+	/* And finally check to see if the irq works */
+	return do_check_timer_pin(apic, pin);
+}
+

In the check_timer_pin, irq_from_pin could return 0, it mean some entry
is for IRQ0 already.
The add_pin_to_irq could add another same entry for it again.

YH


