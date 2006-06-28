Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751568AbWF1VsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbWF1VsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 17:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWF1VsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 17:48:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751567AbWF1VsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 17:48:09 -0400
Date: Wed, 28 Jun 2006 14:51:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Hanjin.Chu@freescale.com,
       gridish@freescale.com
Subject: Re: [PATCH 6/7] net: Add QE UCC Gigabit Ethernet driver
Message-Id: <20060628145124.0c400df9.akpm@osdl.org>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FD7@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FD7@zch01exm40.ap.freescale.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li Yang-r58472 <LeoLi@freescale.com> wrote:
>
> This is a gigabit Ethernet driver for Freescale QE(QUICC ENGINE) SOC.  QE can be found on PowerQUICC II pro family.
> 
>
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index bdaaad8..ebbb218 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2189,6 +2189,33 @@ config GFAR_NAPI
>  	bool "NAPI Support"
>  	depends on GIANFAR
>  
> +config UCC_GETH
> +	tristate "Freescale QE UCC GETH"
> +	depends on QUICC_ENGINE

Opinions vary, but it can be useful if drivers such as this are compilable
on common architectures (ie: x86).  That way, lots of people end up
compiling it and problems (generally simple ones) can be fixed for you. 
Plus it's much less likely that someone will break your driver by accident.

Then again, it'll cause people to build a driver which they cannot possibly
use..

>  # link order important here
>  #
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> new file mode 100644
> index 0000000..a7be2eb
> --- /dev/null
> +++ b/drivers/net/ucc_geth.c
>
> ...
>
> +#include <asm/uaccess.h>
> +#include <asm/irq.h>
> +#include <asm/io.h>
> +#include <asm/immap_qe.h>
> +#include <asm/qe.h>
> +
> +#include <asm/ucc.h>
> +#include <asm/ucc_fast.h>

Well that rather rules out the x86 option.

