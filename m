Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbTEWJ55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTEWJ54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:57:56 -0400
Received: from mail.convergence.de ([212.84.236.4]:42692 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263994AbTEWJ5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:57:55 -0400
Message-ID: <3ECDF3B1.8090902@convergence.de>
Date: Fri, 23 May 2003 12:10:57 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][2.5] generic_usercopy() function (resend, forgot the patches)
References: <3ECDEBC5.5030608@convergence.de> <20030523104722.B15725@infradead.org>
In-Reply-To: <20030523104722.B15725@infradead.org>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

> This function is small and very useful, I think it should be included unconditional
> and the prototype maybe moved to kernel.h.

That's ok for me, although I don't know what the exact criteria for 
adding a function to kernel.h are.

>>+int
>>+generic_usercopy(struct inode *inode, struct file *file,
>>+		unsigned int cmd, unsigned long arg,
>>+		int (*func)(struct inode *inode, struct file *file,
>>+		unsigned int cmd, void *arg))
> 
> 
> The name is a bit mislead.  maybe ioctl_usercopy?  ioctl_uaccess?

These are both fine IMHO.

> Also file/inode should go away from the prototype (and the callback).
> Only file is needed because inode == file->f_dentry->d_inode, and even
> that one should be just some void *data instead.

I only copied the function from videodev.c and renamed it, so please 
don't blame me for the way stuff is done there. 8-)

Perhaps Gerd Knorr or Alan Cox can comment on your changes -- I'll have 
to investigate if all of these arguments are used anyway.

>>+	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
> That's crap.  Please move this workaround to v4l not into generic code.

Is it possible to fix the definitons of the v4l ioctls instead without 
breaking binary compatiblity?

>>+	case _IOC_WRITE:
>>+	case (_IOC_WRITE | _IOC_READ):
>>+		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
>>+			parg = sbuf;
>>+		} else {
>>+			/* too big to allocate from stack */
>>+			mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
>>+			if (NULL == mbuf)
>>+				return -ENOMEM;
>>+			parg = mbuf;
> 
> 
> I wonder whether you should just kmalloc always. 

Since this function is always used in user context and the memory is 
always freed afterwards, it should be possible to use vmalloc() or a 
static buffer (what's the maximum size?) instead.

>>+	/* call driver */
>>+	err = func(inode, file, cmd, parg);
>>+	if (err == -ENOIOCTLCMD)
>>+		err = -EINVAL;
> 
> 
> I don't think this is the right place for this substitution - leave it to
> the drivers.

Agreed.

CU
Michael.



