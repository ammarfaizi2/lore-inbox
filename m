Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282382AbRKXGwk>; Sat, 24 Nov 2001 01:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282381AbRKXGwf>; Sat, 24 Nov 2001 01:52:35 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:54894 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S282382AbRKXGwP>; Sat, 24 Nov 2001 01:52:15 -0500
Date: Sat, 24 Nov 2001 08:52:01 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: Jani Forssell <jani.forssell@viasys.com>, thockin@sun.com,
        andre@linux-ide.org
Subject: Re: HPT370 on 2.2.20+ide-patch - tried 2.4.15 and it fails, too
Message-ID: <20011124085201.G4809@niksula.cs.hut.fi>
In-Reply-To: <2173081930.1006455144@[195.224.237.69]> <20011122210503.B4809@niksula.cs.hut.fi> <20011122215424.C4809@niksula.cs.hut.fi> <20011123143502.D4809@niksula.cs.hut.fi> <20011123163932.E4809@niksula.cs.hut.fi> <20011123233211.F4809@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011123233211.F4809@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Fri, Nov 23, 2001 at 11:32:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 11:32:11PM +0200, you [Ville Herva] claimed:
> 
> Ok, it isn't raid. It took a little more effort to reproduce with plain
> /dev/hd[eg] read, but the md5sum mismatch eventually happaned.
> 
> This was with 2.2.20+IDE, no hpt patch. The drives were forced to UDMA33 as
> opposed to (default) UDMA66. This time, nothing shows up in the log.
> 
> I'll try again with 2.2.18pre19 (this time harder) to make sure it really
> _really_ doesn't happen with it.

(I ahven't gotten around to try this, but...)
 
> Then I'll give 2.4.15 a shot to see if hpt behaves (2.4 lacks e2compr
> however, so I'm not sure I can actually use it).

...I compiled 2.4.15 + Tim Hockin's HPT370 patch. I let it run the test over
night, but

   dd if=/dev/md0 bs=1048576 skip=65536 count=1024 | md5sum

had stalled at _second_ run. The first, identical run had gone through.
The point where it happened is after dd has read the last (not whole GB) and
is trying to skip slightly more than the size of md0:

At 63 GB
756+1 records in
756+1 records out
b1a566b4b54905ab21d138670b7abae3  -
At 64 GB
<stalls>                           

This never happened with 2.2.*

What's more, the md5sum of 1st and 2nd run differ at 31GB:

@@ -125,7 +125,7 @@
 At 31 GB
 1024+0 records in
 1024+0 records out
-c137bbbc546b03b54188697db0758143  -                     
+0bee73556a9fbb38d3af79b0d11b18ec  -                     
 At 32 GB
 1024+0 records in
 1024+0 records out                                      

There's two BadCRC errors in the log:

hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }

Bleah. I'll try 2.4.15 vanilla (no hpt patch) and UDMA33 (instead of UDMA66)
next.


-- v --

v@iki.fi
