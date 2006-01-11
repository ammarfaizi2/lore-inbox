Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWAKTz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWAKTz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWAKTzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:55:55 -0500
Received: from isilmar.linta.de ([213.239.214.66]:36751 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932473AbWAKTzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:55:55 -0500
Date: Wed, 11 Jan 2006 20:55:53 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3
Message-ID: <20060111195553.GA15739@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060111042135.24faf878.akpm@osdl.org> <43C54FB9.9080906@ens-lyon.org> <20060111184012.GA19604@isilmar.linta.de> <43C55761.1090106@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C55761.1090106@ens-lyon.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 11, 2006 at 02:07:13PM -0500, Brice Goglin wrote:
> >git-pcmcia . I'll look at what's broken. Thanks for reporting this.
> >  
> >
> Confirmed, works after reverting it.

Could you check whether this patch helps, please?

diff --git a/drivers/pcmcia/pcmcia_ioctl.c b/drivers/pcmcia/pcmcia_ioctl.c
index c4f7dfb..5f815bf 100644
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
 			p_dev = pcmcia_get_dev(p_dev);
 			break;
 		}
 	}
+	spin_unlock_irqrestore(&pcmcia_dev_list_lock, flags);
 	return p_dev;
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
