Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUBPCHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbUBPCHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:07:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:47293 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265291AbUBPCHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:07:11 -0500
Date: Sun, 15 Feb 2004 18:07:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christophe Saout <christophe@saout.de>
Cc: hch@infradead.org, thornber@redhat.com, mikenc@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop
 device?) on 2.6.*)
Message-Id: <20040215180736.4743f4ee.akpm@osdl.org>
In-Reply-To: <20040216014433.GA5430@leto.cs.pocnet.net>
References: <402A4B52.1080800@centrum.cz>
	<1076866470.20140.13.camel@leto.cs.pocnet.net>
	<20040215180226.A8426@infradead.org>
	<1076870572.20140.16.camel@leto.cs.pocnet.net>
	<20040215185331.A8719@infradead.org>
	<1076873760.21477.8.camel@leto.cs.pocnet.net>
	<20040215194633.A8948@infradead.org>
	<20040216014433.GA5430@leto.cs.pocnet.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> wrote:
>
> +static struct bio *
> +crypt_alloc_buffer(struct crypt_config *cc, unsigned int size,
> +                   struct bio *base_bio, int *bio_vec_idx)
> +{
> ...
> +	/*
> +	 * Tell VM to act less aggressively and fail earlier.
> +	 * This is not necessary but increases throughput.
> +	 * FIXME: Is this really intelligent?
> +	 */
> +	current->flags &= ~PF_MEMALLOC;

This is a bit peculiar.  Is it still the case that it increases throughput?
 How come?

> +	if (base_bio)
> +		bio = bio_clone(base_bio, GFP_NOIO);
> +	else
> +		bio = bio_alloc(GFP_NOIO, nr_iovecs);
> +	if (!bio)
> +		return NULL;

Should restore PF_MEMALLOC here.

> +static int kcryptd_do_work(void *data)
> +{
> +	current->flags |= PF_IOTHREAD;
> +
> +	for(;;) {
> +		struct bio *bio;
> +
> +		set_task_state(current, TASK_INTERRUPTIBLE);
> +		while (!(bio = kcryptd_get_bios())) {
> +			schedule();
> +			if (signal_pending(current))
> +				return 0;
> +		}

This will turn into a busy-loop, because schedule() sets current->state to
TASK_RUNNING.  You need to move the set_task_state(current,
TASK_INTERRUPTIBLE); inside the loop.

Why is this code mucking with signals?

Perhaps a call to blk_congestion_wait() would be appropriate here.

> +/*
> + * Encode key into its hex representation
> + */
> +static void crypt_encode_key(char *hex, u8 *key, int size)
> +{
> +	static char hex_digits[] = "0123456789abcdef";
> +	int i;
> +
> +	for(i = 0; i < size; i++) {
> +		*hex++ = hex_digits[*key >> 4];
> +		*hex++ = hex_digits[*key & 0x0f];
> +		key++;
> +	}
> +
> +	*hex++ = '\0';
> +}

sprintf("%02x")?


