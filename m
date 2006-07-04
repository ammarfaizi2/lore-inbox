Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWGDAJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWGDAJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWGDAJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:09:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750917AbWGDAJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:09:21 -0400
Date: Mon, 3 Jul 2006 17:09:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Straub, Michael" <Michael.Straub@avocent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/13] Equinox SST driver:hardware registers
Message-Id: <20060703170917.6dc1547d.akpm@osdl.org>
In-Reply-To: <4821D5B6CD3C1B4880E6E94C6E70913E01B71109@sun-email.corp.avocent.com>
References: <4821D5B6CD3C1B4880E6E94C6E70913E01B71109@sun-email.corp.avocent.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:16:35 -0400
"Straub, Michael" <Michael.Straub@avocent.com> wrote:

> Adds Equinox multi-port serial (SST) driver.
> 

hm, I missed this patch series.

> + * Each ICP provides a set of input and output registers per channel.
> + * Input registers for receiving data and output registers for
> trasmitting.
> + * In addition, there are also a set of global registers per board
> which are
> + * used for general configuration and also contain the global attention
> bits.

As Randy says, these patches were exorbitantly, unusable wordwrapped.

> +struct icp_gbl_struct {
> +	u8	filler1[24];
> +	u8	gicp_bus_cntrl;		/* 0x18: bus control */
> +	u8	gicp_rev;		/* 0x19: icp revision */
> +	u8	filler2[2];
> +	u8	gicp_initiate;		/* 0x1c: lmx control & icp
> enable */
> +	u8	gicp_scan_spd;		/* 0x1d: lmx scan speeds */
> +	u8	gicp_tmr_size;		/* 0x1e: interval timer scale
> preset */
> +	u8	gicp_tmr_count;		/* 0x1f: interval timer count
> preset */
> +	u8	filler3[24];
> +	u8	gicp_watchdog;		/* 0x38: watchdog timer */
> +	u8	filler4[3];
> +	u8	gicp_attn;		/* 0x3c: global status */
> +	u8	gicp_chan;		/* 0x3d: current channel number
> */
> +	u16	gicp_frame_ctr;		/* 0x3e: frame counter */
> +	u8	filler5[24];
> +	u8	gicp_rcv_attn[8];	/* 0x58: receive attention bits
> */
> +	u8	filler6[24];
> +	u8	gicp_xmit_attn[8];	/* 0x78: transmit attention bits
> */
> +};
>
> ...
>
> +struct ssp4_gbl_struct {
> +	u8	bus_cntrl;		/* 0x0: global control register
> */
> +	u8	rev;			/* 0x1: revision Level number */
> +	u8	on_line;		/* 0x2: on-line */
> +	u8	filler1;
> +	u8	chan_ctr;		/* 0x4: active channel number */
> +	u8	filler2;
> +	u8	chan_attn;		/* 0x6: channel attention bits
> */
> +	u8	tmr_evnt;		/* 0x7: timer event bits */
> +	u8	filler3[17];
> +	u8	type;			/* 0x19: board type */
> +	u8	filler4[34];
> +	u8	attn_pend;		/* 0x3c: channel attention */
> +};
> +
>
> ...
>
> +struct cin_bnk_struct {
> +	u16	bank_nxt_dma;		/* 0x0: offset to next in dma */
> +	u8	bank_fifo_lvl;		/* 0x2: char count held in fifo
> */
> +	u8	bank_tags_l;		/* 0x3: input tags, low byte */
> +	u16	bank_signals;		/* 0x4: channel input signals */
> +	u8	filler0;
> +	u8	bank_tags_h;		/* 0x7: input tags, high byte */
> +	u8	bank_fifo[8];		/* 0x8: input 8 char fifo */
> +	u16	bank_num_chars;		/* 0x10: char count received */
> +	u16	bank_events;		/* 0x12: input events detected
> */
> +};
>
> [ etc ]
>

What are these?  Do they describe chip register sets?

If so, there's a tight compiler dependency here.  I don't know whether any
version of the compiler for any architecture will muck around adding
padding in here.  There's a risk, I guess.

> +
> +/* return active input queue tail pointer */
> +#define GET_TAIL() \
> +{ \
> +	if (icpi->cin_q_cntrl & TAIL_PTR_B) \
> +		return (SSTRD16(icpi->cin_tail_ptr_b)); \
> +	else \
> +		return (SSTRD16(icpi->cin_tail_ptr_a)); \
> +}

