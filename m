Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbVCNLkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVCNLkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCNLkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:40:42 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:10666 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261372AbVCNLkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:40:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kVkHhTSfhOnFQJgJu58w9C10IIWRPQ384sY5Tv1mtkxGQCXFAFi3Hj3jjKULD/MMmY2Ok2YLWs+KxHUzfX48k/SdKjucbryNHSdNGt6F0pUAYCqULj7otqbems/1Lr7UCWTT+J9tnVGZDD/hl1Jif1LkX0FIfS26tCVxXi9hqRE=
Message-ID: <84144f0205031403404eda561c@mail.gmail.com>
Date: Mon, 14 Mar 2005 13:40:18 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: A new 10GB Ethernet Driver by Chelsio Communications
Cc: Christoph Lameter <christoph@graphe.net>, linux-kernel@vger.kernel.org,
       mark@chelsio.com, netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>,
       penberg@cs.helsinki.fi
In-Reply-To: <84144f0205031403105351abf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0503110356340.14213@server.graphe.net>
	 <20050311112132.6a3a3b49.akpm@osdl.org>
	 <84144f0205031403105351abf5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few more coding style comments.

On Fri, 11 Mar 2005 11:21:32 -0800, Andrew Morton <akpm@osdl.org> wrote:
> diff -puN /dev/null drivers/net/chelsio/cxgb2.c
> --- /dev/null	2003-09-15 06:40:47.000000000 -0700
> +++ 25-akpm/drivers/net/chelsio/cxgb2.c	2005-03-11 11:13:06.000000000 -0800
> @@ -0,0 +1,1284 @@
> +#ifndef HAVE_FREE_NETDEV
> +#define free_netdev(dev) kfree(dev)
> +#endif

Please drop this wrapper.

> +	printk(KERN_INFO "%s: %s (rev %d), %s %dMHz/%d-bit\n", adapter->name,
> +	       bi->desc, adapter->params.chip_revision,
> +	       adapter->params.pci.is_pcix ? "PCIX" : "PCI",
> +	       adapter->params.pci.speed, adapter->params.pci.width);
> +	return 0;
> +
> + out_release_adapter_res:
> +	t1_free_sw_modules(adapter);
> + out_free_dev:
> +	if (adapter) {
> +		if (adapter->tdev)
> +			kfree(adapter->tdev);

kfree() handles null pointers so please drop the redundant check.

> diff -puN /dev/null drivers/net/chelsio/gmac.h
> --- /dev/null	2003-09-15 06:40:47.000000000 -0700
> +++ 25-akpm/drivers/net/chelsio/gmac.h	2005-03-11 11:13:06.000000000 -0800
> @@ -0,0 +1,126 @@
> +
> +typedef struct _cmac_instance cmac_instance;

Please drop the typedef.

> diff -puN /dev/null drivers/net/chelsio/osdep.h
> --- /dev/null	2003-09-15 06:40:47.000000000 -0700
> +++ 25-akpm/drivers/net/chelsio/osdep.h	2005-03-11 11:13:06.000000000 -0800
> @@ -0,0 +1,222 @@
> +#define DRV_NAME "cxgb"
> +#define PFX      DRV_NAME ": "
> +
> +#define CH_ERR(fmt, ...)   printk(KERN_ERR PFX fmt, ## __VA_ARGS__)
> +#define CH_WARN(fmt, ...)  printk(KERN_WARNING PFX fmt, ## __VA_ARGS__)
> +#define CH_ALERT(fmt, ...) printk(KERN_ALERT PFX fmt, ## __VA_ARGS__)
> +
> +/*
> + * More powerful macro that selectively prints messages based on msg_enable.
> + * For info and debugging messages.
> + */
> +#define CH_MSG(adapter, level, category, fmt, ...) do { \
> +	if ((adapter)->msg_enable & NETIF_MSG_##category) \
> +		printk(KERN_##level PFX "%s: " fmt, (adapter)->name, \
> +		       ## __VA_ARGS__); \
> +} while (0)
> +
> +#ifdef DEBUG
> +# define CH_DBG(adapter, category, fmt, ...) \
> +        CH_MSG(adapter, DEBUG, category, fmt, ## __VA_ARGS__)
> +#else
> +# define CH_DBG(fmt, ...)
> +#endif

Please consider using dev_* helpers from <linux/device.h> instead.

> +
> +/* Additional NETIF_MSG_* categories */
> +#define NETIF_MSG_MMIO 0x8000000
> +
> +#define CH_DEVICE(devid, ssid, idx) \
> +	{ PCI_VENDOR_ID_CHELSIO, devid, PCI_ANY_ID, ssid, 0, 0, idx }
> +
> +#define SUPPORTED_PAUSE       (1 << 13)
> +#define SUPPORTED_LOOPBACK    (1 << 15)
> +
> +#define ADVERTISED_PAUSE      (1 << 13)
> +#define ADVERTISED_ASYM_PAUSE (1 << 14)
> +
> +/*
> + * Now that we have included the driver's main data structure,
> + * we typedef it to something the rest of the system understands.
> + */
> +typedef struct adapter adapter_t;

Please drop the typedef.

> +
> +#define DELAY_US(x) udelay(x)
> +
> +#define TPI_LOCK(adapter) spin_lock(&(adapter)->tpi_lock)
> +#define TPI_UNLOCK(adapter) spin_unlock(&(adapter)->tpi_lock)

Please drop the obfuscating wrappers.

> +void t1_elmer0_ext_intr(adapter_t *adapter);
> +void t1_link_changed(adapter_t *adapter, int port_id, int link_status,
> +			int speed, int duplex, int fc);
> +
> +static inline void DELAY_MS(unsigned long ms)
> +{
> +	unsigned long ticks = (ms * HZ + 999) / 1000 + 1;
> +
> +	while (ticks) {
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		ticks = schedule_timeout(ticks);
> +	}
> +}

Use msleep here.

> diff -puN /dev/null drivers/net/chelsio/subr.c
> --- /dev/null	2003-09-15 06:40:47.000000000 -0700
> +++ 25-akpm/drivers/net/chelsio/subr.c	2005-03-11 11:13:06.000000000 -0800
> +typedef struct {
> +	u32 format_version;
> +	u8 serial_number[16];
> +	u8 mac_base_address[6];
> +	u8 pad[2];           /* make multiple-of-4 size requirement explicit */
> +} chelsio_vpd_t;

Please drop the typedef.

				Pekka
