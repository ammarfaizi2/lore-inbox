Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271246AbRICE5k>; Mon, 3 Sep 2001 00:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271254AbRICE5a>; Mon, 3 Sep 2001 00:57:30 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:33733 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S271246AbRICE5V>;
	Mon, 3 Sep 2001 00:57:21 -0400
Date: Sun, 02 Sep 2001 21:58:21 -0700
From: Patrick Chase <pchase2@pacbell.net>
Subject: Re: Status of the VIA KT133a and 2.4.x debacle?
To: linux-kernel@vger.kernel.org, g.vanderzouw@chello.nl
Message-id: <999493106.15509.33.camel@homebase.localdomain>
MIME-version: 1.0
X-Mailer: Evolution/0.12 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gerbrand van der Zouw wrote:
> I have a MSI K7T Turbo board with Athlon 1.2 GHz. Recently I 
> upgraded my Award Bios from 2.7 to 2.9. This new version has 
> "memory bank interleaving". It also improves the stability of 
> my system a lot. I do not know if these are related, but is 
> may be a hint for some of the experts out there.

Are you enabling or disabling bank interleaving with the new BIOS?

I would say that given the nature of the prefetch optimizations 
which appear to be causing instabilities, problems related to
SDRAM bank interleaving of lack thereof should be near the top 
of any list of suspects.

Very briefly, SDRAM parts have multiple banks (either 2 or 4 
depending on capacity). Bank select lines are used to control 
which bank is active for a given access cycle. The existence 
of the banks is significant for two reasons:

1.	Each bank can have a separate page (~= row address) 
open. If you're alternating accesses between two separate address
ranges, then performance may be higher if they're in separate 
banks, as this could potentially avoid a lot of page openings.

2.	Unselected banks can process previously issued multi-
cycle commands while the selected bank is returning data. For 
example, you could request a new address from one bank, and 
then transfer previously requested data from another bank during 
the first bank's CAS latency. 

The "native" address layout of SDRAM devices has each bank a 
contiguous region (i.e. no interleave). An SDRAM controller may 
instead cause the banks to appear interleaved to the processor 
by simply remapping a few address bits. The "interleave" option
in your BIOS enables exactly such a remapping in the north 
bridge's SDRAM controller.

Here's why the Athlon prefetch optimization could potentially
interact with the interleave setting: The entire point of 
prefetching is to cause consecutive cache lines to be fetched
with as much overlap as possible (i.e. the next line is 
requested before the current one has been read in). When 
this is done with interleave enabled, the result is consecutive 
accesses to alternating pages, in which case the chipset will
be able to exploit overlap as described in (2) above to hide
latencies. I can come up with rationales for why this could either 
cause instability or help it, though I think I'll leave that to
those who knows more than I.

-- Patrick Chase




