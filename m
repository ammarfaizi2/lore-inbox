Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbTELTIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTELTIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:08:11 -0400
Received: from mcomail01.maxtor.com ([134.6.76.15]:14 "EHLO
	mcomail01.maxtor.com") by vger.kernel.org with ESMTP
	id S262523AbTELTIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:08:10 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: RE: 2.5.69, IDE TCQ can't be enabled
Date: Mon, 12 May 2003 13:19:36 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
>From: Jens Axboe [mailto:axboe@suse.de]
>Sent: Monday, May 12, 2003 1:00 PM
>To: Mudama, Eric
>Cc: Oleg Drokin; Bartlomiej Zolnierkiewicz; Alan Cox; Oliver Neukum;
>lkhelp@rekl.yi.org; linux-kernel@vger.kernel.org
>Subject: Re: 2.5.69, IDE TCQ can't be enabled
>
>
>On Mon, May 12 2003, Mudama, Eric wrote:
>> The only difference between SATA TCQ and PATA TCQ is that in PATA TCQ,
the
>> drive doesn't report the active tag bitmap back to the host after each
>> command.  Other than that they are functionally identical to my
>> understanding.  (Yes, there are options like first-party DMA, but these
are
>> not requirements)
>
>You are ignoring the host side of things. PATA TCQ is basically
>unsupportable without some hardware support (auto-poll). It's my
>understanding that all SATA controllers do that.

The drive is always supposed to generate an interrupt when it sets the
service bit indicating it is ready to receive a service command.

The release interrupt tells the host the drive is doing a bus release
following a queued data command.

The service interrupt tells you you're going DRQ after receiving the service
command.

Maybe there are drives out there that don't support the configuration of
these interrupts... if that is the case, TCQ will never work "well" with
them since you'll need to poll on timer ticks or something, resulting in a
huge performance loss.

I can also picture autopolling for speed on a host controller, done by the
firmware/asic in the background, but all the SATA goodness should be
"achievable" using the interrupt architecture in the design.

>Then there's the debate of whether TCQ is worth it at all, in general. I
>feel that a few tags just to minimize the time spent when ending a
>request to starting a new one is nice.

TCQ shouldn't benefit writes significantly from a performance perspective if
the drive is reasonably smart.  TCQ *will* have a huge performance
improvement for random reads since the drive can order responses based on
minimal rotational latency.

Increasing queue depth reduces the average seek time between commands, both
in distance and rotational latency.  Provided a drive doesn't do dumb stuff
like we discussed earlier, then it should be good.

>> Personally I'd like to see the option stay in there as experimental, it
>> helps us drive folks test stuff when we can just flip an option off/on to
>> get that functionality.
>
>I agree, besides it just needs a bit of fixing, can't be much.

I'll do what I can to help in my spare time.

--eric
