Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312270AbSCTXIb>; Wed, 20 Mar 2002 18:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312268AbSCTXIV>; Wed, 20 Mar 2002 18:08:21 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:63440 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312267AbSCTXIK>; Wed, 20 Mar 2002 18:08:10 -0500
Date: Wed, 20 Mar 2002 15:04:42 -0800
From: Russ Weight <rweight@us.ibm.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: mingo@elte.hu, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Scalable CPU bitmasks
Message-ID: <20020320150442.A1264@us.ibm.com>
In-Reply-To: <20020318140700.A4635@us.ibm.com> <200203190728.g2J7Srq31344@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 09:28:25AM -0200, Denis Vlasenko wrote:
> On 18 March 2002 20:07, Russ Weight wrote:
> >           While systems with more than 32 processors are still
> >   out in the future, these interfaces provide a path for gradual
> >   code migration. One of the primary goals is to provide current
> >   functionality without affecting performance.
> 
> Not so far in the future. "7.52 second kernel compile" thread is about
> timing kernel compile on the 32 CPU SMP box.
> 
> I don't know whether BUG() in inlines makes them too big, but
> _for() _loops_ in inline functions definitely do that.
> Here's one of the overgrown inlines:

I was hoping for some feedback regarding the use of BUG(). I have
been experimenting with the patch - changing various bitmasks to 
use this new datatype. None of them do the error checking that I am
adding. Is it worth the overhead to have these checks at all? If
they ever trigger, they are indicative of an error elsewhere in the
kernel...

With respect to the for loops: For CPUMAP_SIZE > 1, most of the
interfaces expand to a "for loop". This is a performance vs. bloat
tradeoff. The "for-loop" versions of the functions _could_ be moved
to a cpumap.c file under lib. Is this the recommended approach?

The cpumap_format() function below is probably the worst offender.
There is no real performance value in making it an inline function...

> 
> > +static inline char *cpumap_format(cpumap_t map, char *buf, int size)
> > +{
> > +	if (size < CPUMAP_BUFSIZE) {
> > +		BUG();
> > +	}
> > +
> > +#if CPUMAP_SIZE > 1
> > +	sprintf(buf, "0x" CPUMAP_FORMAT_STR, map[CPUMAP_SIZE-1]);
> > +	{
> > +		int i;
> > +		char *p = buf + strlen(buf);
> > +		for (i = CPUMAP_SIZE-2; i >= 0; i--, p += (sizeof(long) + 1)) {
> > +			sprintf(p, " " CPUMAP_FORMAT_STR, map[i]);
> > +		}
> > +	}
> > +#else
> > +	sprintf(buf, "0x" CPUMAP_FORMAT_STR, map[0]);
> > +#endif
> > +	return(buf);
> > +}
> --
> vda

-- 
Russ Weight (rweight@us.ibm.com)
Linux Technology Center
