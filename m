Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVBEAso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVBEAso (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbVBEAso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:48:44 -0500
Received: from EASTCAMPUS-THREE-FORTY-FOUR.MIT.EDU ([18.248.6.89]:7043 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266327AbVBEAsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:48:08 -0500
Date: Fri, 4 Feb 2005 19:43:11 -0500
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] ns558 bug
Message-ID: <20050205004311.GA7998@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	matthieu castet <castet.matthieu@free.fr>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <4203D476.4040706@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4203D476.4040706@free.fr>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 09:00:54PM +0100, matthieu castet wrote:
> Hi,
> 
> this patch is based on http://bugzilla.kernel.org/show_bug.cgi?id=2962 
> patch from adam belay.
> 
> It solve a oops when pnp_register_driver(&ns558_pnp_driver) failed.
> 
> Please apply this patch.
> 
> Matthieu

I remember writing a version of this patch a while ago.  The current behavior
is broken because it shouldn't be considered a failure if the driver doesn't
find any devices.

Thanks,
Adam


> Index: drivers/input/gameport/ns558.c
> ===================================================================
> RCS file: /home/mat/dev/linux-cvs-rep/linux-cvs/drivers/input/gameport/ns558.c,v
> retrieving revision 1.15
> diff -u -u -r1.15 ns558.c
> --- drivers/input/gameport/ns558.c	16 Sep 2004 14:04:04 -0000	1.15
> +++ drivers/input/gameport/ns558.c	4 Feb 2005 19:53:20 -0000
> @@ -261,6 +261,8 @@
>  
>  #endif
>  
> +static int registered = 0;
> +
>  int __init ns558_init(void)
>  {
>  	int i = 0;
> @@ -272,8 +274,10 @@
>  	while (ns558_isa_portlist[i])
>  		ns558_isa_probe(ns558_isa_portlist[i++]);
>  
> -	pnp_register_driver(&ns558_pnp_driver);
> -	return list_empty(&ns558_list) ? -ENODEV : 0;
> +	if (pnp_register_driver(&ns558_pnp_driver) >= 0) 
> +		registered = 1;
> +
> +	return (list_empty(&ns558_list) && !registered) ? -ENODEV : 0;
>  }
>  
>  void __exit ns558_exit(void)
> @@ -297,7 +301,8 @@
>  				break;
>  		}
>  	}
> -	pnp_unregister_driver(&ns558_pnp_driver);
> +	if (registered)
> +		pnp_unregister_driver(&ns558_pnp_driver);
>  }
>  
>  module_init(ns558_init);

