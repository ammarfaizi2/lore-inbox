Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTDSH0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 03:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTDSH0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 03:26:51 -0400
Received: from [202.109.126.231] ([202.109.126.231]:14454 "HELO
	www.support-smartpc.com.cn") by vger.kernel.org with SMTP
	id S263358AbTDSH0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 03:26:50 -0400
Message-ID: <3EA0FCE9.5FC04124@mic.com.tw>
Date: Sat, 19 Apr 2003 15:38:17 +0800
From: "rain.wang" <rain.wang@mic.com.tw>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.67-ac2: ide reset issue
References: <200304181146.h3IBkOx06987@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2003 07:34:15.0218 (UTC) FILETIME=[14287920:01C30646]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> >     I don't know if there's enough reason to change reset semantics
> > now to wait for completion, so that the next call be free of race.
> > and  I once had a simpler fix to let it delay another 50ms, that works
> > on my box but seems not a thorough one. does it help?
>
> BWGROUP(drive)->busy should never reach zero until the reset is
> done. The 50mS miught be enough that this occurs, as might waiting
> for HWGROUP(drive)->busy hitting 0. I don't yet understand why it
> matters, and to fix it properly I have to figure that out.
>
> If you need reliable reset for something like a test harness, or
> IDE drive tester its a usable workaround, but I need to fix it
> properly (eventually)
>

I agree. I found the reason seems some strange there. reset call set
a 50ms's wait handler and return to user at once, when succeed in
the first poll and handler return, there's always about another 50ms
needed to cleanup the path(I once tested values lager and smaller
than 50ms and found about 48ms needed at least on my box).  so
the following call would race it if there's no such a delay, although
there's actually few chances to do continuous reset call, I thought.

> > +                     /* wait for another 50ms */
> > +                     mdelay(50);
>
> In your test set is HWGROUP(drive)->busy always zero after the
> mdelay ?

I think it is.

