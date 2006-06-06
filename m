Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750719AbWFFBlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWFFBlV (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 21:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWFFBlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 21:41:21 -0400
Received: from xenotime.net ([66.160.160.81]:32973 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750719AbWFFBlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 21:41:20 -0400
Date: Mon, 5 Jun 2006 18:44:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, paulkf@microgate.com,
        zippel@linux-m68k.org
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060605184407.230bcf73.rdunlap@xenotime.net>
In-Reply-To: <20060605230248.GE3963@redhat.com>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 19:02:48 -0400 Dave Jones wrote:

> On Sat, Jun 03, 2006 at 11:20:04PM -0700, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
> 
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol alloc_hdlcdev
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_close
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_set_carrier
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol register_hdlc_device
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_open
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol hdlc_ioctl
> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/synclink_cs.ko needs unknown symbol unregister_hdlc_device
> 
> (19:02:21:root@northwood:mm3)# grep SYNCLINK .config
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

Those Kconfig + Makefiles are quite ugly to me.  I would rather see
SYNCLINK depend on HDLC rather than using some tricks to SELECT HDLC.
And then it selects HDLC (and HDLC depends on WAN), but (in my case)
WAN was not enabled, and doing "SELECT HDLC" did not enable WAN.

Adding SELECT WAN and changing the hdlc (wan) Makefile to use
obj-m or obj-y (it was ONLY obj-y for hdlc) fixes^W makes it build
with no missing symbols.  However, I'll also see about a fix
that uses "depends on HDLC" instead of "selects HDLC".

---
From: Randy Dunlap <rdunlap@xenotime.net>

Fix many missing hdlc_generic symbols when CONFIG_HDLC=m.
When Selecting HDLC, also Select WAN.
Fix Makefile to build for HDLC=y or HDLC=m.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/Kconfig     |    3 +++
 drivers/net/wan/Makefile |    8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- linux-2617-rc5mm3.orig/drivers/net/wan/Makefile
+++ linux-2617-rc5mm3/drivers/net/wan/Makefile
@@ -9,14 +9,18 @@ cyclomx-y                       := cycx_
 cyclomx-$(CONFIG_CYCLOMX_X25)	+= cycx_x25.o
 cyclomx-objs			:= $(cyclomx-y)  
 
-hdlc-y				:= hdlc_generic.o
+hdlc-$(CONFIG_HDLC)		:= hdlc_generic.o
 hdlc-$(CONFIG_HDLC_RAW)		+= hdlc_raw.o
 hdlc-$(CONFIG_HDLC_RAW_ETH)	+= hdlc_raw_eth.o
 hdlc-$(CONFIG_HDLC_CISCO)	+= hdlc_cisco.o
 hdlc-$(CONFIG_HDLC_FR)		+= hdlc_fr.o
 hdlc-$(CONFIG_HDLC_PPP)		+= hdlc_ppp.o
 hdlc-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
-hdlc-objs			:= $(hdlc-y)
+ifeq ($(CONFIG_HDLC),y)
+  hdlc-objs			:= $(hdlc-y)
+else
+  hdlc-objs			:= $(hdlc-m)
+endif
 
 pc300-y				:= pc300_drv.o
 pc300-$(CONFIG_PC300_MLPPP)	+= pc300_tty.o
--- linux-2617-rc5mm3.orig/drivers/char/Kconfig
+++ linux-2617-rc5mm3/drivers/char/Kconfig
@@ -197,6 +197,7 @@ config ISI
 config SYNCLINK
 	tristate "SyncLink PCI/ISA support"
 	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
+	select WAN if SYNCLINK_HDLC
 	select HDLC if SYNCLINK_HDLC
 	help
 	  Driver for SyncLink ISA and PCI synchronous serial adapters.
@@ -214,6 +215,7 @@ config SYNCLINK_HDLC
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
 	depends on SERIAL_NONSTANDARD && PCI
+	select WAN if SYNCLINKMP_HDLC
 	select HDLC if SYNCLINKMP_HDLC
 	help
 	  Driver for SyncLink Multiport (2 or 4 ports) PCI synchronous serial adapter.
@@ -231,6 +233,7 @@ config SYNCLINKMP_HDLC
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
 	depends on SERIAL_NONSTANDARD && PCI
+	select WAN if SYNCLINK_GT_HDLC
 	select HDLC if SYNCLINK_GT_HDLC
 	help
 	  Support for SyncLink GT and SyncLink AC families of
