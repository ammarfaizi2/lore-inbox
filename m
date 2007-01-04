Return-Path: <linux-kernel-owner+w=401wt.eu-S1030246AbXADVwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbXADVwM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbXADVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:52:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54430 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030246AbXADVwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:52:11 -0500
Date: Thu, 4 Jan 2007 21:52:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops return values
Message-ID: <20070104215206.GZ17561@ftp.linux.org.uk>
References: <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104130028.39aa44b8.akpm@osdl.org> <459D6BD1.7050406@redhat.com> <20070104131008.1d95cb0c.akpm@osdl.org> <459D6F17.2050208@redhat.com> <Pine.LNX.4.64.0701041325510.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701041325510.3661@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 01:30:47PM -0800, Linus Torvalds wrote:
 
> I'll happily cast away arguments that aren't used, but I'm not sure that 
> we ever should cast different return values (not "int" vs "long", but also 
> not "loff_t" etc). 
> 
> On 32-bit architectures, 64-bit entities may be returned totally different 
> ways (ie things like "caller allocates space for them and passes in a 
> magic pointer to the return value as the first _real_ argument").
> 
> So with my previous email, I was definitely _not_ trying to say that 
> casting function pointers is ok. In practice it is ok when the _arguments_ 
> differ, but not necessarily when the _return-type_ differs.
> 
> I was cc'd into the discussion late, so I didn't realize that we 
> apparently already have a situation where changing the return value to 
> "long" might make a difference. If so, I agree that we shouldn't do this 
> at all (although Andrew's change to "long" seems perfectly fine as a "make 
> old cases continue to work" patch if it actually matters).

We do.
        loff_t (*llseek) (struct file *, loff_t, int);
...
        int (*readdir) (struct file *, void *, filldir_t);

static const struct file_operations bad_file_ops =
{
        .llseek         = EIO_ERROR,
...
        .readdir        = EIO_ERROR,


Moreover, we have int, loff_t, ssize_t and long, plus the unsigned variants.
At least 3 versions, unless you want to mess with ifdefs to reduce them to
two.
