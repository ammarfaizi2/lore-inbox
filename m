Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbRAUJqh>; Sun, 21 Jan 2001 04:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131604AbRAUJq0>; Sun, 21 Jan 2001 04:46:26 -0500
Received: from styx.suse.cz ([195.70.145.226]:6909 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131525AbRAUJqQ>;
	Sun, 21 Jan 2001 04:46:16 -0500
Date: Sun, 21 Jan 2001 10:46:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Message-ID: <20010121104606.A398@suse.cz>
In-Reply-To: <20010120215641.A1818@suse.cz> <Pine.LNX.4.10.10101201301200.657-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101201301200.657-100000@master.linux-ide.org>; from andre@linux-ide.org on Sat, Jan 20, 2001 at 02:57:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 02:57:07PM -0800, Andre Hedrick wrote:

> Vojtech, I worry that the dynamic timing that you are calculating could
> bite you. 

Well, I know this. But I fear hardcoded timings won't really help here,
unles everyone out there ran their chipsets at 33 MHz, in which case the
calculation gains the exact same results (you can compare that) as the
hardcoded numbers for UDMA timings.

> Timings are exact especially at modes 3/4/5 the margins go to
> an effective zero for varition or wiggle room.  The state diagrams from
> Quantum that created the Ultra DMA 0,1,2,3,4,5 show how darn tight it
> constrained.  You need to assume absolutes because the various board
> makers screw up the skew tables by the PCB lane traces.
> 
> By assuming only absolutes, all vendors that do bad designs will show and
> the user can not and "should" not be allowed to hold the driver in a state
> that can damage filesystems or lock the box.  Since I have never addressed
> this issue in public it is no obvious why I hardcoded timings and did not
> let tehm float, but I hope it is clearer now.

Ok, the VIA driver from clean 2.2.18 does nothing. It doesn't even use
hardcoded timings. It doesn't touch any timing tables. It just blindly
enables prefetch and writeback in the chips. The thing works because it
relies on BIOS to set things up correctly, and this is often the case,
yes.

> chipset ---\
>             |
>             \---------IDC-header
> 
> chipset ---+
>            |
>            +----------IDC-header
> 
> These are nearly the same but the corners cause bounce and iCRC's

Well, there are other ways the motherboard maker can screw up the
traces, and often this happens:

chipset --------\
                |
chipset ------\ |
              | \------ header
              \-------- header

So the different traces have different lengths and thus some bits arrive
earlier than others to the header, causing the same CRC errors.

Also it seems that some boards don't use exactly 33.3 MHz PCI clock, but
something like 33.7 or even more, which causes some drives to fail with
them if the chipset is set to the 0xe0 (2 pciclk/ideclk) value.

This is because they use very cheap base 14MHz crystals.

As I said before - if you leave 'idebus' at 33, the calculated timings
are exactly the same as the hardcoded values would be (I think there is
a difference in PIO2 mode, where the calculation gives a slightly larger
active time and shorter recovery, but this is OK with the specs).

And this is also why the cheaply made motherboards fail. (They don't
care to make that VIA UDMA66 ide working correctly when they have a
UDMA100 HPT370 onboard)?

... btw, if we ever implement UDMA slowdown code based on CRC errors, we
should differentiate between CRC errors on read and CRC errors on write,
because each are caused by a different problem ...

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
