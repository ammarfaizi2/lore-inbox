Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVB1Aj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVB1Aj5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVB1Aj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:39:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48271 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261522AbVB1Afr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:35:47 -0500
Message-ID: <4222674A.9070403@pobox.com>
Date: Sun, 27 Feb 2005 19:35:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wen Xiong <wendyx@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [ patch 3/7] drivers/serial/jsm: new serial device driver
References: <42225A37.6070105@us.ltcfwd.linux.ibm.com>
In-Reply-To: <42225A37.6070105@us.ltcfwd.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Xiong wrote:
> +static inline void neo_set_rts_flow_control(struct channel_t *ch)
> +{
> +	uchar ier = readb(&ch->ch_neo_uart->ier);
> +	uchar efr = readb(&ch->ch_neo_uart->efr);

Do not invent new types like "ushort" or "uchar".

For situations where specific size is required, use a size-specific 
type:  u8, u16, u32, etc.



> +static inline void neo_set_ixon_flow_control(struct channel_t *ch)

This function is vaguely large.  Why is it inline?


> +{
> +	uchar ier = readb(&ch->ch_neo_uart->ier);
> +	uchar efr = readb(&ch->ch_neo_uart->efr);

ditto the "don't invent non-standard types" comment.




> +static inline void neo_set_ixoff_flow_control(struct channel_t *ch)

why inline?

> +{
> +	uchar ier = readb(&ch->ch_neo_uart->ier);
> +	uchar efr = readb(&ch->ch_neo_uart->efr);

non-standard types




> +static inline void neo_set_no_input_flow_control(struct channel_t *ch)
> +{
> +	uchar ier = readb(&ch->ch_neo_uart->ier);
> +	uchar efr = readb(&ch->ch_neo_uart->efr);

ditto



> +static inline void neo_set_no_output_flow_control(struct channel_t *ch)
> +{
> +	uchar ier = readb(&ch->ch_neo_uart->ier);
> +	uchar efr = readb(&ch->ch_neo_uart->efr);

ditto



> +static void neo_copy_data_from_uart_to_queue(struct channel_t *ch)
> +{
> +	int qleft = 0;
> +	uchar linestatus = 0;
> +	uchar error_mask = 0;
> +	int n = 0;
> +	int total = 0;  
> +	ushort head;
> +	ushort tail;

non-standard types


> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	/* cache head and tail of queue */
> +	head = ch->ch_r_head & RQUEUEMASK;
> +	tail = ch->ch_r_tail & RQUEUEMASK;
> +
> +	/* Get our cached LSR */
> +	linestatus = ch->ch_cached_lsr;
> +	ch->ch_cached_lsr = 0;
> +
> +	/* Store how much space we have left in the queue */
> +	if ((qleft = tail - head - 1) < 0)
> +		qleft += RQUEUEMASK + 1;
> +
> +	/*
> +	 * If the UART is not in FIFO mode, force the FIFO copy to
> +	 * NOT be run, by setting total to 0.
> +	 *
> +	 * On the other hand, if the UART IS in FIFO mode, then ask
> +	 * the UART to give us an approximation of data it has RX'ed.
> +	 */
> +	if (!(ch->ch_flags & CH_FIFO_ENABLED))
> +		total = 0;
> +	else {
> +		total = readb(&ch->ch_neo_uart->rfifo);
> +
> +		/*
> +		 * EXAR chip bug - RX FIFO COUNT - Fudge factor.
> +		 *
> +		 * This resolves a problem/bug with the Exar chip that sometimes
> +		 * returns a bogus value in the rfifo register.
> +		 * The count can be any where from 0-3 bytes "off".
> +		 * Bizarre, but true.
> +		 */
> +		total -= 3;
> +	}
> +
> +	/*
> +	 * Finally, bound the copy to make sure we don't overflow
> +	 * our own queue...
> +	 * The byte by byte copy loop below this loop this will
> +	 * deal with the queue overflow possibility.
> +	 */
> +	total = min(total, qleft);
> +
> +	while (total > 0) { 
> +		/*
> +		 * Grab the linestatus register, we need to check
> +		 * to see if there are any errors in the FIFO.
> +		 */
> +		linestatus = readb(&ch->ch_neo_uart->lsr);
> +
> +		/*
> +		 * Break out if there is a FIFO error somewhere.
> +		 * This will allow us to go byte by byte down below,
> +		 * finding the exact location of the error.
> +		 */
> +		if (linestatus & UART_17158_RX_FIFO_DATA_ERROR)
> +			break;
> +
> +		/* Make sure we don't go over the end of our queue */
> +		n = min(((uint) total), (RQUEUESIZE - (uint) tail));
> +
> +		/*
> +		 * Cut down n even further if needed, this is to fix
> +		 * a problem with memcpy_fromio() with the Neo on the
> +		 * IBM pSeries platform.
> +		 * 15 bytes max appears to be the magic number.
> +		 */
> +		n = min((uint) n, (uint) 12);

more non-standard types


> +		/*
> +		 * Since we are grabbing the linestatus register, which
> +		 * will reset some bits after our read, we need to ensure
> +		 * we don't miss our TX FIFO emptys.
> +		 */
> +		if (linestatus & (UART_LSR_THRE | UART_17158_TX_AND_FIFO_CLR))
> +			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +
> +		linestatus = 0;
> +
> +		/* Copy data from uart to the queue */
> +		memcpy_fromio(ch->ch_rqueue + head, &ch->ch_neo_uart->txrxburst, n);
> +		jsm_sniff_nowait_nolock(ch, "UART READ", ch->ch_rqueue + head, n);
> +
> +		/*
> +		 * Since RX_FIFO_DATA_ERROR was 0, we are guarenteed
> +		 * that all the data currently in the FIFO is free of
> +		 * breaks and parity/frame/orun errors.
> +		 */
> +		memset(ch->ch_equeue + head, 0, n);
> +
> +		/* Add to and flip head if needed */
> +		head = (head + n) & RQUEUEMASK;
> +		total -= n;
> +		qleft -= n;
> +		ch->ch_rxcount += n;
> +	}
> +
> +	/*
> +	 * Create a mask to determine whether we should
> +	 * insert the character (if any) into our queue.
> +	 */
> +	if (ch->ch_c_iflag & IGNBRK)
> +		error_mask |= UART_LSR_BI;
> +
> +	/*
> +	 * Now cleanup any leftover bytes still in the UART.
> +	 * Also deal with any possible queue overflow here as well.
> +	 */
> +	while (1) {
> +
> +		/*
> +		 * Its possible we have a linestatus from the loop above
> +		 * this, so we "OR" on any extra bits.
> +		 */
> +		linestatus |= readb(&ch->ch_neo_uart->lsr);
> +
> +		/*
> +		 * If the chip tells us there is no more data pending to
> +		 * be read, we can then leave.
> +		 * But before we do, cache the linestatus, just in case.
> +		 */
> +		if (!(linestatus & UART_LSR_DR)) {
> +			ch->ch_cached_lsr = linestatus;
> +			break;
> +		}
> +
> +		/* No need to store this bit */
> +		linestatus &= ~UART_LSR_DR;
> +
> +		/*
> +		 * Since we are grabbing the linestatus register, which
> +		 * will reset some bits after our read, we need to ensure
> +		 * we don't miss our TX FIFO emptys.
> +		 */
> +		if (linestatus & (UART_LSR_THRE | UART_17158_TX_AND_FIFO_CLR)) {
> +			linestatus &= ~(UART_LSR_THRE | UART_17158_TX_AND_FIFO_CLR);
> +			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +		}
> +
> +		/*
> +		 * Discard character if we are ignoring the error mask.
> +		 */
> +		if (linestatus & error_mask)  {
> +			uchar discard;
> +			linestatus = 0;
> +			memcpy_fromio(&discard, &ch->ch_neo_uart->txrxburst, 1);
> +			continue;
> +		}
> +
> +		/*
> +		 * If our queue is full, we have no choice but to drop some data.
> +		 * The assumption is that HWFLOW or SWFLOW should have stopped
> +		 * things way way before we got to this point.
> +		 *
> +		 * I decided that I wanted to ditch the oldest data first,
> +		 * I hope thats okay with everyone? Yes? Good.
> +		 */
> +		while (qleft < 1) {
> +			DPR_READ(("Queue full, dropping DATA:%x LSR:%x\n",
> +				ch->ch_rqueue[tail], ch->ch_equeue[tail]));
> +
> +			ch->ch_r_tail = tail = (tail + 1) & RQUEUEMASK;
> +			ch->ch_err_overrun++;
> +			qleft++;
> +		}
> +
> +		memcpy_fromio(ch->ch_rqueue + head, &ch->ch_neo_uart->txrxburst, 1);
> +		ch->ch_equeue[head] = (uchar) linestatus;
> +		jsm_sniff_nowait_nolock(ch, "UART READ", ch->ch_rqueue + head, 1);
> +
> +		DPR_READ(("DATA/LSR pair: %x %x\n", ch->ch_rqueue[head], ch->ch_equeue[head]));
> +
> +		/* Ditch any remaining linestatus value. */
> +		linestatus = 0;
> +
> +		/* Add to and flip head if needed */
> +		head = (head + 1) & RQUEUEMASK;
> +
> +		qleft--;
> +		ch->ch_rxcount++;
> +	}
> +
> +	/*
> +	 * Write new final heads to channel structure.
> +	 */
> +	ch->ch_r_head = head & RQUEUEMASK;
> +	ch->ch_e_head = head & EQUEUEMASK;
> +	jsm_input(ch);
> +}
> +
> +static void neo_copy_data_from_queue_to_uart(struct channel_t *ch)
> +{
> +	ushort head;
> +	ushort tail;
> +	int n;
> +	int s;
> +	int qlen;
> +	uint len_written = 0;

I'll stop mentioning non-standard types, though the code continues to 
use them.  You get the picture.




> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	/* No data to write to the UART */ 
> +	if (ch->ch_w_tail == ch->ch_w_head)
> +		return;
> +
> +	/* If port is "stopped", don't send any data to the UART */
> +	if ((ch->ch_flags & CH_STOP) || (ch->ch_flags & CH_BREAK_SENDING))
> +		return;
> +	/*
> +	 * If FIFOs are disabled. Send data directly to txrx register
> +	 */
> +	if (!(ch->ch_flags & CH_FIFO_ENABLED)) {
> +		uchar lsrbits = readb(&ch->ch_neo_uart->lsr);
> +
> +		ch->ch_cached_lsr |= lsrbits;
> +		if (ch->ch_cached_lsr & UART_LSR_THRE) {
> +			ch->ch_cached_lsr &= ~(UART_LSR_THRE);
> +
> +			writeb(ch->ch_wqueue[ch->ch_w_tail], &ch->ch_neo_uart->txrx);
> +			DPR_WRITE(("Tx data: %x\n", ch->ch_wqueue[ch->ch_w_head]));
> +			ch->ch_w_tail++;
> +			ch->ch_w_tail &= WQUEUEMASK;
> +			ch->ch_txcount++;
> +		}
> +		return;
> +	}
> +
> +	/*
> +	 * We have to do it this way, because of the EXAR TXFIFO count bug.
> +	 */
> +	if (!(ch->ch_flags & (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM)))
> +		return; 
> +
> +	len_written = 0;
> +	n = UART_17158_TX_FIFOSIZE - ch->ch_t_tlevel;
> +
> +	/* cache head and tail of queue */
> +	head = ch->ch_w_head & WQUEUEMASK;
> +	tail = ch->ch_w_tail & WQUEUEMASK;
> +	qlen = (head - tail) & WQUEUEMASK;
> +
> +	/* Find minimum of the FIFO space, versus queue length */
> +	n = min(n, qlen);
> +
> +	while (n > 0) {
> +
> +		s = ((head >= tail) ? head : WQUEUESIZE) - tail;
> +		s = min(s, n);
> +
> +		if (s <= 0)
> +			break;
> +
> +		memcpy_toio(&ch->ch_neo_uart->txrxburst, ch->ch_wqueue + tail, s);
> +		jsm_sniff_nowait_nolock(ch, "UART WRITE", ch->ch_wqueue + tail, s);
> +
> +		/* Add and flip queue if needed */
> +		tail = (tail + s) & WQUEUEMASK;
> +		n -= s;
> +		ch->ch_txcount += s;
> +		len_written += s;
> +	}
> +
> +	/* Update the final tail */
> +	ch->ch_w_tail = tail & WQUEUEMASK;
> +
> +	if (len_written >= ch->ch_t_tlevel)
> +		ch->ch_flags &= ~(CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +
> +	if (!jsm_tty_write(&ch->uart_port))
> +		uart_write_wakeup(&ch->uart_port);
> +}
> +
> +static void neo_parse_modem(struct channel_t *ch, uchar signals)
> +{
> +	volatile uchar msignals = signals;

Maxim:  "volatile indicates bugs".  Don't use volatile, fix the code 
instead.


> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	DPR_MSIGS(("neo_parse_modem: port: %d msignals: %x\n", ch->ch_portnum, msignals));
> +
> +
> +	/* Scrub off lower bits. They signify delta's, which I don't care about */
> +	msignals &= 0xf0;
> +
> +	if (msignals & UART_MSR_DCD)
> +		ch->ch_mistat |= UART_MSR_DCD;
> +	else
> +		ch->ch_mistat &= ~UART_MSR_DCD;
> +
> +	if (msignals & UART_MSR_DSR)
> +		ch->ch_mistat |= UART_MSR_DSR;
> +	else
> +		ch->ch_mistat &= ~UART_MSR_DSR;
> +
> +	if (msignals & UART_MSR_RI)
> +		ch->ch_mistat |= UART_MSR_RI;
> +	else
> +		ch->ch_mistat &= ~UART_MSR_RI;
> +
> +	if (msignals & UART_MSR_CTS)
> +		ch->ch_mistat |= UART_MSR_CTS;
> +	else
> +		ch->ch_mistat &= ~UART_MSR_CTS;
> +
> +	DPR_MSIGS(("Port: %d DTR: %d RTS: %d CTS: %d DSR: %d " "RI: %d CD: %d\n",
> +		ch->ch_portnum,
> +		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_DTR),
> +		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_RTS),
> +		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_CTS), 
> +		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_DSR), 
> +		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_RI),
> +		!!((ch->ch_mistat | ch->ch_mostat) & UART_MSR_DCD)));
> +}
> +
> +/* Make the UART raise any of the output signals we want up */
> +static void neo_assert_modem_signals(struct channel_t *ch)
> +{
> +	uchar out;
> +
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	out = ch->ch_mostat;
> +
> +	writeb(out, &ch->ch_neo_uart->mcr);
> +
> +	/* Give time for the UART to actually raise/drop the signals */
> +	udelay(10);

PCI posting


> +}
> +
> +/*
> + * Flush the WRITE FIFO on the Neo.
> + *
> + * NOTE: Channel lock MUST be held before calling this function!
> + */
> +static void neo_flush_uart_write(struct channel_t *ch)
> +{
> +	uchar tmp = 0;
> +	int i = 0;
> +
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	writeb((UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_XMIT), &ch->ch_neo_uart->isr_fcr);
> +
> +	for (i = 0; i < 10; i++) {
> +
> +		/* Check to see if the UART feels it completely flushed the FIFO. */
> +		tmp = readb(&ch->ch_neo_uart->isr_fcr);
> +		if (tmp & 4) {
> +			DPR_IOCTL(("Still flushing TX UART... i: %d\n", i));
> +			udelay(10);
> +		}
> +		else
> +			break;
> +	}
> +
> +	ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +}
> +
> +
> +/*
> + * Flush the READ FIFO on the Neo.
> + *
> + * NOTE: Channel lock MUST be held before calling this function!
> + */
> +static void neo_flush_uart_read(struct channel_t *ch)
> +{
> +	uchar tmp = 0;
> +	int i = 0;
> +
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	writeb((UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR), &ch->ch_neo_uart->isr_fcr);
> +
> +	for (i = 0; i < 10; i++) {
> +
> +		/* Check to see if the UART feels it completely flushed the FIFO. */
> +		tmp = readb(&ch->ch_neo_uart->isr_fcr);
> +		if (tmp & 2) {
> +			DPR_IOCTL(("Still flushing RX UART... i: %d\n", i));
> +			udelay(10);
> +		}
> +		else
> +			break;
> +	}
> +}
> +
> +/*
> + * No locks are assumed to be held when calling this function.
> + */
> +void neo_clear_break(struct channel_t *ch, int force)
> +{
> +	ulong lock_flags;
> +
> +	spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +
> +	/* Turn break off, and unset some variables */
> +	if (ch->ch_flags & CH_BREAK_SENDING) {
> +		uchar temp = readb(&ch->ch_neo_uart->lcr);
> +		writeb((temp & ~UART_LCR_SBC), &ch->ch_neo_uart->lcr);
> +
> +		ch->ch_flags &= ~(CH_BREAK_SENDING);
> +		DPR_IOCTL((" clear break Finishing UART_LCR_SBC! finished: %lx\n", jiffies));
> +	}
> +	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +}
> +
> +/*
> + * Parse the ISR register.
> + */
> +static inline void neo_parse_isr(struct board_t *brd, uint port)
> +{
> +	struct channel_t *ch;
> +	uchar isr;
> +	uchar cause;
> +	ulong lock_flags;
> +
> +	if (!brd || brd->magic != JSM_BOARD_MAGIC)
> +		return;
> +
> +	if (port > brd->maxports)
> +		return;
> +
> +	ch = brd->channels[port];
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	/* Here we try to figure out what caused the interrupt to happen */
> +	while (1) {
> +
> +		isr = readb(&ch->ch_neo_uart->isr_fcr);
> +
> +		/* Bail if no pending interrupt */
> +		if (isr & UART_IIR_NO_INT)  {
> +			break;
> +		}
> +
> +		/*
> +		 * Yank off the upper 2 bits, which just show that the FIFO's are enabled.
> +		 */
> +		isr &= ~(UART_17158_IIR_FIFO_ENABLED);
> +
> +		DPR_INTR(("%s:%d isr: %x\n", __FILE__, __LINE__, isr));
> +
> +		if (isr & (UART_17158_IIR_RDI_TIMEOUT | UART_IIR_RDI)) {
> +			/* Read data from uart -> queue */
> +			neo_copy_data_from_uart_to_queue(ch);
> +
> +			/* Call our tty layer to enforce queue flow control if needed. */
> +			spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +			jsm_check_queue_flow_control(ch);
> +			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +		}
> +
> +		if (isr & UART_IIR_THRI) {
> +			/* Transfer data (if any) from Write Queue -> UART. */
> +			spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +			ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +			spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +			neo_copy_data_from_queue_to_uart(ch);
> +		}
> +
> +		if (isr & UART_17158_IIR_XONXOFF) {
> +			cause = readb(&ch->ch_neo_uart->xoffchar1);
> +
> +			DPR_INTR(("Port %d. Got ISR_XONXOFF: cause:%x\n", port, cause));
> +
> +			/*
> +			 * Since the UART detected either an XON or
> +			 * XOFF match, we need to figure out which
> +			 * one it was, so we can suspend or resume data flow.
> +			 */
> +			if (cause == UART_17158_XON_DETECT) {
> +				/* Is output stopped right now, if so, resume it */
> +				if (brd->channels[port]->ch_flags & CH_STOP) {
> +					spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +					ch->ch_flags &= ~(CH_STOP);
> +					spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +				}
> +				DPR_INTR(("Port %d. XON detected in incoming data\n", port));
> +			} 
> +			else if (cause == UART_17158_XOFF_DETECT) {
> +				if (!(brd->channels[port]->ch_flags & CH_STOP)) {
> +					spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +					ch->ch_flags |= CH_STOP;
> +					spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +					DPR_INTR(("Setting CH_STOP\n"));
> +				}
> +				DPR_INTR(("Port: %d. XOFF detected in incoming data\n", port));
> +			}
> +		}
> +
> +		if (isr & UART_17158_IIR_HWFLOW_STATE_CHANGE) {
> +			/*
> +			 * If we get here, this means the hardware is doing auto flow control.
> +			 * Check to see whether RTS/DTR or CTS/DSR caused this interrupt.
> +			 */
> +			cause = readb(&ch->ch_neo_uart->mcr);
> +			/* Which pin is doing auto flow? RTS or DTR? */
> +			if ((cause & 0x4) == 0) {
> +				if (cause & UART_MCR_RTS) {
> +					spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +					ch->ch_mostat |= UART_MCR_RTS;
> +					spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +				}
> +				else {
> +					spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +					ch->ch_mostat &= ~(UART_MCR_RTS);
> +					spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +				}
> +			} else {
> +				if (cause & UART_MCR_DTR) {
> +					spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +					ch->ch_mostat |= UART_MCR_DTR;
> +					spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +				}
> +				else {
> +					spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +					ch->ch_mostat &= ~(UART_MCR_DTR);
> +					spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +				}
> +			}
> +		}

The locking in this function is AWFUL.  The worst case has you acquiring 
and releasing the same lock several times.


> +		/* Parse any modem signal changes */
> +		DPR_INTR(("MOD_STAT: sending to parse_modem_sigs\n"));
> +		neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
> +	}
> +}
> +
> +static inline void neo_parse_lsr(struct board_t *brd, uint port)
> +{
> +	struct channel_t *ch;
> +	int linestatus;
> +	ulong lock_flags;
> +
> +	if (!brd)
> +		return;
> +
> +	if (brd->magic != JSM_BOARD_MAGIC)
> +		return;
> +
> +	if (port > brd->maxports)
> +		return;
> +
> +	ch = brd->channels[port];
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	linestatus = readb(&ch->ch_neo_uart->lsr);
> +
> +	DPR_INTR(("%s:%d port: %d linestatus: %x\n", __FILE__, __LINE__, port, linestatus));
> +
> +	ch->ch_cached_lsr |= linestatus;
> +
> +	if (ch->ch_cached_lsr & UART_LSR_DR) {
> +		/* Read data from uart -> queue */
> +		neo_copy_data_from_uart_to_queue(ch);
> +		spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +		jsm_check_queue_flow_control(ch);
> +		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +	}
> +
> +	/*
> +	 * This is a special flag. It indicates that at least 1
> +	 * RX error (parity, framing, or break) has happened.
> +	 * Mark this in our struct, which will tell me that I have
> +	 *to do the special RX+LSR read for this FIFO load.
> +	 */
> +	if (linestatus & UART_17158_RX_FIFO_DATA_ERROR)
> +		DPR_INTR(("%s:%d Port: %d Got an RX error, need to parse LSR\n",
> +			__FILE__, __LINE__, port));
> +
> +	/*
> +	 * The next 3 tests should *NOT* happen, as the above test
> +	 * should encapsulate all 3... At least, thats what Exar says.
> +	 */
> +
> +	if (linestatus & UART_LSR_PE) {
> +		ch->ch_err_parity++;
> +		DPR_INTR(("%s:%d Port: %d. PAR ERR!\n", __FILE__, __LINE__, port));
> +	}
> +
> +	if (linestatus & UART_LSR_FE) {
> +		ch->ch_err_frame++;
> +		DPR_INTR(("%s:%d Port: %d. FRM ERR!\n", __FILE__, __LINE__, port));
> +	}
> +
> +	if (linestatus & UART_LSR_BI) {
> +		ch->ch_err_break++;
> +		DPR_INTR(("%s:%d Port: %d. BRK INTR!\n", __FILE__, __LINE__, port));
> +	}
> +
> +	if (linestatus & UART_LSR_OE) {
> +		/*
> +		 * Rx Oruns. Exar says that an orun will NOT corrupt
> +		 * the FIFO. It will just replace the holding register
> +		 * with this new data byte. So basically just ignore this.
> +		 * Probably we should eventually have an orun stat in our driver...
> +		 */
> +		ch->ch_err_overrun++;
> +		DPR_INTR(("%s:%d Port: %d. Rx Overrun!\n", __FILE__, __LINE__, port));
> +	}
> +
> +	if (linestatus & UART_LSR_THRE) {
> +		spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +		ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +
> +		/* Transfer data (if any) from Write Queue -> UART. */
> +		neo_copy_data_from_queue_to_uart(ch);
> +	}
> +	else if (linestatus & UART_17158_TX_AND_FIFO_CLR) {
> +		spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +		ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +		spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +
> +		/* Transfer data (if any) from Write Queue -> UART. */
> +		neo_copy_data_from_queue_to_uart(ch);
> +	}
> +}
> +
> +/*
> + * neo_param()
> + * Send any/all changes to the line to the UART.
> + */
> +static void neo_param(struct channel_t *ch)
> +{
> +	uchar lcr = 0;
> +	uchar uart_lcr = 0;
> +	uchar ier = 0;
> +	uint baud = 9600;
> +	int quot = 0;
> +	struct board_t *bd;
> +
> +	bd = ch->ch_bd;
> +	if (!bd || bd->magic != JSM_BOARD_MAGIC)
> +		return;
> +
> +	/*
> +	 * If baud rate is zero, flush queues, and set mval to drop DTR.
> +	 */
> +	if ((ch->ch_c_cflag & (CBAUD)) == 0) {
> +		ch->ch_r_head = ch->ch_r_tail = 0;
> +		ch->ch_e_head = ch->ch_e_tail = 0;
> +		ch->ch_w_head = ch->ch_w_tail = 0;
> +
> +		neo_flush_uart_write(ch);
> +		neo_flush_uart_read(ch);
> +
> +		ch->ch_flags |= (CH_BAUD0);
> +		ch->ch_mostat &= ~(UART_MCR_RTS | UART_MCR_DTR);
> +		neo_assert_modem_signals(ch);
> +		ch->ch_old_baud = 0;
> +		return;
> +
> +	} else if (ch->ch_custom_speed) {
> +			baud = ch->ch_custom_speed;
> +			if (ch->ch_flags & CH_BAUD0)
> +				ch->ch_flags &= ~(CH_BAUD0);
> +		} else {
> +			int iindex = 0;
> +			int jindex = 0;
> +
> +			ulong bauds[4][16] = {
> +				{ 
> +					0,	50,	75,	110,
> +					134,	150,	200,	300,
> +					600,	1200,   1800,   2400,
> +					4800,   9600,   19200,  38400 },
> +				{ 
> +					0,	57600,  115200, 230400,
> +					460800, 150,	200,	921600,
> +					600,	1200,   1800,   2400,
> +					4800,   9600,   19200,  38400 },
> +				{ 
> +					0,	57600,   76800, 115200,
> +					131657, 153600, 230400, 460800,
> +					921600, 1200,   1800,   2400,
> +					4800,   9600,   19200,  38400 },
> +				{ 
> +					0,	57600,  115200, 230400,
> +					460800, 150,	200,	921600,
> +					600,	1200,   1800,   2400,
> +					4800,   9600,   19200,  38400 }
> +			};

const


> +			if (!(ch->ch_tun.un_flags & UN_ISOPEN) )
> +				baud = C_BAUD(ch->uart_port.info->tty) & 0xff;
> +			else
> +				baud = C_BAUD(ch->uart_port.info->tty) & 0xff;
> +
> +
> +			if (ch->ch_c_cflag & CBAUDEX)
> +				iindex = 1;
> +
> +			jindex = baud;
> +
> +			if ((iindex >= 0) && (iindex < 4) && (jindex >= 0) && (jindex < 16))
> +				baud = bauds[iindex][jindex];  
> +			else {
> +				DPR_IOCTL(("baud indices were out of range (%d)(%d)",
> +				iindex, jindex));
> +				baud = 0;
> +			}
> +
> +			if (baud == 0)
> +				baud = 9600;
> +
> +			if (ch->ch_flags & CH_BAUD0) {
> +				ch->ch_flags &= ~(CH_BAUD0);
> +			}
> +		}
> +
> +	if (ch->ch_c_cflag & PARENB)
> +		lcr |= UART_LCR_PARITY;
> +
> +	if (!(ch->ch_c_cflag & PARODD))
> +		lcr |= UART_LCR_EPAR;
> +
> +	/* 
> +	 * Not all platforms support mark/space parity,
> +	 * so this will hide behind an ifdef.
> +	 */
> +#ifdef CMSPAR
> +	if (ch->ch_c_cflag & CMSPAR) 
> +		lcr |= UART_LCR_SPAR;
> +#endif
> +
> +	if (ch->ch_c_cflag & CSTOPB)
> +		lcr |= UART_LCR_STOP;
> +
> +	switch (ch->ch_c_cflag & CSIZE) {
> +		case CS5:
> +			lcr |= UART_LCR_WLEN5;
> +			break;
> +		case CS6:
> +			lcr |= UART_LCR_WLEN6;
> +			break;
> +		case CS7:
> +			lcr |= UART_LCR_WLEN7;
> +			break;
> +		case CS8:
> +		default:
> +			lcr |= UART_LCR_WLEN8;
> +		break;
> +	}
> +
> +	ier = readb(&ch->ch_neo_uart->ier);
> +	uart_lcr = readb(&ch->ch_neo_uart->lcr);
> +
> +	if (baud == 0)
> +		baud = 9600;
> +
> +	quot = ch->ch_bd->bd_dividend / baud;
> +
> +	if (quot != 0) {
> +		ch->ch_old_baud = baud;
> +		writeb(UART_LCR_DLAB, &ch->ch_neo_uart->lcr);
> +		writeb((quot & 0xff), &ch->ch_neo_uart->txrx);
> +		writeb((quot >> 8), &ch->ch_neo_uart->ier);
> +		writeb(lcr, &ch->ch_neo_uart->lcr);
> +	}
> +
> +	if (uart_lcr != lcr)
> +		writeb(lcr, &ch->ch_neo_uart->lcr);
> +
> +	if (ch->ch_c_cflag & CREAD)
> +		ier |= (UART_IER_RDI | UART_IER_RLSI);
> +
> +	ier |= (UART_IER_THRI | UART_IER_MSI);
> +
> +	writeb(ier, &ch->ch_neo_uart->ier);
> +
> +	/* Set new start/stop chars */
> +	neo_set_new_start_stop_chars(ch);
> +
> +	if (ch->ch_c_cflag & CRTSCTS)
> +		neo_set_cts_flow_control(ch);
> +	else if (ch->ch_c_iflag & IXON) {
> +		/* If start/stop is set to disable, then we should disable flow control */
> +		if ((ch->ch_startc == _POSIX_VDISABLE) || (ch->ch_stopc == _POSIX_VDISABLE))
> +			neo_set_no_output_flow_control(ch);
> +		else
> +			neo_set_ixon_flow_control(ch);
> +	}
> +	else
> +		neo_set_no_output_flow_control(ch);
> +
> +	if (ch->ch_c_cflag & CRTSCTS)
> +		neo_set_rts_flow_control(ch);
> +	else if (ch->ch_c_iflag & IXOFF) {
> +		/* If start/stop is set to disable, then we should disable flow control */
> +		if ((ch->ch_startc == _POSIX_VDISABLE) || (ch->ch_stopc == _POSIX_VDISABLE))
> +			neo_set_no_input_flow_control(ch);
> +		else
> +			neo_set_ixoff_flow_control(ch);
> +	} 
> +	else
> +		neo_set_no_input_flow_control(ch);
> +	/*
> +	 * Adjust the RX FIFO Trigger level if baud is less than 9600.
> +	 * Not exactly elegant, but this is needed because of the Exar chip's
> +	 * delay on firing off the RX FIFO interrupt on slower baud rates.
> +	 */
> +	if (baud < 9600) {
> +		writeb(1, &ch->ch_neo_uart->rfifo);
> +		ch->ch_r_tlevel = 1;
> +	}
> +
> +	neo_assert_modem_signals(ch);
> +
> +	/* Get current status of the modem signals now */
> +	neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
> +	return;
> +}
> +
> +/*
> + * Our board poller function.
> + */
> +static void neo_tasklet(unsigned long data)
> +{
> +	struct board_t *bd = (struct board_t *) data;
> +	struct channel_t *ch;
> +	ulong  lock_flags;
> +	int i;
> +	int state = 0;
> +	int ports = 0;
> +
> +	if (!bd || bd->magic != JSM_BOARD_MAGIC) {
> +		APR(("poll_tasklet() - NULL or bad bd.\n"));
> +		return;
> +	}
> +
> +	/* Cache a couple board values */
> +	spin_lock_irqsave(&bd->bd_lock, lock_flags);
> +	state = bd->state;
> +	ports = bd->nasync;
> +	spin_unlock_irqrestore(&bd->bd_lock, lock_flags);
> +
> +	/*
> +	 * Do NOT allow the interrupt routine to read the intr registers
> +	 * Until we release this lock.
> +	 */
> +	spin_lock_irqsave(&bd->bd_intr_lock, lock_flags);
> +
> +	/*
> +	 * If board is ready, parse deeper to see if there is anything to do.
> +	 */
> +	if ((state == BOARD_READY) && (ports > 0)) {
> +		/* Loop on each port */
> +		for (i = 0; i < ports; i++) {
> +			ch = bd->channels[i];
> +
> +			/* Just being careful... */
> +			if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +				continue;
> +			if (ch->ch_tun.un_flags != UN_ISOPEN)
> +				continue;
> +
> +			/*
> +			 * NOTE: Remember you CANNOT hold any channel
> +			 * locks when calling the input routine.
> +			 *
> +			 * During input processing, its possible we
> +			 * will call the Linux ld, which might in turn,
> +			 * do a callback right back into us, resulting
> +			 * in us trying to grab the channel lock twice!
> +			 */
> +			jsm_input(ch);
> +
> +			/*
> +			 * Channel lock is grabbed and then released
> +			 * inside both of these routines, but neither
> +			 * call anything else that could call back into us.
> +			 */
> +			neo_copy_data_from_queue_to_uart(ch);
> +			uart_write_wakeup(&ch->uart_port);
> +
> +			/*
> +			 * Call carrier carrier function, in case something
> +			 * has changed.
> +			 */
> +			jsm_carrier(ch);
> +		}
> +	}
> +
> +	/* Allow interrupt routine to access the interrupt register again */
> +	spin_unlock_irqrestore(&bd->bd_intr_lock, lock_flags);
> +}
> +
> +/*
> + * jsm_neo_intr()
> + *
> + * Neo specific interrupt handler.
> + */
> +static JSM_IRQRETURN_TYPE neo_intr(int irq, void *voidbrd, struct pt_regs *regs)

do not define a non-standard JSM_IRQRETURN_TYPE


> +	struct board_t *brd = (struct board_t *) voidbrd;
> +	struct channel_t *ch;
> +	int port = 0;
> +	int type = 0;
> +	int current_port;
> +	u32 tmp;
> +	u32 uart_poll;
> +	unsigned long lock_flags;
> +	unsigned long lock_flags2;
> +
> +	if (!brd) {
> +		APR(("Received interrupt (%d) with null board associated\n", irq));
> +		JSM_IRQ_RETURN(IRQ_NONE);
> +	}

eliminate 'if' test that will never succeed


> +	/*
> +	 * Check to make sure its for us.
> +	 */
> +	if (brd->magic != JSM_BOARD_MAGIC) {
> +		APR(("Received interrupt (%d) with a board pointer that wasn't ours!\n", irq));
> +		JSM_IRQ_RETURN(IRQ_NONE);
> +	}

ditto

Also, do not define non-standard JSM_IRQ_RETURN()


> +	brd->intr_count++;
> +
> +	/* Lock out the slow poller from running on this board. */
> +	spin_lock_irqsave(&brd->bd_intr_lock, lock_flags);
> +
> +	/*
> +	 * Read in "extended" IRQ information from the 32bit Neo register.
> +	 * Bits 0-7: What port triggered the interrupt.
> +	 * Bits 8-31: Each 3bits indicate what type of interrupt occurred.
> +	 */
> +	uart_poll = readl(brd->re_map_membase + UART_17158_POLL_ADDR_OFFSET);
> +
> +	DPR_INTR(("%s:%d uart_poll: %x\n", __FILE__, __LINE__, uart_poll));
> +
> +	/*
> +	 * If 0, no interrupts pending.
> +	 * This can happen if the IRQ is shared among a couple Neo/Classic boards.
> +	 */

Incorrect comment.  The irq can be shared with boards your driver will 
never touch.


> +	if (!uart_poll) {
> +		DPR_INTR(("Kernel interrupted to me, but no pending interrupts...\n"));
> +		spin_unlock_irqrestore(&brd->bd_intr_lock, lock_flags);
> +		JSM_IRQ_RETURN(IRQ_NONE);
> +	}
> +
> +	/* At this point, we have at least SOMETHING to service, dig further... */
> +
> +	current_port = 0;
> +
> +	/* Loop on each port */
> +	while ((uart_poll & 0xff) != 0) {

infinite loop if hardware is unplugged, or on hardware fault.



> +		tmp = uart_poll;
> +
> +		/* Check current port to see if it has interrupt pending */
> +		if ((tmp & jsm_offset_table[current_port]) != 0) {
> +			port = current_port;
> +			type = tmp >> (8 + (port * 3));
> +			type &= 0x7;
> +		} else {
> +			current_port++;
> +			continue;
> +		}
> +
> +		DPR_INTR(("%s:%d port: %x type: %x\n", __FILE__, __LINE__, port, type));
> +
> +		/* Remove this port + type from uart_poll */
> +		uart_poll &= ~(jsm_offset_table[port]);
> +
> +		if (!type) {
> +			/* If no type, just ignore it, and move onto next port */
> +			DPR_INTR(("Interrupt with no type! port: %d\n", port));
> +			continue;
> +		}
> +
> +		/* Switch on type of interrupt we have */
> +		switch (type) {
> +
> +		case UART_17158_RXRDY_TIMEOUT:
> +			/*
> +			 * RXRDY Time-out is cleared by reading data in the
> +			* RX FIFO until it falls below the trigger level.
> +			 */
> +
> +			/* Verify the port is in range. */
> +			if (port > brd->nasync)
> +				continue;
> +
> +			ch = brd->channels[port];
> +			neo_copy_data_from_uart_to_queue(ch);
> +
> +			/* Call our tty layer to enforce queue flow control if needed. */
> +			spin_lock_irqsave(&ch->ch_lock, lock_flags2);
> +			jsm_check_queue_flow_control(ch);
> +			spin_unlock_irqrestore(&ch->ch_lock, lock_flags2);
> +
> +			continue;
> +
> +		case UART_17158_RX_LINE_STATUS:
> +			/*
> +			 * RXRDY and RX LINE Status (logic OR of LSR[4:1])
> +			 */
> +			neo_parse_lsr(brd, port);
> +			continue;
> +
> +		case UART_17158_TXRDY:
> +			/*
> +			 * TXRDY interrupt clears after reading ISR register for the UART channel.
> +			 */
> +
> +			/*
> +			 * Yes, this is odd...
> +			 * Why would I check EVERY possibility of type of
> +			 * interrupt, when we know its TXRDY???
> +			 * Becuz for some reason, even tho we got triggered for TXRDY,
> +			 * it seems to be occassionally wrong. Instead of TX, which
> +			 * it should be, I was getting things like RXDY too. Weird.
> +			 */
> +			neo_parse_isr(brd, port);
> +			continue;
> +
> +		case UART_17158_MSR:
> +			/*
> +			 * MSR or flow control was seen.
> +			 */
> +			neo_parse_isr(brd, port);
> +			continue;
> +
> +		default:
> +			/*
> +			 * The UART triggered us with a bogus interrupt type.
> +			 * It appears the Exar chip, when REALLY bogged down, will throw
> +			 * these once and awhile.
> +			 * Its harmless, just ignore it and move on.
> +			 */
> +			DPR_INTR(("%s:%d Unknown Interrupt type: %x\n", __FILE__, __LINE__, type));
> +			continue;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&brd->bd_intr_lock, lock_flags);
> +
> +	DPR_INTR(("jsm_intr finish.\n"));
> +	JSM_IRQ_RETURN(IRQ_HANDLED);
> +}
> +
> +/*
> + * Neo specific way of turning off the receiver.
> + * Used as a way to enforce queue flow control when in
> + * hardware flow control mode.
> + */
> +static void neo_disable_receiver(struct channel_t *ch)
> +{
> +	uchar tmp = readb(&ch->ch_neo_uart->ier);
> +	tmp &= ~(UART_IER_RDI);
> +	writeb(tmp, &ch->ch_neo_uart->ier);
> +}
> +
> +
> +/*
> + * Neo specific way of turning on the receiver.
> + * Used as a way to un-enforce queue flow control when in
> + * hardware flow control mode.
> + */
> +static void neo_enable_receiver(struct channel_t *ch)
> +{
> +	uchar tmp = readb(&ch->ch_neo_uart->ier);
> +	tmp |= (UART_IER_RDI);
> +	writeb(tmp, &ch->ch_neo_uart->ier);
> +}
> +
> +/*
> + * This function basically goes to sleep for secs, or until
> + * it gets signalled that the port has fully drained.
> + */
> +static int neo_drain(struct tty_struct *tty, uint seconds)
> +{
> +	ulong lock_flags;
> +	struct channel_t *ch;
> +	struct un_t *un;
> +	int rc = 0;
> +
> +	if (!tty || tty->magic != TTY_MAGIC)
> +		return -ENXIO;
> +
> +	un = (struct un_t *) tty->driver_data;
> +	if (!un || un->magic != JSM_UNIT_MAGIC)
> +		return -ENXIO;
> +
> +	ch = un->un_ch;   
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return -ENXIO;
> +
> +	DPR_IOCTL(("%d Drain wait started.\n", __LINE__));
> +
> +	spin_lock_irqsave(&ch->ch_lock, lock_flags);
> +	un->un_flags |= UN_EMPTY;
> +	spin_unlock_irqrestore(&ch->ch_lock, lock_flags);
> +
> +	/*
> +	 * Go to sleep waiting for the tty layer to wake me back up when
> +	 * the empty flag goes away.
> +	 *
> +	 * NOTE: TODO: Do something with time passed in.
> +	 */
> +	rc = wait_event_interruptible(un->un_flags_wait, ((un->un_flags & UN_EMPTY) == 0));
> +
> +	/* If ret is non-zero, user ctrl-c'ed us */
> +	if (rc) {
> +		DPR_IOCTL(("%d Drain - User ctrl c'ed\n", __LINE__));
> +	}
> +	else {
> +		DPR_IOCTL(("%d Drain wait finished.\n", __LINE__));
> +	}
> +
> +	return rc;
> +}
> +
> +static void neo_send_start_character(struct channel_t *ch)
> +{
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	if (ch->ch_startc != _POSIX_VDISABLE) {
> +		ch->ch_xon_sends++;
> +		writeb(ch->ch_startc, &ch->ch_neo_uart->txrx);
> +		udelay(10);

PCI posting


> +
> +static void neo_send_stop_character(struct channel_t *ch)
> +{
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	if (ch->ch_stopc != _POSIX_VDISABLE) {
> +		ch->ch_xoff_sends++;
> +		writeb(ch->ch_stopc, &ch->ch_neo_uart->txrx);
> +		udelay(10);

PCI posting


> +
> +/*
> + * neo_uart_init
> + */
> +static void neo_uart_init(struct channel_t *ch)
> +{
> +	writeb(0, &ch->ch_neo_uart->ier);
> +	writeb(0, &ch->ch_neo_uart->efr);
> +	writeb(UART_EFR_ECB, &ch->ch_neo_uart->efr);
> +
> +
> +	/* Clear out UART and FIFO */
> +	readb(&ch->ch_neo_uart->txrx);
> +	writeb((UART_FCR_ENABLE_FIFO|UART_FCR_CLEAR_RCVR|UART_FCR_CLEAR_XMIT), &ch->ch_neo_uart->isr_fcr);
> +	readb(&ch->ch_neo_uart->lsr);
> +	readb(&ch->ch_neo_uart->msr);
> +
> +	ch->ch_flags |= CH_FIFO_ENABLED;
> +
> +	/* Assert any signals we want up */
> +	writeb(ch->ch_mostat, &ch->ch_neo_uart->mcr);
> +}
> +
> +/*
> + * Make the UART completely turn off.
> + */
> +static void neo_uart_off(struct channel_t *ch)
> +{
> +	/* Turn off UART enhanced bits */
> +	writeb(0, &ch->ch_neo_uart->efr);
> +
> +	/* Stop all interrupts from occurring. */
> +	writeb(0, &ch->ch_neo_uart->ier);
> +}
> +
> +static uint neo_get_uart_bytes_left(struct channel_t *ch)
> +{
> +	uchar left = 0;
> +	uchar lsr = readb(&ch->ch_neo_uart->lsr);
> +
> +	/* We must cache the LSR as some of the bits get reset once read... */
> +	ch->ch_cached_lsr |= lsr;
> + 
> +	/* Determine whether the Transmitter is empty or not */
> +	if (!(lsr & UART_LSR_TEMT))
> +		left = 1;
> +	else {
> +		ch->ch_flags |= (CH_TX_FIFO_EMPTY | CH_TX_FIFO_LWM);
> +		left = 0;
> +	}
> +
> +	return left;
> +}
> +
> +/* Channel lock MUST be held by the calling function! */
> +static void neo_send_break(struct channel_t *ch)
> +{
> +	/*
> +	 * Set the time we should stop sending the break.
> +	 * If we are already sending a break, toss away the existing
> +	 * time to stop, and use this new value instead.
> +	 */
> +
> +	/* Tell the UART to start sending the break */
> +	if (!(ch->ch_flags & CH_BREAK_SENDING)) {
> +		uchar temp = readb(&ch->ch_neo_uart->lcr);
> +		writeb((temp | UART_LCR_SBC), &ch->ch_neo_uart->lcr);
> +		ch->ch_flags |= (CH_BREAK_SENDING);
> +	}
> +}
> +
> +/*
> + * neo_send_immediate_char.
> + *
> + * Sends a specific character as soon as possible to the UART,   
> + * jumping over any bytes that might be in the write queue.
> + *
> + * The channel lock MUST be held by the calling function.
> + */
> +static void neo_send_immediate_char(struct channel_t *ch, unsigned char c)
> +{
> +	if (!ch || ch->magic != JSM_CHANNEL_MAGIC)
> +		return;
> +
> +	writeb(c, &ch->ch_neo_uart->txrx);
> +}
> +
> +struct board_ops jsm_neo_ops = {
> +	.tasklet			= neo_tasklet,
> +	.intr				= neo_intr,
> +	.uart_init			= neo_uart_init,
> +	.uart_off			= neo_uart_off,
> +	.drain				= neo_drain,
> +	.param				= neo_param,
> +	.assert_modem_signals		= neo_assert_modem_signals,
> +	.flush_uart_write		= neo_flush_uart_write,
> +	.flush_uart_read		= neo_flush_uart_read,
> +	.disable_receiver		= neo_disable_receiver,
> +	.enable_receiver		= neo_enable_receiver,
> +	.send_break			= neo_send_break,
> +	.send_start_character		= neo_send_start_character,
> +	.send_stop_character		= neo_send_stop_character,
> +	.copy_data_from_queue_to_uart	= neo_copy_data_from_queue_to_uart,
> +	.get_uart_bytes_left		= neo_get_uart_bytes_left,
> +	.send_immediate_char		= neo_send_immediate_char
> +};

