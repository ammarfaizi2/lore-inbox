Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTKNVTT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 16:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTKNVTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 16:19:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3721 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264377AbTKNVTR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 16:19:17 -0500
Date: Fri, 14 Nov 2003 21:19:13 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org
Subject: Re: seq_file API strangeness
Message-ID: <20031114211912.GL24159@parcelfarce.linux.theplanet.co.uk>
References: <20031114202327.GK24159@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0311142048520.849-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311142048520.849-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 08:55:48PM +0000, Tigran Aivazian wrote:
> In the ->open() method I allocate a seq->private like this:
> 
>   err = seq_open(file, sop);
>   if (!err) {
> 	struct seq_file *m = file->private_data;
> 
> 	m->private = kmalloc(sizeof(struct ctask), GFP_KERNEL);
>         if (!m->private) {
>                         kfree(file->private_data);
>                         return -ENOMEM;
>         }
>   }
> 
> Now, freeing the structure that I did not allocate (file->private_data 
> allocated in seq_open()) is not nice. But calling seq_release() from 
> ->open() method is not nice either (different arguments, namely 'inode'

I beg your pardon?  What different arguments?

->open() gets struct inode * and struct file *
->release() gets exactly the same.
seq_release() is what you use as ->release()

What's the problem?

> and also m->buf is NULL at that point, although I believe kfree(NULL) is 
> not illegal).

Of course it is not illegal.  Moreover, if you just do open() immediately
followed by close(), you won't get non-NULL ->buf at all.  It's a perfectly
normal situation and seq_release() can handle it - no problems with that.

> What do you think?

	if (!m->private) {
		seq_release(inode, file);
		return -ENOMEM;
	}

Same as e.g. fs/proc/base.c does in similar situation (see mounts_open()).
