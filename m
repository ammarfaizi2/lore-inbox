Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbUDRSvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 14:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUDRSvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 14:51:12 -0400
Received: from tag.witbe.net ([81.88.96.48]:38410 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S263801AbUDRSvG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 14:51:06 -0400
Message-Id: <200404181851.i3IIp1107295@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Stephen Hemminger'" <shemminger@osdl.org>,
       "'David S. Miller'" <davem@redhat.com>
Cc: "'Paul Rolland'" <rol@witbe.net>, <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: RE: [2.6.5] Bad scheduling while atomic
Date: Sun, 18 Apr 2004 20:50:55 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQj8N4vTSnSCAKNT3W50Gg+qBW/wgAAdfUg
In-Reply-To: <20040416131633.1bfbfa4c@dell_ss3.pdx.osdl.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen for being so fast !

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 

  

> -----Message d'origine-----
> De : linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] De la part de 
> Stephen Hemminger
> Envoyé : vendredi 16 avril 2004 22:17
> À : David S. Miller
> Cc : Paul Rolland; linux-kernel@vger.kernel.org; netdev@oss.sgi.com
> Objet : Re: [2.6.5] Bad scheduling while atomic
> 
> Bring up/down network devices with lapbether causes scheduling while
> atomic (if preempt enabled).
> 
> The calls to rcu_read_lock are unnecessary since lapb_device_event 
> is called from notifier with the rtnetlink semaphore held, it is
> already protected from the labp_devices list changing.
> 
> Patch against 2.6.6-rc1
> 
> diff -Nru a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> --- a/drivers/net/wan/lapbether.c	Fri Apr 16 11:00:35 2004
> +++ b/drivers/net/wan/lapbether.c	Fri Apr 16 11:00:35 2004
> @@ -392,6 +392,8 @@
>  
>  /*
>   *	Handle device status changes.
> + *
> + * Called from notifier with RTNL held.
>   */
>  static int lapbeth_device_event(struct notifier_block *this,
>  				unsigned long event, void *ptr)
> @@ -402,7 +404,6 @@
>  	if (!dev_is_ethdev(dev))
>  		return NOTIFY_DONE;
>  
> -	rcu_read_lock();
>  	switch (event) {
>  	case NETDEV_UP:
>  		/* New ethernet device -> new LAPB interface	 */
> @@ -422,7 +423,6 @@
>  			lapbeth_free_device(lapbeth);
>  		break;
>  	}
> -	rcu_read_unlock();
>  
>  	return NOTIFY_DONE;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


