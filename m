Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUBYDqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 22:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUBYDqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 22:46:16 -0500
Received: from cm6.gamma186.maxonline.com.sg ([202.156.186.6]:11654 "EHLO
	garfield.anomalistic.org") by vger.kernel.org with ESMTP
	id S262406AbUBYDqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 22:46:06 -0500
Date: Wed, 25 Feb 2004 11:46:05 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Gertjan van Wingerde <gwingerde@home.nl>
Cc: linux-kernel@vger.kernel.org, ptoal@cisco.com, jhp@pobox.com
Subject: Re: Cisco vpnclient prevents proper shutdown starting with 2.6.2
Message-ID: <20040225034605.GA13259@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <200402242141.40208.gwingerde@home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402242141.40208.gwingerde@home.nl>
X-Operating-System: Linux 2.6.3-rc3
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Gertjan, et al.

I have uploaded the vpnclient with your fix, and some of my cleanups 
for Debian installation at:

http://www.anomalistic.org/vpnclient/vpnclient-linux-4.0.3.B-k9.tar.gz

Eugene

<quote sender="Gertjan van Wingerde">
> Hi Patrick, et al.
> 
> Even though this seems to work, the real problem seems to lie in the cisco_ipsec module itself.
> It looks like it is registering a netdevice notifier at ioctl time, which seems to deadlock in the lock
> that has been introduced in 2.6.2. Moving the registration to module initialisation time (with the
> proper checks in the event handler itself to only act when VPN is up) seems to resolve the
> issue.
> 
> Patch to Cisco vpnclient 4.0.3.B is below.
> 
> 	MvG,
> 
> 		Gertjan.
> 
> diff -u --recursive vpnclient/interceptor.c vpnclient-new/interceptor.c
> --- vpnclient/interceptor.c	2003-10-30 02:27:34.000000000 +0100
> +++ vpnclient-new/interceptor.c	2004-02-24 21:26:36.000000000 +0100
> @@ -364,11 +364,6 @@
>          error = VPNIFUP_FAILURE;
>          goto error_exit;
>      }
> -    error = register_netdevice_notifier(&interceptor_notifier);
> -    if (error)
> -    {
> -        goto error_exit;
> -    }
>  
>      vpn_is_up = TRUE;
>      return error;
> @@ -388,8 +383,6 @@
>  {
>      int i;
>  
> -    unregister_netdevice_notifier(&interceptor_notifier);
> -
>      cleanup_frag_queue();
>      /*restore IP packet handler */
>      if (original_ip_handler.pt != NULL)
> @@ -436,6 +429,9 @@
>  {
>      struct net_device *dev = (struct net_device *) val;
>  
> +    if (!vpn_is_up)
> +	return 1;
> +
>      switch (event)
>      {
>      case NETDEV_REGISTER:
> @@ -853,6 +849,8 @@
>          CNICallbackTable = *PCNICallbackTable;
>          CniPluginDeviceCreated();
>  
> +        register_netdevice_notifier(&interceptor_notifier);
> +
>          if ((status = register_netdev(&interceptor_dev)) != 0)
>          {
>              printk(KERN_INFO "%s: error %d registering device \"%s\".\n",
> @@ -876,6 +874,9 @@
>      CniPluginUnload();
>  
>      unregister_netdev(&interceptor_dev);
> +
> +    unregister_netdevice_notifier(&interceptor_notifier);
> +
>      return;
>  }
>  
> 
> 
> >Hi Patrick,
> >
> >Just a data point..
> >
> >I reversed this patch on a system running 2.6.3-mm2, and vpnclient now
> >works.
> >
> >/harley
> >
> >> Newsgroups: fa.linux.kernel
> >> Subject: RE: Cisco vpnclient prevents proper shutdown starting with 2.6.2
> >> From: Patrick Toal <ptoal@cisco.com>
> >> To: linux-kernel@vger.kernel.org
> >> Date: Mon, 23 Feb 2004 01:36:17 GMT
> >> 
> >> Sid Boyce wrote:
> >> > I tried using this client with up to 2.6.1-mm5 and ended up with Dead
> >> > processes for cvpnd and vpnclient, nothing else was affected, went
> >> > back to 2.4.x kernel.
> >> > Regards
> >> > Sid
> >> 
> >> Sid, et al. 
> >> 
> >> First, before anyone starts deluging me with questions, you should know
> >> that even though my details say Cisco, I am an SE in the field, _not_ a
> >> developer.  Second, please reply to me off-list, as I do not subscribe
> >> to the LK list.  
> >> 
> >> That being said, I think I've tracked this down to a recent change in
> >> the net/core/dev.c file.  I reversed the patch to
> >> register_netdevice_notifier below, and the vpnclient now works fine. 
> >> This is called by the handle_vpnup routine in interceptor.c of the
> >> vpnclient kernel module.
> >> 
> >> I am _not_ a kernel developer, nor do I spend the majority of my time
> >> programming, so I haven't been able to figure out _why_ these changes
> >> cause the module to freeze.  I'd be interested if anyone could tell me
> >> the answer to that question. :-)
> >> 
> >> Regards,
> >> Patrick
> >> 
> 
> <snip>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Eugene TEO -  <eugeneteo%null!cc!uic!edu> <http://www.anomalistic.org/>
1024D/14A0DDE5 print D851 4574 E357 469C D308  A01E 7321 A38A 14A0 DDE5
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

