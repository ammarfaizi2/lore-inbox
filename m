Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUC2UB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUC2UA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:00:28 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7057 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263127AbUC2UAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:00:10 -0500
Date: Mon, 29 Mar 2004 11:57:54 -0800 (PST)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Jeff Garzik <jgarzik@pobox.com>
cc: Edgar Toernig <froese@gmx.de>, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Consolidate multiple implementations of jiffies-msecs
 conversions.
In-Reply-To: <40647E65.7020903@pobox.com>
Message-ID: <Pine.LNX.4.58.0403291137360.23386@localhost.localdomain>
References: <Pine.LNX.4.58.0403251142110.3037@localhost.localdomain>
 <20040326014403.39388cb8.froese@gmx.de> <Pine.LNX.4.58.0403261007370.6718@localhost.localdomain>
 <40647E65.7020903@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004, Jeff Garzik wrote:

> Sridhar Samudrala wrote:
> > On Fri, 26 Mar 2004, Edgar Toernig wrote:
> >
> >
> >>Sridhar Samudrala wrote:
> >>
> >>>The following patch to 2.6.5-rc2 consolidates 6 different implementations
> >>>of msecs to jiffies and 3 different implementation of jiffies to msecs.
> >>>All of them now use the generic msecs_to_jiffies() and jiffies_to_msecs()
> >>>that are added to include/linux/time.h
> >>>[...]
> >>>-#define MSECS(ms)  (((ms)*HZ/1000)+1)
> >>>-return (((ms)*HZ+999)/1000);
> >>>+return (msecs / 1000) * HZ + (msecs % 1000) * HZ / 1000;
> >>
> >>Did you check that all users of the new version will work correctly
> >>with your rounding?  Explicit round-up of delays is often required,
> >>especially when talking to hardware...
> >
> >
> > I don't see any issues with the 2.6 default HZ value of 1000 as they become
> > no-ops and there is no need for any rounding.
> > I guess you are referring to cases when HZ < 1000(ex: 100) and msecs is
> > less than 10. In those cases, the new version returns 0, whereas some of the
> > older versions return 1.
>
> We'll definitely want to return 1 rather than zero, for the uses in my
> drivers, at least...

I have modified msecs_to_jiffies() to do the proper rounding when HZ=100.
Do these work better?

static inline unsigned long msecs_to_jiffies(unsigned long msecs)
{
#if 1000 % HZ == 0
        return (msecs + ((1000 / HZ) - 1)) / (1000 / HZ);
#elif HZ % 1000 == 0
        return msecs * (HZ / 1000);
#else
        return (msecs / 1000) * HZ + (msecs % 1000) * HZ / 1000;
#endif
}

static inline unsigned long jiffies_to_msecs(unsigned long jiffs)
{
#if 1000 % HZ == 0
        return jiffs * (1000 / HZ);
#elif HZ % 1000 == 0
        return jiffs / (HZ / 1000);
#else
        return (jiffs / HZ) * 1000 + (jiffs % HZ) * 1000 / HZ;
#endif
}

Thanks
Sridhar
