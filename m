Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965246AbVLRTRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbVLRTRA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbVLRTQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:16:40 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:21326 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932707AbVLRTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:16:36 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI:  async message handing library update
Date: Sun, 18 Dec 2005 10:59:13 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051215151948.497d703b.vwool@ru.mvista.com>
In-Reply-To: <20051215151948.497d703b.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512181059.14301.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CGbpDGMCA67mZsv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_CGbpDGMCA67mZsv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

OK, I made some time to look at that.  As I've mentioned already,
the "spi_bitbang" code needed to morph in this direction, and
that was in fact the patch I was hoping you'd be sending.  So I
finished that up instead, and have sent it separately ... but
I've also attached the C file to this response.


> +struct threaded_async_data {
> +	atomic_t exiting;
> +	struct spi_master *master;
> +	struct task_struct *thread;
> +	wait_queue_head_t wq;

I just kept the workqueue, named after its device.
It makes the code look a lot simpler!


> +	struct list_head msgs;
> +	spinlock_t lock;

> +	int (*xfer) (struct spi_master *, struct spi_message *);
> +};
> +
> +/**
> + * spi_start_async - start the thread
> + * @master: SPI controller structure which the thread is related to
> + * @return: abstract pointer to the thread context
> + */
> +int spi_start_async (struct spi_master *master, int (*xfer)(struct spi_master *,
> 				struct spi_message *)) 

I did this differently, but liked your start/stop names.  :)
So:
	int spi_bitbang_start(struct spi_bitbang *bitbang);
	int spi_bitbang_stop(struct spi_bitbang *bitbang);

to start and stop processing the queue associated with the bitbanged
spi_master.  Callbacks just get stored in the structure; simpler,
and the return value is just a normal zero-or-negative-errno.


> @@ -152,6 +152,7 @@ static inline void spi_unregister_driver
>   * 	device's SPI controller; protocol code may call this.
>   * @transfer: adds a message to the controller's transfer queue.
>   * @cleanup: frees controller-specific state
> + * @context: controller-specific data
>   *
>   * Each SPI master controller can communicate with one or more spi_device
>   * children.  These make a small bus, sharing MOSI, MISO and SCK signals

I've not seen a need for that yet; the class_get_devdata() is doing
that already.  And it's now wrapped up as spi_master_get_devdata(). 

- Dave

--Boundary-00=_CGbpDGMCA67mZsv
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="spi_bitbang.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="spi_bitbang.c"

/*
 * spi_bitbang.c - polling/bitbanging SPI master controller driver utilities
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#include <linux/config.h>
#include <linux/init.h>
#include <linux/spinlock.h>
#include <linux/workqueue.h>
#include <linux/interrupt.h>
#include <linux/delay.h>
#include <linux/errno.h>
#include <linux/platform_device.h>

#include <linux/spi/spi.h>
#include <linux/spi/spi_bitbang.h>


/*----------------------------------------------------------------------*/

/*
 * FIRST PART (OPTIONAL):  word-at-a-time spi_transfer support.
 * Use this for GPIO or shift-register level hardware APIs.
 *
 * spi_bitbang_cs is in spi_device->controller_state, which is unavailable
 * to glue code.  These bitbang setup() and cleanup() routines are always
 * used, though maybe they're called from controller-aware code.
 *
 * chipselect() and friends may use use spi_device->controller_data and
 * controller registers as appropriate.
 *
 *
 * NOTE:  SPI controller pins can often be used as GPIO pins instead,
 * which means you could use a bitbang driver either to get hardware
 * working quickly, or testing for differences that aren't speed related.
 */

struct spi_bitbang_cs {
	unsigned	nsecs;	/* (clock cycle time)/2 */
	u32		(*txrx_word)(struct spi_device *spi, unsigned nsecs,
					u32 word, u8 bits);
	unsigned	(*txrx_bufs)(struct spi_device *,
					u32 (*txrx_word)(
						struct spi_device *spi,
						unsigned nsecs,
						u32 word, u8 bits),
					unsigned, struct spi_transfer *);
};

