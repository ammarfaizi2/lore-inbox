Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVHOIxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVHOIxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVHOIxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:53:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24704 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932280AbVHOIxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:53:49 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: hyoshiok@miraclelinux.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d305081501441bc9b121@mail.gmail.com>
References: <98df96d305081402164ce52f8@mail.gmail.com>
	 <1124012489.3222.13.camel@laptopd505.fenrus.org>
	 <98df96d305081403222e75b232@mail.gmail.com>
	 <1124015743.3222.17.camel@laptopd505.fenrus.org>
	 <98df96d30508142343407b4d61@mail.gmail.com>
	 <1124090190.3228.3.camel@laptopd505.fenrus.org>
	 <98df96d305081501441bc9b121@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 10:53:40 +0200
Message-Id: <1124096021.3228.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 17:44 +0900, Hiro Yoshioka wrote:
> Hi,
> 
> I appreciate your suggestion.
> 
> On 8/15/05, Arjan van de Ven <arjan@infradead.org> wrote:
> > 
> > > Anyway we could not find the cache aware version of __copy_from_user_ll
> > > has a big regression yet.
> > 
> > 
> > that is because you spread the cache misses out from one place to all
> > over the place, so that no one single point sticks out anymore.
> > 
> > Do you agree that your copy is less optimal for the case where the
> > kernel will (almost) immediately use the data?
> 
> Yes, I do.
> 
> My server has 8KB of L1 cache. (512KB of L2/2MB of L3)
> 
> If you move more than 4KB of data using by __copy_from_user_ll(), the
> data will be spilled over L1 cache but in L2 (or L3)

L2 access time isn't too bad. your code evicts the data even from L2 and
L3 though (even if it was in there before)..

> When you move huge data (> 1MB), even L3 cache will not help you.
> (This is known as a cache pollution.)

yes.
> copy_from_user_nocache() is fine.
> 
> But I don't know where I can use it. (I'm not so
>  familiar with the linux kernel file system yet.) 

I suspect the few cases where it will make the most difference will be
in the VFS for the write() system call, and the AIO variants thereof.

generic_file_buffered_write() will be a good candidate to try first...


