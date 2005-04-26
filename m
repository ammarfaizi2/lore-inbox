Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVDZReq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVDZReq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDZRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:33:09 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:46554 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261718AbVDZRb6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:31:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PopERRu9ENjqO8CO2cxcoiiNtGqFPPxEqF0MNowRejHijuTffUb9ce6y0SWwRHDhFD406EwpTVxKeOJAPElHPl7LwkeXqTMu9Mdb3nb0u19FS9aRbM58AU2tQqOeJKZDcjYEqNbgbEiOwBWWBkIwbq0CucIoV24lw261fAp1LJ0=
Message-ID: <d120d50005042610317961a564@mail.gmail.com>
Date: Tue, 26 Apr 2005 12:31:58 -0500
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
In-Reply-To: <20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <d120d5000504260857cb5f99e@mail.gmail.com>
	 <20050426202437.234e7d45@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> On Tue, 26 Apr 2005 10:57:55 -0500
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Evgeniy,
> >
> > On 4/11/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > /*****************************************/
> > > Kernel Connector.
> > > /*****************************************/
> > ...
> > > +static int cn_call_callback(struct cn_msg *msg, void (*destruct_data) (void *), void *data)
> > > +{
> > > +       struct cn_callback_entry *__cbq;
> > > +       struct cn_dev *dev = &cdev;
> > > +       int found = 0;
> > > +
> > > +       spin_lock_bh(&dev->cbdev->queue_lock);
> > > +       list_for_each_entry(__cbq, &dev->cbdev->queue_list, callback_entry) {
> > > +               if (cn_cb_equal(&__cbq->cb->id, &msg->id)) {
> > > +                       __cbq->cb->priv = msg;
> > > +
> > > +                       __cbq->ddata = data;
> > > +                       __cbq->destruct_data = destruct_data;
> > > +
> > > +                       queue_work(dev->cbdev->cn_queue, &__cbq->work);
> >
> > It looks like there is a problem with the code. As far as I can see
> > there is only one cn_callback_entry associated with each callback. So,
> > if someone sends netlink messages with the same id at a high enough
> > rate (so cbdev's work queue does not get a chance to get scheduled and
> > process pending requests) ddata and the destructor will be overwritten
> > which can lead to memory leaks and non-delivery of some messages.
> >
> > Am I missing something?
> 
> Connector needs to check return value here - zero means
> that work was already queued and we must free shared skb.
> 
> There may not be the same work with different data.
> 

Ugh, that really blows. Now every user of a particular message type
has to coordinate efforts with other users of the same message type...

Imability to "fire and forget" undermines usefulness of whole
connector. How will you for example implement hotplug notification
over connector? Have kobject_hotplug wait and block other instances?
But wait on what?

-- 
Dmitry
