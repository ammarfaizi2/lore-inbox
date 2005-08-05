Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263034AbVHEOLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbVHEOLM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVHEOK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:10:57 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:8440 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S263031AbVHEOKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:10:22 -0400
Subject: Re: lockups with netconsole on e1000 on media insertion
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
In-Reply-To: <20050805135551.GQ8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <20050805135551.GQ8266@wotan.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 10:10:13 -0400
Message-Id: <1123251013.18332.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 15:55 +0200, Andi Kleen wrote:
> > This is fixing the symptom and is not the cure.  Unfortunately I don't
> > have a e1000 card so I can't try a fix. But I did have a e100 card that
> > would lock up the same way.  The problem was that netpoll_poll calls the
> > cards netpoll routine (in e1000_main.c e1000_netpoll).  In the e100
> > case, when the transmit buffer would fill up, the queue would go down.
> > But the netpoll routine in the e100 code never put it back up after it
> > was all transfered. So this would lock up the kernel when that happened.
> 
> In my case the hang happened when no cable was connected.

But should come back when the cable is reconnected. 

OK, I admit, it shouldn't hang in the first place.

> 
> There is no way to handle this in any other way. You eventually
> have to bail out.
> 
> >  
> >  repeat:
> > -	if(!np || !np->dev || !netif_running(np->dev)) {
> > +	if(try-- == 0 || !np || !np->dev || !netif_running(np->dev)) {
> > +		if (!try)
> > +			printk(KERN_WARNING "net driver is stuck down, maybe a"
> > +					" problem with the driver's netpoll\n");
> 
> ... and nobody will see that. It will not even trigger an output.

Since one would be using net console right? :-)   Oops! I forgot that.
Well it may make it to the logs, since this patch also bails out.
That's why I think your first patch with this warning as well as a fix
for the e1000 should be submitted.  Since the e1000 shouldn't lock up
netpoll just because the queue was put down.

Hmm, how bad is it to have a printk in a routine that is registered to
printk?   If this does print, a "static once" variable should be added
so that this is only printed once and not everytime it tries to print
this message.

-- Steve


