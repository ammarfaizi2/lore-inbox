Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbTEWJfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTEWJfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:35:00 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:12562 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263992AbTEWJe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:34:58 -0400
Date: Fri, 23 May 2003 10:47:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.5] generic_usercopy() function (resend, forgot the patches)
Message-ID: <20030523104722.B15725@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org
References: <3ECDEBC5.5030608@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3ECDEBC5.5030608@convergence.de>; from hunold@convergence.de on Fri, May 23, 2003 at 11:37:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function is small and very useful, I think it should be included unconditional
and the prototype maybe moved to kernel.h.

> +int
> +generic_usercopy(struct inode *inode, struct file *file,
> +		unsigned int cmd, unsigned long arg,
> +		int (*func)(struct inode *inode, struct file *file,
> +		unsigned int cmd, void *arg))

The name is a bit mislead.  maybe ioctl_usercopy?  ioctl_uaccess?
Also file/inode should go away from the prototype (and the callback).
Only file is needed because inode == file->f_dentry->d_inode, and even
that one should be just some void *data instead.



> +	char	sbuf[128];
> +	void    *mbuf = NULL;
> +	void	*parg = NULL;
> +	int	err  = -EINVAL;
> +
> +	/*  Copy arguments into temp kernel buffer  */
> +	switch (_IOC_DIR(cmd)) {
> +	case _IOC_NONE:
> +		parg = (void *)arg;
> +		break;
> +	case _IOC_READ: /* some v4l ioctls are marked wrong ... */

That's crap.  Please move this workaround to v4l not into generic code.

> +	case _IOC_WRITE:
> +	case (_IOC_WRITE | _IOC_READ):
> +		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
> +			parg = sbuf;
> +		} else {
> +			/* too big to allocate from stack */
> +			mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
> +			if (NULL == mbuf)
> +				return -ENOMEM;
> +			parg = mbuf;

I wonder whether you should just kmalloc always. 

> +	/* call driver */
> +	err = func(inode, file, cmd, parg);
> +	if (err == -ENOIOCTLCMD)
> +		err = -EINVAL;

I don't think this is the right place for this substitution - leave it to
the drivers.

