Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbUFFDaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUFFDaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 23:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUFFDaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 23:30:05 -0400
Received: from 146-235-81-62.libre.auna.net ([62.81.235.146]:51420 "EHLO
	asmtp01.eresmas.com") by vger.kernel.org with ESMTP id S262794AbUFFD3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 23:29:51 -0400
From: ktech@wanadoo.es
To: torvalds@osdl.org
Subject: RE: Re: 2.6.7-rc1 breaks forcedeth
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com, jgarzik@pobox.com
Date: Sun, 6 Jun 2004 05:29:49 +0200
X-MAILER: ARB/3.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E1BWoM2-0003XH-2w@mb03.in.mad.eresmas.com>
X-Spam-Score: 0.3 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well. Should I wait until a "debug" versión of forcedeth is released? Or do you want for me to do some tests?



If you (or the maintainer of the driver) wants me to do some tests, please drop me an email (I'm not subscribed).



Thanks.



Luis Miguel García

Spain





----- Mensaje Original -----

Remitente: Linus Torvalds torvalds@osdl.org

Destinatario: ktech@wanadoo.es

Fecha: Domingo, Junio 6, 2004  5:14am

Asunto: Re: 2.6.7-rc1 breaks forcedeth



>

>On Sun, 6 Jun 2004 ktech@wanadoo.es wrote:

>> 

>> 2.6.7rc

>> 

>> ------------

>>            CPU0       

>>   0:     163490          XT-PIC  timer

>>   1:        170          XT-PIC  i8042

>>   2:          0          XT-PIC  cascade

>>   5:          0          XT-PIC  Bt87x audio

>>   7:          0          XT-PIC  NVidia nForce2

>>   8:          2          XT-PIC  rtc

>>   9:          0          XT-PIC  acpi

>>  11:     100000          XT-PIC  ehci_hcd

>>  12:       1162          XT-PIC  i8042

>>  14:      14766          XT-PIC  ide0

>>  15:         18          XT-PIC  ide1

>> NMI:          0 

>> ERR:          0

>This doesn't show the forcedeth driver at all. Not on irq11 (where 

>it 

>should be), and not anywhere else either.

>The thing is, the driver seems to not actually even register the irq 

>handler until the device is opened, which seems a bit bogus. It will 

>certainly result in problems if the device ever sends an interrupt. 

>And 

>that seems to be exactly the behaviour you see.

>I suspect that the driver should at the very least make sure to disable

>any potentially pending interrupts in the "nv_probe()" function. I 

>have no 

>idea how to do that, but it looks like something like

>	writel(0, base + NvRegIrqMask);

>	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);

>should probably do it. It would be better to reset the thing 

>completely, 

>methinks, but whatever.

>Anyway, this really looks very much like an irq is pending on the 

>ethernet 

>controller, and isn't cleared, and then when the USB driver 

>registers the 

>same irq (which was previously masked because nobody had actually 

>registered it), you get a storm of irq's.

>As to _why_ this happens only with the current kernel, I don't know. 

>Might 

>be an irq level/edge issue.

>It would be interesting to have the forcedeth driver print out the 

>irq it 

>will use in nv_probe, just to verify that it's 11. So when it 

>currently 

>just says "forcedeth.c: subsystem: %05x:%04x bound to %s", make it 

>print 

>out "dev->irq" too..

>		Linus
