Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUBPClR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbUBPClR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:41:17 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:32677 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265335AbUBPClK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:41:10 -0500
Subject: Re: dm-crypt using kthread
From: Christophe Saout <christophe@saout.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Mike Christie <mikenc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4030268C.6050701@pobox.com>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <20040216014433.GA5430@leto.cs.pocnet.net>  <4030268C.6050701@pobox.com>
Content-Type: text/plain
Message-Id: <1076899244.5601.21.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 03:40:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Jeff Garzik um 03:10:

> > +		/*
> > +		 * if additional pages cannot be allocated without waiting,
> > +		 * return a partially allocated bio, the caller will then try
> > +		 * to allocate additional bios while submitting this partial bio
> > +		 */
> > +		if ((i - bio->bi_idx) == (MIN_BIO_PAGES - 1))
> > +			gfp_mask = (gfp_mask | __GFP_NOWARN) & ~__GFP_WAIT;
> 
> If the caller said they can wait, why not wait?

How can the caller say this?

This is basically to avoid deadlocks. The kernel might decide to flush
data in order to free memory (or even swap out). dm-crypt needs to
allocate buffers for encryption. If we run out of memory we need to be
able to write something in order to get new memory. Successful writes
will return some pages to the pool and potentially wake up some threads
needing these.

> > +static void dec_pending(struct crypt_io *io, int error)
> > [...]
> > +	if (io->bio)
> > +		bio_endio(io->bio, io->bio->bi_size, io->error);
> 
> when does io->bio==NULL ?

Umm, right. Can't ever happen. Thanks.

> > +		set_task_state(current, TASK_INTERRUPTIBLE);
> > +		while (!(bio = kcryptd_get_bios())) {
> > +			schedule();
> > +			if (signal_pending(current))
> > +				return 0;
> > +		}
> > +		set_task_state(current, TASK_RUNNING);
> 
> You just keep calling schedule() rapid-fire until you get a bio?  That's 
> a bit sub-optimal.

That's wrong anyway. I was just making sure I was calling
kcryptd_get_bios after schedule. schedule() will sleep and woken after
someone added a bio to the list.

I've changed it to an if now and call kcryptd_get_bios after schedule.

I'm calling it twice because it is likely that someone started a new
list while the old list is being processed and I don't want to sleep in
this case, just fall through.

The kcryptd_get_bios needs to be after state = TASK_INTERRUPTIBLE to
avoid a race. If someone wakes the process after kcryptd_get_bios but
before schedule it resets the state to TASK_RUNNING so that the schedule
won't sleep.

> > +/*
> > + * Encode key into its hex representation
> > + */
> > +static void crypt_encode_key(char *hex, u8 *key, int size)
> > +{
> > +	static char hex_digits[] = "0123456789abcdef";
> 
> static const

Or sprintf... I doubt this would result in shorter code but it would be
more consistent.

> > +	if (!mode || strcmp(mode, "plain") == 0)
> > +		cc->iv_generator = crypt_iv_plain;
> > +	else if (strcmp(mode, "ecb") == 0)
> > +		cc->iv_generator = NULL;
> > +	else {
> > +		ti->error = "dm-crypt: Invalid chaining mode";
> > +		return -EINVAL;
> > +	}
> 
> memory leak on error

Ouch. Thanks.

> > +static int crypt_endio(struct bio *bio, unsigned int done, int error)
> > +{
> > +	struct crypt_io *io = (struct crypt_io *) bio->bi_private;
> > +	struct crypt_config *cc = (struct crypt_config *) io->target->private;
> > +
> > +	if (bio_rw(bio) == WRITE) {
> > +		/*
> > +		 * free the processed pages, even if
> > +		 * it's only a partially completed write
> > +		 */
> > +		crypt_free_buffer_pages(cc, bio, done);
> > +	}
> > +
> > +	if (bio->bi_size)
> > +		return 1;
> 
> dumb question, for my own knowledge:  what does this 'if' test do?

It checks whether has bio has been completed. The block layer may notify
us if parts of the bio has been finished.

> 
> > +static int crypt_map(struct dm_target *ti, struct bio *bio,
> > +                     union map_info *map_context)
> > [...]
>
> would be nice to move this code into a separate "create and init my 
> clone" function, simply to be ease review and make things a bit more 
> clear...

create and init would be the whole content of the loop. But if you think
so, I can do that.

> might want to use the standard 'goto' style exception handling here too, 
> instead of duplicating the error unwind code.

Yes, the function got larger over time.

> Overall, needs a tiny bit of work, but I like it.

Thanks.


