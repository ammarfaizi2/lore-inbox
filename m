Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRAOWeI>; Mon, 15 Jan 2001 17:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131617AbRAOWd7>; Mon, 15 Jan 2001 17:33:59 -0500
Received: from chiara.elte.hu ([157.181.150.200]:53520 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131402AbRAOWds>;
	Mon, 15 Jan 2001 17:33:48 -0500
Date: Mon, 15 Jan 2001 23:33:24 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Paul Hubbard <phubbard@fnal.gov>
Subject: Re: 4G SGI quad Xeon - memory-related slowdowns
In-Reply-To: <93vq9o$vt$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101152326480.7760-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15 Jan 2001, Linus Torvalds wrote:

> The performance problem is _probably_ due to the kernel having to
> double-buffer the IO requests, coupled with bad MTRR settings (ie
> memory above the 4GB range is probably marked as non-cacheable or
> something, which means that you'll get really bad performance).

the highmem related double-buffering alone on such a category of system is
miniscule, compared to other costs of IO, and considering the expected
bandwidth (20-30 MB/sec).

the MTRR part could be a problem.

> Not using the high memory will avoid the double-buffering, and will
> also avoid using memory that isn't cached. If I'm right.

> The hang still indicates that something is wrong in PAE-land, though.

it's working just fine on all 4GB+ systems tested (including 32GB
systems), Intel, Dell, Compaq boxes. So if it's a unique PAE bug, then it
must be some boundary condition.

Paul, here is the memory map of my 8GB system:

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009d400 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000002c00 @ 000000000009d400 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000003ef8000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000007c00 @ 0000000003ff8000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000003fffc00 (ACPI NVS)
 BIOS-e820: 00000000ec000000 @ 0000000004000000 (usable)
 BIOS-e820: 0000000001400000 @ 00000000fec00000 (reserved)
 BIOS-e820: 00000000f0000000 @ 0000000100000000 (usable)

and here are the MTRR settings:

[root@m mingo]# cat /proc/mtrr
reg00: base=0xf0000000 (3840MB), size= 256MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg02: base=0x100000000 (4096MB), size=2048MB: write-back, count=1
reg03: base=0x180000000 (6144MB), size=1024MB: write-back, count=1
reg04: base=0x1c0000000 (7168MB), size= 512MB: write-back, count=1
reg05: base=0x1e0000000 (7680MB), size= 256MB: write-back, count=1

i'd suggest using the mem=exact feature to force different type of memory
maps. Eg. i'm using the following append= line to force a 800 MB setup:

        append="mem=exactmap mem=0x0009d800@0x00000000 mem=0x03ef8000@0x00100000 mem=0x2bffe000@0x04000000"

such mem=exactmap lines can be constructed based on the BIOS output.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
