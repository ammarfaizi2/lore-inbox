Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVCHEkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVCHEkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVCHEkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:40:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2500 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261353AbVCHEkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:40:14 -0500
Date: Tue, 8 Mar 2005 04:40:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] inotify for 2.6.11-mm1, updated
Message-ID: <20050308044009.GA352@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>, akpm@osdl.org,
	John McCutchan <ttb@tentacle.dhs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com> <1109963494.10313.32.camel@betsy.boston.ximian.com> <20050307011939.GA7764@infradead.org> <1110230878.3973.40.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110230878.3973.40.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > this one seems totally unrelated.
> 
> Eh?  We did not add that. ;)

Sorry, I thought I saw a + somewhere there at the beggining of the line,
my fault.

> > Should probably use the /dev/mem major.
> 
> Hrm, should we?
> 
> Also, the memory class stuff is all local to mem.c.  For example, I
> cannot get at /sys/class/mem.  The misc. device stuff is exported.

Why do you need the classdevice?  I'm really not too eager about adding
tons of new misdevices now that we can route directly to individual majors
with cdev_add & stuff.  Especially when you're actually relying on class
device you should have your own one instead of relying on an onsolete
layer.

> > do you really need a spinlock of your own in every inode?  Inode memory
> > usage is a quite big problem.
> 
> Yah, we do.  For a couple of reasons.  First, by introducing our own
> lock, we never need touch i_lock, and avoid that scalability mess
> altogether.  Second, and most importantly, i_lock is an outermost lock.
> We need our lock to be nestable, because we walk inode -> inotify_watch
> -> inotify_device.  I've tried various rewrites to not need our own
> lock.  None are pretty.
> 
> I can offer to the "inode memory worries me" people that they can always
> disable CONFIG_INOTIFY.

They're bound to use distro kernels unfortunaly..  These people is anyone
doing big-scale fileserving at least.

> +	if ((ret + (type == READ)) > 0) {
> +		struct dentry *dentry = file->f_dentry;
> +		if (type == READ)
> +			fsnotify_access(dentry, dentry->d_inode,
> +					dentry->d_name.name);
> +		else
> +			fsnotify_modify(dentry, dentry->d_inode,
> +					dentry->d_name.name);
> +	}

Arguments two and three are still redudant.

Actually, you fixed that in read_write.c, just compat.c is still missing.
Looks like you forget to fix that one and didn't have a chance to compile-test
the 32bit compat layer?

