Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSKGPMM>; Thu, 7 Nov 2002 10:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSKGPMM>; Thu, 7 Nov 2002 10:12:12 -0500
Received: from host194.steeleye.com ([66.206.164.34]:39435 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261228AbSKGPMK>; Thu, 7 Nov 2002 10:12:10 -0500
Message-Id: <200211071518.gA7FIWv02566@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       me Rusty Russell <rusty@rustcorp.com.au>, dipankar@in.ibm.com
Subject: Re: Strange panic as soon as timer interrupts are enabled (recent 
 2.5)
In-Reply-To: Message from "Martin J. Bligh" <mbligh@aracnet.com> 
   of "Wed, 06 Nov 2002 16:27:16 PST." <150020000.1036628836@flay> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 10:18:31 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbligh@aracnet.com said:
> Which seems to work, and is similar to what James did, I think. 

Yes, that's almost exactly equivalent.  The voyager start_secondary sequence 
is almost identical to the APIC sequence in function, it just plays with a 
different piece of hardware.

> Not sure that's any less ugly than the above ;-) I prefer your idea of
> moving calibrate_delay, I'll try that sometime soonish, but need to
> stare at what uses the result for a while first. 

The question really is whether the secondaries need to receive any interrupts 
at all (except for the one that booted them) before the smp_commence mask is 
cleared.  I don't believe this to be the case.  calibrate_delay only requires 
that jiffies be ticking, which will happen as long as the boot cpu is 
receiving timer interrupts.  Perhaps the correct fix is not to enable the 
interrupts early in the start_secondary sequence, and not to lower the APIC 
(or VIC in my case) interrupt masks at all until after smp_commence.  Thus the 
boot CPU will handle all the interrupts up until that point.

James


