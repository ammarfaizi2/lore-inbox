Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWAKXAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWAKXAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWAKXAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:00:41 -0500
Received: from isilmar.linta.de ([213.239.214.66]:32905 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932500AbWAKXAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:00:40 -0500
Date: Thu, 12 Jan 2006 00:00:39 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm3
Message-ID: <20060111230039.GB4541@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20060111042135.24faf878.akpm@osdl.org> <43C54FB9.9080906@ens-lyon.org> <20060111184012.GA19604@isilmar.linta.de> <43C55761.1090106@ens-lyon.org> <20060111195553.GA15739@isilmar.linta.de> <43C56A6C.8020707@ens-lyon.org> <20060111212135.GA32021@isilmar.linta.de> <43C58B02.6010601@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C58B02.6010601@ens-lyon.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 05:47:30PM -0500, Brice Goglin wrote:
> Dominik Brodowski wrote:
> 
> >Exactly. Could you pass the parameter pc_debug=9 to the "pcmcia" module,
> >please, and send me the resulting dmesg? I can't reproduce it here,
> >unfortunately...
> >  
> >
> Here you are (I had to enable CONFIG_PCMCIA_DEBUG).

Many thanks... Could you try out this patch instead of the other one,
please? get_pcmcia_device() seems to be the buggiest function I've ever
written, sorry about that...

Thanks,
	Dominik

diff --git a/drivers/pcmcia/pcmcia_ioctl.c b/drivers/pcmcia/pcmcia_ioctl.c
index c4f7dfb..be08bc9 100644
--- a/drivers/pcmcia/pcmcia_ioctl.c
+++ b/drivers/pcmcia/pcmcia_ioctl.c
@@ -69,25 +69,26 @@ extern int ds_pc_debug;
 #define ds_dbg(lvl, fmt, arg...) do { } while (0)
 #endif
 
-static struct pcmcia_device * get_pcmcia_device (struct pcmcia_socket *s,
-						 unsigned int function)
+static struct pcmcia_device *get_pcmcia_device(struct pcmcia_socket *s,
+						unsigned int function)
 {
 	struct pcmcia_device *p_dev = NULL;
-
 	unsigned long flags;
+
 	spin_lock_irqsave(&pcmcia_dev_list_lock, flags);
-        list_for_each_entry(p_dev, &s->devices_list, socket_device_list) {
+	list_for_each_entry(p_dev, &s->devices_list, socket_device_list) {
 		if (p_dev->func == function) {
-			p_dev = pcmcia_get_dev(p_dev);
-			break;
+			spin_unlock_irqrestore(&pcmcia_dev_list_lock, flags);
+			return pcmcia_get_dev(p_dev);
 		}
 	}
-	return p_dev;
+	spin_unlock_irqrestore(&pcmcia_dev_list_lock, flags);
+	return NULL;
 }
 
 /* backwards-compatible accessing of driver --- by name! */
 
-static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info)
+static struct pcmcia_driver *get_pcmcia_driver(dev_info_t *dev_info)
 {
 	struct device_driver *drv;
 	struct pcmcia_driver *p_drv;
@@ -625,15 +626,15 @@ static int ds_ioctl(struct inode * inode
 	ret = pccard_reset_card(s);
 	break;
     case DS_GET_STATUS:
-	if (buf->status.Function &&
-	   (buf->status.Function >= s->functions))
-	    ret = CS_BAD_ARGS;
-	else {
-	    struct pcmcia_device *p_dev = get_pcmcia_device(s, buf->status.Function);
-	    ret = pccard_get_status(s, p_dev, &buf->status);
-	    pcmcia_put_dev(p_dev);
-	}
-	break;
+	    if (buf->status.Function &&
+		(buf->status.Function >= s->functions))
+		    ret = CS_BAD_ARGS;
+	    else {
+		    struct pcmcia_device *p_dev = get_pcmcia_device(s, buf->status.Function);
+		    ret = pccard_get_status(s, p_dev, &buf->status);
+		    pcmcia_put_dev(p_dev);
+	    }
+	    break;
     case DS_VALIDATE_CIS:
 	mutex_lock(&s->skt_mutex);
 	pcmcia_validate_mem(s);