static unsigned bitbang_txrx_8(
	struct spi_device	*spi,
	u32			(*txrx_word)(struct spi_device *spi,
					unsigned nsecs,
					u32 word, u8 bits),
	unsigned		ns,
	struct spi_transfer	*t
) {
	unsigned		bits = spi->bits_per_word;
	unsigned		count = t->len;
	const u8		*tx = t->tx_buf;
	u8			*rx = t->rx_buf;

	while (likely(count > 0)) {
		u8		word = 0;

		if (tx)
			word = *tx++;
		word = txrx_word(spi, ns, word, bits);
		if (rx)
			*rx++ = word;
		count -= 1;
	}
	return t->len - count;
}

static unsigned bitbang_txrx_16(
	struct spi_device	*spi,
	u32			(*txrx_word)(struct spi_device *spi,
					unsigned nsecs,
					u32 word, u8 bits),
	unsigned		ns,
	struct spi_transfer	*t
) {
	unsigned		bits = spi->bits_per_word;
	unsigned		count = t->len;
	const u16		*tx = t->tx_buf;
	u16			*rx = t->rx_buf;

	while (likely(count > 1)) {
		u16		word = 0;

		if (tx)
			word = *tx++;
		word = txrx_word(spi, ns, word, bits);
		if (rx)
			*rx++ = word;
		count -= 2;
	}
	return t->len - count;
}

static unsigned bitbang_txrx_32(
	struct spi_device	*spi,
	u32			(*txrx_word)(struct spi_device *spi,
					unsigned nsecs,
					u32 word, u8 bits),
	unsigned		ns,
	struct spi_transfer	*t
) {
	unsigned		bits = spi->bits_per_word;
	unsigned		count = t->len;
	const u32		*tx = t->tx_buf;
	u32			*rx = t->rx_buf;

	while (likely(count > 3)) {
		u32		word = 0;

		if (tx)
			word = *tx++;
		word = txrx_word(spi, ns, word, bits);
		if (rx)
			*rx++ = word;
		count -= 4;
	}
	return t->len - count;
}

/**
 * spi_bitbang_setup - default setup for per-word I/O loops
 */
int spi_bitbang_setup(struct spi_device *spi)
{
	struct spi_bitbang_cs	*cs = spi->controller_state;
	struct spi_bitbang	*bitbang;

	if (!cs) {
		cs = kzalloc(sizeof *cs, SLAB_KERNEL);
		if (!cs)
			return -ENOMEM;
		spi->controller_state = cs;
	}
	bitbang = spi_master_get_devdata(spi->master);

	if (!spi->bits_per_word)
		spi->bits_per_word = 8;

	/* spi_transfer level calls that work per-word */
	if (spi->bits_per_word <= 8)
		cs->txrx_bufs = bitbang_txrx_8;
	else if (spi->bits_per_word <= 16)
		cs->txrx_bufs = bitbang_txrx_16;
	else if (spi->bits_per_word <= 32)
		cs->txrx_bufs = bitbang_txrx_32;
	else
		return -EINVAL;

	/* per-word shift register access, in hardware or bitbanging */
	cs->txrx_word = bitbang->txrx_word[spi->mode & (SPI_CPOL|SPI_CPHA)];
	if (!cs->txrx_word)
		return -EINVAL;

	if (!spi->max_speed_hz)
		spi->max_speed_hz = 500 * 1000;

	/* nsecs = max(50, (clock period)/2), be optimistic */
	cs->nsecs = (1000000000/2) / (spi->max_speed_hz);
	if (cs->nsecs < 50)
		cs->nsecs = 50;
	if (cs->nsecs > MAX_UDELAY_MS * 1000)
		return -EINVAL;

	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec\n",
			__FUNCTION__, spi->mode & (SPI_CPOL | SPI_CPHA),
			spi->bits_per_word, 2 * cs->nsecs);

	/* NOTE we _need_ to call chipselect() early, ideally with adapter
	 * setup, unless the hardware defaults cooperate to avoid confusion
	 * between normal (active low) and inverted chipselects.
	 */

	/* deselect chip (low or high) */
	spin_lock(&bitbang->lock);
	if (!bitbang->busy) {
		bitbang->chipselect(spi, 0);
		ndelay(cs->nsecs);
	}
	spin_unlock(&bitbang->lock);

	return 0;
}
EXPORT_SYMBOL_GPL(spi_bitbang_setup);

