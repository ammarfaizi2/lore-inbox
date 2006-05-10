Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWEJXP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWEJXP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 19:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWEJXP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 19:15:28 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:400 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965074AbWEJXP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 19:15:27 -0400
Date: Thu, 11 May 2006 01:13:47 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Brice Goglin <bgoglin@myri.com>
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "Andrew J. Gallatin" <gallatin@myri.com>, brice@myri.com
Subject: Re: [PATCH 4/6] myri10ge - First half of the driver
Message-ID: <20060510231347.GC25334@electric-eye.fr.zoreil.com>
References: <446259A0.8050504@myri.com> <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0605101438410.498-100000@adel.myri.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <bgoglin@myri.com> :
> [PATCH 4/6] myri10ge - First half of the driver
> 
> The first half of the myri10ge driver core.
> 
> Signed-off-by: Brice Goglin <brice@myri.com>
> Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>
> 
>  myri10ge.c | 1483 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1483 insertions(+)
> 
> --- /dev/null	2006-05-09 19:43:19.324446250 +0200
> +++ linux/drivers/net/myri10ge/myri10ge.c	2006-05-09 23:00:55.000000000 +0200
[...]
> +module_param(myri10ge_flow_control, int, S_IRUGO);
> +module_param(myri10ge_deassert_wait, int, S_IRUGO | S_IWUSR);
> +module_param(myri10ge_force_firmware, int, S_IRUGO);
> +module_param(myri10ge_skb_cross_4k, int, S_IRUGO | S_IWUSR);
> +module_param(myri10ge_initial_mtu, int, S_IRUGO);
> +module_param(myri10ge_napi, int, S_IRUGO);
> +module_param(myri10ge_napi_weight, int, S_IRUGO);
> +module_param(myri10ge_watchdog_timeout, int, S_IRUGO);
> +module_param(myri10ge_max_irq_loops, int, S_IRUGO);

MODULE_PARM_DESC() would be nice.

> +
> +#define MYRI10GE_FW_OFFSET 1024*1024
> +#define MYRI10GE_HIGHPART_TO_U32(X) \
> +(sizeof (X) == 8) ? ((uint32_t)((uint64_t)(X) >> 32)) : (0)
> +#define MYRI10GE_LOWPART_TO_U32(X) ((uint32_t)(X))
> +
> +#define myri10ge_pio_copy(to,from,size) __iowrite64_copy(to,from,size/8)
> +
> +int myri10ge_hyper_msi_cap_on(struct pci_dev *pdev)

static int ?

