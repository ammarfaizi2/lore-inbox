Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWFBN5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWFBN5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWFBN5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:57:48 -0400
Received: from es335.com ([67.65.19.105]:56380 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S932106AbWFBN5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:57:47 -0400
Subject: RE: [openib-general] Re: [PATCH 1/2] iWARP Connection Manager.
From: Steve Wise <swise@opengridcomputing.com>
To: Caitlin Bestler <caitlinb@broadcom.com>
Cc: Tom Tucker <tom@opengridcomputing.com>,
       Sean Hefty <mshefty@ichips.intel.com>, netdev@vger.kernel.org,
       rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <54AD0F12E08D1541B826BE97C98F99F150D3E6@NT-SJCA-0751.brcm.ad.broadcom.com>
References: <54AD0F12E08D1541B826BE97C98F99F150D3E6@NT-SJCA-0751.brcm.ad.broadcom.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 08:57:44 -0500
Message-Id: <1149256664.791.3.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > The problem is that we can't synchronously cancel an
> > outstanding connect request. Once we've asked the adapter to
> > connect, we can't tell him to stop, we have to wait for it to
> > fail. During the time period between when we ask to connect
> > and the adapter says yeah-or-nay, the user hits ctrl-C. This
> > is the case where disconnect and/or destroy gets called and
> > we have to block it waiting for the outstanding connect
> > request to complete.
> > 
> > One alternative to this approach is to do the kfree of the
> > cm_id in the deref logic. This was the original design and
> > leaves the object around to handle the completion of the
> > connect and still allows the app to clean up and go away
> > without all this waitin' around. When the adapter finally
> > finishes and releases it's reference, the object is kfree'd.
> > 
> > Hope this helps.
> > 
> Why couldn't you synchronously put the cm_id in a state of
> "pending delete" and do the actual delete when the RNIC
> provides a response to the request? 

This is Tom's "alternative" mentioned above.  The provider already keeps
an explicit reference on the cm_id while it might possibly deliver an
event on that cm_id.  So if you change deref to kfree the cm_id on its
last deref (when the refcnt reaches 0), then you can avoid blocking
during destroy...  

> There could even be
> an optional method to see if the device is capable of
> cancelling the request. I know it can't yank a SYN back
> from the wire, but it could refrain from retransmitting.

I would suggest we don't add this optional method until we see an RNIC
that supports canceling a connect request or accept synchronously...

Steve.

