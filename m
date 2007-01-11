Return-Path: <linux-kernel-owner+w=401wt.eu-S965343AbXAKJ1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965343AbXAKJ1R (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 04:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965339AbXAKJ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 04:27:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54148 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965340AbXAKJ1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 04:27:15 -0500
Date: Thu, 11 Jan 2007 09:27:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: jeff@garzik.org, shemminger@osdl.org, csnook@redhat.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/4] atl1: Header files for Attansic L1 driver
Message-ID: <20070111092704.GB3141@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
	shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
References: <20070111004137.GC2624@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111004137.GC2624@osprey.hogchain.net>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 06:41:37PM -0600, Jay Cliburn wrote:
> +/**
> + * atl1.h - atl1 main header

Please remove these kind of comments, they get out of date far too soon
and don't really help anything.  (Also everywhere else in the driver)

> +#include <linux/tcp.h>
> +#include <linux/skbuff.h>
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/workqueue.h>
> +#include <linux/timer.h>
> +#include <linux/delay.h>
> +#include <linux/if_vlan.h>
> +
> +#include <asm/types.h>

Please always include <linux/types.h>

>
> +#include <asm/atomic.h>

Please only includ headers where you use them - that's mostly the .c
files unless you have lots of inlines or complex structures in the headers.



> +#ifdef NETIF_F_TSO
> +#include <net/checksum.h>
> +#endif
> +
> +#ifdef SIOCGMIIPHY
> +#include <linux/mii.h>
> +#endif
> +
> +#ifdef SIOCETHTOOL
> +#include <linux/ethtool.h>
> +#endif

Please remove all these ifdefs.

> +#define BAR_0	0

This looks etirely superflous.

> +#define usec_delay(x)	udelay(x)
> +#ifndef msec_delay
> +#define msec_delay(x)	do { if(in_interrupt()) { \
> +			/* Don't mdelay in interrupt context!*/ \
> +				BUG(); \
> +			} else { \
> +				msleep(x); \
> +			}} while(0)
> +/**
> + * Some workarounds require millisecond delays and are run during interrupt
> + * context.  Most notably, when establishing link, the phy may need tweaking
> + * but cannot process phy register reads/writes faster than millisecond
> + * intervals...and we establish link due to a "link status change" interrupt.
> + **/
> +#define msec_delay_irq(x) mdelay(x)
> +#endif

Please kill all these wrappers.

> +} _ATL1_ATTRIB_PACK_;

All your structs seems to be properly packed from a first sight.  Please
doble-check this and get rid of the attribute packed.

> +struct csum_param {
> +	unsigned buf_len:14;
> +	unsigned dma_int:1;
> +	unsigned pkt_int:1;
> +	u16 valan_tag;
> +	unsigned eop:1;
> +	/* command */
> +	unsigned coalese:1;
> +	unsigned ins_vlag:1;
> +	unsigned custom_chksum:1;
> +	unsigned segment:1;
> +	unsigned ip_chksum:1;
> +	unsigned tcp_chksum:1;
> +	unsigned udp_chksum:1;
> +	/* packet state */
> +	unsigned vlan_tagged:1;
> +	unsigned eth_type:1;
> +	unsigned iphl:4;
> +	unsigned:2;
> +	unsigned payload_offset:8;
> +	unsigned xsum_offset:8;
> +} _ATL1_ATTRIB_PACK_;

Bitfields should not be used for hardware datastructures ever.
Please convert this to explicit masking and shifting.

> +/* Structure containing variables used by the shared code */
> +struct atl1_hw {
> +	u8 __iomem *hw_addr;
> +	void *back;

This is definitly a kernel data structure.  Shouldn't it be in atl1.h
instead of _hw.h?  Also does back really need to be a void pointer or
can it be something typed?

> +	u16 dev_rev;
> +	u16 device_id;
> +	u16 vendor_id;
> +	u16 subsystem_id;
> +	u16 subsystem_vendor_id;
> +	u8 revision_id;

Please just use the values from the pci_dev insead of duplicating them.

> +/* formerly ATL1_WRITE_REG */
> +static inline void atl1_write32(const struct atl1_hw *hw, int reg, u32 val)
> +{
> +        writel(val, hw->hw_addr + reg);
> +}
> +
> +/* formerly ATL1_READ_REG */
> +static inline u32 atl1_read32(const struct atl1_hw *hw, int reg)
> +{
> +        return readl(hw->hw_addr + reg);
> +}

Just kill all these wrappers.  Also you probably want to convert to
pci_iomap + ioread*/iowrite*.