> +
> +static ucc_geth_info_t ugeth_primary_info = {
> +	.uf_info = {
> +		    .bd_mem_part = MEM_PART_SYSTEM,
> +		    .brkpt_support = 0,
> +		    .grant_support = 0,
> +		    .tsa = 0,
> +		    .cdp = 0,
> +		    .cds = 0,
> +		    .ctsp = 0,
> +		    .ctss = 0,
> +		    .tci = 0,
> +		    .txsy = 0,
> +		    .rtsm = UCC_FAST_SEND_IDLES_BETWEEN_FRAMES,
> +		    .revd = 0,
> +		    .rsyn = 0,

Note that all the `.foo = 0' lines aren't needed.

> +	.l2qt = {0, 0, 0, 0, 0, 0, 0, 0},
> +	.l3qt = {0, 0, 0, 0, 0, 0, 0, 0,
> +		 0, 0, 0, 0, 0, 0, 0, 0,
> +		 0, 0, 0, 0, 0, 0, 0, 0,
> +		 0, 0, 0, 0, 0, 0, 0, 0,
> +		 0, 0, 0, 0, 0, 0, 0, 0,
> +		 0, 0, 0, 0, 0, 0, 0, 0,
> +		 0, 0, 0, 0, 0, 0, 0, 0,
> +		 0, 0, 0, 0, 0, 0, 0, 0},
> +	.vtagtable = {0, 0, 0, 0, 0, 0, 0, 0},
> +	.iphoffset = {0, 0, 0, 0, 0, 0, 0, 0},

In fact I'd be inclined to remove them - the chances of keeping this table
in sync with the actual struct definition seem low.

> +
> +#ifdef DEBUG
> +static void mem_disp(u8 * addr, int size)
> +{
> +	u8 *i;
> +	int size16Aling = (size >> 4) << 4;
> +	int size4Aling = (size >> 2) << 2;
> +	int notAlign = 0;
> +	if (size % 16)
> +		notAlign = 1;
> +
> +	for (i = addr; (u32) i < (u32) addr + size16Aling; i += 16)
> +		printk("0x%08x: %08x %08x %08x %08x\r\n",
> +		       (u32) i,
> +		       *((u32 *) (i)),
> +		       *((u32 *) (i + 4)),
> +		       *((u32 *) (i + 8)), *((u32 *) (i + 12)));
> +	if (notAlign == 1)
> +		printk("0x%08x: ", (u32) i);
> +	for (; (u32) i < (u32) addr + size4Aling; i += 4)
> +		printk("%08x ", *((u32 *) (i)));
> +	for (; (u32) i < (u32) addr + size; i++)
> +		printk("%02x", *((u8 *) (i)));
> +	if (notAlign == 1)
> +		printk("\r\n");
> +}
> +#endif /* DEBUG */

This is very non-64-bit.

> +#ifdef CONFIG_UGETH_FILTERING
> +static void enqueue(struct list_head *node, struct list_head *lh)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	list_add_tail(node, lh);
> +	local_irq_restore(flags);
> +}
> +#endif /* CONFIG_UGETH_FILTERING */

And local_irq_save() is very non-SMP (isn't it?)

> +static struct list_head *dequeue(struct list_head *lh)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	if (!list_empty(lh)) {
> +		struct list_head *node = lh->next;
> +		list_del(node);
> +		local_irq_restore(flags);
> +		return node;
> +	} else {
> +		local_irq_restore(flags);
> +		return NULL;
> +	}
> +}

Unless this really really really never will run on SMP, it'd be better to
use spin_lock_irqsave() here.  That's equivalent on !SMP.

> +static struct sk_buff *get_new_skb(ucc_geth_private_t * ugeth, u8 * bd)

Preferred coding style is

static struct sk_buff *get_new_skb(ucc_geth_private_t *ugeth, u8 *bd)

> +{
> +	struct sk_buff *skb = NULL;
> +	unsigned int timeout = SKB_ALLOC_TIMEOUT;
> +
> +	/* We have to allocate the skb, so keep trying till we succeed */
> +	while ((!skb) && timeout--)
> +		skb =
> +		    dev_alloc_skb(ugeth->ug_info->uf_info.max_rx_buf_length +
> +				  UCC_GETH_RX_DATA_BUF_ALIGNMENT);

This is pretty pointless.  If the first allocation attempt failed then
for-sure the rest of them will fail too.  All it does is waste CPU.

> +
> +static int rx_bd_buffer_set(ucc_geth_private_t * ugeth, u8 rxQ)
> +{
> +	u8 *bd;
> +	u32 bd_status;
> +	struct sk_buff *skb;
> +	int i;
> +
> +	if (!ugeth) {
> +		ugeth_err("%s: No handle passed.", __FUNCTION__);
> +		return -EINVAL;
> +	}

Presumably, this can't happen.  Suggest you remove this code and let the
thing oops if it does happen.

> +static int fill_init_enet_entries(ucc_geth_private_t * ugeth,
> +				  volatile u32 * p_start,
> +				  u8 num_entries,
> +				  u32 thread_size,
> +				  u32 thread_alignment,
> +				  qe_risc_allocation_e risc,
> +				  int skip_page_for_first_entry)
> +{
> +	u32 init_enet_offset;
> +	u8 i;
> +	int snum;
> +
> +	if (!ugeth || !ugeth->uccf) {
> +		ugeth_err("%s: No handle passed.", __FUNCTION__);
> +		return -EINVAL;
> +	}

Ditto.

> +#ifdef CONFIG_UGETH_FILTERING
> +static enet_addr_container_t *get_enet_addr_container(void)
> +{
> +	enet_addr_container_t *enet_addr_cont;
> +
> +	/* allocate memory */
> +	enet_addr_cont =
> +	    (enet_addr_container_t *) kmalloc(sizeof(enet_addr_container_t),

Unneeded typecast.

> +
> +static inline int compare_addr(enet_addr_t * addr1, enet_addr_t * addr2)
> +{
> +	return strncmp((char *)addr1, (char *)addr2,
> +		       ENET_NUM_OCTETS_PER_ADDRESS);
> +}

Shouldn't this use memcmp()?  strncmp() will stop at 0x00.

> +			mem_disp((u8 *) & ugeth->p_thread_data_tx[i],
> +				 sizeof(ucc_geth_thread_data_tx_t));

We should have a kernel-wide printk-a-block-of-memory-out library function,
but we don't.

> +static int init_check_frame_length_mode(int length_check,
> +					volatile u32 * maccfg2_register)
> +{
> +	u32 value = 0;

Unneeded initialisation (lots of places).

> +	value = in_be32(maccfg2_register);

> +/* Called every time the controller might need to be made
> + * aware of new link state.  The PHY code conveys this
> + * information through variables in the ugeth structure, and this
> + * function converts those variables into the appropriate
> + * register values, and can bring down the device if needed.
> + */
> +#include <linux/mii.h>

This is a funny place to be including a header file.  Better to put it at
the top of the .c file.

[remainder skipped - it's a big driver]
