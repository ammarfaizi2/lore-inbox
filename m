Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUCZSut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCZSut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:50:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:40326 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261186AbUCZSuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:50:44 -0500
Date: Fri, 26 Mar 2004 10:49:15 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Edgar Toernig <froese@gmx.de>
cc: davem@redhat.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
In-Reply-To: <20040326014403.39388cb8.froese@gmx.de>
Message-ID: <Pine.LNX.4.58.0403261007370.6718@localhost.localdomain>
References: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
 <20040326014403.39388cb8.froese@gmx.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 26 Mar 2004, Edgar Toernig wrote:

> Sridhar Samudrala wrote:
> >
> > The following patch to 2.6.5-rc2 consolidates 6 different implementations
> > of msecs to jiffies and 3 different implementation of jiffies to msecs.
> > All of them now use the generic msecs_to_jiffies() and jiffies_to_msecs()
> > that are added to include/linux/time.h
> >[...]
> > -#define MSECS(ms)  (((ms)*HZ/1000)+1)
> > -return (((ms)*HZ+999)/1000);
> > +return (msecs / 1000) * HZ + (msecs % 1000) * HZ / 1000;
>
> Did you check that all users of the new version will work correctly
> with your rounding?  Explicit round-up of delays is often required,
> especially when talking to hardware...

I don't see any issues with the 2.6 default HZ value of 1000 as they become
no-ops and there is no need for any rounding.
I guess you are referring to cases when HZ < 1000(ex: 100) and msecs is
less than 10. In those cases, the new version returns 0, whereas some of the
older versions return 1.

If i am not mistaken, Jeff Garjik/David Miller are the maintainers for most
of the users of these routines and i have got an OK from them.
   drivers/block/carmel.c
   drivers/net/tulip/de204x.c
   include/linux/libata.h
   include/net/irda/irda.h
   drivers/atm/fore200e.c
   include/net/sctp/sctp.h

The only other place where the older version is different is
   drivers/char/watchdot/shwdt.c

Dave, Jeff
  Do you see any issues with the new generic versions of these routines?

Thanks
Sridhar
>
> Ciao, ET.
>
