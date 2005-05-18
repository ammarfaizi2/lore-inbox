Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVERWrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVERWrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVERWqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:46:55 -0400
Received: from tim.rpsys.net ([194.106.48.114]:3549 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262385AbVERWpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:45:40 -0400
From: Richard Purdie <rpurdie@rpsys.net>
To: "Brice Goglin" <Brice.Goglin@ens-lyon.org>,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.12-rc4-mm2
Date: Wed, 18 May 2005 23:45:27 +0100
User-Agent: KMail/1.5.4
Cc: <linux-kernel@vger.kernel.org>
References: <20050516021302.13bd285a.akpm@osdl.org> <4289B423.7050407@ens-lyon.org> <038301c55afe$f064ad50$0f01a8c0@max>
In-Reply-To: <038301c55afe$f064ad50$0f01a8c0@max>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505182345.27605.rpurdie@rpsys.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 5:38 pm, Richard Purdie wrote:
> Brice Goglin:
> > Cardmgr does not automatically start my pcmcia wireless card anymore.
> > orinoco modules are not loaded at all.
> > I still can modprobe orinoco_cs to get my wireless to work.
> >
> > Cardmgr says this when starting:
> > cardmgr[27367]: no pcmcia driver in /proc/devices
> >
> > Is this a feature related to the upcoming deprecation of cardctl ?
> > Am I supposed to use pcmcia-utils ?
>
> I also see the above message on the arm pxa zaurus with -mm2. I'm still
> using pcmcia-cs rather than pcmcia-utils. pcmcia+cardmgr works fine in
> -mm1. I'm also not sure if this is by design or not...

I found the problem. The pcmcia-move-pcmcia-ioctl-to-a-separate-file patch was 
corrupted in -mm2 causing this problem. The fix is below.

Richard

--- linux-2.6.11.orig/drivers/pcmcia/ds.c	2005-05-18 23:27:43.000000000 +0100
+++ linux-2.6.11/drivers/pcmcia/ds.c	2005-05-17 17:13:50.000000000 +0100
@@ -1199,6 +1199,9 @@
 
 	bus_register(&pcmcia_bus_type);
 	class_interface_register(&pcmcia_bus_interface);
+
+	pcmcia_setup_ioctl();
+
 	return 0;
 }
 fs_initcall(init_pcmcia_bus); /* one level after subsys_initcall so that 
@@ -1212,7 +1215,6 @@
 	class_interface_unregister(&pcmcia_bus_interface);
 
 	bus_unregister(&pcmcia_bus_type);
- 	pcmcia_setup_ioctl();
 }
 module_exit(exit_pcmcia_bus);

