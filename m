Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUELVKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUELVKD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUELVHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:07:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14292 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265240AbUELVEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:04:42 -0400
Date: Wed, 12 May 2004 14:03:24 -0700 (PDT)
From: Sridhar Samudrala <sri@us.ibm.com>
X-X-Sender: sridhar@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, mingo@elte.hu, davidel@xmailserver.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
In-Reply-To: <20040512133520.44fbfd39.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405121352060.8535@localhost.localdomain>
References: <20040512020700.6f6aa61f.akpm@osdl.org> <20040512181903.GG13421@kroah.com>
 <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu>
 <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
 <20040512200305.GA16078@elte.hu> <20040512132050.6eae6905.akpm@osdl.org>
 <40A28815.2020009@pobox.com> <20040512133520.44fbfd39.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have submitted a patch just to do this some time back on netdev mailing
list. You can find it at
	http://marc.theaimsgroup.com/?l=linux-netdev&m=108024598716537&w=2

static inline unsigned long msecs_to_jiffies(unsigned long msecs)
{
#if 1000 % HZ == 0
	return msecs / (1000 / HZ);
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

I was told that some users of these routines need an explicit roundup of
delays.
For ex: when HZ=100 and msecs is less than 10, the above msecs_to_jiffies()
returns 0 jiffies, whereas some users expect 1 jiffy.

So i modified msecs_to_jiffies() as follows which should do proper rounding
when HZ=100. But didn't get back any response.

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

Thanks
Sridhar


On Wed, 12 May 2004, Andrew Morton wrote:

> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > > How about we do:
> >  >
> >  > #if HZ=1000
> >  > #define	MSEC_TO_JIFFIES(msec) (msec)
> >  > #define JIFFIES_TO_MESC(jiffies) (jiffies)
> >  > #elif HZ=100
> >  > #define	MSEC_TO_JIFFIES(msec) (msec * 10)
> >  > #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
> >  > #else
> >  > #define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
> >  > #define	JIFFIES_TO_MSEC(jiffies) ...
> >  > #endif
> >  >
> >  > in some kernel-wide header then kill off all the private implementations?
> >
> >
> >  include/linux/time.h.  One of the SCTP people already did this, but I
> >  suppose it's straightforward to reproduce.
>
> OK, I'll do it.
>
>
