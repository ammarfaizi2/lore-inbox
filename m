Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVICVr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVICVr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 17:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVICVr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 17:47:29 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:3249 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751138AbVICVr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 17:47:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=sNyj+y7lhWAu826VoYgQ1p41AP3LhuAPaaqIPFHjj/IBmxhsKaVg6Bo+fqpGt57Xht76O4FqXQi0p1u4JgOo5VY+1SX1z28Pnb6NIBiBo/hNfIHSnbF5yOa0m4V+gRUmENlaKkIlzdHDCXSnAbXpOt1yEPdqII0hj6VxMPyBVFA=
Date: Sun, 4 Sep 2005 01:56:56 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Message-ID: <20050903215656.GA10187@mipter.zuzino.mipt.ru>
References: <20050904101218.GM4415@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904101218.GM4415@rama.de.gnumonks.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 12:12:18PM +0200, Harald Welte wrote:
> Below you can find a driver for the Omnikey CardMan 4040 PCMCIA
> Smartcard Reader.  

> --- /dev/null
> +++ b/drivers/char/pcmcia/cm4040_cs.c

> +#include <linux/config.h>

Not needed.

> +static volatile char *version =

Can we lose all volatile and register keywords?

> +typedef struct reader_dev_t {
> +	dev_link_t		link;		
> +	dev_node_t		node;		
> +	wait_queue_head_t	devq;	
> +
> +	wait_queue_head_t	poll_wait;
> +	wait_queue_head_t	read_wait;
> +	wait_queue_head_t	write_wait;
> +
> +	unsigned int 	  	buffer_status;
> +                                
> +	unsigned int      	fTimerExpired;
> +	struct timer_list	timer;
> +	unsigned long     	timeout;
> +	unsigned char     	sBuf[READ_WRITE_BUFFER_SIZE];
> +	unsigned char     	rBuf[READ_WRITE_BUFFER_SIZE];
> +	struct task_struct 	*owner;	
> +} reader_dev_t;

And typedefs too.

	struct reader_dev {
	
	};

> +static ssize_t cmx_read(struct file *filp,char *buf,size_t count,loff_t *ppos)

char __user *buf

> +	ulBytesToRead = 5 + 
> +			(0x000000FF&((char)dev->rBuf[1])) + 
> +			(0x0000FF00&((char)dev->rBuf[2] << 8)) + 
> +			(0x00FF0000&((char)dev->rBuf[3] << 16)) + 
> +			(0xFF000000&((char)dev->rBuf[4] << 24));

	ulBytesToRead = 5 + le32_to_cpu(*(__le32 *)&dev->rBuf[1]);

> +	ulMin = (count < (ulBytesToRead+5))?count:(ulBytesToRead+5);

	ulMin = min(count, ulBytesToRead + 5);

> +	copy_to_user(buf, dev->rBuf, ulMin);

Can fail.

> +static ssize_t cmx_write(struct file *filp,const char *buf,size_t count,

const char __user *buf

> +			 loff_t *ppos)

> +	copy_from_user(dev->sBuf, buf, uiBytesToWrite);

Can fail.

> +static int cmx_ioctl(struct inode *inode,struct file *filp,unsigned int cmd,
> +			unsigned long arg)
> +{
> +	dev_link_t *link;
> +	int rc, size;
> +
> +	link=dev_table[MINOR(inode->i_rdev)];
> +	if (!(DEV_OK(link))) {
> +		DEBUG(4, "DEV_OK false\n");
> +		return -ENODEV;
> +	}
> +	if (_IOC_TYPE(cmd)!=CM_IOC_MAGIC) {
> +		DEBUG(4,"ioctype mismatch\n");
> +		return -EINVAL;
> +	}
> +	if (_IOC_NR(cmd)>CM_IOC_MAXNR) {
> +		DEBUG(4,"iocnr mismatch\n");
> +		return -EINVAL;
> +	} 
> +	size = _IOC_SIZE(cmd);
> +	rc = 0;
> +	DEBUG(4,"iocdir=%.4x iocr=%.4x iocw=%.4x iocsize=%d cmd=%.4x\n",
> +		_IOC_DIR(cmd),_IOC_READ,_IOC_WRITE,size,cmd);
> +
> +	if (_IOC_DIR(cmd)&_IOC_READ) {
> +		if (!access_ok(VERIFY_WRITE, (void *)arg, size))
> +			return -EFAULT;
> +	}
> +	if (_IOC_DIR(cmd)&_IOC_WRITE) {
> +		if (!access_ok(VERIFY_READ, (void *)arg, size))
> +			return -EFAULT;
> +	}
> +
> +	return rc;
> +}

Whoo, empty ioctl handler.

> +static void reader_release(u_long arg)

> +	link = (dev_link_t *)arg;

You do

	reader_release((unsigned long)link);

somewhere above and below.

> +static void reader_detach_by_devno(int devno,dev_link_t *link)

> +		reader_release((u_long)link);

Like this.

