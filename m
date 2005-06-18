Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVFRXwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVFRXwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 19:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVFRXwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 19:52:34 -0400
Received: from colin.muc.de ([193.149.48.1]:45576 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262206AbVFRXwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 19:52:31 -0400
Date: 19 Jun 2005 01:52:29 +0200
Date: Sun, 19 Jun 2005 01:52:29 +0200
From: Andi Kleen <ak@muc.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work II + PATCH
Message-ID: <20050618235229.GA35248@muc.de>
References: <200506181452.52921.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506181452.52921.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 02:52:52PM +0100, Alistair John Strachan wrote:
> Hi,
> 
> I upgraded my nForce3 x86-64 desktop from 2.6.12-rc5 to 2.6.12 today and 
> something strange started happening. Waay back in 2.6.x I had problems with 
> the "noapic" default for nForce boards on x86-64, and so used the "apic" 
> kernel boot parameter to force the apic on; this worked successfully for a 
> long time with no timer problems.
> 
> However, as of 2.6.12 (maybe -rc6, too?) my desktop occasionally fails to boot 
> with the message:
> 
> "IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter."
> (arch/x86_64/kernel/io_apic.c)
> 
> However, this message is intermittent; it is sometimes possible to boot 
> without getting it, and everything works fine. So I took its advice and ran 
> with noapic, and everything seems fine now.
> 
> However, I just thought I'd let whoever maintains this bit of code know that 
> the check isn't a "sure thing": it's not being flagged reliably. Whether this 
> is my BIOS or the kernel, I don't know.

It's a bit of a shot into the dark, but could you test if the following
patch helps?  The A64 is quite aggressive in reordering instructions and it
 might be breaking __delay() and cause it to return early.

If not I would check what a failing case and a working case output for

Calibrating delay loop... 3940.35 BogoMIPS (lpj=1970176)

Does the failing kernel output something different here? 

-Andi


diff -u linux-2.6.12/arch/x86_64/lib/delay.c-o linux-2.6.12-rc6-git4-work/arch/x86_64/lib/delay.c
--- linux-2.6.12/arch/x86_64/lib/delay.c-o	2005-06-11 13:04:28.000000000 +0200
+++ linux-2.6.12/arch/x86_64/lib/delay.c	2005-06-19 01:49:09.000000000 +0200
@@ -27,9 +27,9 @@
 	do
 	{
 		rep_nop(); 
+		sync_core();
 		rdtscl(now);
-	}
-	while((now-bclock) < loops);
+	} while((now-bclock) < loops);
 }
 
 inline void __const_udelay(unsigned long xloops)
