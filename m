Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVCVCvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVCVCvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCVCqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:46:22 -0500
Received: from mail.inter-page.com ([207.42.84.180]:59141 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262271AbVCVCab convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:30:31 -0500
From: "Robert White" <rwhite@casabyte.com>
To: "'Felix Matathias'" <felix@nevis.columbia.edu>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: select() doesn't respect SO_RCVLOWAT ?
Date: Mon, 21 Mar 2005 18:30:18 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAebtPmrJREEaqT7wOvKd9HQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.61.0503111434040.30914@shang.nevis.columbia.edu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
On Behalf Of Felix Matathias
Sent: Friday, March 11, 2005 12:27 PM

>  Isn't a significant reduction in the amount of read operations 
> a real gain in high speed networking ?

In a word? No.

Here at my company we make various pieces of cell phone test equipment in diverse
configurations.  One of these involves an XScale based linux board and an DSTnI based
board running RTXC.  The XScale board has several devices connected to it and a
private Ethernet segment connects the two boards (blah blah blah, I'll skip the
boring parts, but leave it to say that I have intimate control over the RTXC end of
the link and we are doing 1-5 millisecond timing of real time events +/- uniform
event delay factoring).

The cost of receiving large numbers of small packet data dwarfs the cost of read().
Depending on your actual network media, you will better sustained throughtput by
worrying about transmit fragmentation that you will ever have to concern yourself
with (well written) small-read() buffer reassembly.

Consider Ethernet, where sending one byte uses something like 70 (?) bytes of wire
bandwidth.  If you have the slightest chance of recognizing framing or sagging in
your datastream, using TCP_CORK to make sure you only transmit if you have more than
~45 characters pending can make a real difference.  Your particular mileage will, of
course, vary.  [On our box the win/win point was to cork for ~800 bytes or a known
end-of-frame, whichever came first; said calculation included the DSTnI board's
byte-copy and task switching rates and a bunch of other things.]

In practical terms, if you can get to the read() before more data arrived, then,
unless you _really_ have something better to do, you might as well do the read().  If
your processing takes longer than the strobe on the read() you will get some
backlogging between reads that you will make up next time.  There is a "natural
speed" for any given application, and as long as your data is slower than this speed,
the practical load doesn't matter much.  Something somewhere is going to have to
combine fragments, or not, so until you get to the point where your particular
application is starting to waste too much time in context switching (the "real
overhead" cost of a syscall) then you need to sweat the syscall density.

If you are "always" passing in a read buffer that is bigger than the pending data,
[e.g. if Y != X for all "Y = read(fd,buf,X);"] then you are pretty much under the
power curve and doing nicely.

Regardless, the real place to maximize network throughput is in intelligent write()
combining.  "The media is always slower than the computer" is the watch-phrase for
eeking out your best throughput.

Rob White,
Casabyte, Inc.

P.S. "High Speed Networking" is not the same thing as "Fair Resource Usage
Networking" for the purposes of this discussion... 8-)


