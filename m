Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289161AbSA1IhH>; Mon, 28 Jan 2002 03:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289162AbSA1Ig6>; Mon, 28 Jan 2002 03:36:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289161AbSA1Igx>;
	Mon, 28 Jan 2002 03:36:53 -0500
Message-ID: <3C550BD4.E9CBE6A@zip.com.au>
Date: Mon, 28 Jan 2002 00:29:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
CC: Kristian <kristian.peters@korseby.net>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
In-Reply-To: <20020127111917.3c019701.kristian.peters@korseby.net>,
		<3C5119E0.6E5C45B6@zip.com.au>
		<000701c1a5d5$812ef580$6caaa8c0@kevin> <3C53711B.F8D89811@zip.com.au>
		<3C53A116.81432588@zip.com.au>
		<20020127101131.0f71e978.kristian.peters@korseby.net> 
		<20020127111917.3c019701.kristian.peters@korseby.net> <1012161271.22707.50.camel@psuedomode>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Gents.  Version three is at

	http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre7/ide-akpm-3.patch

This attempts to overcome the situation where a drive/controller
doesn't want to perform multiframe DMA, but is happy performing
single-frame DMA.

So:

- We start out trying to perform multiframe DMA.  If we get
  a DMA error, we fall back to single-frame DMA.

- If we get a DMA error in single frame mode, we fall back
  to multi-frame PIO.

At no stage does a packet-mode DMA error turn off drive-level
DMA.  This is because some devices seem to perform ordinary
ATA DMA OK, but screw up packet DMA.

The kernel internally retries the requests when it performs fallback,
so userspace shouldn't see any disruption as the kernel works
out what to do.

Once the drive has fallen back to single-frame (or PIO mode) for
packet reads, the only way to get it back to a higher level is
a reboot.

-
