Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTFGA5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTFGA5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:57:47 -0400
Received: from almesberger.net ([63.105.73.239]:60170 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262439AbTFGA5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:57:45 -0400
Date: Fri, 6 Jun 2003 22:11:00 -0300
From: Werner Almesberger <wa@almesberger.net>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606221100.L3232@almesberger.net>
References: <20030606211005.H3232@almesberger.net> <200306070057.h570vtsG003449@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306070057.h570vtsG003449@ginger.cmf.nrl.navy.mil>; from chas@cmf.nrl.navy.mil on Fri, Jun 06, 2003 at 08:56:06PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chas williams wrote:
> but parts of the control/config plane still arent synchronus.
> how about atm_async_release()?

That's just "tag and go away". If I understood Dave right, he
wants the device to actually disappear at that point (well, at
what would be the equivalent point for devices).

Of course, "tag and go away" is relatively easy, and you can
even make it partially look as if you'd destroy things
immediately, e.g. by putting the old "ATM device" layer under
a network device layer. When that dreaded async call comes,
you drop the network device layer part, leave the ATM device
intact, and start working towards getting rid of it too. (E.g.
by failing all system calls related to it, much like what
happens when atmsigd dies.)

> actually i believe its up to the driver author to make sure that
> a vcc isnt used after the close completes.

When a driver's "close" function returns, the driver must have
released all externally visible resources (e.g. VPI/VCI) that
belong to the VCC, and ideally all invisible resources (e.g.
buffers). There must be no more calls to "push".

In return, the stack must not make any other calls for that
VCC after invoking "close".

Hmm, and I should have written all this in the device driver
interface document :-)

>  but very few (if any) try to do this.  

Looks like trouble ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
