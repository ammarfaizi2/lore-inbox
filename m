Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTKOTv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 14:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTKOTv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 14:51:58 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:37511 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262033AbTKOTvz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 14:51:55 -0500
Date: Sat, 15 Nov 2003 19:52:00 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein.homenet
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Harald Welte <laforge@netfilter.org>, <linux-kernel@vger.kernel.org>
Subject: Re: seq_file API strangeness
In-Reply-To: <20031114211912.GL24159@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0311151950320.743-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Yes, you are right, thank you. I don't know why I thought open/release 
took different arguments. Yes, calling seq_release(inode,file) is the 
right way, I will change my code.

Kind regards
Tigran

On Fri, 14 Nov 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Fri, Nov 14, 2003 at 08:55:48PM +0000, Tigran Aivazian wrote:
> > In the ->open() method I allocate a seq->private like this:
> > 
> >   err = seq_open(file, sop);
> >   if (!err) {
> > 	struct seq_file *m = file->private_data;
> > 
> > 	m->private = kmalloc(sizeof(struct ctask), GFP_KERNEL);
> >         if (!m->private) {
> >                         kfree(file->private_data);
> >                         return -ENOMEM;
> >         }
> >   }
> > 
> > Now, freeing the structure that I did not allocate (file->private_data 
> > allocated in seq_open()) is not nice. But calling seq_release() from 
> > ->open() method is not nice either (different arguments, namely 'inode'
> 
> I beg your pardon?  What different arguments?
> 
> ->open() gets struct inode * and struct file *
> ->release() gets exactly the same.
> seq_release() is what you use as ->release()
> 
> What's the problem?
> 
> > and also m->buf is NULL at that point, although I believe kfree(NULL) is 
> > not illegal).
> 
> Of course it is not illegal.  Moreover, if you just do open() immediately
> followed by close(), you won't get non-NULL ->buf at all.  It's a perfectly
> normal situation and seq_release() can handle it - no problems with that.
> 
> > What do you think?
> 
> 	if (!m->private) {
> 		seq_release(inode, file);
> 		return -ENOMEM;
> 	}
> 
> Same as e.g. fs/proc/base.c does in similar situation (see mounts_open()).
> 

