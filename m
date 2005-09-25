Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVIYIGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVIYIGx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVIYIGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:06:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30982 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751237AbVIYIGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:06:52 -0400
Date: Sun, 25 Sep 2005 10:03:29 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Andrew Morton <akpm@osdl.org>, Davide Libenzi <davidel@xmailserver.org>,
       nish.aravamudan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <20050925080328.GA31855@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <Pine.LNX.4.63.0509240800020.31060@localhost.localdomain> <20050924172011.GA25997@alpha.home.local> <Pine.LNX.4.63.0509241113370.31327@localhost.localdomain> <20050924230545.3245da3f.akpm@osdl.org> <Pine.LNX.4.58.0509250000470.5772@shell3.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509250000470.5772@shell3.speakeasy.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Sep 25, 2005 at 12:08:03AM -0700, Vadim Lobanov wrote:
(...)
> > +/* Maximum msec timeout value storeable in a long int */
> > +#define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, LONG_MAX / HZ - 1000ULL)
> 
> This should instead be:
> #define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, (LONG_MAX - 999ULL) / HZ)
> Here's why:
> We want to avoid overflow of (timeout * HZ + 999), or, in other words,
> the case where (timeout * HZ + 999) >= LONG_MAX
> Unwrapping the equation, we get timeout >= (LONG_MAX - 999) / HZ
> 
> The original code isn't _wrong_, but more restrictive than it should be.
> In any case, better to fix up the base patch now, before all the other
> patches go in. I could do this, or Davide can... it's all good. :-)

I think it's because with the numerous changes we brought, the '>' test
became '>=' but the old timeout was still used with '>'. With '>=', I
agree with you that it must be -999.

Andrew, Vadim is right. Anyway, this proves why we must really move all
those complicated tests to jiffies.h ASAP !

BTW, Andrew, could you merge the jiffies fix before -mm3, so that we can
remove those annoying tests quickly ?

Thanks in advance,
Willy

