Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbUJ0TuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbUJ0TuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbUJ0Tru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:47:50 -0400
Received: from waste.org ([209.173.204.2]:65184 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262658AbUJ0Tlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:41:37 -0400
Date: Wed, 27 Oct 2004 14:41:13 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll_setup questions
Message-ID: <20041027194113.GP31237@waste.org>
References: <16767.50093.59665.83462@segfault.boston.redhat.com> <20041027173031.GO31237@waste.org> <16767.61372.910664.763968@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16767.61372.910664.763968@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 02:58:04PM -0400, Jeff Moyer wrote:
> ==> Regarding Re: netpoll_setup questions; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> On Wed, Oct 27, 2004 at 11:50:05AM -0400, Jeff Moyer wrote:
> >> Hi, Matt,
> >> 
> >> The section of code in the body of this if statement:
> >> 
> >> if (!(ndev->flags & IFF_UP)) {
> >> 
> >> is a bit broken.  First, upon discussion with jgarzik, it seems we
> >> should not check for IFF_UP, but instead do netif_running.
> 
> mpm> Well I cribbed it from the nfsroot code, which is perhaps not up on
> mpm> fashion.
> 
> Hmm, I can't seem to find the relevant code.  Where is it?

net/ipv4/ipconfig.c, IIRC.
 
> mpm> I don't expect it does. Usually we have our own IP address from the
> mpm> command line, but if we don't, we will check if there's an in_dev
> mpm> connected to the device and if so, look up the device's IP. This is
> mpm> useful for the modular case where the network is up before we start
> mpm> and we have a handy default for local IP.
> 
> Right, but the case in question is the one where we don't have a local IP
> specified:

Yeah..
 
> 	if (!np->local_ip) {

"but if we don't"

> 		rcu_read_lock();
> 		in_dev = __in_dev_get(ndev);
> 
> 		if (!in_dev) {

"we will check if there's an in_dev"

> 			rcu_read_unlock();
> 			printk(KERN_ERR "%s: no IP address for %s, aborting\n",
> 			       np->name, np->dev_name);
> 			goto release;
> 		}
> 
> 		np->local_ip = ntohl(in_dev->ifa_list->ifa_local);

"if so, look up the device's IP"

> 		rcu_read_unlock();
> 		printk(KERN_INFO "%s: local IP %d.%d.%d.%d\n",
> 		       np->name, HIPQUAD(np->local_ip));
> 	}
> 
> 
> >> And, in the case where it doesn't, you will get an oops further on when
> >> dereferencing the ifa_list.
> 
> mpm> Does this actually happen? I'm checking in_dev for null already, but
> mpm> perhaps I need to check ifa_list as well.
> 
> Yes, that should do it.

Again, does the oops actually happen? I'd expect I'd have seen it by
now if this were really a problem, but I don't mind adding another check.

> Here is a patch which should work.  I'll test today.
> 
> -Jeff
> 
> --- linux-2.6.9/net/core/netpoll.c~	2004-10-21 17:49:10.000000000 -0400
> +++ linux-2.6.9/net/core/netpoll.c	2004-10-27 14:53:57.492149880 -0400
> @@ -571,7 +571,7 @@ int netpoll_setup(struct netpoll *np)
>  		goto release;
>  	}
>  
> -	if (!(ndev->flags & IFF_UP)) {
> +	if (!netif_running(ndev)) {
>  		unsigned short oflags;
>  		unsigned long atmost, atleast;
>  
> @@ -617,7 +617,7 @@ int netpoll_setup(struct netpoll *np)
>  		rcu_read_lock();
>  		in_dev = __in_dev_get(ndev);
>  
> -		if (!in_dev) {
> +		if (!in_dev || !in_dev->ifa_list) {
>  			rcu_read_unlock();
>  			printk(KERN_ERR "%s: no IP address for %s, aborting\n",
>  			       np->name, np->dev_name);

Looks good to me.

-- 
Mathematics is the supreme nostalgia of our time.
