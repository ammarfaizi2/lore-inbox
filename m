Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751859AbWJMUJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWJMUJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWJMUJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:09:33 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:19437 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751840AbWJMUJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:09:32 -0400
Date: Fri, 13 Oct 2006 16:07:05 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi, ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Subject: Re: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
Message-ID: <20061013200705.GB31928@filer.fsl.cs.sunysb.edu>
References: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu> <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu> <20061013122706.56970df2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013122706.56970df2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 12:27:06PM -0700, Andrew Morton wrote:
> On Fri, 13 Oct 2006 07:18:49 -0400
> Josef "Jeff" Sipek <jsipek@cs.sunysb.edu> wrote:
> > include/linux/stack_fs.h |   65 ++++++++++++++++++++++++++++++++++++++++++++++
> 
> The name stack_fs implies that there's a filesystem called stackfs.  Only
> there isn't.  I wonder if we can choose a better name for all of this. 
> Maybe fs_stack_*?
 
fs_stack_* sounds good to me.
 
> What are the locking requirements for these functions?  Presumably the
> caller must hold i_mutex on at least the source inode, and perhaps the
> destination one?
> 
> If i_mutex is held, i_size_read() isn't needed.
> 
> If i_mutex is held, i_size_write() isn't needed either.
> 
> So please document the locking requirements via source comments and then
> see if this can be simplified.

Fair enough. I'll submit an updated version.

> > +static inline void __stackfs_copy_attr_all(struct inode *dest,
> > +					   const struct inode *src,
> > +					   int (*get_nlinks)(struct inode *))
> > +{
> > +	if (!get_nlinks)
> > +		dest->i_nlink = src->i_nlink;
> > +	else
> > +		dest->i_nlink = get_nlinks(dest);
> 
> I cannot find a get_nlinks() in 2.6.19-rc2?
 
It is the last argument to the function. Perhaps the function name is
deceiving.
 
> Many of these functions are too large to be inlined.  Suggest they be
> placed in fs/fs-stack.c (or whatever we call it).
 
Ack. As a rule of thumb, for functions like these (laundry list of
assignments), what's a good threshold?
 
> The functions themselves seem a bit arbitrary.
> stackfs_copy_attr_timesizes() copy the three timestamps and the size.  Is
> there actually any methodical reason for that, or is it simply some
> sequence which happens to have been observed in ecryptfs?

These functions come from the FiST templates [1]. Some of these can
definitely removed, or split up.

> And please - if I asked these questions when reviewing the patch, others
> will ask them when reading the code two years from now.  So please treat my
> questions as "gosh, I should have put a comment in there".

That's exactly how I look at it.

Josef "Jeff" Sipek.

-- 
Bad pun of the week: The formula 1 control computer suffered from a race
condition
