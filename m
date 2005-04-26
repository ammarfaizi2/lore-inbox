Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVDZScR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVDZScR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVDZScR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:32:17 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:61397 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261670AbVDZScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:32:11 -0400
Date: Tue, 26 Apr 2005 22:31:26 +0400
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
Message-ID: <20050426223126.37b7aea1@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d50005042611203ce29dd8@mail.gmail.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	<d120d5000504260857cb5f99e@mail.gmail.com>
	<20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
	<20050426203023.378e4831@zanzibar.2ka.mipt.ru>
	<d120d50005042610342368cd72@mail.gmail.com>
	<20050426220713.7915e036@zanzibar.2ka.mipt.ru>
	<d120d50005042611203ce29dd8@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 26 Apr 2005 22:31:39 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005 13:20:08 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > Yes, I found it too.
> > Following patch should be the solution:
> > 
> > --- orig/drivers/connector/connector.c
> > +++ mod/drivers/connector/connector.c
> > @@ -146,13 +146,16 @@
> >        spin_lock_bh(&dev->cbdev->queue_lock);
> >        list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
> >                if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> > -                       __cbq->cb->priv = msg;
> > +
> > +                       if (!test_bit(0, &work->pending)) {
> > +                               __cbq->cb->priv = msg;
> > 
> > -                       __cbq->ddata = data;
> > -                       __cbq->destruct_data = destruct_data;
> > +                               __cbq->ddata = data;
> > +                               __cbq->destruct_data = destruct_data;
> > 
> 
> Still not good enough - work->pending bit gets cleared when work has
> been scheduled, but before executing payload. You still have the race.

Data pointer is copied before bit is set, 
but I forget that it is not data, but another pointer
which may be overwritten.

I think we may finish it by setting skb as data,
and call kfree_skb() as destructor.

Thank you for your analysis.
 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
