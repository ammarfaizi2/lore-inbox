Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132449AbRCZOak>; Mon, 26 Mar 2001 09:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132450AbRCZOaa>; Mon, 26 Mar 2001 09:30:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:57578 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132449AbRCZOaT>;
	Mon, 26 Mar 2001 09:30:19 -0500
Message-ID: <3ABF5251.60EFC4C1@mandrakesoft.com>
Date: Mon, 26 Mar 2001 09:29:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Jacobberger <f1j@xmission.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Fix net driver load problems
In-Reply-To: <3ABF4D3D.2070401@xmission.com>
Content-Type: multipart/mixed;
 boundary="------------B7A1762D8737A0FE08B88A7E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B7A1762D8737A0FE08B88A7E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Frank Jacobberger wrote:
> 
> Something has changed regarding the 8139too driver in pre8.
> 
> I worked on it all morning long trying to resolve why the sucker
> failed to load. There are new configuration options that need to
> be addressed. As you recall there were zippo options in the pre7.
> 
> There are now:
> 
> RealTek RTL-8139 PCI Fast Ethernet Adapter support      [M]
>   Use PIO instead of MMIO
>       [*]

Note by selecting this, you must made your driver slower.  Did you read
the help for the option?

>   Support for automatic channel equalization (EXPERIMENTAL)   [ ]
>   Support for older RTL-8129/8130 boards                            [*]

By selecting this you made your driver bigger, probably for no reason..

> Doing any combination of the above netted no positive result here.
> 
> I have run every kernel patch since 2.4.0 blah and
> have never seen this driver fail to load or perform to some degree.
> 
> Trying to do insmod 8139too.o from the :
> /lib/modules/2.4.3-pre8/kernel/drivers/net directory show these
> unresolved symbols:
> 
> 8139too.o: unresolved symbol alloc_etherdev
> 8139too.o: unresolved symbol unregister_netdev
> 8139too.o: unresolved symbol register_netdev
> 
> Maybe Jeff can shed more light on these changes....

After staring hard at my source, I ran another diff and found that
net_init is not listed in export-objs.  Oh well, it's better to compile
stuff into your kernel anyway ;-) ;-)

Attached is a patch which fixes things.

	Jeff


-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------B7A1762D8737A0FE08B88A7E
Content-Type: text/plain; charset=us-ascii;
 name="makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="makefile.patch"

Index: drivers/net/Makefile
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/net/Makefile,v
retrieving revision 1.1.1.32
retrieving revision 1.1.1.32.2.1
diff -u -r1.1.1.32 -r1.1.1.32.2.1
--- drivers/net/Makefile	2001/03/26 04:48:45	1.1.1.32
+++ drivers/net/Makefile	2001/03/26 05:29:41	1.1.1.32.2.1
@@ -15,8 +15,9 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o ppp_async.o \
-			ppp_generic.o slhc.o pppox.o auto_irq.o
+export-objs     :=	8390.o arlan.o aironet4500_core.o aironet4500_card.o \
+			ppp_async.o ppp_generic.o slhc.o pppox.o auto_irq.o \
+			net_init.o
 
 ifeq ($(CONFIG_TULIP),y)
   obj-y += tulip/tulip.o

--------------B7A1762D8737A0FE08B88A7E--

