Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279853AbRKFRso>; Tue, 6 Nov 2001 12:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279845AbRKFRse>; Tue, 6 Nov 2001 12:48:34 -0500
Received: from air-1.osdl.org ([65.201.151.5]:53254 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S279842AbRKFRs0>;
	Tue, 6 Nov 2001 12:48:26 -0500
Message-ID: <3BE820A8.8B93A497@osdl.org>
Date: Tue, 06 Nov 2001 09:40:56 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: robert@schwebel.de
CC: linux-kernel@vger.kernel.org
Subject: Re: ioport range of 8259 aka pic1
In-Reply-To: <Pine.LNX.4.33.0111061001351.12441-100000@callisto.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> 
> is there a reason why the kernel (tested with 2.4.13) picks up the io port
> region from 0020-003f for pic1? All I could find on the net lets me assume
> that only 0020-0021 are used by the interrupt controllers (may be wrong
> here - hints for literature are welcome). Same problem with pic2.
> 
> I'm currently working with an AMD Elan SC410 (x86 embedded system on chip)
> which has it's private registers at 0022 and following, which makes it
> impossible to write "correct" drivers that request_region() their ports
> before using them.

The Intel chipset specs say that PIC1 uses:
  (all hex:) 20-21, 24-25, 28-29, 2c-2d, 30-31, 34-35, 38-39, 3c-3d.

Some of the older chipset specs say that all of these other than
20-21 are just aliases of 20-21 (like the 440MX spec).
Later specs don't say this (as in all of the 800-model ICH0/ICH2
specs).

In either case, port 0x22 should be available for you.  What
do you mean by "and following"?  What register range does it use?
What fixed IO addresses does the Elan require (consume)?

So in linux/arch/i386/kernel/setup.c, you could modify the
"standard IO resources" table to match your target system's
requirements.

Current table:
struct resource standard_io_resources[] = {
	{ "dma1", 0x00, 0x1f, IORESOURCE_BUSY },
	{ "pic1", 0x20, 0x3f, IORESOURCE_BUSY },
	{ "timer", 0x40, 0x5f, IORESOURCE_BUSY },
	{ "keyboard", 0x60, 0x6f, IORESOURCE_BUSY },
	{ "dma page reg", 0x80, 0x8f, IORESOURCE_BUSY },
	{ "pic2", 0xa0, 0xbf, IORESOURCE_BUSY },
	{ "dma2", 0xc0, 0xdf, IORESOURCE_BUSY },
	{ "fpu", 0xf0, 0xff, IORESOURCE_BUSY }
};

Just modify the "pic1" and "pic2" entries to be multiple shorter
entries.

~Randy
