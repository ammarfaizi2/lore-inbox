Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVLMTJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVLMTJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVLMTJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:09:51 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:24954 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030208AbVLMTJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:09:50 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Date: Tue, 13 Dec 2005 11:01:01 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com>
In-Reply-To: <20051213195317.29cfd34a.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131101.02025.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 8:53 am, Vitaly Wool wrote:
> 
> this patch removes nasty buffer allocation in spi core for sync message transfers.

That's not "core" in the normal "everyone must use this" sense.
Even the folk that do use synchronous transfers aren't always
going to use that particular codepath.

Neither is it "remove" in the normal sense either.  The hot
path never had an allocation before ... but it could easily
have one now, because that sort of bounce-buffer semantic is
what a DMA_UNSAFE flag demands from the lower levels.  (That's
a key part part of the proposed change that's not included in
this patch... making the chage look much smaller.)


How much of the reason you're arguing for this is because you
have that WLAN stack that does some static allocation for I/O
buffers?  Changing that to use dynamic allocation -- the more
usual style -- should be easy.  But instead, you want all code
in the SPI stack to need to worry about two different kinds of
I/O memory:  the normal stuff, and the DMA-unsafe kind.  Not
just this WLAN code which for some reason started out using
a nonportable scheme for allocating I/O buffers.

It'd take a lot more persuasion to make me think that's a good
idea.  That's the kind of subtle confusion that really promotes
hard-to-find bugs in drivers, and lots of developer confusion.
And all that to support a new less-portable I/O buffer model...

It's way better to just insist that all I/O buffers (in all
generic APIs) be DMA-safe.  AFAICT that's a pretty standard
rule everywhere in Linux.

- Dave

