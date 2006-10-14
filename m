Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752073AbWJNF0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbWJNF0A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWJNF0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:26:00 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:9369 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752073AbWJNFZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:25:59 -0400
Date: Fri, 13 Oct 2006 22:23:11 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       v4l-dvb-maintainer@linuxtv.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [v4l-dvb-maintainer] 2.6.19-rc1: DVB frontend selection causes
 compile errors
Message-Id: <20061013222311.6d2b6b74.randy.dunlap@oracle.com>
In-Reply-To: <452A07EE.9020303@linuxtv.org>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<20061009003146.GA3172@stusta.de>
	<4529FFDC.5080708@linuxtv.org>
	<20061009080542.GE3172@stusta.de>
	<452A07EE.9020303@linuxtv.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2006 04:27:26 -0400 Michael Krufky wrote:

> Adrian Bunk wrote:
> > On Mon, Oct 09, 2006 at 03:53:00AM -0400, Michael Krufky wrote:
> >> Adrian Bunk wrote:
> >>> The DVB frontend selection changes in 2.6.19-rc1 are giving me the 
> >>> following compile error:
> >>>
> >>> <--  snip  -->
> >>>
> >>> ...
> >>>   LD      .tmp_vmlinux1
> >>> drivers/built-in.o: In function `dvb_init':
> >>> saa7134-dvb.c:(.text+0x91d94): undefined reference to `tda10086_attach'
> >>> saa7134-dvb.c:(.text+0x91db0): undefined reference to `tda826x_attach'
> >>> make: *** [.tmp_vmlinux1] Error 1
> >>>
> >>> <--  snip  -->
> >>>
> >>> .config attached.
> >>>
> >>> cu
> >>> Adrian
> >>
> >> Adrian,
> > 
> > Hi Michael,
> > 
> >> Does this fix it for you?
> > 
> > it does fix it with my .config, but
> > 
> >> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> >>
> >> diff -r 7efa405e2d66 linux/drivers/media/dvb/frontends/tda10086.h
> >> --- a/drivers/media/dvb/frontends/tda10086.h	Fri Oct 06 17:12:00 2006 -0300
> >> +++ b/drivers/media/dvb/frontends/tda10086.h	Mon Oct 09 03:43:28 2006 -0400
> >> @@ -35,7 +35,16 @@ struct tda10086_config
> >>  	u8 invert;
> >>  };
> >>  
> >> +#if defined(CONFIG_DVB_TDA10086) || defined(CONFIG_DVB_TDA10086_MODULE)
> >>  extern struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
> >>  					    struct i2c_adapter* i2c);
> >> +#else
> >> +static inline struct dvb_frontend* tda10086_attach(const struct tda10086_config* config,
> >> +						   struct i2c_adapter* i2c)
> >> +{
> >> +	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
> >> +	return NULL;
> >> +}
> >> +#endif // CONFIG_DVB_TDA10086
> >> ...
> > 
> > this breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA1004X=m.
> > 
> > #if defined(CONFIG_DVB_TDA10086) || (defined(CONFIG_DVB_TDA10086_MODULE) && defined(MODULE))
> > might work, but the whole manual frontend selection IMHO looks a bit 
> > fragile.
> > 
> > cu
> > Adrian
> > 
> 
> That's never going to work --  If the card driver is build as y, then the frontend must also be built y...

Where is the connection between the card driver and the frontend(s)?
Is it in card driver source files or frontend source files
or in Kconfig files?  I looked but didn't see it (in Kconfig).

> Andrew, we need some Kconfig logic to prevent that case described by Adrian, above.


There seems to be a good bit on dependence between the Multimedia devices
menu and DVB/frontends menus.. without having much Kconfig language
dependence info there.  Maybe I'm wrong.  I hope so.


---
~Randy
