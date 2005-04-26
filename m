Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVDZUCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVDZUCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVDZUCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:02:52 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:59602 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261766AbVDZUCF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:02:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MRsmo306Fpr0SZTeFpQFUl87i61sFZZuoNKYlSNvnzaO0BD+Etd+q8FXpafdlUP+rSc4HGKoYTv/A0xjnP2Q8gXEPViZ9KhWvxZU1X6lESE81QquXC0ZkARhkTWb/wczOGbRBPw615ua/Oa0+tkPRcCgKehjSW/FtOSiLZT3tGc=
Message-ID: <d120d500050426130250ff9632@mail.gmail.com>
Date: Tue, 26 Apr 2005 15:02:01 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050426232812.0c7bb3a4@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <20050426203023.378e4831@zanzibar.2ka.mipt.ru>
	 <d120d50005042610342368cd72@mail.gmail.com>
	 <20050426220713.7915e036@zanzibar.2ka.mipt.ru>
	 <d120d50005042611203ce29dd8@mail.gmail.com>
	 <20050426223126.37b7aea1@zanzibar.2ka.mipt.ru>
	 <d120d50005042611426ec326e9@mail.gmail.com>
	 <20050426224833.3b6a0792@zanzibar.2ka.mipt.ru>
	 <d120d50005042612069b84ef@mail.gmail.com>
	 <20050426232812.0c7bb3a4@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Tue, 26 Apr 2005 14:06:36 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > On Tue, 26 Apr 2005 13:42:10 -0500
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > Yes, that woudl work, although I would urge you to implement a message
> > > > queue for callbacks (probably limit it to 1000 messages or so) to
> > > > allow bursting.
> > >
> > > It already exist, btw, but not exactly in that way -
> > > we have skb queue, which can not be filled from userspace
> > > if pressure is so strong so work queue can not be scheduled.
> > > It is of course different and is influenced by other things
> > > but it handles bursts quite well - it was tested on both
> > > SMP and UP machines with continuous flows of forks with
> > > shape addon of new running tasks [both fith fork bomb and not],
> > > so I think it can be called real bursty test.
> > >
> >
> > Ok, hear me out and tell me where I am wrong:
> >
> > By default a socket can receive at least 128 skbs with 258-byte
> > payload, correct? That means that user of cn_netlink_send, if started
> > "fresh", 128 average - size connector messages. If sender does not
> > want to wait for anything (unlike your fork tests that do schedule)
> > that means that 127 of those 128 messages will be dropped, although
> > netlink would deliver them in time just fine.
> >
> > What am I missing?
> 
> Concider netlink_broadcast - it delivers skb to the kernel
> listener directly to the input callback - no queueing actually,

Right, no queueing for in-kernel... 

But then we have the following: netlink will drop messages sent to
in-kernel socket ony if it can not copy skb - which is i'd say a very
rare scenario. Connector, on the other hand, is guaranteed to drop all
but the very first message sent between 2 schedules. That makes
connector several orders of magnitude less reliable than bare netlink
protocol. And you don't see it with your fork tests because you do
schedule when you fork.

-- 
Dmitry
