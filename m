Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932952AbWJIPoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932952AbWJIPoX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932954AbWJIPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:44:23 -0400
Received: from xenotime.net ([66.160.160.81]:48520 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932952AbWJIPoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:44:22 -0400
Date: Mon, 9 Oct 2006 08:45:45 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: akinobu.mita@gmail.com (Akinobu Mita)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       "Digi International, Inc" <Eng.Linux@digi.com>
Subject: Re: [PATCH] epca: privent from panic on tty_register_driver()
 failure
Message-Id: <20061009084545.c64daf6c.rdunlap@xenotime.net>
In-Reply-To: <20061009090603.GA6278@localhost>
References: <20061009090603.GA6278@localhost>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 18:06:03 +0900 Akinobu Mita wrote:

> This patch makes epca fail on initialization failure instead of panic.
> 
> Cc: "Digi International, Inc" <Eng.Linux@digi.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
>  drivers/char/epca.c |   32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> Index: work-fault-inject/drivers/char/epca.c
> ===================================================================
> --- work-fault-inject.orig/drivers/char/epca.c	2006-10-09 15:06:32.000000000 +0900
> +++ work-fault-inject/drivers/char/epca.c	2006-10-09 15:09:14.000000000 +0900
> @@ -1160,6 +1160,7 @@ static int __init pc_init(void)
>  	int crd;
>  	struct board_info *bd;
>  	unsigned char board_id = 0;
> +	int err = -ENOMEM;
>  
>  	int pci_boards_found, pci_count;
>  
> @@ -1167,13 +1168,11 @@ static int __init pc_init(void)
>  
>  	pc_driver = alloc_tty_driver(MAX_ALLOC);
>  	if (!pc_driver)
> -		return -ENOMEM;
> +		goto out1;
>  
>  	pc_info = alloc_tty_driver(MAX_ALLOC);
> -	if (!pc_info) {
> -		put_tty_driver(pc_driver);
> -		return -ENOMEM;
> -	}
> +	if (!pc_info)
> +		goto out2;

and then out2: uses pc_info, if it's NULL.  Is that OK?

>  
>  	/* -----------------------------------------------------------------------
>  		If epca_setup has not been ran by LILO set num_cards to defaults; copy
> @@ -1373,11 +1372,17 @@ static int __init pc_init(void)
>  
>  	} /* End for each card */
>  
> -	if (tty_register_driver(pc_driver))
> -		panic("Couldn't register Digi PC/ driver");
> +	err = tty_register_driver(pc_driver);
> +	if (err) {
> +		printk(KERN_ERR "Couldn't register Digi PC/ driver");
> +		goto out3;
> +	}
>  
> -	if (tty_register_driver(pc_info))
> -		panic("Couldn't register Digi PC/ info ");
> +	err = tty_register_driver(pc_info);
> +	if (err) {
> +		printk(KERN_ERR "Couldn't register Digi PC/ info ");
> +		goto out4;
> +	}
>  
>  	/* -------------------------------------------------------------------
>  	   Start up the poller to check for events on all enabled boards
> @@ -1388,6 +1393,15 @@ static int __init pc_init(void)
>  	mod_timer(&epca_timer, jiffies + HZ/25);
>  	return 0;
>  
> +out4:
> +	tty_unregister_driver(pc_driver);
> +out3:
> +	put_tty_driver(pc_driver);
> +out2:
> +	put_tty_driver(pc_info);
> +out1:
> +	return err;
> +
>  } /* End pc_init */
>  
>  /* ------------------ Begin post_fep_init  ---------------------- */
> -

---
~Randy
