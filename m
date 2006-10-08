Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWJHJH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWJHJH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWJHJH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:07:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21395 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750964AbWJHJHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:07:25 -0400
Date: Sun, 8 Oct 2006 02:07:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wink Saville <wink@saville.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Matthias Hentges <oe@hentges.net>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Hang in fb_notifier_call_chain with nvidia framebuffer
Message-Id: <20061008020711.1e7b77c4.akpm@osdl.org>
In-Reply-To: <4528B377.2050104@saville.com>
References: <45206777.7020405@saville.com>
	<1159808447.4652.6.camel@mhcln03>
	<4521E326.2000406@saville.com>
	<1159882225.2891.525.camel@laptopd505.fenrus.org>
	<4523E09C.9000609@saville.com>
	<20061007230129.323ac807.akpm@osdl.org>
	<4528B377.2050104@saville.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Oct 2006 01:14:47 -0700
Wink Saville <wink@saville.com> wrote:

> Andrew Morton wrote:
> > On Wed, 04 Oct 2006 09:26:04 -0700
> > Wink Saville <wink@saville.com> wrote:
> > 
> >> Attached in the zip file is:
> >>
> >> log-hang1.txt	-> log showing hang
> >> cfg-hang1	-> config file for hang condition
> >> cfg-ok		-> config file that works
> >> fbmem.c		-> Modifications to register_framebuffer
> >>
> >> To possibly assist I turned on debugging in nvidia.c and found that it 
> >> hung in the call to register_framebuffer. I then added some additional 
> >> debug in that routine and it appears the hang occurs in the call to 
> >> fb_notifier_call_chain.
> >>
> >> Please let me know what else maybe needed.
> > 
> > Please:
> > 
> > - get sysrq working:
> > 
> > 	set CONFIG_MAGIC_SYSRQ=y, rebuild, reboot
> > 	echo 1 > /proc/sys/kernel/sysrq
> > 	dmesg -n 8
> > 
> > - make it hang
> > 
> > - Hit alt-sysrq-T
> > 
> > - Send us the resulting output
> > 
> > Thanks.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Andrew,
> 
> Thank you for the reply, I believe I've found the reason frame buffer doesn't
> work on my system, there is a divide by zero occurring at line 157 of
> nvGetClocks in ./drivers/video/nvidia/nv_hw.c.
> 
> (Note: The screwy output below is due to hacking drivers/serial/8250.c to add two
> routines serial_putchar and serial_putchars so that I could make progress looking
> for the bug, as printk stopped working at acquire_console_sem called from bind_con_driver.)
> 
> Last portion of the output:
> 
> @[   97.643286] take_over_console: call bind_con_driver csw=ffffffff805d8600 first=0, last=62, deflt=1
> @[   97.652521] bind_con_driver: E
> @[   97.655774] bind_con_driver: acquire_console_sem
> @1[   97.660604] acquire_console_sem: drivers/char/vt.c:bind_con_driver:2752
> @!2345689abABCDEF<fb_con_init>abcdefghij<nvidiafb_set_par>abcd<nvidia_calc_regs>bdjkl<NVCalcStateExt>acei<nv30UpdateArbitrationSettings>a<nv
> GetClocks>N=83 NB=0 freq=27000 M=3 MB=0 P=0
> 
> >From the above output we see MB=0 and hence death at line 157:
> 
> *MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;
> 
> It would seem that my hardware (7600 GT K0) is not supported by the driver?
> It should also be noted that there are quite a number of divisions
> in the nv_hw.c that have no protection against divide by zeros.

OK.  Does the below reversion fix it?

It's a bit sad that printk doesn't work inside console_sem.  It's hard to
avoid, really.  I suppose we could cheat and let the message through if
oops_in_progress is set.  But the fbcon layer is obviously doing too much
stuff inside that lock.



From: Andrew Morton <akpm@osdl.org>

Olaf reports that this gave him a black screen.

Cc: Olaf Hering <olaf@aepfle.de>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/Kconfig         |    1 
 drivers/video/nvidia/nv_i2c.c |   43 ++++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 3 deletions(-)

diff -puN drivers/video/Kconfig~revert-nvidiafb-use-generic-ddc-reading drivers/video/Kconfig
--- a/drivers/video/Kconfig~revert-nvidiafb-use-generic-ddc-reading
+++ a/drivers/video/Kconfig
@@ -701,7 +701,6 @@ config FB_NVIDIA
 	depends on FB && PCI
 	select I2C_ALGOBIT if FB_NVIDIA_I2C
 	select I2C if FB_NVIDIA_I2C
-	select FB_DDC if FB_NVIDIA_I2C
 	select FB_MODE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff -puN drivers/video/nvidia/nv_i2c.c~revert-nvidiafb-use-generic-ddc-reading drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c~revert-nvidiafb-use-generic-ddc-reading
+++ a/drivers/video/nvidia/nv_i2c.c
@@ -160,12 +160,51 @@ void nvidia_delete_i2c_busses(struct nvi
 
 }
 
+static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
+{
+	u8 start = 0x0;
+	struct i2c_msg msgs[] = {
+		{
+		 .addr = 0x50,
+		 .len = 1,
+		 .buf = &start,
+		 }, {
+		     .addr = 0x50,
+		     .flags = I2C_M_RD,
+		     .len = EDID_LENGTH,
+		     },
+	};
+	u8 *buf;
+
+	if (!chan->par)
+		return NULL;
+
+	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+	if (!buf) {
+		dev_warn(&chan->par->pci_dev->dev, "Out of memory!\n");
+		return NULL;
+	}
+	msgs[1].buf = buf;
+
+	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
+		return buf;
+	dev_dbg(&chan->par->pci_dev->dev, "Unable to read EDID block.\n");
+	kfree(buf);
+	return NULL;
+}
+
 int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
 {
 	struct nvidia_par *par = info->par;
-	u8 *edid;
+	u8 *edid = NULL;
+	int i;
 
-	edid = fb_ddc_read(&par->chan[conn - 1].adapter);
+	for (i = 0; i < 3; i++) {
+		/* Do the real work */
+		edid = nvidia_do_probe_i2c_edid(&par->chan[conn - 1]);
+		if (edid)
+			break;
+	}
 
 	if (!edid && conn == 1) {
 		/* try to get from firmware */
_