Please, no.

- It's a macro qhich requires that the caller have a local variable named
  `icpi'.  At a minimum, the name of the pointer should be an arg to the
  macro.

- The macro hides a `return' statement.  That's a show-stopper.

I suggest this be reimplemented as a function.  Possibly inlined.

> +/* set input queue tail pointer */
> +#define SET_TAIL(val) \
> +{ \
> +        if (icpi->cin_q_cntrl & TAIL_PTR_B) \
> +		SSTWR16(icpi->cin_tail_ptr_a, (val)); \
> +	else \
> +		SSTWR16(icpi->cin_tail_ptr_b, (val)); \
> +	icpi->cin_q_cntrl ^= TAIL_PTR_B; \
> +}

This also can be a regular C function.

> +/* freeze active input register bank */
> +#define FREEZ_BANK(mpc) \
> +{ \
> +	u16 cie = CHAN_ATTN_SET | SSTRD16(icpi->cin_attn_ena); \
> +	int frztimeo = 0; \
> +	u8 lcks = 0; \
> +	SSTWR16(icpi->cin_attn_ena, 0); \
> +	if ((icpi->cin_locks & DIS_BANK_A) == DIS_BANK_A) { \
> +		/* Bank A is active (locked) */ \
> +		icpb = &icpi->cin_bank_b; \
> +		lcks = BANK_B_ACT; \
> +	} else  \
> +		/* Bank B is active (locked) */ \
> +		icpb = &icpi->cin_bank_a; \
> +	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT)) { \
> +		while ((icpi->cin_intern_flgs & 0x80) != lcks) \
> +			if (++frztimeo > 8000) break; \
> +	}  \
> +	mpc->mpc_icpb = icpb; \
> +	icpi->cin_locks ^= (DIS_BANK_A | DIS_BANK_B); /* flip banks */ \
> +	eqnx_chnl_sync(mpc); \
> +	mpc->mpc_cin_events |= SSTRD16(icpb->bank_events); \
> +	SSTWR16(icpb->bank_events, 0); \
> +	SSTWR16(icpi->cin_attn_ena, cie); \
> +}

No way, sorry.  Implement as a function.

> +/* get and return output events for the channel */
> +#define TX_EVENTS(x, mpc) \
> +{ \
> +	volatile u16 csr = SSTRD16(icpo->cout_status); \
> +	volatile u16 oie = SSTRD16(icpo->cout_attn_enbl); \
> +	SSTWR16(icpo->cout_attn_enbl, 0); \
> +	if (csr & TXSR_EV_B_ACT) { \
> +		icpo->cout_lck_cntrl ^= (LCK_EVT_A | LCK_EVT_B); \
> +		eqnx_chnl_sync(mpc); \
> +		(x) |= SSTRD16(icpo->cout_events_b); \
> +		SSTWR16(icpo->cout_events_b, 0); \
> +	} else { \
> +		icpo->cout_lck_cntrl ^= (LCK_EVT_A | LCK_EVT_B); \
> +		eqnx_chnl_sync(mpc); \
> +		(x) |= SSTRD16(icpo->cout_events_a); \
> +		SSTWR16(icpo->cout_events_a, 0); \
> +	} \
> +	if ((x) & EV_TX_EMPTY_Q0) \
> +		oie &= ~ENA_TX_EMPTY_Q0;\
> +	if ((x) & EV_TX_LOW_Q0) \
> +		oie &= ~ENA_TX_LOW_Q0;\
> +	SSTWR16(icpo->cout_attn_enbl, oie); \
> +}

Ditto.


> +/* returns outbound control signals for channel */
> +#define GET_CTRL_SIGS(mpc,val) val =
> SSTRD16(mpc->mpc_icpo->cout_cntrl_sig);
>
> +/* sets outbound control signals for channel */
> +#define SET_CTRL_SIGS(mpc, val)
> SSTWR16((mpc->mpc_icpo)->cout_cntrl_sig, val);

That's

> +#define        SSTRD16(x)      (cpu_to_le16(x))

Please remove this macro - just open-code the cpu_to_le16() everywhere
(edit the diffs..)

And please review all patches for excess parenthesisation and fix that up.

