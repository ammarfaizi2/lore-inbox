Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUBPTJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUBPTJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:09:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52461 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265800AbUBPTJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:09:17 -0500
Message-ID: <4031154D.1030705@pobox.com>
Date: Mon, 16 Feb 2004 14:09:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@redhat.com>,
       Mike Christie <mikenc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
References: <1076866470.20140.13.camel@leto.cs.pocnet.net> <20040215180226.A8426@infradead.org> <1076870572.20140.16.camel@leto.cs.pocnet.net> <20040215185331.A8719@infradead.org> <1076873760.21477.8.camel@leto.cs.pocnet.net> <20040215194633.A8948@infradead.org> <20040216014433.GA5430@leto.cs.pocnet.net> <4030268C.6050701@pobox.com> <1076899244.5601.21.camel@leto.cs.pocnet.net> <403031DF.9050506@pobox.com> <20040216130454.GA9591@leto.cs.pocnet.net>
In-Reply-To: <20040216130454.GA9591@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> +static void kcryptd_do_work(void *data)
> +{
> +	struct crypt_io *io = (struct crypt_io *) data;
> +	struct crypt_config *cc = (struct crypt_config *) io->target->private;
> +	struct convert_context ctx;
> +	int r;
> +
> +	crypt_convert_init(cc, &ctx, io->bio, io->bio,
> +	                   io->bio->bi_sector - io->target->begin, 0);
> +	r = crypt_convert(cc, &ctx);
> +
> +	dec_pending(io, r);
> +}


> +static void kcryptd_queue_io(struct crypt_io *io)
> +{
> +	/* with the work struct in crypt_io we can only queue whole io's */
> +	BUG_ON(atomic_read(&io->pending) != 1);
> +
> +	INIT_WORK(&io->work, kcryptd_do_work, io);
> +	queue_work(_kcryptd_workqueue, &io->work);
> +}

Yum, nice and small.

Me likee.



> +/*
> + * Construct an encryption mapping:
> + * <cipher> <key> <iv_offset> <dev_path> <start>
> + */
> +static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
> +{
> +	struct crypt_config *cc;
> +	struct crypto_tfm *tfm;
> +	char *tmp;
> +	char *cipher;
> +	char *mode;
> +	int crypto_flags;
> +	int key_size;
> +
> +	if (argc != 5) {
> +		ti->error = "dm-crypt: Not enough arguments";
> +		return -EINVAL;
> +	}
> +
> +	tmp = argv[0];
> +	cipher = strsep(&tmp, "-");
> +	mode = strsep(&tmp, "-");
> +
> +	if (tmp)
> +		DMWARN("dm-crypt: Unexpected additional cipher options");

Janitorial/cleanup:  I define a macro "PFX" in most of my drivers, which 
in this case would look like

#define MODNAME "dm-crypt"
#define PFX MODNAME ": "

This is IMO preferred over typing in the driver's name into bunches of 
strings.


Your code looks OK-to-merge to me, at this point.

	Jeff



