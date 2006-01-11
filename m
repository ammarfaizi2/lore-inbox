Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWAKU2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWAKU2j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWAKU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:28:39 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:17145 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S964815AbWAKU2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:28:39 -0500
Message-ID: <43C56A6C.8020707@ens-lyon.org>
Date: Wed, 11 Jan 2006 15:28:28 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org> <43C54FB9.9080906@ens-lyon.org> <20060111184012.GA19604@isilmar.linta.de> <43C55761.1090106@ens-lyon.org> <20060111195553.GA15739@isilmar.linta.de>
In-Reply-To: <20060111195553.GA15739@isilmar.linta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:

>Could you check whether this patch helps, please?
>
>  
>
No, sorry, it does not fix it.
This patch is actually only white spaces cleanups and the addition of a
spin_lock_irqrestore, right ?

Brice



>diff --git a/drivers/pcmcia/pcmcia_ioctl.c b/drivers/pcmcia/pcmcia_ioctl.c
>index c4f7dfb..5f815bf 100644
>--- a/drivers/pcmcia/pcmcia_ioctl.c
>+++ b/drivers/pcmcia/pcmcia_ioctl.c
>@@ -69,25 +69,26 @@ extern int ds_pc_debug;
> #define ds_dbg(lvl, fmt, arg...) do { } while (0)
> #endif
> 
>-static struct pcmcia_device * get_pcmcia_device (struct pcmcia_socket *s,
>-						 unsigned int function)
>+static struct pcmcia_device *get_pcmcia_device(struct pcmcia_socket *s,
>+						unsigned int function)
> {
> 	struct pcmcia_device *p_dev = NULL;
>-
> 	unsigned long flags;
>+
> 	spin_lock_irqsave(&pcmcia_dev_list_lock, flags);
>-        list_for_each_entry(p_dev, &s->devices_list, socket_device_list) {
>+	list_for_each_entry(p_dev, &s->devices_list, socket_device_list) {
> 		if (p_dev->func == function) {
> 			p_dev = pcmcia_get_dev(p_dev);
> 			break;
> 		}
> 	}
>+	spin_unlock_irqrestore(&pcmcia_dev_list_lock, flags);
> 	return p_dev;
> }
> 
> /* backwards-compatible accessing of driver --- by name! */
> 
>-static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info)
>+static struct pcmcia_driver *get_pcmcia_driver(dev_info_t *dev_info)
> {
> 	struct device_driver *drv;
> 	struct pcmcia_driver *p_drv;
>@@ -625,15 +626,15 @@ static int ds_ioctl(struct inode * inode
> 	ret = pccard_reset_card(s);
> 	break;
>     case DS_GET_STATUS:
>-	if (buf->status.Function &&
>-	   (buf->status.Function >= s->functions))
>-	    ret = CS_BAD_ARGS;
>-	else {
>-	    struct pcmcia_device *p_dev = get_pcmcia_device(s, buf->status.Function);
>-	    ret = pccard_get_status(s, p_dev, &buf->status);
>-	    pcmcia_put_dev(p_dev);
>-	}
>-	break;
>+	    if (buf->status.Function &&
>+		(buf->status.Function >= s->functions))
>+		    ret = CS_BAD_ARGS;
>+	    else {
>+		    struct pcmcia_device *p_dev = get_pcmcia_device(s, buf->status.Function);
>+		    ret = pccard_get_status(s, p_dev, &buf->status);
>+		    pcmcia_put_dev(p_dev);
>+	    }
>+	    break;
>     case DS_VALIDATE_CIS:
> 	mutex_lock(&s->skt_mutex);
> 	pcmcia_validate_mem(s);
>  
>

