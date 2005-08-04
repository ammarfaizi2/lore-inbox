Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVHDPZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVHDPZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVHDPXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:23:46 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:10705 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S262574AbVHDPXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:23:20 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] pmtmr and PRINTK_TIME timings display
Date: Thu, 4 Aug 2005 17:23:25 +0200
User-Agent: KMail/1.7.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200508041459.43500.petkov@uni-muenster.de> <1123161545.12009.6.camel@localhost.localdomain>
In-Reply-To: <1123161545.12009.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041723.25848.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 August 2005 15:19, Steven Rostedt wrote:
> On Thu, 2005-08-04 at 14:59 +0200, Borislav Petkov wrote:
> > where you see the deltas between the printk's printed once the tsc timer
> > is initialized as opposed to the first bootlog where you see all times
> > relative to a single point in time. The python script
> > <scripts/show_delta> in the kernel source converts between these two
> > representations but there's a pretty simple solution IMHO to make
> > PRINTK_TIME uniform and independent from the used timer. The one liner is
> > against 2.6.12.3.
> >
> > After applying it, printk timing looks like this:
> >
> > <snip>
> > [    0.000000] Detected 1500.132 MHz processor.
> > [    0.000000] Using pmtmr for high-res timesource
> > [    0.000000] Console: colour VGA+ 80x25
> > [    1.890000] Dentry cache hash table entries: 131072 (order: 7, 524288
> > bytes)
> > [    1.891000] Inode-cache hash table entries: 65536 (order: 6, 262144
> > bytes) [    1.906000] Memory: 513756k/523520k available (2839k kernel
> > code, 9276k reserved, 1148k data, 152k init, 0k highmem)
> > [    1.906000] Checking if this processor honours the WP bit even in
> > supervisor mode... Ok.
> > [    1.906000] Calibrating delay loop... 2973.69 BogoMIPS (lpj=1486848)
> > [    1.928000] Security Framework v1.0.0 initialized
> > </snip>
>
> But if you are debugging problems with jiffies wrapping, wouldn't you
> want to see the jiffies unmodified?  I understand your point, but the
> tsc output (which I do prefer) seems to only be for the tsc (on x86),
> and all else use jiffies (haven't looked at other archs). So debugging a
> problem with jiffy wrap*, one would need to use something other than the
> tsc, and then they would see the time the wrap occurred.
>
> Also, the big number stands out more than the 3 zeros, so when I see
> that, I know right away to go and change it back to use the tsc (since
> my debugging usually needs higher resolutions).
>
> * new product from Renolds ;-)
>
> -- Steve

I get it. Actually, I wasn't very sure whether this is the right solution 
since my desktop machine uses tsc timer as default while the laptop the 
pmtmr. I also remember that there was a patch a while ago on lkml which 
enabled a modifiable behavior for PRINTK_TIME through a /proc interface and 
kernel boot option but it somehow didn't get accepted. Ok, then, since we 
keep the jiffies solution across arch's, how can I force the kernel to use 
tsc for printk timings so that i can see the deltas between the different 
printk's instead of the jiffies_64 ns value? The Pentium-M Centrino on the 
laptop evidently supports rdtsc as a msr instruction after testing with this 
small inline assembly snippet:

#include <stdio.h>

int main()
{
		unsigned long long val;
		__asm__ __volatile__("rdtsc" : "=A" (val));
		printf("%llu\n", val);

		return 0;
}


-- 
Regards,
Borislav Petkov.
