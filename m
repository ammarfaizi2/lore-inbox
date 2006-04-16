Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWDPLkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWDPLkm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 07:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWDPLkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 07:40:41 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9450 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750721AbWDPLkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 07:40:41 -0400
Date: Sun, 16 Apr 2006 15:40:18 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Libor Vanek <libor.vanek@gmail.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Connector - how to start?
Message-ID: <20060416114017.GA30180@2ka.mipt.ru>
References: <369a7ef40604141809u45b7b37ay27dfb74778a91893@mail.gmail.com> <20060414192634.697cd2e3.rdunlap@xenotime.net> <1145070437.28705.73.camel@stark> <20060415091801.GA4782@2ka.mipt.ru> <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <369a7ef40604160426s301dcd52r4c9826698d3d2f79@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 16 Apr 2006 15:40:18 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2006 at 01:26:10PM +0200, Libor Vanek (libor.vanek@gmail.com) wrote:
> Hi,
> 
> > I've attached simple userspace program used with w1, which sends
> > and receives connector messages. It can be also used as example of
> > netlink usage from userspace point of view.
> 
> Maybe I'm really stupid and/or blind but I can't find in this example
> (from my point of view) quite important features:
> 
> - there is no way how can user-space part say what "cb_id.idx" and
> "cb_id.val" it should accept (as far as I understand these are used
> for settings "message type" - what SW is using these)

"idx" field is a group number userspace binds to, "val" is a private
identificator which is used as you like.

> - I can't find neither in cn_test.c nor w1_netlink.c (which is the
> only part I found connector used in) any way of detecting if message
> was delivered to/from user-space

If cn_netlink_send() returns zero this means message was queued into
userspace socket. In case of error negative value is returned.

> - the very same is for detecting if there is some user-space
> "reciever" (there is some mention about this in
> Documentantation/connector/connector.txt but it's not working to
> myself - I got 2.6.17-pre1-mm2)

connector uses netlink_has_listeners(), but it can produce false
positives, in this case netlink_broadcast() will say the final word.
If message has been added into socket's queue netlink_broadcast(), which
is used in connector, returns zero, and it's return value is propagated
back to original caller of cn_netlink_send().

Message from userspace is always delivered, and in this case appropriate
callback is called.

> Maybe connector doesn't support these things... ?
> 
> Libor Vanek

-- 
	Evgeniy Polyakov
