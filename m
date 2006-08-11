Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWHKUsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWHKUsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHKUsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:48:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62092 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932234AbWHKUsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:48:45 -0400
Date: Fri, 11 Aug 2006 16:48:03 -0400
From: Dave Jones <davej@redhat.com>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
Message-ID: <20060811204803.GJ26930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200608102318.04512.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608102318.04512.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:18:04PM +0200, Thomas Koeller wrote:
 > This is a driver used for image capturing by the Basler eXcite smart camera
 > platform. It utilizes the integrated GPI DMA engine of the MIPS RM9122
 > processor. Since this driver does not fit into one of the existing categories
 > I created a new toplevel directory for it (which may not be appropriate?).

Hi Thomas.

As others have pointed out, drivers/media/video is probably a better home.

Some speedy mostly-nitpicking comments below. I didn't give it an indepth review,
but this is stuff that jumped out at me from a quick skim.

 > + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 > + */
 > +
 > +#include <linux/config.h>

Unnecessary include (kbuild does this for you now)

 > +static unsigned long devnum_bitmap = 0;

Unneeded initialisation. (static uninitialised vars go in .bss)

 > +/* Function prototypes */
 > +static void xicap_device_release(struct class_device *);
 > +static long xicap_ioctl(struct file *, unsigned int, unsigned long);
 > +static unsigned int xicap_poll(struct file *, poll_table *);
 > +static ssize_t xicap_read(struct file *, char __user *, size_t, loff_t *);
 > +static int xicap_open(struct inode *, struct file *);
 > +static int xicap_release(struct inode *, struct file *);
 > +static int xicap_queue_buffer(xicap_device_context_t *,
 > +			      const xicap_arg_qbuf_t *);

You could lose all these forward declarations if you move
the xicap_fops after the function declarations.

 > +/* A class for xicap devices */
 > +static struct class xicap_class = {
 > +	.name		= (char *) xicap_name,

Is that cast necessary ?

 > +/* Device registration */
 > +xicap_device_context_t *
 > +xicap_device_register(struct device *dev, const xicap_hw_driver_t *hwdrv)

The typedef had me dancing around trying to find out what it was a few
times. Can we just replace it with uses of struct xicap_devctx ?
Ditto for xicap_frame_context_t

 > +	/* Set up a device context */
 > +	xicap_device_context_t * const dc =
 > +		(xicap_device_context_t *) kmalloc(sizeof *dc, GFP_KERNEL);
 > +	if (!dc) {
 > +		res = -ENOMEM;
 > +		goto ex;
 > +	}
 > +
 > +	memset(dc, 0, sizeof *dc);

You could lose the memset, and use kzalloc instead.

 > +MODULE_VERSION("0.0");

Heh, early days ? :-)

 > +++ b/drivers/xicap/xicap_gpi.c
 > ...
 > +
 > +#include <linux/config.h>

Same as above. Unneeded.

 > +#define VMAP_WORKAROUND			1

This needs a comment to explain what its doing.

 > +/*
 > + * I/O register access macros
 > + * Do not use __raw_writeq() and __raw_readq(), these do not seem to work!
 > + */
 > +#define io_writeq(__v__, __a__)	\
 > +	*(volatile unsigned long long *) (__a__) = (__v__)
 > +#define io_readq(__a__)		(*(volatile unsigned long long *) (__a__))
 > +#define io_readl(__a__)		__raw_readl((__a__))
 > +#define io_writel(__v__, __a__)	__raw_writel((__v__), (__a__))
 > +#define io_readb(__a__)		__raw_readb((__a__))
 > +#define io_writeb(__v__, __a__)	__raw_writeb((__v__), (__a__))
 
If they don't work, it'd be nice to get them fixed instead of reinventing new ones.

 > +	/* Create and set up the device context */
 > +	dc = (xicap_gpi_device_context_t *)
 > +	      kmalloc(sizeof (xicap_gpi_device_context_t), GFP_KERNEL);
 > +	if (!dc) {
 > +		res = -ENOMEM;
 > +		goto errex;
 > +	}
 > +	memset(dc, 0, sizeof *dc);

kzalloc.

 > +	rsrc = xicap_gpi_get_resource(pdv, 0, rsrcname_gpi_slice);
 > +	if (unlikely(!rsrc)) goto errex;

	if (unlikely(!rsrc))
		goto errex;

 > +	if (unlikely(!rsrc)) goto errex;

	if (unlikely(!rsrc))
		goto errex;
 
 > +	if (unlikely(!rsrc)) goto errex;

	if (unlikely(!rsrc))
		goto errex;

 > +	if (unlikely(!rsrc)) goto errex;

etc.

 > +	if (res) {
 > +		if (dc->regaddr_fifo_rx) iounmap(dc->regaddr_fifo_rx);
 > +		if (dc->regaddr_fifo_tx) iounmap(dc->regaddr_fifo_tx);
 > +		if (dc->regaddr_xdma) iounmap(dc->regaddr_xdma);
 > +		if (dc->regaddr_pktproc) iounmap(dc->regaddr_pktproc);
 > +		if (dc->regaddr_fpga) iounmap(dc->regaddr_fpga);
 > +		if (dc->dmadesc) iounmap(dc->dmadesc);
 > +		if (dc) kfree(dc);

etc


 > +	/* Set up the XDMA descriptor ring & enable the XDMA */
 > +	dc->curdesc = dc->dmadesc;
 > +	atomic_set(&dc->desc_cnt, XDMA_DESC_RING_SIZE);
 > +	io_writel(dc->dmadesc_p, dc->regaddr_xdma + 0x0018);
 > +	wmb();

Uncommented wmb's are a sin :)
This one may actually need to be a io_readl if its just to flush
the previous io_writel ?

 > +	/*
 > +	 * Enable the rx fifo we are going to use. Disable the
 > +	 * unused ones as well as the tx fifo.
 > +	 */
 > +	io_writel(0x00100000 | ((dc->fifomem_size) << 10)
 > +		  | dc->fifomem_start,
 > +		  dc->regaddr_fifo_rx + 0x0000);
 > +	wmb();

same again.

 > +	titan_writel(0xf << (dc->slice * 4), 0x482c);
 > +	wmb();

and again for a whole bunch more writel's, which really make me wonder...

Asides from all these points, the only thing that really makes me nervous
is the amount of access_ok & __copy_*_user()/memcpy() uses we have rather than
just doing a copy_*_user.  It's one of those "are we sure we've checked everything"
paranoia's I have..

		Dave

-- 
http://www.codemonkey.org.uk
