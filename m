Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVAYPe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVAYPe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 10:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVAYPe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 10:34:56 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:15587 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261983AbVAYPew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 10:34:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KoR03hc2ooKqG5BtczUwtjyEW979QuVLIED5FnbSsGajKu1k9lofggAoEsCT7GAzGdgB6w+tjvucYCF7tZWOIeDtVRYTUgufFezrDN88teCM/W87GxdHj2KUDxn0a2FYqhn4DOqK4D36DYj3AnC+kLODHE4rf5H45adixR/8EjM=
Message-ID: <58cb370e050125073464befe4@mail.gmail.com>
Date: Tue, 25 Jan 2005 16:34:52 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: johnpol@2ka.mipt.ru
Subject: Re: 2.6.11-rc2-mm1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <1106666690.5257.97.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050125125323.GA19055@infradead.org>
	 <1106662284.5257.53.camel@uganda>
	 <20050125142356.GA20206@infradead.org>
	 <1106666690.5257.97.camel@uganda>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 18:24:50 +0300, Evgeniy Polyakov
<johnpol@2ka.mipt.ru> wrote:
> On Tue, 2005-01-25 at 14:23 +0000, Christoph Hellwig wrote:
> > > > Also your locking is broken.  sdev_lock sometimes nests outside
> > > > sdev->lock and sometimes inside.  Similarly dev->chain_lock nests
> > > > inside dev->lock sometimes and sometimes outside.  You really need
> > > > a locking hiearchy document and the lockign should probably be
> > > > simplified a lot.
> > >
> > > It is almost the same like after hand waving say that there is a wind.
> > >
> > > Each lock protect it's own data, sometimes it happens when other data is
> > > locked,
> > > sometimes not. Yes, probably interrupt handling can race, it requires
> > > more review,
> > > I will take a look.
> >
> > The thing I mention is called lock order reversal, which means a deadlock
> > in most cases.  I don't have the time to actual walk through all codepathes
> > to tell you whether it can really happen and where, but it's a really
> > big warning sign.
> 
> No, it is not called lock order reversal.
> 
> There are no places like
> lock a
> lock b
> unlock a
> unlock b
> 
> and if they are, then I'm completely wrong.
> 
> What you see is only following:
> 
> place 1:
> lock a
> lock b
> unlock b
> lock c
> unlock c
> unlock a
> 
> place 2:
> lock b
> lock a
> unlock a
> lock c
> unlock c
> unlock b

Ugh, now think about that:

CPU0     CPU1
place1:   place2:
lock a      lock b
< guess what happens here :-) >
lock b      lock a
...             ...
