Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVDZT3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVDZT3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVDZT3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:29:11 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49833 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261751AbVDZT3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:29:05 -0400
Date: Tue, 26 Apr 2005 23:28:12 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
 next.
Message-ID: <20050426232812.0c7bb3a4@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d50005042612069b84ef@mail.gmail.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	<d120d5000504260857cb5f99e@mail.gmail.com>
	<20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
	<20050426203023.378e4831@zanzibar.2ka.mipt.ru>
	<d120d50005042610342368cd72@mail.gmail.com>
	<20050426220713.7915e036@zanzibar.2ka.mipt.ru>
	<d120d50005042611203ce29dd8@mail.gmail.com>
	<20050426223126.37b7aea1@zanzibar.2ka.mipt.ru>
	<d120d50005042611426ec326e9@mail.gmail.com>
	<20050426224833.3b6a0792@zanzibar.2ka.mipt.ru>
	<d120d50005042612069b84ef@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 26 Apr 2005 23:28:26 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 14:06:36 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Tue, 26 Apr 2005 13:42:10 -0500
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > Yes, that woudl work, although I would urge you to implement a message
> > > queue for callbacks (probably limit it to 1000 messages or so) to
> > > allow bursting.
> > 
> > It already exist, btw, but not exactly in that way -
> > we have skb queue, which can not be filled from userspace
> > if pressure is so strong so work queue can not be scheduled.
> > It is of course different and is influenced by other things
> > but it handles bursts quite well - it was tested on both
> > SMP and UP machines with continuous flows of forks with
> > shape addon of new running tasks [both fith fork bomb and not],
> > so I think it can be called real bursty test.
> > 
> 
> Ok, hear me out and tell me where I am wrong:
> 
> By default a socket can receive at least 128 skbs with 258-byte
> payload, correct? That means that user of cn_netlink_send, if started
> "fresh", 128 average - size connector messages. If sender does not
> want to wait for anything (unlike your fork tests that do schedule)
> that means that 127 of those 128 messages will be dropped, although
> netlink would deliver them in time just fine.
> 
> What am I missing?

Concider netlink_broadcast - it delivers skb to the kernel 
listener directly to the input callback - no queueing actually,
the same is for netlink_unicast - so in-kernel users are always 
called synchronously.
send() [sys_send()] system call(which btw as syscall does schedule too) 
ends up in netlink_sendmsg and thus either netlink_broadcast and 
netlink_unicast, which is called directly as we have seen.

> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
