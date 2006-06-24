Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWFXMsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWFXMsT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933389AbWFXMsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:48:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:55394 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S933381AbWFXMsS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:48:18 -0400
X-IronPort-AV: i="4.06,171,1149490800"; 
   d="scan'208"; a="88658777:sNHT17268496"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] riport LADAR driver
Date: Sat, 24 Jun 2006 05:48:16 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D018D2230@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] riport LADAR driver
Thread-Index: AcaXfWeYph0yIl2ySqSx7WH1Cft69wADba+g
From: "Gross, Mark" <mark.gross@intel.com>
To: "Arjan van de Ven" <arjan@infradead.org>, <mgross@linux.intel.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jun 2006 12:48:17.0731 (UTC) FILETIME=[772D4930:01C6978C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Arjan van de Ven [mailto:arjan@infradead.org]
>Sent: Saturday, June 24, 2006 4:00 AM
>To: mgross@linux.intel.com
>Cc: Randy.Dunlap; linux-kernel@vger.kernel.org; Gross, Mark
>Subject: Re: [PATCH] riport LADAR driver
>
>
>since this is for a tutorial... double nitpick mode ;-)
>(since examples should be squeeky clean or people will turn the right
>thing into the not quite right thing later in their own code)

Way cool. Thanks! I'll update the patch and respond to your issues later
today.


>
>> +#undef PDEBUG
>> +#ifdef RIPORT_DEBUG
>> +#  define PDEBUG(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ##
args)
>> +#else	/*  */
>> +#  define PDEBUG(fmt, args...)
>> +#endif	/*  */
>
>this is still there while it really shouldn't be; either use pr_debug()
>or dev_printk().
>

OK.  I had a dumb reason in my head for not making this change.  (I had
it in my head the DEBUG define was more global than it was...)

>
>> +struct devriport {
>> +	unsigned int io;
>> +	unsigned int io_ext;
>> +	int irq;
>> +	int dma;
>> +	int size;		/* buffer size */
>> +	unsigned char *pbuf;	/* pointer to the start of the memory
that
>> +				stores scans from the riegl */
>> +	unsigned char *pbuf_top;/* pointer to the end of pbuf (see
above) */
>> +	unsigned char *pin;	/* pointer to the end of new data */
>> +	unsigned char *pout;	/* pointer to the start of new data (end
of
>> +				old/read data) */
>> +	wait_queue_head_t qwait;
>> +	struct inode *pinode;
>> +	struct file *pfile;
>> +	int usage;
>> +	int irqinuse;
>> +	int readstate;
>> +	short syncWord;
>> +	int numbytesthisstate;
>> +	int bytestoread;
>> +	char buf[4];
>> +	struct timeval timestamp;
>> +
>> +	spinlock_t lock;
>> +};
>
>if this is for a tutorial.. might as well sort these fields in order of
>decreasing size so that you get minimal alignment packing by the
>compiler

Ok

>
>> +	if (!request_region(io + ECP_OFFSET, 3, "riport")) {
>> +		release_region(io,3);
>> +
>> +		PDEBUG("request_region 0x%X of 3 bytes fails\n", io +
ECP_OFFSET );
>> +		*presult = -EBUSY;
>> +		goto fail_io;
>> +	}
>
>might as well make another goto target and have that do the
>release_region...

OK,

>
>> +
>> +static int devriport_release(struct devriport *this)
>> +{
>> +	this->irqinuse = 0;
>> +
>> +	/* switch to compatibility mode */
>> +	outb(ECR_SPP_MODE | ECR_ERRINT_DISABLED | ECR_SERVICE_INTERRUPT,
>> +		this->io_ext + ECR_EXT);
>> +	outb(DCR_NOT_REVERSE_REQUEST | DCR_SELECT_IN, this->io +
DCR_BASE);
>> +
>> +	free_irq(this->irq, this);
>> +	kfree(this->pbuf);
>> +
>> +	this->usage--;
>> +	WARN_ON(this->usage < 0);
>> +	PDEBUG("release\n");
>> +	return 0;
>> +}
>> +
>> +
>...
>
>> +
>> +
>> +static int devriport_open(struct devriport *this)
>> +{
>> +	int result;
>> +
>> +	if (this->usage)
>> +		return -EBUSY;
>
>this "usage count" thing is probably buggy and racy; what is it for?

I'll look at this more closely.  I bet we can loose it.

Thanks again,

The patch will come later this weekend.

--mgross
