Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUAGHzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 02:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUAGHzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 02:55:40 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:31124 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265196AbUAGHzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 02:55:33 -0500
Date: Wed, 7 Jan 2004 02:43:09 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040107024308.GB3188@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andi Kleen <ak@colin2.muc.de>, Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
	David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>,
	"Grover, Andrew" <andrew.grover@intel.com>
References: <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de> <Pine.LNX.4.58.0401060744240.2653@home.osdl.org> <20040106222959.GA3188@neo.rr.com> <Pine.LNX.4.58.0401062000490.12602@home.osdl.org> <20040107050256.GA4351@colin2.muc.de> <20040107055557.GA13812@redhat.com> <20040107065156.GA30773@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107065156.GA30773@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 07:51:56AM +0100, Andi Kleen wrote:
> On Wed, Jan 07, 2004 at 05:55:57AM +0000, Dave Jones wrote:
> > On Wed, Jan 07, 2004 at 06:02:56AM +0100, Andi Kleen wrote:
> >  > > > 5.) Look into other ways of finding out if the PnPBIOS might be buggy,
> >  > > > currently we only have DMI.
> >  > > > Any others?
> >  > > We could use the exception mechanism, and try to fix up any BIOS errors.
> >  > > That would require:
> >  >
> >  > [...] It would not work for x86-64 unfortunately where you cannot do
> >  > any BIOS calls after the system is running (it would only be possible
> >  > early in boot)
> >
> > Why on earth would you want to call PNPBIOS on AMD64 anyway ?
>
> See the preceding thread. We're currently missing a reliable way to find
> free IO space for PCI resources, which is needed for some cases. The
> PNPBIOS was discussed as one of the possible solutions.
>
> For AMD64 clearly something ACPI based is needed though.
>
> -Andi

Just as an example...

Here is how the PnPBIOS reserves io space for which it can't find an actual
device: (notice it isn't necessarily related to ISA)

09 PNP0c02 system peripheral: other
    flags: [no disable] [no config] [static]
    allocated resources:
	io 0x04d0-0x04d1 [16-bit decode]
	io 0x0cf8-0x0cff [16-bit decode]
	io 0x0010-0x001f [16-bit decode]
	io 0x0022-0x002d [16-bit decode]
	io 0x0030-0x003f [16-bit decode]
	io 0x0050-0x0052 [16-bit decode]
	io 0x0072-0x0077 [16-bit decode]
	io 0x0091-0x0093 [16-bit decode]
	io 0x00a2-0x00be [16-bit decode]
	io 0x0400-0x047f [16-bit decode]
	io 0x0540-0x054f [16-bit decode]
	io 0x0500-0x053f [16-bit decode]
	io disabled [16-bit decode]
	io disabled [16-bit decode]
	io disabled [16-bit decode]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem disabled [8/16 bit] [r/o] [cacheable] [shadow]
	mem 0xffb00000-0xffbfffff [32 bit] [r/o]


And here is the output for ACPI on the same system:

00000970:       Device SYSR (\_SB_.PCI0.SBRG.SYSR)
00000978:         Name _HID (\_SB_.PCI0.SBRG.SYSR._HID)
0000097d:           PNP0c02 (0x020cd041)

-->snip

00000995:         Name _CRS (\_SB_.PCI0.SBRG.SYSR._CRS)

-->snip

0000099f:             Interpreted as PnP Resource Descriptor:
0000099f:             Fixed I/O Ports: 0x10 @ 0x10
0000099f:             Fixed I/O Ports: 0x1e @ 0x22
0000099f:             Fixed I/O Ports: 0x1c @ 0x44
0000099f:             Fixed I/O Ports: 0x2 @ 0x62
0000099f:             Fixed I/O Ports: 0xb @ 0x65
0000099f:             Fixed I/O Ports: 0xe @ 0x72
0000099f:             Fixed I/O Ports: 0x1 @ 0x80
0000099f:             Fixed I/O Ports: 0x3 @ 0x84
0000099f:             Fixed I/O Ports: 0x1 @ 0x88
0000099f:             Fixed I/O Ports: 0x3 @ 0x8c
0000099f:             Fixed I/O Ports: 0x10 @ 0x90
0000099f:             Fixed I/O Ports: 0x1e @ 0xa2
0000099f:             Fixed I/O Ports: 0x10 @ 0xe0
0000099f:             I/O Ports: 16 bit address decoding,
0000099f:             minbase 0x4d0, maxbase 0x4d0, align 0x0, count 0x2
0000099f:             I/O Ports: 16 bit address decoding,
0000099f:             minbase 0x400, maxbase 0x400, align 0x0, count 0x70
0000099f:             I/O Ports: 16 bit address decoding,
0000099f:             minbase 0x470, maxbase 0x470, align 0x0, count 0x10
0000099f:             I/O Ports: 16 bit address decoding,
0000099f:             minbase 0x500, maxbase 0x500, align 0x0, count 0x40
0000099f:             I/O Ports: 16 bit address decoding,
0000099f:             minbase 0x800, maxbase 0x800, align 0x0, count 0x80
0000099f:             32-bit rw Fixed memory range:
0000099f:             base 0xfff00000, count 0x100000
0000099f:             32-bit rw Fixed memory range:
0000099f:             base 0xffb00000, count 0x100000
0000099f:             Bad checksum 0x6, should be 0     // hmm, interesting ;-)


So they seem to provide a potential solution for this sort of problem.

Thanks,
Adam
