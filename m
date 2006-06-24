Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWFXLA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWFXLA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 07:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWFXLA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 07:00:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42927 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751324AbWFXLA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 07:00:26 -0400
Subject: Re: [PATCH] riport LADAR driver
From: Arjan van de Ven <arjan@infradead.org>
To: mgross@linux.intel.com
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       mark.gross@intel.com
In-Reply-To: <20060623224654.GA5204@linux.intel.com>
References: <20060622144120.GA5215@linux.intel.com>
	 <1151000401.3120.55.camel@laptopd505.fenrus.org>
	 <20060622231604.GA5208@linux.intel.com>
	 <20060622225239.bf0ccab2.rdunlap@xenotime.net>
	 <20060623224654.GA5204@linux.intel.com>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 13:00:20 +0200
Message-Id: <1151146820.3181.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


since this is for a tutorial... double nitpick mode ;-)
(since examples should be squeeky clean or people will turn the right
thing into the not quite right thing later in their own code)

> +#undef PDEBUG
> +#ifdef RIPORT_DEBUG
> +#  define PDEBUG(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ## args)
> +#else	/*  */
> +#  define PDEBUG(fmt, args...)
> +#endif	/*  */

this is still there while it really shouldn't be; either use pr_debug()
or dev_printk().


> +struct devriport {
> +	unsigned int io;
> +	unsigned int io_ext;
> +	int irq;
> +	int dma;
> +	int size;		/* buffer size */
> +	unsigned char *pbuf;	/* pointer to the start of the memory that
> +				stores scans from the riegl */
> +	unsigned char *pbuf_top;/* pointer to the end of pbuf (see above) */
> +	unsigned char *pin;	/* pointer to the end of new data */
> +	unsigned char *pout;	/* pointer to the start of new data (end of
> +				old/read data) */
> +	wait_queue_head_t qwait;
> +	struct inode *pinode;
> +	struct file *pfile;
> +	int usage;
> +	int irqinuse;
> +	int readstate;
> +	short syncWord;
> +	int numbytesthisstate;
> +	int bytestoread;
> +	char buf[4];
> +	struct timeval timestamp;
> +
> +	spinlock_t lock;
> +};

if this is for a tutorial.. might as well sort these fields in order of
decreasing size so that you get minimal alignment packing by the
compiler

> +	if (!request_region(io + ECP_OFFSET, 3, "riport")) {
> +		release_region(io,3);
> +
> +		PDEBUG("request_region 0x%X of 3 bytes fails\n", io + ECP_OFFSET );
> +		*presult = -EBUSY;
> +		goto fail_io;
> +	}

might as well make another goto target and have that do the
release_region...

> +
> +static int devriport_release(struct devriport *this)
> +{
> +	this->irqinuse = 0;
> +
> +	/* switch to compatibility mode */
> +	outb(ECR_SPP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
> +		this->io_ext + ECR_EXT);
> +	outb(DCR_NOT_REVERSE_REQUEST | DCR_SELECT_IN, this->io + DCR_BASE);
> +
> +	free_irq(this->irq, this);
> +	kfree(this->pbuf);
> +
> +	this->usage--;
> +	WARN_ON(this->usage < 0);
> +	PDEBUG("release\n");
> +	return 0;
> +}
> +
> +
...

> +
> +
> +static int devriport_open(struct devriport *this)
> +{
> +	int result;
> +
> +	if (this->usage)
> +		return -EBUSY;

this "usage count" thing is probably buggy and racy; what is it for? 

