Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318877AbSIIVvd>; Mon, 9 Sep 2002 17:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318884AbSIIVvd>; Mon, 9 Sep 2002 17:51:33 -0400
Received: from ute.rlxtechnologies.com ([65.66.195.252]:45067 "EHLO
	mail.rocketlogix.com") by vger.kernel.org with ESMTP
	id <S318877AbSIIVvc>; Mon, 9 Sep 2002 17:51:32 -0400
Subject: Re: oops on 2.4.20-pre5-ac2
From: Dan Eaton <dan.eaton@rlx.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031603294.29715.20.camel@irongate.swansea.linux.org.uk>
References: <1031596139.25426.184.camel@dan> 
	<1031603294.29715.20.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 16:51:05 -0500
Message-Id: <1031608265.25426.245.camel@dan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2002-09-09 at 15:28, Alan Cox wrote:
> Thats a very very strange machine 8). Your diagnosis is correct. We are
> assuming conventional PC north bridge behaviour. I take it this is your
> blade systems. 
Your diagnosis is correct.  This is one of our blade servers. :)
> 
> As far as I can make out from the ALi docs you can't get an ALi north
> bridge at anywhere but 0:0.0 in which case making the check
> 
>        if(north && north->vendor == ...)
> 
> should do the trick.
Our north bridge is a Micron north bridge (see lspci output below).  As
you can see it is not in the "expected" pci bus location.  The fix you
listed above did the trick as you expected.  The server booted fine,
but (there's always a but).....the two drives came up in PIO mode and 
could not even be forced (hdparm -d1 /dev/hd?) into DMA mode.  Looking
at dmesg, I got the following message associated with IDE
configuration:

     ALi15x3:  simplex device with no drives: DMA disabled

The __init ide_get_or_set_dma_base() function in
drivers/ide/setup-pci.c is generating this error.  I noticed in the
source code a "FIXME" comment that seemed to indicate the problem I was
having is a potential shortcoming in the current implementation.  I 
added the PCI_DEVICE_ID_AL_M5229 (my IDE controller) as a case to the
switch construct and this seemed to fix me completely up.  Both drives
came up in udma4 mode (as expected).  My contribution to the "FIXME"
effort would be to suggest that this mod be maded to this function (but
I'm no ide expert).

Thanks for your help,

Dan

lscpi output:

00:18.0 Host bridge: Crucial Technology: Unknown device 3320 (rev 03)
        Subsystem: Micron: Unknown device 1042
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
00: 44 13 20 33 07 01 a0 02 03 00 00 06 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 42 10 42 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 07 00 00 00 38 00 00 80 ff 00 00 00 03 00 00 00
50: 94 00 01 00 00 00 10 01 00 00 00 00 02 30 20 22
60: 00 00 ff 0f 00 00 ff 0f 00 00 ff 0f f0 f0 ec 0f
70: a8 8c 47 8b 00 00 20 00 20 00 20 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 f4 82 9c c0
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 5b 36 04 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 02 42 00 00 00 00 00 00 03 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 80 00 00 00 80 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: fc 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00


-- 
Dan Eaton
RLX Technologies, Inc.
25231 Grogan's Mill Rd - Suite 600
The Woodlands, TX 77380
281.863.2100 Main
281.863.2126 Direct
281.863.2104 Fax
dan.eaton@rlxtechnologies.com
http://www.rlxtechnologies.com 

