Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbTL3XUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265912AbTL3XTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:19:53 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:17631 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S265895AbTL3XR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:17:26 -0500
Date: Tue, 30 Dec 2003 16:18:45 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set released
Message-ID: <20031230231845.GA9128@bounceswoosh.org>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org> <Pine.LNX.4.58L.0312300935040.22101@logos.cnet> <Pine.LNX.4.58.0312301130430.2065@home.osdl.org> <Pine.LNX.4.58L.0312301849400.23875@logos.cnet> <Pine.LNX.4.58.0312301352570.2065@home.osdl.org> <Pine.LNX.4.58L.0312302002130.23875@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0312302002130.23875@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 30 at 20:21, Marcelo Tosatti wrote:
>"hda: no DRQ after issuing WRITE
>ide0: reset: success
>hda: status timeout: status=0xd0 { Busy }
>
>hda: no DRQ after issuing WRITE
>ide0: reset: success"
>
>(Daniel wrote the patch which got applied to 2.4, it fixed the problems
>for him).
>
>There are several other reports of "no DRQ after issuing {MULTI}WRITE",
>some of them probably involved with this bug, some of them potentially
>not. You can find more reports (both from 2.6 and 2.4) at:

Old ATA specifications had the concept of an auto-write segment,
in that the drive had to begin accepting data an extremly short time
after the command had been issued.

>From what I understand, there was a time when people attempted to
remove this from the spec, however, it was discovered that some old
BIOSs didn't bother to check the DRDY bit at all after issuing a PIO
write, and they immediately just went straight to data
transfer... without the drive ready to receive the data, it would
corrupt the block since the first N words of data wouldn't be seen.

In more modern versions of the ATA specification, the only time
constraint built into PIO protocol transfers is that the hardware has
at most 400ns to assert BSY following the write of the command
register.  Since every drive today has hardware to automate this
process, that time constraint is never violated.

Other than that, the drive is free to leave BSY asserted as long as it
needs to prior to setting DRQ and being ready for data-transfer in.

I could just be talking totally tangential to the issue being
discussed, but is the 20/30 or 29/30ms wait being discussed at this
point in the protocol, or is it elsewhere?

Unless it has been something like 5-8 *seconds* without DRQ=1 and
BSY=0, I don't think the driver should reset the device.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

