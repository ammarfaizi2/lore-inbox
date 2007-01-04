Return-Path: <linux-kernel-owner+w=401wt.eu-S965127AbXADWfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbXADWfo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbXADWfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:35:44 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:60453 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965129AbXADWfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:35:44 -0500
Date: Thu, 4 Jan 2007 14:35:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: Al Viro <viro@ftp.linux.org.uk>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
In-Reply-To: <20070104223856.GA79126@gaz.sfgoth.com>
Message-ID: <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
References: <20070104105430.1de994a7.akpm@osdl.org>
 <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk>
 <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk>
 <20070104215206.GZ17561@ftp.linux.org.uk> <20070104223856.GA79126@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Mitchell Blank Jr wrote:
> 
> I don't think you need to do fancy #ifdef's:
> 
> static s32 return_eio_32(void) { return -EIO; }
> static s64 return_eio_64(void) { return -EIO; }
> extern void return_eio_unknown(void);   /* Doesn't exist */
> #define return_eio(type)        ((sizeof(type) == 4)			\
> 					? ((void *) return_eio_32)	\
> 				: ((sizeof(type) == 8)			\
> 					? ((void *) return_eio_64)	\
> 					: ((void *) return_eio_unknown)))

Well, that probably would work, but it's also true that returning a 64-bit 
value on a 32-bit platform really _does_ depend on more than the size.

For an example of this, try compiling this:

	long long a(void)
	{
		return -1;
	}

	struct dummy { int a, b };

	struct dummy b(void)
	{
		struct dummy retval = { -1 , -1 };
		return retval;
	}

on x86.

Now, I don't think we actually have anything like this in the kernel, and 
your example is likely to work very well in practice, but once we start 
doing tricks like this, I actually think it's getting easier to just say 
"let's not play tricks with function types at all".

Anybody want to send in the patch that just generates separate versions 
for

	loff_t eio_llseek(struct file *file, loff_t offset, int origin)
	{
		return -EIO;
	}

	int eio_readdir(struct file *filp, void *dirent, filldir_t filldir)
	{
		return -EIO;
	..

and so on?

		Linus
