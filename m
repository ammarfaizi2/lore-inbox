Return-Path: <linux-kernel-owner+w=401wt.eu-S965062AbXADS1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbXADS1R (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbXADS1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:27:17 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:42111 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965062AbXADS1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:27:16 -0500
Date: Thu, 4 Jan 2007 10:26:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
Message-Id: <20070104102659.8c61d510.akpm@osdl.org>
In-Reply-To: <459D3E8E.7000405@redhat.com>
References: <459C4038.6020902@redhat.com>
	<20070103162643.5c479836.akpm@osdl.org>
	<459D3E8E.7000405@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 11:51:10 -0600
Eric Sandeen <sandeen@redhat.com> wrote:

> Andrew Morton wrote:
> 
> > Al is correct, of course.  But the patch takes bad_inode.o from 280 up to 703
> > bytes, which is a bit sad for some cosmetic thing which nobody ever looks
> > at or modifies.
> >
> > Perhaps you can do
> >
> > static int return_EIO_int(void)
> > {
> > 	return -EIO;
> > }
> >
> > static int bad_file_release(struct inode * inode, struct file * filp)
> > 	__attribute__((alias("return_EIO_int")));
> > static int bad_file_fsync(struct inode * inode, struct file * filp)
> > 	__attribute__((alias("return_EIO_int")));
> >
> > etcetera?
> Ok, try this on for size.  Even though the gcc manual says alias doesn't work
> on all target machines, I assume linux arches are ok since alias is used
> in the core module init & exit code...
> 
> Also - is it ok to alias a function with one signature to a function with
> another signature?

Ordinarily I'd say no wucking fay, but that's effectively what we've been
doing in there for ages, and it seems to work.

I'd be a bit worried if any of these functions were returning pointers,
because one could certainly conceive of an arch+compiler combo which
returns pointers in a different register from integers (680x0?) but that's
not happening here.

> Note... I also realized that there are a couple of file ops which expect unsigned
> returns... poll and get_unmapped_area.  The latter seems to be handled just fine by
> the caller, which does IS_ERR gyrations to check for errnos.
> 
> I'm not so sure about poll; some callers put the return in a signed int, others
> unsigned, not sure anyone is really checking for -EIO... I think this op should
> probably be returning POLLERR, so that's what I've got in this version.

Yeah, that should all be OK.

