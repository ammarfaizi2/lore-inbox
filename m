Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTINABV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 20:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbTINABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 20:01:21 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:59041 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262263AbTINABS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 20:01:18 -0400
Date: Sat, 13 Sep 2003 19:55:18 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
Message-ID: <20030913195518.GB13402@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Ranjeet Shetye <ranjeet.shetye2@zultys.com>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>,
	Jaroslav Kysela <perex@suse.cz>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com> <20030910154608.14ad0ac8.akpm@osdl.org> <1063239544.1328.22.camel@ranjeet-pc2.zultys.com> <20030911002404.GA7178@kroah.com> <1063240611.1327.37.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063240611.1327.37.camel@ranjeet-pc2.zultys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 05:36:51PM -0700, Ranjeet Shetye wrote:
> On Wed, 2003-09-10 at 17:24, Greg KH wrote:
> > On Wed, Sep 10, 2003 at 05:19:05PM -0700, Ranjeet Shetye wrote:
> > > 
> > > Your changes fixed the issue. Thanks a lot for your help. I still get
> > > this call trace, but no more OOPS on bootup.
> > > 
> > > kobject_register failed for Ensoniq AudioPCI (-17)
> > > Call Trace:
> > >  [<c026f45c>] kobject_register+0x50/0x59
> > >  [<c02f8003>] bus_add_driver+0x4c/0xaf
> > >  [<c02f8453>] driver_register+0x31/0x35
> > >  [<c027c3bf>] pci_populate_driver_dir+0x29/0x2b
> > >  [<c027c491>] pci_register_driver+0x5e/0x83
> > >  [<c06a145f>] alsa_card_ens137x_init+0x15/0x41
> > >  [<c068475a>] do_initcalls+0x2a/0x97
> > >  [<c012e920>] init_workqueues+0x12/0x2a
> > >  [<c01050a3>] init+0x39/0x196
> > >  [<c010506a>] init+0x0/0x196
> > >  [<c0108f31>] kernel_thread_helper+0x5/0xb
> > 
> > Odds are that the pci driver is trying to register 2 drivers with the
> > pci core with the same name.  What does /sys/bus/pci/drivers show?
> > 
> > thanks,
> > 
> > greg k-h

Hi Ranjeet,

I noticed this in your .config included in your previous message.

>CONFIG_SND_ENS1370=y
>CONFIG_SND_ENS1371=y

I think the conflict might be occuring between these two drivers.
Look at sound/pci/ens1371.c and sound/pci/ens1370.c.

Out of curiosity, could you try this patch without making any changes to
your config.  If it works properly, could you then verify it in sysfs.

--- a/sound/pci/ens1370.c	2003-09-13 19:28:45.000000000 +0000
+++ b/sound/pci/ens1370.c	2003-09-13 19:30:02.000000000 +0000
@@ -2354,7 +2354,11 @@
 }

 static struct pci_driver driver = {
-	.name = "Ensoniq AudioPCI",
+#ifdef CHIP1371
+	.name = "Ensoniq 1371",
+#else
+	.name = "Ensoniq 1370",
+#endif
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),


Thanks,
Adam
