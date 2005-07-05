Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVGER1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVGER1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVGER1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 13:27:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55510 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261915AbVGER1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 13:27:25 -0400
Date: Tue, 5 Jul 2005 10:27:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Ondrej Zary <linux@rainbow-software.org>,
       =?ISO-8859-1?Q?Andr=E9_Tomt?= <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
In-Reply-To: <20050705142122.GY1444@suse.de>
Message-ID: <Pine.LNX.4.58.0507051016420.3570@g5.osdl.org>
References: <42C9C56D.7040701@tomt.net> <42CA5A84.1060005@rainbow-software.org>
 <20050705101414.GB18504@suse.de> <42CA5EAD.7070005@rainbow-software.org>
 <20050705104208.GA20620@suse.de> <42CA7EA9.1010409@rainbow-software.org>
 <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org>
 <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org>
 <20050705142122.GY1444@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Jul 2005, Jens Axboe wrote:
> 
> Looks interesting, 2.6 spends oodles of times copying to user space.
> Lets check if raw reads perform ok, please try and time this app in 2.4
> and 2.6 as well.

I think it's just that 2.4.x used to allow longer command queues. I think
MAX_NR_REQUESTS is 1024 in 2.4.x, and just 128 in 2.6.x or something like
that.

Also, the congestion thresholds are questionable: we consider a queue
congested if it is within 12% of full, but then we consider it uncongested
whenever it falls to within 18% of full, which I bet means that for some
streaming loads we have just a 6% "window" that we keep adding new
requests to (we wait when we're almost full, but then we start adding
requests again when we're _still_ almost full). Jens, we talked about this
long ago, but I don't think we ever did any timings.

Making things worse, things like this are only visible on stupid hardware
that has long latencies to get started (many SCSI controllers used to have
horrid latencies), so you'll never even see any difference on a lot of 
hardware.

It's probably worth testing with a bigger request limit. I forget what the 
/proc interfaces are (and am too lazy to look it up), Jens can tell us ;)

		Linus
