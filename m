Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbTEWKHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 06:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264008AbTEWKHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 06:07:19 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:23314 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264007AbTEWKHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 06:07:18 -0400
Date: Fri, 23 May 2003 11:19:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Gerd Knorr <kraxel@bytesex.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][2.5] generic_usercopy() function (resend, forgot the patches)
Message-ID: <20030523111941.A19033@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <3ECDEBC5.5030608@convergence.de> <20030523104722.B15725@infradead.org> <3ECDF3B1.8090902@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3ECDF3B1.8090902@convergence.de>; from hunold@convergence.de on Fri, May 23, 2003 at 12:10:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 23, 2003 at 12:10:57PM +0200, Michael Hunold wrote:
> > Also file/inode should go away from the prototype (and the callback).
> > Only file is needed because inode == file->f_dentry->d_inode, and even
> > that one should be just some void *data instead.
> 
> I only copied the function from videodev.c and renamed it, so please 
> don't blame me for the way stuff is done there. 8-)
> 
> Perhaps Gerd Knorr or Alan Cox can comment on your changes -- I'll have 
> to investigate if all of these arguments are used anyway.

I don't blame you.  I just think it shouldn't be added to the kernel API
without fixing it first :)

> 
> >>+	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
> > That's crap.  Please move this workaround to v4l not into generic code.
> 
> Is it possible to fix the definitons of the v4l ioctls instead without 
> breaking binary compatiblity?

I doubt it.  This just means v4l has to work around it's bug in the
v4l code, not in common code.

> >>+	case _IOC_WRITE:
> >>+	case (_IOC_WRITE | _IOC_READ):
> >>+		if (_IOC_SIZE(cmd) <= sizeof(sbuf)) {
> >>+			parg = sbuf;
> >>+		} else {
> >>+			/* too big to allocate from stack */
> >>+			mbuf = kmalloc(_IOC_SIZE(cmd),GFP_KERNEL);
> >>+			if (NULL == mbuf)
> >>+				return -ENOMEM;
> >>+			parg = mbuf;
> > 
> > 
> > I wonder whether you should just kmalloc always. 
> 
> Since this function is always used in user context and the memory is 
> always freed afterwards, it should be possible to use vmalloc() or a 
> static buffer (what's the maximum size?) instead.

Sorry, I meant it's probably not worth using the stack at all.
vmalloc() for ioctl buffers sounds like a very bad idea.