/**
 * spi_bitbang_cleanup - default cleanup for per-word I/O loops
 */
void spi_bitbang_cleanup(const struct spi_device *spi)
{
	kfree(spi->controller_state);
}
EXPORT_SYMBOL_GPL(spi_bitbang_cleanup);

static int spi_bitbang_bufs(struct spi_device *spi, struct spi_transfer *t)
{
	struct spi_bitbang_cs	*cs = spi->controller_state;
	unsigned		nsecs = cs->nsecs;

	return cs->txrx_bufs(spi, cs->txrx_word, nsecs, t);
}

/*----------------------------------------------------------------------*/

/*
 * SECOND PART ... simple transfer queue runner.
 *
 * This costs a task context per controller, running the queue by
 * performing each transfer in sequence.  Smarter hardware can queue
 * several DMA transfers at once, and process several controller queues
 * in parallel; this driver doesn't match such hardware very well.
 *
 * Drivers can provide word-at-a-time i/o primitives, or provide
 * transfer-at-a-time ones to leverage dma or fifo hardware.
 */
static void bitbang_work(void *_bitbang)
{
	struct spi_bitbang	*bitbang = _bitbang;
	unsigned long		flags;

	spin_lock_irqsave(&bitbang->lock, flags);
	bitbang->busy = 1;
	while (!list_empty(&bitbang->queue)) {
		struct spi_message	*m;
		struct spi_device	*spi;
		unsigned		nsecs;
		struct spi_transfer	*t;
		unsigned		tmp;
		unsigned		chipselect;
		int			status;

		m = container_of(bitbang->queue.next, struct spi_message,
				queue);
		list_del_init(&m->queue);
		spin_unlock_irqrestore(&bitbang->lock, flags);

// FIXME this is made-up
nsecs = 100;

		spi = m->spi;
		t = m->transfers;
		tmp = 0;
		chipselect = 0;
		status = 0;

		for (;;t++) {
			if (bitbang->shutdown) {
				status = -ESHUTDOWN;
				break;
			}

			/* set up default clock polarity, and activate chip */
			if (!chipselect) {
				bitbang->chipselect(spi, 1);
				ndelay(nsecs);
			}
			if (!t->tx_buf && !t->rx_buf && t->len) {
				status = -EINVAL;
				break;
			}

			/* transfer data */
			if (t->len) {
				/* FIXME if bitbang->use_dma, dma_map_single()
				 * before the transfer, and dma_unmap_single()
				 * afterwards, for either or both buffers...
				 */
				status = bitbang->txrx_bufs(spi, t);
			}
			if (status != t->len) {
				if (status > 0)
					status = -EMSGSIZE;
				break;
			}
			m->actual_length += status;
			status = 0;

			/* protocol tweaks before next transfer */
			if (t->delay_usecs)
				udelay(t->delay_usecs);

			tmp++;
			if (tmp >= m->n_transfer)
				break;

			chipselect = !t->cs_change;
			if (chipselect);
				continue;

			bitbang->chipselect(spi, 0);

			/* REVISIT do we want the udelay here instead? */
			msleep(1);
		}

		tmp = m->n_transfer - 1;
		tmp = m->transfers[tmp].cs_change;

		m->status = status;
		m->complete(m->context);

		ndelay(2 * nsecs);
		bitbang->chipselect(spi, status == 0 && tmp);
		ndelay(nsecs);

		spin_lock_irqsave(&bitbang->lock, flags);
	}
	bitbang->busy = 0;
	spin_unlock_irqrestore(&bitbang->lock, flags);
}

/**
 * spi_bitbang_transfer - default submit to transfer queue
 */
