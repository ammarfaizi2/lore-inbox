Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbULaEaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbULaEaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 23:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbULaEaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 23:30:39 -0500
Received: from mail.dif.dk ([193.138.115.101]:5840 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261823AbULaEaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 23:30:24 -0500
Date: Fri, 31 Dec 2004 05:41:33 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: William Park <opengeometry@yahoo.ca>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: waiting 10s before mounting root filesystem?
In-Reply-To: <20041231035834.GA2421@node1.opengeometry.net>
Message-ID: <Pine.LNX.4.61.0412310537420.26032@dragon.hygekrogen.localhost>
References: <20041227195645.GA2282@node1.opengeometry.net>
 <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at>
 <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet>
 <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost>
 <20041231035834.GA2421@node1.opengeometry.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004, William Park wrote:

> On Fri, Dec 31, 2004 at 02:45:53AM +0100, Jesper Juhl wrote:
> > William Park wrote:
> > > On Thu, Dec 30, 2004 at 01:25:32PM -0200, Marcelo Tosatti wrote:
> > > > On Tue, Dec 28, 2004 at 07:59:22PM -0500, William Park wrote:
> > > > > On Mon, Dec 27, 2004 at 10:23:34PM +0100, Andreas Unterkircher wrote:
> > > > > > [1] http://www.xenotime.net/linux/usb/usbboot-2422.patch
> ...
> > > http://linux.bkbits.net:8080/linux-2.4/patch@1.1527.1.20?nav=index.html|ChangeSet@-3w|cset@1.1527.1.20 
> > > 
> > > Hi Marcelo,
> > > 
> > > 1.  Actually, my patch above loops every 5s to reduce screen clutter,
> > >     whereas the original 2.4 patch (cited by Andreas Unterkircher) loops
> > >     every 1s.  Both loops forever.
> > > 
> > >     But, if a limit of 10 tries is what you want, then here is a patch
> > >     for 2.6.10:
> > 
> > I agree with you that reducing screen clutter is a good thing. How
> > about something like this that waits for 10+ seconds so even slow
> > devices have a chance to get up but also does some primitive
> > ratelimiting on the messages by only printing one every 3 seconds (but
> > still attempting to mount every 1 sec) ? 
> 
> Hi Jesper,
> 
> I prefer countdown with short message.  The 2.4 messages are too long.
> Incorporating your use of ssleep() and printk() loglevel, here is
> the latest iteration:
> 
> --- ./init/do_mounts.c--orig	2004-12-27 17:36:35.000000000 -0500
> +++ ./init/do_mounts.c	2004-12-30 22:43:57.000000000 -0500
> @@ -6,6 +6,7 @@
>  #include <linux/suspend.h>
>  #include <linux/root_dev.h>
>  #include <linux/security.h>
> +#include <linux/delay.h>
>  
>  #include <linux/nfs_fs.h>
>  #include <linux/nfs_fs_sb.h>
> @@ -278,6 +279,7 @@
>  	char *fs_names = __getname();
>  	char *p;
>  	char b[BDEVNAME_SIZE];
> +	int tryagain = 20;
>  
Ok, I'm nitpicking here, but why int and not short? are we likely to ever
want to wait for more than 2 minutes? and if we want to wait ~3min, then
unsigned short should do just fine (and unsigned would even be logical
since negative retry value doesn't make any sense)....


> +		if (--tryagain) {

I think if  (tryagain--)  makes more sense. You set tryagain to 20 thereby 
implying that we will be doing 20 retries, but with --tryagain we will 
only be doing 19 retries, not 20 - with tryagain-- we will be doing the 
nr. of retries that we initially initialize 'tryagain' to.

other than that (and it /is/ nitpicking) the patch looks good to me.


-- 
Jesper Juhl


