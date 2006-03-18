Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWCRV0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWCRV0k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWCRV0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:26:39 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:20590 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751026AbWCRV0j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:26:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KwrkSLuF9e0PRUlPCE6Wtuf01jUhMF/DB2iUeJip0BcidDNXQ6BiGXUbOryDRjsLbbNnM/EZHhiiPQ69mGYI2ozZ3MW9cs0+35SUh8e/3T3GB7l52kO1F8RkCZG+x/6IWdGTr9fYrs+M0Z5g/hZOGx76KkNn1k47JWS/+yxADsc=
Message-ID: <9a8748490603181326p12f35665y4504e77561f3c99@mail.gmail.com>
Date: Sat, 18 Mar 2006 22:26:36 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
In-Reply-To: <20060318130925.616d11c5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142830.607556000@localhost.localdomain>
	 <20060318120728.63cbad54.akpm@osdl.org>
	 <1142712975.17279.131.camel@localhost.localdomain>
	 <20060318123102.7d8c048a.akpm@osdl.org>
	 <1142714332.17279.148.camel@localhost.localdomain>
	 <20060318130925.616d11c5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Andrew Morton <akpm@osdl.org> wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Sat, 2006-03-18 at 12:31 -0800, Andrew Morton wrote:
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Sat, 2006-03-18 at 12:07 -0800, Andrew Morton wrote:
> > > >
> > > > > From my reading, 2.4's sys_setitimer() will normalise the incoming timeval
> > > > > rather than rejecting it.  And I think 2.6.13 did that too.
> > > > >
> > > > > It would be bad of us to change this behaviour, even if that's what the
> > > > > spec says we should do - because we can break existing applications.
> > > > >
> > > > > So I think we're stuck with it - we should normalise and then accept such
> > > > > timevals.  And we should have a big comment explaining how we differ from
> > > > > the spec, and why.
> > > >
> > > > Hmm. How do you treat a negative value ?
> > > >
> > >
> > > In the same way as earlier kernels did!
> > >
> > > Unless, of course, those kernels did something utterly insane.  In that
> > > case we'd need to have a little think.
> >
> > It was caught by:
> >
> > timeval_to_jiffies(const struct timeval *value)
> > {
> >         unsigned long sec = value->tv_sec;
> >         long usec = value->tv_usec;
> >
> >         if (sec >= MAX_SEC_IN_JIFFIES)
> > sec = MAX_SEC_IN_JIFFIES;
> > ....
> > }
> >
> > The conversion of long to unsigned long converted a negative value to
> > the maximum timeout.
> >
> > It's not utterly insane, but it does not make much sense either.
> >
> > Of course I can convert it that way, if we want to keep this "help
> > sloppy programmers aid" alive.
> >
>
> It would be strange to set an alarm for 0xffffffff seconds in the future
> but yeah, unless we can point at a reason why nobody could have ever been
> doing that, we should turn this into permanent, documented behaviour of
> Linux 2.6 and earlier, I'm afraid.
>

How about 0xffffffff seconds into the future being the same as 136
years (unless I botched the math)... That means that if any Linux
application ever did that it's still waiting for the alarm and will be
for at least another century...
I'd say that makes it pretty certain that noone are doing or have been
doing that without spotting the problem somehow - apps with such a bug
are unlikely to be in production and actually working correctly.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
