Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269363AbRGaRZv>; Tue, 31 Jul 2001 13:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269373AbRGaRZl>; Tue, 31 Jul 2001 13:25:41 -0400
Received: from ns1.austin.rr.com ([24.93.35.62]:43782 "EHLO ns1.austin.rr.com")
	by vger.kernel.org with ESMTP id <S269363AbRGaRZY>;
	Tue, 31 Jul 2001 13:25:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: linux-kernel@vger.kernel.org
Subject: Re: Serverworks LE, 4GB RAM, and MTRR
Date: Tue, 31 Jul 2001 12:29:12 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <01073018370207.04012@bozo>
In-Reply-To: <01073018370207.04012@bozo>
MIME-Version: 1.0
Message-Id: <01073112291200.04928@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Sorry, I checked again and enabling write-combining was not the solution. 
Apparently, I forgot to remove an append="mem=0xf8000000" statement when 
testing the mtrr.c modification. Limiting the memory to 4GB - 128 MB was the 
real reason for the performance improvement. As far as we're concerned, 
simply telling the kernel to ignore the last 128MB is an acceptable solution.

For what it's worth, enabling write-combining does make X noticeably faster, 
however :)

Marvin Justice

> Slow performance on Serverworks LE boards with 4GB of RAM seem to be
> related to mtrr misconfiguration. Here is the /proc/mtrr for a Tyan 2510 (
> 2.4.7-ac2):
>
> reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
> reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
> reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
> reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
> reg04: base=0xf0000000 (3840MB), size= 128MB: write-back, count=1
> reg05: base=0xf8000000 (3968MB), size=  64MB: write-back, count=1
> reg06: base=0xfc000000 (4032MB), size=  64MB: uncachable, count=1
>
> Also, the framebuffer is 4MB starting at 0xfd000000 (4048MB) on this
> system. The last entry seems to be the culprit. Why should there be 64MB
> uncachable starting at 4032?
>
> Back in April there was a thread concering the mtrr setup for the LE
> chipset. A patch for mtrr.c was submitted (but never accepted, apparently)
> that allows write-combining (which is currently disabled for all
> Serverworks LE) for revisions >5.  If I modify mtrr.c to allow
> write-combining the system works normally with 4G. /proc/mtrr is unchanged
> but the following line shows up in the syslog when the X-server is started:
>
> mtrr: type mismatch for fd000000,400000 old: uncachable new:
> write-combining
>
> The slowness of the system without write-combining is independent of
> whether X is started.
>
> Marvin Justice
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
