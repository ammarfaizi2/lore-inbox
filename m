Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbTBOVj7>; Sat, 15 Feb 2003 16:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbTBOVj7>; Sat, 15 Feb 2003 16:39:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60678 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265211AbTBOVj4>;
	Sat, 15 Feb 2003 16:39:56 -0500
Message-ID: <3E4EB5E4.9070508@pobox.com>
Date: Sat, 15 Feb 2003 16:49:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [0/4][via-rhine] Improvements
References: <20030215111705.GA11127@k3.hellgate.ch> <3E4E9028.3090601@pobox.com> <20030215205302.GB4627@k3.hellgate.ch>
In-Reply-To: <20030215205302.GB4627@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Sat, 15 Feb 2003 14:08:24 -0500, Jeff Garzik wrote:
> 
> 
>>Looks good, all patches applied to 2.5.
> 
> 
> Thx. Patch to bump the version number up attached.

applied to 2.4 and 2.5


>>Should these apply to 2.4, too?
> 
> 
> Yes. I'm trying to keep the drivers in both trees in sync.

noted


>>Just a general comment, the reset logic seems a bit too much like voodoo 
>>magic ;-)
> 
> 
> Look at the rest of the driver and you will find the reset voodoo magic is
> a perfect fit. We'd be waving dead chickens if only tar could handle them.
> Actually, the reset logic is slightly better because for every line I have
> some reasoning and actual tests conducted. The underlying problem is that
> the Rhine is only loosely documented and various revisions differ in
> amazing ways from each other and from the documentation that supposedly
> describes them.
> 
> I've named the magic register in the patch below, does that ease your
> voodoo pain?

I applied the patch, but I meant more that wait_for_reset seems 
questionable.  There is generally a PIO or MMIO write preceding 
wait_for_reset function call, and then the function delays.  If the PCI 
write is posted, for example, which at least my own Via EPIA does, then 
you cannot be guaranteed the timing of
	write[bwl]()
	udelay(5)

PCI writes must be flushed, by doing a read[bwl]().

So, obvious PCI posting bugs in the wait_for_reset may be the cause of 
some of the randomness that appears in the field.  (Note this applies to 
all PCI writes in the driver...)

So, I said "voodoo magic" because it doesn't really seem like we know 
what the exact handling is... and randomly placed udelay() calls are, 
unfortunately, sometimes a sign of driver bugs instead of necessary 
hardware delays.


> I've been considering for a while to document the driver somewhat better.
> Are documentation patches welcome, or do you just want to have official
> word from VIA that they agree with the reset code? And if I need a few
> lines to explain some voodoo magic, is the prefered way to put it into the
> source or would a freshly created Documentation/network/via-rhine.txt be
> (my first choice but the directory typically contains user rather than
> developer documentation) the better place?

I would prefer both user and developer docs go in 
Documentation/networking/via-rhine.txt.  It is easy enough to note 
separate sections of the document...


>>It would be nice long-term to get an official answer from Via 
>>about the proper reset sequence and time limits.  [regardless, like I 
> 
> 
> Heh. If I had a contact at VIA I'd have many and more important questions
> than the reset sequence that actually works now, unlike lots of other
> stuff. Yes, reliable information from within VIA -- official or not --
> would be a big help.

Let me wave some dead chickens of my own, and see what happens...

	Jeff




