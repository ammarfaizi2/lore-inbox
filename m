Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWDPHxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWDPHxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 03:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWDPHxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 03:53:40 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15020 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751232AbWDPHxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 03:53:40 -0400
Date: Sun, 16 Apr 2006 11:53:23 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060416075323.GB6101@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604150350x8e7dea1sbf1f83cb800dd1c3@mail.gmail.com> <20060415111443.GA4079@2ka.mipt.ru> <87hd4vvxpk.fsf@briny.internal.ondioline.org> <20060415123832.GA19850@2ka.mipt.ru> <369a7ef40604150624n28da8895if158a2c13cac2b9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <369a7ef40604150624n28da8895if158a2c13cac2b9e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 16 Apr 2006 11:53:25 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 03:24:26PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> > > However, with 256 I get "File name too long", as you did.
> >
> > Sure, as pointed in previous e-mail, several concatenated directories can exceed any resonable limit,
> > even PATH_MAX (4k):
> > $ pwd | wc
> >       1       1    4113
> >
> > So it is wrong idea to transfer the whole name in one message, which
> > will not only add huge overhead (for each subdir one must transfer the
> > whole path for the parent dir), but can be impossible to allocate such a
> > buffer in kernelspace to store the whole pathname.
> 
> OK, so what would you suggest as the right "tool" to transfer these
> (full path text) information?
> 
> I see these options:
> 1, Keep using procfs (I don't like it)
> 2, Use connector and create such "communication protocol" that it'll
> be able to transfer such long messages in more datagrams (even if
> 99.99% of messages will fit 1 datagram)
> 3, Some other API to transfer information to user-space and back?
> 
> I'll probably go with 2, but I'd be more then happy to hear any
> comments about this...


In general case using any tool you will be unable to transfer the whole
path in one shot, consider low memory condition and you try to allocate
a page with high order.
So it is required to split your path into multiple blocks, I would
recommend to use messages with names between slashes, i.e.
/home/test/aaa/bbb/ccc will be sent as 5 messages with /home, test, aaa,
bbb and ccc data, this will also reduce overhead when there are several
files or directories in one parent dir. Each message should also include
some reference to which parent dir it belongs. This will also speed
things up noticebly, since you will not rescan the whole path when new
file is created, only parent dir.

I wish you success in this hacking journey.

> Libor Vanek

-- 
	Evgeniy Polyakov
