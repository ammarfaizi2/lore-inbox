Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWE0GiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWE0GiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 02:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWE0GiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 02:38:20 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:21678 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750797AbWE0GiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 02:38:19 -0400
Message-ID: <348711895.05505@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 14:38:26 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/33] readahead: initial method - expected read size
Message-ID: <20060527063826.GC4991@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469546.16482@ustc.edu.cn> <20060526102934.1dd39296.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526102934.1dd39296.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:29:34AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > backing_dev_info.ra_expect_bytes is dynamicly updated to be the expected
> > read pages on start-of-file. It allows the initial readahead to be more
> > aggressive and hence efficient.
> > 
> > 
> > +void fastcall readahead_close(struct file *file)
> 
> eww, fastcall.

Hehe, it's a tiny function, and calls no further sub-routines
except debugging ones.   Still not necessary?

> > +{
> > +	struct inode *inode = file->f_dentry->d_inode;
> > +	struct address_space *mapping = inode->i_mapping;
> > +	struct backing_dev_info *bdi = mapping->backing_dev_info;
> > +	unsigned long pos = file->f_pos;
> 
> f_pos is loff_t.

Just meant to be a little more compact ;)

+       unsigned long pos = file->f_pos;
+       unsigned long pgrahit = file->f_ra.cache_hits;
+       unsigned long pgaccess = 1 + pos / PAGE_CACHE_SIZE;
+       unsigned long pgcached = mapping->nrpages;
+
+       if (!pos)                               /* pread */
+               return;
+
+       if (pgcached > bdi->ra_pages0)          /* excessive reads */
+               return;

Here the f_pos will almost definitely has small values.

+
+       if (pgaccess >= pgcached) {


Fixed by adding a comment to clarify it:

+       unsigned long pos = file->f_pos;  /* supposed to be small */
