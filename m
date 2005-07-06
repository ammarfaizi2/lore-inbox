Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVGFHEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVGFHEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 03:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVGFHEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 03:04:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53413 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261534AbVGFFXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:23:22 -0400
Date: Tue, 5 Jul 2005 22:22:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Grant Coady <grant_lkml@dodo.com.au>
cc: Jens Axboe <axboe@suse.de>, Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
In-Reply-To: <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com>
Message-ID: <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org>
References: <42CA5A84.1060005@rainbow-software.org> <20050705101414.GB18504@suse.de>
 <42CA5EAD.7070005@rainbow-software.org> <20050705104208.GA20620@suse.de>
 <42CA7EA9.1010409@rainbow-software.org> <1120567900.12942.8.camel@linux>
 <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux>
 <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de>
 <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org>
 <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Grant Coady wrote:
>
> Sure, take a while longer to vary by block size.  One effect seems 
> to be wrong is interaction between /dev/hda and /dev/hdc in 'peetoo', 
> the IDE channels not independent?

Well, looking at your numbers for "silly" and "tosh", which were perhaps
the most extreme examples of slowdown on the /dev/hda thing:

	silly:  22MB/s   -> 8.5MB/s, oread similar    13GB
	tosh:   35MB/s   -> 23MB/s,  oread similar    40GB 2.5"

now it says:

> summary		2.4.31-hf1	2.6.12.2
> boxen \ time ->	 w 	 r	 w	 r
> ---------------	----	----	----	----
> silly			54	24	49	25
> tosh			30	19.5	27	19.5

ie here both silly and tosh do equally well on 2.4.x and 2.6.x on reads, 
and seem to perhaps show a bit of slowdown on writes (which I suspect may 
be due to the fact that we try to limit the queues a bit more, but hey, 
that's handwaving).

The point being that the slowdown you see seems to really largely be
limited to the raw partition code. Your filesystem throughput numbers for 
reads are generally _better_ on 2.6.x than on 2.4.x when doing filesystem 
accesses (but the differences aren't all that big).

So my gut feel is that the reason hdparm and dd from the raw partition 
gives different performance is not so much the driver, but probably that 
we've tweaked read-ahead for file access or something like that. Maybe 
the maximum fs-level read-ahead changed?

		Linus
