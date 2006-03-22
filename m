Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932793AbWCVVb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWCVVb7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWCVVb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:31:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932793AbWCVVb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:31:58 -0500
Date: Wed, 22 Mar 2006 13:28:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: shbader@de.ibm.com, holzheu@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 20/24] s390: 3590 tape driver
Message-Id: <20060322132834.051a3dc4.akpm@osdl.org>
In-Reply-To: <20060322152547.GT5801@skybase.boeblingen.de.ibm.com>
References: <20060322152547.GT5801@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> From: Stefan Bader <shbader@de.ibm.com>
> From: Michael Holzheu <holzheu@de.ibm.com>
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> [patch 20/24] s390: 3590 tape driver
>
> ...
>
> +static void
> +tape_3590_work_handler(void *data)
> +{
> +	struct {
> +		struct tape_device *device;
> +		enum tape_op op;
> +		struct work_struct work;
> +	} *p = data;
> +
> +	switch (p->op) {
> +	case TO_MSEN:
> +		tape_3590_sense_medium(p->device);
> +		break;
> +	case TO_READ_ATTMSG:
> +		tape_3590_read_attmsg(p->device);
> +		break;
> +	default:
> +		DBF_EVENT(3, "T3590: work handler undefined for "
> +			  "operation 0x%02x\n", p->op);
> +	}
> +	tape_put_device(p->device);
> +	kfree(p);
> +}
> +
> +static int
> +tape_3590_schedule_work(struct tape_device *device, enum tape_op op)
> +{
> +	struct {
> +		struct tape_device *device;
> +		enum tape_op op;
> +		struct work_struct work;
> +	} *p;
> +
> +	if ((p = kzalloc(sizeof(*p), GFP_ATOMIC)) == NULL)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&p->work, tape_3590_work_handler, p);
> +
> +	p->device = tape_get_device_reference(device);
> +	p->op = op;
> +
> +	schedule_work(&p->work);
> +	return 0;
> +}

That duplicated struct definition is pretty poor form, IMO.  Best to have a
single definition.

What happens to this driver if the GFP_ATOMIC allocation fails?

I don't see a flush_scheduled_work() in this driver.  Is it not possible
that there's still work pending at shutdown or rmmod time?


> +#ifdef CONFIG_S390_TAPE_BLOCK
> +/*
> + * Tape Block READ
> + */
> +static struct tape_request *
> +tape_3590_bread(struct tape_device *device, struct request *req)
> +{
> +	struct tape_request *request;
> +	struct ccw1 *ccw;
> +	int count = 0, start_block, i;
> +	unsigned off;
> +	char *dst;
> +	struct bio_vec *bv;
> +	struct bio *bio;
> +
> +	DBF_EVENT(6, "xBREDid:");
> +	start_block = req->sector >> TAPEBLOCK_HSEC_S2B;
> +	DBF_EVENT(6, "start_block = %i\n", start_block);
> +
> +	rq_for_each_bio(bio, req) {
> +		bio_for_each_segment(bv, bio, i) {
> +			count += bv->bv_len >> (TAPEBLOCK_HSEC_S2B + 9);
> +		}
> +	}
> +	request = tape_alloc_request(2 + count + 1, 4);
> +	if (IS_ERR(request))
> +		return request;
> +	request->op = TO_BLOCK;
> +	*(__u32 *) request->cpdata = start_block;
> +	ccw = request->cpaddr;
> +	ccw = tape_ccw_cc(ccw, MODE_SET_DB, 1, device->modeset_byte);
> +
> +	/*
> +	 * We always setup a nop after the mode set ccw. This slot is
> +	 * used in tape_std_check_locate to insert a locate ccw if the
> +	 * current tape position doesn't match the start block to be read.
> +	 */
> +	ccw = tape_ccw_cc(ccw, NOP, 0, NULL);
> +
> +	rq_for_each_bio(bio, req) {
> +		bio_for_each_segment(bv, bio, i) {
> +			dst = kmap(bv->bv_page) + bv->bv_offset;
> +			for (off = 0; off < bv->bv_len;
> +			     off += TAPEBLOCK_HSEC_SIZE) {
> +				ccw->flags = CCW_FLAG_CC;
> +				ccw->cmd_code = READ_FORWARD;
> +				ccw->count = TAPEBLOCK_HSEC_SIZE;
> +				set_normalized_cda(ccw, (void *) __pa(dst));
> +				ccw++;
> +				dst += TAPEBLOCK_HSEC_SIZE;
> +			}
> +			if (off > bv->bv_len)
> +				BUG();
> +		}
> +	}

We seem to be missing a kunmap().

