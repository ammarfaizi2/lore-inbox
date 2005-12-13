Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbVLMWQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbVLMWQg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbVLMWQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:16:36 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:41064 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030241AbVLMWQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:16:35 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
Date: Tue, 13 Dec 2005 14:16:32 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051130195053.713ea9ef.vwool@ru.mvista.com> <200511301327.02053.david-b@pacbell.net> <439DABEC.8000301@ru.mvista.com>
In-Reply-To: <439DABEC.8000301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512131416.33220.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 December 2005 8:57 am, Vitaly Wool wrote:
> BTW:
> 
> David Brownell wrote:
> 
> >+How do I write an "SPI Master Controller Driver"?
> >+-------------------------------------------------
> >+An SPI controller will probably be registered on the platform_bus; write
> >+a driver to bind to the device, whichever bus is involved.
> >+
> >+The main task of this type of driver is to provide an "spi_master".
> >+Use spi_alloc_master() to allocate the master, and class_get_devdata()
> >+to get the driver-private data allocated for that device.
> >+
> >+	struct spi_master	*master;
> >+	struct CONTROLLER	*c;
> >+
> >+	master = spi_alloc_master(dev, sizeof *c);
> >+	if (!master)
> >+		return -ENODEV;
> >+
> >+	c = class_get_devdata(&master->cdev);
> >  
> >
> Here's an example of a mixture of two approaches which leads to 
> misleading code.

I can't see that, myself.  I count three things, separated in as
close to "the usual way" as I've heard of:  the spi_master, which
essentially bridges some bus (platform etc) to SPI; the class
device, associated one-to-one with the master; and the controller
state used to implement the bridging.

Have you ever noticed how alloc_etherdev() works?  This is much
the same approach as that function (and its siblings) use.  Not
identical, but that could change.  The infrastructure code allocates
one block for the publicly visible state (spi_master in this case,
"struct netdevice" for alloc_netdev) and the private data.  You
want something like a "netdev_priv" backed by some different
implementation?


> If you want to have abstract spi_master, then you have to disallow (or 
> at least discourage) explicit usage of spi_master fields, otherwise 
> 'kzalloc is your friend' and you don't have toadd this spi_alloc_master 
> API as it's basically useless IMHO.

Well, it's what ensures that the class device is set up reasonably,
and incidentally takes its memory management out of the hands of
the controller driver.   Of course, "the Right Way" to handle such
class devices has changed recently, and this code may be a closer
match to "the Previous Right Way" than the new one.  ;)


> As opposed to this, we use abstract handles where possible (i. e. for 
> spi_message).
> I'd have understood your dissatisfaction with that if you were 
> consistently following the approach 'expose everything, forget the 
> extensibility, viva lightwieghtness', but you're mixing things.

Data abstraction isn't all-or-nothing, especially in C.  And in
particular, there's a lot to be said for low level APIs not being
fully opaque ... abstraction has costs, both in terms of growing
conceptual complexity (you're supporting multiple things behind
the abstraction, else why even bother?), loss of visibility into
what's really going on, and in terms of lines of having more source
(and likely object) code to cope with.  

The opaque way to access a "struct", as C++ or Java users know, is
to have get()/set() functions for every member.  And at the end of
the day, that's just a lot of code bloat, which tends to slow things
down (unless someone inlined it all, rather non-opaquely).

So no, I don't see an inconsistency in wrapping up common code so
it doesn't have to be copied/pasted everywhere (adding bugs), and
not wrapping up code that boils down to "xfer->buf = ptr" (where
funcall style wrappers hide how cheap it is).

- Dave
