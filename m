Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWE3KpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWE3KpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWE3KpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:45:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65411 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932234AbWE3KpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:45:04 -0400
Subject: Re: [patch 34/61] lock validator: special locking: bdev
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060529183523.0985b537.akpm@osdl.org>
References: <20060529212109.GA2058@elte.hu> <20060529212554.GH3155@elte.hu>
	 <20060529183523.0985b537.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 12:45:00 +0200
Message-Id: <1148985901.3636.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 18:35 -0700, Andrew Morton wrote:
> On Mon, 29 May 2006 23:25:54 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > teach special (recursive) locking code to the lock validator. Has no
> > effect on non-lockdep kernels.
> > 
> 
> There's no description here of the problem which is being worked around. 
> This leaves everyone in the dark.
> 
> > +static int
> > +blkdev_get_whole(struct block_device *bdev, mode_t mode, unsigned flags)
> > +{
> > +	/*
> > +	 * This crockload is due to bad choice of ->open() type.
> > +	 * It will go away.
> > +	 * For now, block device ->open() routine must _not_
> > +	 * examine anything in 'inode' argument except ->i_rdev.
> > +	 */
> > +	struct file fake_file = {};
> > +	struct dentry fake_dentry = {};
> > +	fake_file.f_mode = mode;
> > +	fake_file.f_flags = flags;
> > +	fake_file.f_dentry = &fake_dentry;
> > +	fake_dentry.d_inode = bdev->bd_inode;
> > +
> > +	return do_open(bdev, &fake_file, BD_MUTEX_WHOLE);
> > +}
> 
> "crock" is a decent description ;)
> 
> How long will this live, and what will the fix look like?

this btw is not new crock; the only new thing is the BD_MUTEX_WHOLE :)