[...]
> +static int
> +myri10ge_send_cmd(struct myri10ge_priv *mgp, uint32_t cmd,
> +		  myri10ge_cmd_t *data)
> +{
> +	mcp_cmd_t *buf;
> +	char buf_bytes[sizeof(*buf) + 8];
> +	volatile mcp_cmd_response_t *response = mgp->cmd;
> +	volatile char __iomem *cmd_addr = mgp->sram + MYRI10GE_MCP_CMD_OFFSET;
> +	uint32_t dma_low, dma_high;
> +	int sleep_total = 0;
> +
> +	/* ensure buf is aligned to 8 bytes */
> +	buf = (mcp_cmd_t *) ((unsigned long)(buf_bytes + 7) & ~7UL);
> +
> +	buf->data0 = htonl(data->data0);
> +	buf->data1 = htonl(data->data1);
> +	buf->data2 = htonl(data->data2);
> +	buf->cmd = htonl(cmd);
> +	dma_low = MYRI10GE_LOWPART_TO_U32(mgp->cmd_bus);
> +	dma_high = MYRI10GE_HIGHPART_TO_U32(mgp->cmd_bus);
> +
> +	buf->response_addr.low = htonl(dma_low);
> +	buf->response_addr.high = htonl(dma_high);
> +	spin_lock(&mgp->cmd_lock);
> +	response->result = 0xffffffff;
> +	mb();
> +	myri10ge_pio_copy((void __iomem *) cmd_addr, buf, sizeof (*buf));
> +
> +	/* wait up to 2 seconds */

You must not hold a spinlock for up to 2 seconds.

> +	for (sleep_total = 0; sleep_total < (2 * 1000); sleep_total += 10) {
> +		mb();
> +		if (response->result != 0xffffffff) {
> +			if (response->result == 0) {
> +				data->data0 = ntohl(response->data);
> +				spin_unlock(&mgp->cmd_lock);
> +				return 0;
> +			} else {
> +				dev_err(&mgp->pdev->dev,
> +					"command %d failed, result = %d\n",
> +				       cmd, ntohl(response->result));
> +				spin_unlock(&mgp->cmd_lock);
> +				return -ENXIO;

Return in a middle of a spinlock-intensive function. :o(

> +			}
> +		}
> +		udelay(1000 * 10);
> +	}
> +	spin_unlock(&mgp->cmd_lock);
> +	dev_err(&mgp->pdev->dev, "command %d timed out, result = %d\n",
> +	       cmd, ntohl(response->result));
> +	return -EAGAIN;
> +}
> +
> +
> +/*
> + * The eeprom strings on the lanaiX have the format
> + * SN=x\0
> + * MAC=x:x:x:x:x:x\0
> + * PT:ddd mmm xx xx:xx:xx xx\0
> + * PV:ddd mmm xx xx:xx:xx xx\0
> + */
> +int
> +myri10ge_read_mac_addr(struct myri10ge_priv *mgp)

static int ?

[...]
> +static void
> +myri10ge_dummy_rdma(struct myri10ge_priv *mgp, int enable)
> +{
> +	volatile uint32_t *confirm;
> +	volatile char __iomem *submit;
> +	uint32_t buf[16];
> +	uint32_t dma_low, dma_high;
> +	int i;
> +
> +	/* clear confirmation addr */
> +	confirm = (volatile uint32_t *) mgp->cmd;
> +	*confirm = 0;
> +	mb();
> +
> +	/* send a rdma command to the PCIe engine, and wait for the
> +	 * response in the confirmation address.  The firmware should
> +	 * write a -1 there to indicate it is alive and well
> +	 */
> +	dma_low = MYRI10GE_LOWPART_TO_U32(mgp->cmd_bus);
> +	dma_high = MYRI10GE_HIGHPART_TO_U32(mgp->cmd_bus);
> +
> +	buf[0] = htonl(dma_high); 	/* confirm addr MSW */
> +	buf[1] = htonl(dma_low); 	/* confirm addr LSW */
> +	buf[2] = htonl(0xffffffff);	/* confirm data */
> +	buf[3] = htonl(dma_high); 	/* dummy addr MSW */
> +	buf[4] = htonl(dma_low); 	/* dummy addr LSW */
> +	buf[5] = htonl(enable);		/* enable? */
> +
> +	submit = mgp->sram + 0xfc01c0;
> +
> +	myri10ge_pio_copy((void __iomem *) submit, &buf, sizeof (buf));
> +	mb();
> +	udelay(1000);
> +	mb();
> +	i = 0;
> +	while (*confirm != 0xffffffff && i < 20) {
> +		udelay(1000);
> +		i++;
> +	}

	for (i = 0; *confirm != 0xffffffff && i < 20; i++)
		udelay(1000);


[...]
> +static int
> +myri10ge_adopt_running_firmware(struct myri10ge_priv *mgp)
> +{
> +	mcp_gen_header_t *hdr;
> +	struct device *dev = &mgp->pdev->dev;
> +	size_t bytes, hdr_offset;
> +	int status;
> +
> +	/* find running firmware header */
> +	hdr_offset = ntohl(__raw_readl(mgp->sram + MCP_HEADER_PTR_OFFSET));
> +
> +	if ((hdr_offset & 3) || hdr_offset + sizeof(*hdr) > mgp->sram_size) {
> +		dev_err(dev, "Running firmware has bad header offset (%d)\n",
> +			(int)hdr_offset);
> +		return -EIO;
> +	}
> +
> +	/* copy header of running firmware from SRAM to host memory to
> +	 * validate firmware */
> +	bytes = sizeof (mcp_gen_header_t);

const size_t bytes = ...

> +	hdr = (mcp_gen_header_t *) kmalloc(bytes, GFP_KERNEL);

Useless cast.

[...]
> +static int
> +myri10ge_change_pause(struct myri10ge_priv *mgp, int pause)
> +{
> +	myri10ge_cmd_t cmd;
> +	int status;
> +
> +	if (pause)
> +		status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_ENABLE_FLOW_CONTROL, &cmd);
> +	else
> +		status = myri10ge_send_cmd(mgp, MYRI10GE_MCP_DISABLE_FLOW_CONTROL, &cmd);

	ctl = pause ? MYRI10GE_MCP_ENABLE_FLOW_CONTROL : 
		MYRI10GE_MCP_DISABLE_FLOW_CONTROL;

	status = myri10ge_send_cmd(mgp, ctl, ...)

> +
> +	if (status) {
> +		printk(KERN_ERR "myri10ge: %s: Failed to set flow control mode\n",
> +		       mgp->dev->name);
> +		return -ENXIO;

Why not use the status code returned by myri10ge_send_cmd() ?

[...]
> +static int
> +myri10ge_reset(struct myri10ge_priv *mgp)
> +{
[...]
> +	cmd.data0 = MYRI10GE_LOWPART_TO_U32(mgp->rx_done.bus);
> +	cmd.data1 = MYRI10GE_HIGHPART_TO_U32(mgp->rx_done.bus);
> +	cmd.data2 = len * 0x10001;
> +	status |= myri10ge_send_cmd(mgp, MYRI10GE_MCP_DMA_TEST, &cmd);

The status code is not used.

> +	mgp->read_write_dma = ((cmd.data0>>16) * len * 2 * 2) /
> +		(cmd.data0 & 0xffff);
> +
> +	memset(mgp->rx_done.entry, 0, bytes);
> +
> +	/* reset mcp/driver shared state back to 0 */
> +	mgp->tx.req = 0;
> +	mgp->tx.done = 0;
> +	mgp->tx.pkt_start = 0;
> +	mgp->tx.pkt_done = 0;
> +	mgp->rx_big.cnt = 0;
> +	mgp->rx_small.cnt = 0;
> +	mgp->rx_done.idx = 0;
> +	mgp->rx_done.cnt = 0;
> +	status = myri10ge_update_mac_address(mgp, mgp->dev->dev_addr);
> +	myri10ge_change_promisc(mgp, 0);
> +	myri10ge_change_pause(mgp, mgp->pause);
> +	return status;
> +}
> +
> +static inline void
> +myri10ge_submit_8rx(mcp_kreq_ether_recv_t __iomem *dst, mcp_kreq_ether_recv_t *src)
> +{
> +	uint32_t low;
> +
> +	low = src->addr_low;
> +	src->addr_low = 0xffffffff;

DMA_32BIT_MASK ?

> +	myri10ge_pio_copy(dst, src, 8 * sizeof(*src));
> +	mb();
> +	src->addr_low = low;
> +	*(uint32_t __force *) &dst->addr_low = src->addr_low;
> +	mb();
> +}
> +
> +/*
> + * Set of routunes to get a new receive buffer.  Any buffer which
> + * crosses a 4KB boundary must start on a 4KB boundary due to PCIe
> + * wdma restrictions. We also try to align any smaller allocation to
> + * at least a 16 byte boundary for efficiency.  We assume the linux
> + * memory allocator works by powers of 2, and will not return memory
> + * smaller than 2KB which crosses a 4KB boundary.  If it does, we fall
> + * back to allocating 2x as much space as required.
> + */
> +
> +static inline struct sk_buff *
> +myri10ge_alloc_big(int bytes)

It fits on a single line.

> +{
> +	struct sk_buff *skb;
> +	unsigned long data, roundup;
> +
> +	skb = dev_alloc_skb(bytes + 4096 + MYRI10GE_MCP_ETHER_PAD);
> +	if (skb == NULL)
> +		return NULL;

Imho you will want to work directly with pages shortly.

[...]
> +static irqreturn_t
> +myri10ge_napi_intr(int irq, void *arg, struct pt_regs *regs)
> +{
> +	struct myri10ge_priv *mgp = (struct myri10ge_priv *) arg;

Useless cast.

[...]
> +static int
> +myri10ge_set_settings(struct net_device *netdev, struct ethtool_cmd *cmd)
> +{
> +	return -EINVAL;
> +}

Useless.

-- 
Ueimor
