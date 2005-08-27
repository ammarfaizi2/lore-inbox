Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbVH0NQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbVH0NQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 09:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbVH0NQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 09:16:50 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47514 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751610AbVH0NQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 09:16:49 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Greg Howard <ghoward@sgi.com>
Subject: Re: [PATCH, RFC] Standardize shutdown of the system from enviroment control modules
Date: Sat, 27 Aug 2005 16:16:21 +0300
User-Agent: KMail/1.8.2
Cc: Christoph Hellwig <hch@lst.de>, davem@davemloft.net,
       LKML <linux-kernel@vger.kernel.org>, Aaron Young <ayoung@sgi.com>
References: <20050809211003.GA29361@lst.de> <20050826114453.GA28115@lst.de> <Pine.SGI.4.58.0508260719050.46392@gallifrey.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.58.0508260719050.46392@gallifrey.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508271616.21847.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Currently snsc_event for Altix systems sends SIGPWR to init (and
> > > > abuses tasklist_lock..) while the sbus drivers call execve for
> > > > /sbin/shutdown (which is also ugly, it should at least use
> > > > call_usermodehelper) With normal sysvinit both will end up the same,
> > > > but I suspect the shutdown variant, maybe with a sysctl to chose the
> > > > exact path to call would be cleaner.  What do you guys think about

sysctl is indeed would be nice. Paranoid users may insist on having
freedom not to have /sbin at all.

> > > > adding a common function to do this.  Could you test such a patch for
> > > > me?
> > >
> > > Okay, here's such a patch, I've also switched the SN and the two sbus
> > > drivers over.
> >
> > ping?
>
> Hi Christoph,
>
> Got your patch and built it into a kernel...  Ran into other
> (unrelated) difficulties booting said kernel...  I'll see if I
> can get that sorted out today and test drive it.
>
> From inspection I don't see any problem with the patch.
>
> Thanks - Greg

[snip]

> > > +/*
> > > + * envctrl_do_shutdown  -  shut the system down when overheating
> > > + *
> > > + * Common routine to be called from all enviromental monitoring
> > > + * drivers when a fatal overheating is detected.
> > > + *
> > > + * Returns 0 if /sbin/shutdown has been called sucessfully, 1 if
> > > + * this routine has been called already but the kernel is still
> > > + * running or a negative error value if executing the shutdown
> > > + * command failed.
> > > + */
> > > +int envctrl_do_shutdown(void)
> > > +{
> > > +	static int shutting_down = 0;
> > > +	int error;
> > > +
> > > +	if (shutting_down)
> > > +		return 1;
> > > +	shutting_down = 1;
> > > +
> > > +	printk(KERN_CRIT "envctrl: WARNING: Shutting down the system now.\n");
> > > +	error = call_usermodehelper("/sbin/shutdown", argv, envp, 0);
> > > +	if (error) 
> > > +		printk(KERN_CRIT "envctrl: WARNING: system shutdown failed!\n");
> > > +	return error;
> > > +}
--
vda
