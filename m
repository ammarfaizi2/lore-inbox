Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVEQUM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVEQUM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEQUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:12:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29150 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261815AbVEQUMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:12:55 -0400
Date: Tue, 17 May 2005 21:13:10 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>
Subject: Re: [patch 2/7] BSD Secure Levels: move bd claim from inode to filp
Message-ID: <20050517201310.GD29811@parcelfarce.linux.theplanet.co.uk>
References: <20050517152303.GA2814@halcrow.us> <20050517152545.GA2944@halcrow.us> <20050517160900.GB32436@infradead.org> <20050517164922.GA29811@parcelfarce.linux.theplanet.co.uk> <20050517194616.GA14957@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517194616.GA14957@halcrow.us>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 02:46:17PM -0500, Michael Halcrow wrote:
> In my tests, utime() does not cause file_permission() to be called.

> > Use of current in setting/checking ->i_security is a bad joke.

OK, these applied to the original.  Now to the patched version:

	a) ->file_permission() is called on every write(2).  So you get
an open() for each write().  And only one matching close() (aka. blkdev_put())
	b) ->file_permission() is *not* called on mmap() path.  So much for
protection, exclusion, etc.
	c) you get bd_claim() on each write(); subsequent ones work just
fine, since you use the same holder.  On close() you undo one of those.
Leaving the rest there, with holder pointing to freed-and-soon-to-be-reused
struct file.
 
> > d) cargo-cult programming: ->f_dentry and ->f_dentry->d_inode are
> > *not* NULL, TYVM.
> 
> Exactly what code are you refering to here?

seclvl_file_free_security(), but I have to lift that objection in part - this
crap gets called from put_filp(), so ->f_dentry might be NULL.  If it is not
NULL, though, we are guaranteed that ->f_dentry->d_inode will *not* be NULL.
BTW, all your checks in that path can be replaced with a single check for
f->f_security being non-NULL.  Not that it helped, though - see (a) and (c)
above.
