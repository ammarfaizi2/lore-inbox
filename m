Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbUBIAB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUBIAB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 19:01:56 -0500
Received: from brln-d9b80ed4.pool.mediaWays.net ([217.184.14.212]:6660 "EHLO
	satellite.undata.org") by vger.kernel.org with ESMTP
	id S264411AbUBIABy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 19:01:54 -0500
Message-ID: <4026C668.7060905@undata.org>
Date: Mon, 09 Feb 2004 00:29:44 +0100
From: Thomas Charbonnel <thomas@undata.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.4) Gecko/20030915
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Tim Blechmann <TimBlechmann@gmx.net>
CC: linux-kernel@vger.kernel.org, pcmcia-cs-devel@lists.sourceforge.net,
       alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] 02 micro 6933 cardbus controller creates problem
 with the hammerfall dsp driver
References: <20040208191040.191bcd24@laptop>
In-Reply-To: <20040208191040.191bcd24@laptop>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Blechmann wrote :

> i'm experiencing problems with the O2 micro 6933 card when trying to use
> the hammerfall dsp sound device. i'm using the yenta socket driver (the
> O2 micro 6933 should be 100% compatible to the yenta socket)
> 
> i met thomas charbonnel, who maintains the alsa driver of the hdsp, and
> concerning him, it seems to be a problem of the dma mapping in the
> cardbus-pci bridge ... the alsa driver is working fine, until it starts
> dma (to output sounds) ... (thomas, please correct me if i'm saying
> something completely stupid, i'm a musician, not a kernel hacker)
> 

I believe a little more background information is needed. Tim's card is 
a busmaster carbus audio card capable of hardware routing, that is any 
audio stream arriving on the physical inputs of the card can be routed 
to any physical output without involving the computer in any way (this 
is done using an FPGA chip). The card can also do hardware peak and rms 
computation on incoming and playback streams. On Tim's machine the card 
is detected and initialized properly, and hardware routing works as 
expected until audio interrupts are enabled. Then something strange 
happens : parts of the incoming audio streams are found in the card's 
playback buffer (rms and peak values are reported for those signals), 
but the driver is not involved in this process. I got this piece of 
information from Martin Bjoernsen at RME, the company manufacturing the 
card :

"The HDSP cards use an internal double buffer per channel of 2*16 
samples. Data is transferred in blocks of 16 samples. Every 16 samples 
16 samples per channel are read and written to and from the main memory. 
In the card the same buffer is used for inputs and outputs. Playback 
data is overwritten from new recorded data. If the hardware is started 
and an output dma channel is not enabled but the input is, you will hear 
the input delayed by 32 samples or silence when there is no input signal."

The driver does enable both input and output dma channels for all 
possible streams, so my guess for now is that there is something wrong 
in the underlying subsystem.

I hope this helps track the problem down.

Thomas


