Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbRBASHg>; Thu, 1 Feb 2001 13:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRBASHR>; Thu, 1 Feb 2001 13:07:17 -0500
Received: from styx.suse.cz ([195.70.145.226]:37106 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129477AbRBASHD>;
	Thu, 1 Feb 2001 13:07:03 -0500
Date: Thu, 1 Feb 2001 19:06:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Byron Stanoszek <gandalf@winds.org>
Cc: safemode <safemode@voicenet.com>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
Message-ID: <20010201190653.H2341@suse.cz>
In-Reply-To: <3A794945.5F652819@voicenet.com> <Pine.LNX.4.21.0102011137590.27273-100000@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0102011137590.27273-100000@winds.org>; from gandalf@winds.org on Thu, Feb 01, 2001 at 11:46:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2001 at 11:46:08AM -0500, Byron Stanoszek wrote:

> Yeah, by bios does the same thing too on the Abit KT7(a).

Ok, I'll remember this. This is most likely the cause of the problems
many people had with the KT7 in the past.

> But you might not
> want to run your PCI clock at 34 instead of 33. Two problems can occur. If you
> don't specify idebus=34 on the kernel prompt, the IDE timings might eventually
> get a DMA reset under 100% disk access. If you do say idebus=34, then you drop
> your maximum throughput from 33 MB/s to 27MB/s.
> 
> I was curious and compiled a list of timings from Vojtech's formula for certain
> idebus=xx MHz ratings (I _think_ the UDMA-66 timings are correct, maybe you can
> check on these, Vojtech..)
> 
> Clock | Setup  Active  Recover  Cycle  UDMA | UDMA-33  UDMA-66  UDMA-100
>    21 |    1       2        1      3    0   |   28.0     56.0      84.0
>    22 |    1       2        1      3    0   |   29.3     58.6      88.0
>    23 |    1       2        1      3    0   |   30.6     61.2      92.0
[snip]
>    31 |    1       3        1      4    0   |   31.0     62.0      93.0
>    32 |    1       3        1      4    0   |   32.0     64.0      96.0
>    33 |    1       3        1      4    0   |   33.0     66.0      99.0
>    34 |    1       3        2      5    0   |   27.2     54.4      81.6
[snip]
>    59 |    2       5        3      8    1   |   29.5     59.0      88.5
>    60 |    2       5        3      8    1   |   30.0     60.0      90.0

Well, the table depends on what type of southbridge chip are you using -
if it's 586b or other UDMA33 chip, 586b/686a or other UDMA66 chip or the
UDMA100 capable 686b.

The U33 chips do UDMA timing in PCICLK (T = 30ns @ 33MHz) increments, U66 in
PCICLK*2 (T = 15ns @ 33 MHz) increments, and for U100 it's assumed that
there is an external 100MHz clock fed to the chip, so that the UDMA timing is
in T = 10ns increments independent of the PCICLK. I'm not 100% sure about
the last, it might be just PCICLK*3 (T = 10ns @ 33 MHz). An experiment needs
to be carried out to verify this.

So, s ahort excerpt of the table will look like:

Chip   | Clock | Setup Active Recover | T  | UDMA-33  UDMA-66  UDMA-100
586b   |    25 |    1      2       1  | 40 | 2T=25.0  xxxxxxx  xxxxxxxx
686a   |    25 |    1      2       1  | 20 | 3T=33.3  2T=50.0  xxxxxxxx
686b   |    25 |    1      2       1  | 10 | 6T=33.3  4T=66.6  2T=100.0

Chip   | Clock | Setup Active Recover | T  | UDMA-33  UDMA-66  UDMA-100
586b   |    33 |    1      2       1  | 30 | 2T=33.3  xxxxxxx  xxxxxxxx
686a   |    33 |    1      2       1  | 15 | 4T=33.3  2T=66.6  xxxxxxxx
686b   |    33 |    1      2       1  | 10 | 6T=33.3  4T=66.6  2T=100.0

... that is, if the 686b indeed has a 100MHz clock source. If not, then
in the case of 25 MHz, T would be 13.3ns. If you can verify this, it'd
be nice.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
