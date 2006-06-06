Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWFFVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWFFVFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWFFVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:05:39 -0400
Received: from xenotime.net ([66.160.160.81]:8380 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751100AbWFFVFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:05:38 -0400
Date: Tue, 6 Jun 2006 14:08:22 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: khc@pm.waw.pl, paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
Message-Id: <20060606140822.c6f4ef37.rdunlap@xenotime.net>
In-Reply-To: <20060606134816.363cbeca.rdunlap@xenotime.net>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain>
	<20060606134816.363cbeca.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2006 13:48:16 -0700 Randy.Dunlap wrote:

> On Tue, 06 Jun 2006 22:27:40 +0200 Krzysztof Halasa wrote:
> 
> > Paul Fulghum <paulkf@microgate.com> writes:
> > 
> > > +++ b/drivers/net/wan/Makefile	2006-06-06 14:08:53.000000000 -0500
> > > @@ -9,14 +9,18 @@ cyclomx-y                       := cycx_
> > >  cyclomx-$(CONFIG_CYCLOMX_X25)	+= cycx_x25.o
> > >  cyclomx-objs			:= $(cyclomx-y)  
> > >  
> > > -hdlc-y				:= hdlc_generic.o
> > > +hdlc-$(CONFIG_HDLC)		:= hdlc_generic.o
> > >  hdlc-$(CONFIG_HDLC_RAW)		+= hdlc_raw.o
> > >  hdlc-$(CONFIG_HDLC_RAW_ETH)	+= hdlc_raw_eth.o
> > >  hdlc-$(CONFIG_HDLC_CISCO)	+= hdlc_cisco.o
> > >  hdlc-$(CONFIG_HDLC_FR)		+= hdlc_fr.o
> > >  hdlc-$(CONFIG_HDLC_PPP)		+= hdlc_ppp.o
> > >  hdlc-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
> > > -hdlc-objs			:= $(hdlc-y)
> > > +ifeq ($(CONFIG_HDLC),y)
> > > +  hdlc-objs			:= $(hdlc-y)
> > > +else
> > > +  hdlc-objs			:= $(hdlc-m)
> > > +endif
> > 
> > How could that work? If CONFIG_HDLC=m and CONFIG_HDLC_*=y it would read:
> > 
> > hdlc-m := hdlc_generic.o
> > hdlc-y := hdlc_{raw,raw_eth,cisco,fr,ppp,x25}.o
> > hdlc-objs := $(hdlc-m)
> > 
> > CONFIG_HDLC is 3-state and CONFIG_HDLC_* are simple bools, everything
> > makes a single module.
> > 
> > Not sure what missing symbols do you experience (never had synclink
> > adapter) but almost certainly it's when generic HDLC is not selected
> > (or is 'm' while synclink is 'y') and it's not related to the Makefile
> > (i.e., while I don't exactly like the rest of the patch as I think
> > enabling gHDLC should enable hw drivers - like with other drivers -
> > it would probably work).
> 
> Hi,
> I think that the main problem is that SYNCLINK wants to be able
> to use some functions from hdlc_generic.c when
> CONFIG_HDLC=m.  How do you handle that?

Oh, using hdlc-y even for CONFIG_HDLC=m.  :)

OK, it's still not working.  As Dave Jones reported:

> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol alloc_hdlcdev
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_close
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_set_carrier
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol register_hdlc_device
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_open
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_ioctl
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol unregister_hdlc_device

with:
> CONFIG_SYNCLINK_CS=m
> CONFIG_SYNCLINK_CS_HDLC=y
> (19:02:25:root@northwood:mm3)# grep HDLC .config
> CONFIG_HDLC=m
> # CONFIG_HDLC_RAW is not set
> # CONFIG_HDLC_RAW_ETH is not set
> # CONFIG_HDLC_CISCO is not set
> # CONFIG_HDLC_FR is not set
> # CONFIG_HDLC_PPP is not set
> CONFIG_HISAX_HDLC=y
> CONFIG_SYNCLINK_CS_HDLC=y

Or enabling all SYNCLINK drivers =m with HDLC support:

WARNING: "register_hdlc_device" [drivers/char/synclinkmp.ko] undefined!
WARNING: "alloc_hdlcdev" [drivers/char/synclinkmp.ko] undefined!
WARNING: "hdlc_ioctl" [drivers/char/synclinkmp.ko] undefined!
WARNING: "hdlc_open" [drivers/char/synclinkmp.ko] undefined!
WARNING: "hdlc_close" [drivers/char/synclinkmp.ko] undefined!
WARNING: "hdlc_set_carrier" [drivers/char/synclinkmp.ko] undefined!
WARNING: "unregister_hdlc_device" [drivers/char/synclinkmp.ko] undefined!
WARNING: "register_hdlc_device" [drivers/char/synclink_gt.ko] undefined!
WARNING: "alloc_hdlcdev" [drivers/char/synclink_gt.ko] undefined!
WARNING: "hdlc_close" [drivers/char/synclink_gt.ko] undefined!
WARNING: "hdlc_open" [drivers/char/synclink_gt.ko] undefined!
WARNING: "hdlc_ioctl" [drivers/char/synclink_gt.ko] undefined!
WARNING: "hdlc_set_carrier" [drivers/char/synclink_gt.ko] undefined!
WARNING: "unregister_hdlc_device" [drivers/char/synclink_gt.ko] undefined!
WARNING: "register_hdlc_device" [drivers/char/synclink.ko] undefined!
WARNING: "alloc_hdlcdev" [drivers/char/synclink.ko] undefined!
WARNING: "hdlc_close" [drivers/char/synclink.ko] undefined!
WARNING: "hdlc_open" [drivers/char/synclink.ko] undefined!
WARNING: "hdlc_ioctl" [drivers/char/synclink.ko] undefined!
WARNING: "hdlc_set_carrier" [drivers/char/synclink.ko] undefined!
WARNING: "unregister_hdlc_device" [drivers/char/synclink.ko] undefined!
WARNING: "hdlc_close" [drivers/char/pcmcia/synclink_cs.ko] undefined!
WARNING: "hdlc_open" [drivers/char/pcmcia/synclink_cs.ko] undefined!
WARNING: "hdlc_ioctl" [drivers/char/pcmcia/synclink_cs.ko] undefined!
WARNING: "hdlc_set_carrier" [drivers/char/pcmcia/synclink_cs.ko] undefined!
WARNING: "unregister_hdlc_device" [drivers/char/pcmcia/synclink_cs.ko] undefined!
WARNING: "register_hdlc_device" [drivers/char/pcmcia/synclink_cs.ko] undefined!
WARNING: "alloc_hdlcdev" [drivers/char/pcmcia/synclink_cs.ko] undefined!

with partial .config:
# CONFIG_WAN is not set
CONFIG_HDLC=m
# CONFIG_HDLC_RAW is not set
# CONFIG_HDLC_RAW_ETH is not set
# CONFIG_HDLC_CISCO is not set
# CONFIG_HDLC_FR is not set
# CONFIG_HDLC_PPP is not set
...
CONFIG_SYNCLINK=m
CONFIG_SYNCLINK_HDLC=y
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINKMP_HDLC=y
CONFIG_SYNCLINK_GT=m
CONFIG_SYNCLINK_GT_HDLC=y
CONFIG_N_HDLC=m

so the hdlc_generic code isn't available for some reason.

---
~Randy
