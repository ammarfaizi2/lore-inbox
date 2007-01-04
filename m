Return-Path: <linux-kernel-owner+w=401wt.eu-S964880AbXADVbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbXADVbE (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbXADVbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:31:03 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:55333 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964880AbXADVbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:31:01 -0500
Date: Thu, 4 Jan 2007 13:30:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Sandeen <sandeen@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
In-Reply-To: <459D6F17.2050208@redhat.com>
Message-ID: <Pine.LNX.4.64.0701041325510.3661@woody.osdl.org>
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org>
 <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org>
 <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org>
 <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk>
 <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk>
 <20070104130028.39aa44b8.akpm@osdl.org> <459D6BD1.7050406@redhat.com>
 <20070104131008.1d95cb0c.akpm@osdl.org> <459D6F17.2050208@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Eric Sandeen wrote:
> Andrew Morton wrote:
> 
> > btw, couldn't we fix this bug with a simple old
> > 
> > --- a/fs/bad_inode.c~a
> > +++ a/fs/bad_inode.c
> > @@ -15,7 +15,7 @@
> >  #include <linux/smp_lock.h>
> >  #include <linux/namei.h>
> >  
> > -static int return_EIO(void)
> > +static long return_EIO(void)
> >  {
> >  	return -EIO;
> >  }
> > _
> > 
> > ?
> 
> What about ops that return loff_t (64 bits) on 32-bit arches and stuff
> it into 2 registers....

Do we actually have cases where we cast to a different return value?

I'll happily cast away arguments that aren't used, but I'm not sure that 
we ever should cast different return values (not "int" vs "long", but also 
not "loff_t" etc). 

On 32-bit architectures, 64-bit entities may be returned totally different 
ways (ie things like "caller allocates space for them and passes in a 
magic pointer to the return value as the first _real_ argument").

So with my previous email, I was definitely _not_ trying to say that 
casting function pointers is ok. In practice it is ok when the _arguments_ 
differ, but not necessarily when the _return-type_ differs.

I was cc'd into the discussion late, so I didn't realize that we 
apparently already have a situation where changing the return value to 
"long" might make a difference. If so, I agree that we shouldn't do this 
at all (although Andrew's change to "long" seems perfectly fine as a "make 
old cases continue to work" patch if it actually matters).

		Linus
