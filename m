Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVKJOCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVKJOCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbVKJOBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:01:51 -0500
Received: from ns2.suse.de ([195.135.220.15]:27842 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750900AbVKJOBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:01:23 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>, vojtech@suse.cz
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
Date: Thu, 10 Nov 2005 14:19:03 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43720DAE.76F0.0078.0@novell.com> <4372105B.76F0.0078.0@novell.com> <437210D1.76F0.0078.0@novell.com>
In-Reply-To: <437210D1.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511101419.03838.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 November 2005 15:08, Jan Beulich wrote:
> Since x86-64 time handling is not overflow-safe, these are the
> adjustments needed for allowing debuggers to update time after
> having halted the system for perhaps extended periods of time.
>
> Note that this depends on the HPET definitions adjustments, which
> aren't in 2.6.14, but have supposedly been merged already into 2.6.15.
>
> From: Jan Beulich <jbeulich@novell.com>

<no code quoting because that is hard with your attachments>

In general thanks for the overflow fixes. I understand the code
had generic problems in this area and it's good someone tackling them.

But many details should be changed.

The magic ICH6 HPET enable code has to go. It looks far too fragile and might 
break something else. I also don't want direct PCI config space accesses like 
this. We'll have to wait for ACPI HPET support I think. I think I'll remove 
the original hack for AMD 8111 too - it was only for testing anyways. If you 
still want to use it you have to keep it as a private patch.

Please remove the ifdefs too.  64bit HPET support would be fine, but 
only as a runtime mechanism, not compile time.

Can you remove debugger_jiffies please? 
The code has to handle long delays anyways (e.g. if someone uses a target
probe), so we cannot rely on such hacks anyways.

I don't quite understand why the SMP case should be different from UP
in that ifdef. Can you explain?  It shouldn't in theory.


/* When the TSC gets reset during AP startup, the code below would
+			   incorrectly think we lost a huge amount of ticks. */
That is outdated - the TSCs are not reset anymore since 2.6.12.
Please remove code for handling that.

The union in vxtime_data is ugly - can it be avoided?

Vojtech should probably review that one too when you repost.

-Andi
