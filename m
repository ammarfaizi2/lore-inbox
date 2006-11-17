Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753098AbWKQUuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbWKQUuy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 15:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbWKQUuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 15:50:54 -0500
Received: from smtp.osdl.org ([65.172.181.25]:5312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753095AbWKQUux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 15:50:53 -0500
Date: Fri, 17 Nov 2006 12:49:02 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Divy Le Ray <divy@chelsio.com>" <divy@chelsio.com>
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/10] cxgb3 - main header files
Message-ID: <20061117124902.7e69af2e@freekitty>
In-Reply-To: <20061117202320.25878.26769.stgit@colfax2.asicdesigners.com>
References: <20061117202320.25878.26769.stgit@colfax2.asicdesigners.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +struct work_struct;
> +struct dentry;


Why do you need these extra forward declarations?

...

> +
> +struct sge_rspq {                   /* state for an SGE response queue */
> +	unsigned int credits;       /* # of pending response credits */
> +	unsigned int size;          /* capacity of response queue */
> +	unsigned int cidx;          /* consumer index */
> +	unsigned int gen;           /* current generation bit */
> +	unsigned int polling;       /* is the queue serviced through NAPI? */
> +	unsigned int holdoff_tmr;   /* interrupt holdoff timer in 100ns */
> +	unsigned int next_holdoff;  /* holdoff time for next interrupt */
> +	struct rsp_desc *desc;      /* address of HW response ring */
> +	dma_addr_t   phys_addr;     /* physical address of the ring */
> +	unsigned int cntxt_id;      /* SGE context id for the response q */
> +	spinlock_t   lock;          /* guards response processing */
> +	struct sk_buff *rx_head;    /* offload packet receive queue head */
> +	struct sk_buff *rx_tail;    /* offload packet receive queue tail */

Why not use sk_buff_head?

...

> +	/*
> +	 * Dummy netdevices are needed when using multiple receive queues with
> +	 * NAPI as each netdevice can service only one queue.
> +	 */
> +	struct net_device *dummy_netdev[SGE_QSETS - 1];
>

Rather than abusing, NAPI with multiple receive queue's why not do it
by either:
	1) changing NAPI to have multiple receive contexts
	2) or use your own tasklet and processing.

> +	struct dentry *debugfs_root;
> +
> +	struct semaphore mdio_lock;
> +	spinlock_t stats_lock;
> +	spinlock_t work_lock;
> +};
> +
> +#define MDIO_LOCK(adapter) down(&(adapter)->mdio_lock)
> +#define MDIO_UNLOCK(adapter) up(&(adapter)->mdio_lock)

Please don't wrap locks


> +static inline u32 t3_read_reg(adapter_t *adapter, u32 reg_addr)
> +{
> +	u32 val = readl(adapter->regs + reg_addr);
> +
> +	CH_DBG(adapter, MMIO, "read register 0x%x value 0x%x\n", reg_addr,
> +	       val);
> +	return val;
> +}
> +
> +static inline void t3_write_reg(adapter_t *adapter, u32 reg_addr, u32 val)
> +{
> +	CH_DBG(adapter, MMIO, "setting register 0x%x to 0x%x\n", reg_addr,
> +	       val);
> +	writel(val, adapter->regs + reg_addr);
> +}

This kind of wrapper makes sense.

> +static inline int t3_os_pci_save_state(adapter_t *adapter)
> +{
> +	return pci_save_state(adapter->pdev);
> +}

Please don't add bogus OS independent wrappers. It makes it harder for later
maintenance.

> +static inline int t3_os_pci_restore_state(adapter_t *adapter)
> +{
> +	return pci_restore_state(adapter->pdev);
> +}
> +
> +static inline void t3_os_pci_write_config_4(adapter_t *adapter, int reg,
> +					    u32 val)
> +{
> +	pci_write_config_dword(adapter->pdev, reg, val);
> +}
> +
> +static inline void t3_os_pci_read_config_4(adapter_t *adapter, int reg,
> +					   u32 *val)
> +{
> +	pci_read_config_dword(adapter->pdev, reg, val);
> +}
> +
> +static inline void t3_os_pci_write_config_2(adapter_t *adapter, int reg,
> +					    u16 val)
> +{
> +	pci_write_config_word(adapter->pdev, reg, val);
> +}
> +
> +static inline void t3_os_pci_read_config_2(adapter_t *adapter, int reg,
> +					   u16 *val)
> +{
> +	pci_read_config_word(adapter->pdev, reg, val);
> +}
> +
> +static inline int t3_os_find_pci_capability(adapter_t *adapter, int cap)
> +{
> +	return pci_find_capability(adapter->pdev, cap);
> +}
> +
> +static inline const char *adapter_name(adapter_t *adapter)
> +{
> +	return adapter->name;
> +}
> +
> +static inline const char *port_name(adapter_t *adapter, unsigned int port_idx)
> +{
> +	return adapter->port[port_idx].dev->name;
> +}

Why not do this inline.

> +static inline void t3_os_set_hw_addr(adapter_t *adapter, int port_idx,
> +				     u8 hw_addr[])
> +{
> +	memcpy(adapter->port[port_idx].dev->dev_addr, hw_addr, ETH_ALEN);
> +#ifdef ETHTOOL_GPERMADDR
> +	memcpy(adapter->port[port_idx].dev->perm_addr, hw_addr, ETH_ALEN);
> +#endif
> +}

Another bogus wrapper.

> +/*
> + * We use the spare atalk_ptr to map a net device to its SGE queue set.
> + * This is a macro so it can be used as l-value.
> + */
> +#define dev2qset(netdev) ((netdev)->atalk_ptr)

That looks a bad idea.

> +
> +#define OFFLOAD_DEVMAP_BIT 15
> +
> +#define tdev2adap(d) container_of(d, struct adapter, tdev)
> +
> +static inline int offload_running(adapter_t *adapter)
> +{
> +	return test_bit(OFFLOAD_DEVMAP_BIT, &adapter->open_device_map);
> +}
> +
> +int t3_offload_tx(struct t3cdev *tdev, struct sk_buff *skb);

What kind of offload?  You remember TOE was rejected.


> +#define promisc_rx_mode(rm)  ((rm)->dev->flags & IFF_PROMISC)
> +#define allmulti_rx_mode(rm) ((rm)->dev->flags & IFF_ALLMULTI)


Yet another high maintenance wrapper


> +struct sg_ent {                   /* SGE scatter/gather entry */
> +	u32 len[2];
> +	u64 addr[2];
> +};

Shouldn't 2 be NPORTS or somthing.
