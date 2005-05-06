Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVEFVZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEFVZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVEFVZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:25:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21987 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261260AbVEFVYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:24:40 -0400
Date: Fri, 6 May 2005 13:50:33 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>,
       openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Message-ID: <20050506165033.GA2105@logos.cnet>
References: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr> <20050506052803.GE777@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506052803.GE777@alpha.home.local>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 07:28:03AM +0200, Willy Tarreau wrote:
> Hi,
> 
> On Fri, May 06, 2005 at 02:55:40AM +0300, Dimitris Zilaskos wrote:
> > 
> > 	Hello ,
> > 
> > [1.] One line summary of the problem:
> > 
> > Oopses on an openafs client system using openafs 1.3.78 and kernel 2.4.29.
> > Oopses also occur afer moving to kernel 2.4.30 and openafs 1.3.82
> 
> The problem you encounter on 2.4.30 is not the same as on 2.4.29. The problem
> in 2.4.29 is related to link_path_walk, which has been fixed in 2.4.30.
> 
> You might want to try 1.3.78 (or other) with 2.4.29-hf7 to check if your
> 2.4.30 problem was brought by kernel 2.4.30 or openafs 1.3.82, as the
> link_path_walk bug is also fixed in hf7. The patch is available on :


Willy,

The link_path_walk fix in v2.4.30 is related to a reference counting
bug triggered by "umount"...

As Christoph noted OpenAFS seems to be doing nasty things...  it seems 
to play with dentries inode i_state directly? If that is the case, 
maybe it should define d_iput? 

static inline void dentry_iput(struct dentry * dentry)
{
        struct inode *inode = dentry->d_inode;
        if (inode) {
                dentry->d_inode = NULL;
                list_del_init(&dentry->d_alias);
                spin_unlock(&dcache_lock);
                if (dentry->d_op && dentry->d_op->d_iput)
                        dentry->d_op->d_iput(dentry, inode);



May  6 04:55:29 system kernel: kernel BUG at inode.c:1204!
