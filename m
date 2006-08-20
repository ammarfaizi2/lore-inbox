Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWHTAG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWHTAG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 20:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbWHTAG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 20:06:29 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:16103
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751072AbWHTAG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 20:06:29 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Date: Sun, 20 Aug 2006 02:05:20 +0200
User-Agent: KMail/1.9.1
References: <20060819230532.GA16442@openwall.com> <20060819234806.GB27115@1wt.eu>
In-Reply-To: <20060819234806.GB27115@1wt.eu>
Cc: Solar Designer <solar@openwall.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608200205.20876.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 01:48, Willy Tarreau wrote:
> On Sun, Aug 20, 2006 at 03:05:32AM +0400, Solar Designer wrote:
> > Willy,
> > 
> > I propose the attached patch (extracted from 2.4.33-ow1) for inclusion
> > into 2.4.34-pre.
> > 
> > (2.6 kernels could benefit from the same change, too, but at the moment
> > I am dealing with proper submission of generic changes like this that
> > are a part of 2.4.33-ow1.)
> > 
> > The patch makes getsockopt(2) sanity-check the value pointed to by
> > the optlen argument early on.  This is a security hardening measure
> > intended to prevent exploitation of certain potential vulnerabilities in
> > socket type specific getsockopt() code on UP systems.
> > 
> > This change has been a part of -ow patches for some years.
> 
> looks valid to me, merged.

Not to me. It heavily violates codingstyle and screws brains
with the non-indented else branches. Learn about goto.

> Thanks Alexander !
> Willy
> 
> 
> > Thanks,
> > 
> > -- 
> > Alexander Peslyak <solar at openwall.com>
> > GPG key ID: B35D3598  fp: 6429 0D7E F130 C13E C929  6447 73C3 A290 B35D 3598
> > http://www.openwall.com - bringing security into open computing environments
> 
> > diff -urpPX nopatch linux-2.4.33/net/socket.c linux/net/socket.c
> > --- linux-2.4.33/net/socket.c	Wed Jan 19 17:10:14 2005
> > +++ linux/net/socket.c	Sat Aug 12 08:51:47 2006
> > @@ -1307,10 +1307,18 @@ asmlinkage long sys_setsockopt(int fd, i
> >  asmlinkage long sys_getsockopt(int fd, int level, int optname, char *optval, int *optlen)
> >  {
> >  	int err;
> > +	int len;
> >  	struct socket *sock;
> >  
> >  	if ((sock = sockfd_lookup(fd, &err))!=NULL)
> >  	{
> > +		/* XXX: insufficient for SMP, but should be redundant anyway */
> > +		if (get_user(len, optlen))
> > +			err = -EFAULT;
> > +		else
> > +		if (len < 0)
> > +			err = -EINVAL;
> > +		else
> >  		if (level == SOL_SOCKET)
> >  			err=sock_getsockopt(sock,level,optname,optval,optlen);
> >  		else
> 
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Greetings Michael.
