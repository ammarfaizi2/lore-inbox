Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSHMFRL>; Tue, 13 Aug 2002 01:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSHMFRL>; Tue, 13 Aug 2002 01:17:11 -0400
Received: from dp.samba.org ([66.70.73.150]:3546 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317365AbSHMFRK>;
	Tue, 13 Aug 2002 01:17:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] [patch, 2.4] drivers_sound_ad1848.c doesn't release region on error 
In-reply-to: Your message of "12 Aug 2002 11:14:18 +0100."
             <1029147258.16421.123.camel@irongate.swansea.linux.org.uk> 
Date: Tue, 13 Aug 2002 15:01:12 +1000
Message-Id: <20020813002128.9959C2C150@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1029147258.16421.123.camel@irongate.swansea.linux.org.uk> you write
:
> On Mon, 2002-08-12 at 04:35, Rusty Russell wrote:
> > [ Simple, and looks trivially correct from reading file. ]
> > From:  Marcus Alanen <maalanen@ra.abo.fi>
> >   
> >   Doesn't check request_region and doesn't release region on failed 
> >   kmalloc.
> 
> I don't have hardware to test this, so on the basis its not tested I'd
> say no until someone with the hardware tests it. 

Can someone with an ad1848 please test this trivial patch?  Preferably
test that loading the module the second time works fine?

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

===== drivers/sound/ad1848.c 1.8 vs edited =====
--- 1.8/drivers/sound/ad1848.c	Fri May 10 01:40:52 2002
+++ edited/drivers/sound/ad1848.c	Sun Jul 14 18:21:20 2002
@@ -1997,7 +1997,8 @@
 		sprintf(dev_name,
 			"Generic audio codec (%s)", devc->chip_name);
 
-	request_region(devc->base, 4, devc->name);
+	if (!request_region(devc->base, 4, devc->name))
+		return -1;
 
 	conf_printf2(dev_name, devc->base, devc->irq, dma_playback, dma_capture);
 
@@ -2013,8 +2014,10 @@
 	}
 
 	portc = (ad1848_port_info *) kmalloc(sizeof(ad1848_port_info), GFP_KERNEL);
-	if(portc==NULL)
+	if(portc==NULL) {
+		release_region(devc->base, 4);
 		return -1;
+	}
 
 	if ((my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
 					     dev_name,
@@ -2026,8 +2029,8 @@
 					     dma_playback,
 					     dma_capture)) < 0)
 	{
+		release_region(devc->base, 4);
 		kfree(portc);
-		portc=NULL;
 		return -1;
 	}
 	


