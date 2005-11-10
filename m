Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVKJOWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVKJOWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVKJOWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:22:25 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:12320
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750957AbVKJOWY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:22:24 -0500
Message-Id: <437365EF.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 15:23:27 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <vojtech@suse.cz>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
References: <43720DAE.76F0.0078.0@novell.com>  <4372105B.76F0.0078.0@novell.com>  <437210D1.76F0.0078.0@novell.com> <200511101419.03838.ak@suse.de>
In-Reply-To: <200511101419.03838.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The magic ICH6 HPET enable code has to go. It looks far too fragile and might 
>break something else. I also don't want direct PCI config space accesses like 
>this. We'll have to wait for ACPI HPET support I think. I think I'll remove 
>the original hack for AMD 8111 too - it was only for testing anyways. If you 
>still want to use it you have to keep it as a private patch.

That's fine with me. However, it was the only way for me to test the HPET code... It's not enabled anyway by default, but if you want the whole hack go away that's fine with me.

>Please remove the ifdefs too.  64bit HPET support would be fine, but 
>only as a runtime mechanism, not compile time.

This I added only for the purpose of not affecting existing code in existing configurations. If the code is generally acceptable, then I'll be more than happy to convert it.

>Can you remove debugger_jiffies please? 
>The code has to handle long delays anyways (e.g. if someone uses a target
>probe), so we cannot rely on such hacks anyways.

As above, I introduced this only to not affect existing code. If the added latency is no problem, then of course only the overflow safe code path should be kept, and then debugger_jiffies is completely unnecessary.

>I don't quite understand why the SMP case should be different from UP
>in that ifdef. Can you explain?  It shouldn't in theory.
>
>
>/* When the TSC gets reset during AP startup, the code below would
>+			   incorrectly think we lost a huge amount of ticks. */
>That is outdated - the TSCs are not reset anymore since 2.6.12.
>Please remove code for handling that.

Good to know, I didn't notice that. The conditional was so that the reset TSC would be considered a rolled-over one, resulting in a huge number of lost ticks.

>The union in vxtime_data is ugly - can it be avoided?

Yes, if the whole code is to become overflow-safe, then it'll just need to be a 64-bit field.

Jan

