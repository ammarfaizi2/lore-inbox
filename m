Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVGQAob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVGQAob (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 20:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVGQAob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 20:44:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:23201 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261189AbVGQAoa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 20:44:30 -0400
Date: Sat, 16 Jul 2005 17:44:27 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 1/4] add jiffies_to_nsecs() helper and fix up size of usecs
Message-ID: <20050717004427.GB5865@us.ibm.com>
References: <20050714202629.GD28100@us.ibm.com> <20050714202826.GE28100@us.ibm.com> <1121374488.15263.54.camel@localhost> <20050714210328.GJ28100@us.ibm.com> <20050715121424.GA1775@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715121424.GA1775@elf.ucw.cz>
X-Operating-System: Linux 2.6.13-rc2 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2005 [14:14:25 +0200], Pavel Machek wrote:
> Hi!
> 
> > > > +static inline u64 jiffies_to_nsecs(const unsigned long j)
> > > > +{
> > > > +#if HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ)
> > > > +	return (NSEC_PER_SEC / HZ) * (u64)j;
> > > > +#elif HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC)
> > > > +	return ((u64)j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
> > > > +#else
> > > > +	return ((u64)j * NSEC_PER_SEC) / HZ;
> > > > +#endif
> > > > +}
> > > 
> > > That might look a little better something like:
> > > 
> > > static inline u64 jiffies_to_nsecs(const unsigned long __j)
> > > {
> > > 	u64 j = __j;
> > > 
> > > 	if (HZ <= NSEC_PER_SEC && !(NSEC_PER_SEC % HZ))
> > > 		return (NSEC_PER_SEC / HZ) * j;
> > > 	else if (HZ > NSEC_PER_SEC && !(HZ % NSEC_PER_SEC))
> > > 		return (j + (HZ / NSEC_PER_SEC) - 1)/(HZ / NSEC_PER_SEC);
> > > 	else
> > > 		return (j * NSEC_PER_SEC) / HZ;
> > > }
> > > 
> > > Compilers are smart :)
> > 
> > Well, I was trying to keep it similar to the other conversion functions.
> > I guess the compiler can evaluate the conditional full of constants at
> > compile-time regardless of whether it is #if or if ().
> > 
> > I can make these changes if others would like them as well.
> 
> Yes, please. And feel free to convert nearby functions, too ;-).

I have a patch to make this change for all the jiffies <--> human-time
functions, but have a problem. I noticed that these functions, in the
if/else form (as opposed to #if/#else) will warn about division-by-zero
problems, as (HZ / MSEC_PER_SEC), (HZ / USEC_PER_SEC) & (HZ /
NSEC_PER_SEC) are all 0 if HZ < 1000 (which, of course, is the default
now :) ). Any suggestions? Just leave the functions as is? Even then,
I'm going to update this patch to use USEC_PER_SEC and MSEC_PER_SEC in
the other conversion functions like I use NSEC_PER_SEC in the first
version.

Thanks,
Nish