int spi_bitbang_transfer(struct spi_device *spi, struct spi_message *m)
{
	struct spi_bitbang	*bitbang;
	unsigned long		flags;

	m->actual_length = 0;
	m->status = -EINPROGRESS;

	bitbang = spi_master_get_devdata(spi->master);
	if (bitbang->shutdown)
		return -ESHUTDOWN;

	spin_lock_irqsave(&bitbang->lock, flags);
	list_add_tail(&m->queue, &bitbang->queue);
	queue_work(bitbang->workqueue, &bitbang->work);
	spin_unlock_irqrestore(&bitbang->lock, flags);

	return 0;
}
EXPORT_SYMBOL_GPL(spi_bitbang_transfer);

/*----------------------------------------------------------------------*/

/**
 * spi_bitbang_start - start up a polled/bitbanging SPI master driver
 * @bitbang: driver handle
 *
 * Caller should have zero-initialized all parts of the structure, and then
 * provided callbacks for chip selection and I/O loops.  If the master has
 * a transfer method, its final step should call spi_bitbang_transfer; or,
 * that's the default if the transfer routine is not initialized.  It should
 * also set up the bus number and number of chipselects.
 *
 * For i/o loops, provide callbacks either per-word (for bitbanging, or for
 * hardware that basically exposes a shift register) or per-spi_transfer
 * (which takes better advantage of hardware like fifos or DMA engines).
 *
 * Drivers using per-word I/O loops should use (or call) spi_bitbang_setup and
 * spi_bitbang_cleanup to handle those spi master methods.  Those methods are
 * the defaults if the bitbang->txrx_bufs routine isn't initialized.
 *
 * This routine registers the spi_master, which will process requests in a
 * dedicated task, keeping IRQs unblocked most of the time.  To stop
 * processing those requests, call spi_bitbang_stop().
 */
int spi_bitbang_start(struct spi_bitbang *bitbang)
{
	int	status;

	if (!bitbang->master || !bitbang->chipselect)
		return -EINVAL;

	INIT_WORK(&bitbang->work, bitbang_work, bitbang);
	spin_lock_init(&bitbang->lock);
	INIT_LIST_HEAD(&bitbang->queue);

	if (!bitbang->master->transfer)
		bitbang->master->transfer = spi_bitbang_transfer;
	if (!bitbang->txrx_bufs) {
		bitbang->use_dma = 0;
		bitbang->txrx_bufs = spi_bitbang_bufs;
		if (!bitbang->master->setup) {
			bitbang->master->setup = spi_bitbang_setup;
			bitbang->master->cleanup = spi_bitbang_cleanup;
		}
	} else if (!bitbang->master->setup)
		return -EINVAL;

	/* this task is the only thing to touch the SPI bits */
	bitbang->busy = 0;
	bitbang->workqueue = create_singlethread_workqueue(
			bitbang->master->cdev.dev->bus_id);
	if (bitbang->workqueue == NULL) {
		status = -EBUSY;
		goto err1;
	}

	/* driver may get busy before register() returns, especially
	 * if someone registered boardinfo for devices
	 */
	status = spi_register_master(bitbang->master);
	if (status < 0)
		goto err2;

	return status;

err2:
	destroy_workqueue(bitbang->workqueue);
err1:
	return status;
}
EXPORT_SYMBOL_GPL(spi_bitbang_start);

/**
 * spi_bitbang_stop - stops the task providing spi communication
 */
int spi_bitbang_stop(struct spi_bitbang *bitbang)
{
	unsigned	limit = 500;

	spin_lock_irq(&bitbang->lock);
	bitbang->shutdown = 0;
	while (!list_empty(&bitbang->queue) && limit--) {
		spin_unlock_irq(&bitbang->lock);

		dev_dbg(bitbang->master->cdev.dev, "wait for queue\n");
		msleep(10);

		spin_lock_irq(&bitbang->lock);
	}
	spin_unlock_irq(&bitbang->lock);
	if (!list_empty(&bitbang->queue)) {
		dev_err(bitbang->master->cdev.dev, "queue didn't empty\n");
		return -EBUSY;
	}

	destroy_workqueue(bitbang->workqueue);

	spi_unregister_master(bitbang->master);

	return 0;
}
EXPORT_SYMBOL_GPL(spi_bitbang_stop);

MODULE_LICENSE("GPL");


--Boundary-00=_CGbpDGMCA67mZsv--
