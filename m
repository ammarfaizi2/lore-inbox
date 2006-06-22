Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWFVSUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWFVSUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWFVSUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:20:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41090 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750761AbWFVSUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:20:04 -0400
Subject: Re: [PATCH] riport LADAR driver
From: Arjan van de Ven <arjan@infradead.org>
To: mgross@linux.intel.com
Cc: linux-kernel@vger.kernel.org, mark.gross@intel.com
In-Reply-To: <20060622144120.GA5215@linux.intel.com>
References: <20060622144120.GA5215@linux.intel.com>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 20:20:01 +0200
Message-Id: <1151000401.3120.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 07:41 -0700, mark gross wrote:
> +
> +#undef PDEBUG
> +#ifdef RIPORT_DEBUG
> +#  define PDEBUG(fmt, args...) printk( KERN_DEBUG "riport: " fmt, ## args)
> +#else	/*  */
> +#  define PDEBUG(fmt, args...)
> +#endif	/*  */

what's wrong with prdebug ?
> +   
> +
> +struct devriport *devriport_init(int major, int minor, int io, int irq,
> +				   int dma, int size, int *presult);
> +void devriport_cleanup(struct devriport *this);
> +int devriport_open(struct devriport *this);
> +int devriport_release(struct devriport *this);
> +int devriport_read(struct devriport *this, char *pbuf, int length);
> +unsigned int devriport_poll(struct devriport *this,
> +			     struct poll_table_struct *ptable);
> +void devriport_irq(struct devriport *this, int irq, struct pt_regs *regs);

if you reorder the functions a bit you can get rid of these prototypes
entirely... (and make a bunch static)


> +
> +irqreturn_t devriport_irq_wrap(int irq, void *pv, struct pt_regs *pr) 
> +{
> +	devriport_irq(pv, irq, pr);
> +	return IRQ_HANDLED;
> +} 

that looks odd; even if it's not your IRQ you always call it handled....




> +int devriport_open(struct devriport *this) 
> +{
> +	int result;
> +	
> +	if (this->usage)
> +		return -EBUSY;
> +	
> +	result =
> +	request_irq(this->irq, devriport_irq_wrap, SA_INTERRUPT, "riport",
> +			this);

are you sure you can handle an interrupt at this time already?  Usually
the request_irq() is done *after* initialization of all other data
structures to make sure that if an irq hits all data structures are
initialized...


> +int devriport_read(struct devriport *this, char *pbuf, int length) 
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +	int retval;
> +	int length0, length1;
> +	int count;
> +	
> +	add_wait_queue(&this->qwait, &wait);
> +	
> +	retval = 0;
> +	current->state = TASK_INTERRUPTIBLE;
> +	
> +	while (this->pin == this->pout) {

this looks buggy, at least you want to set the state inside the while
loop somewhere (and use set_task_state() and friends API)

> +	current->state = TASK_RUNNING;

set_current_state()

> +		/* length1 is the number of bytes from the current read
> +		 * position in the circular buffer to the end of the buffer */
> +		length1 = this->pbuf + this->size - this->pout;
> +		if (length < length1) {
> +			count = copy_to_user(pbuf, this->pout, length);
> +			WARN_ON(count != length);

WARN_ON isn't really handling the error......
> +void devriport_irq(struct devriport *this, int irq, struct pt_regs *regs) 
> +{
> +	if (this->irqinuse) {
> +		spin_lock_irq(&this->lock);
> +		devriport_rx(this);
> +		spin_unlock_irq(&this->lock);

this unconditionally enables interrupts... that's generally bad. Please
consider using irqsave/irqrestore

> +ssize_t drvriport_read(struct file * pfile, char *pbuf, size_t length,
> +			 loff_t * ppos)
> +{
> +	return devriport_read((struct devriport *)pfile->private_data, pbuf,
> +			       length);
> +}

this looks odd; you don't pass pfile to the _read function below... yet
inside it you do use the file argument. Would make a lot more sense to
pass it in....

> +static struct file_operations drvriport_fops = { 
> +	owner: THIS_MODULE, 
> +	read : drvriport_read,
> +	open : drvriport_open, 
> +	release : drvriport_release, 
> +};

can be "const"



