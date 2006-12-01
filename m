Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759243AbWLAHCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759243AbWLAHCJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759244AbWLAHCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:02:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:65452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759243AbWLAHCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:02:07 -0500
Date: Thu, 30 Nov 2006 23:01:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [GFS2] Don't flush everything on fdatasync [70/70]
Message-Id: <20061130230158.174e995c.akpm@osdl.org>
In-Reply-To: <1164889448.3752.449.camel@quoit.chygwyn.com>
References: <1164889448.3752.449.camel@quoit.chygwyn.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 12:24:08 +0000
Steven Whitehouse <swhiteho@redhat.com> wrote:

>  static int gfs2_fsync(struct file *file, struct dentry *dentry, int datasync)
>  {
> -	struct gfs2_inode *ip = GFS2_I(dentry->d_inode);
> +	struct inode *inode = dentry->d_inode;
> +	int sync_state = inode->i_state & (I_DIRTY_SYNC|I_DIRTY_DATASYNC);
> +	int ret = 0;
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = 0,
> +	};
> +
> +	if (gfs2_is_jdata(GFS2_I(inode))) {
> +		gfs2_log_flush(GFS2_SB(inode), GFS2_I(inode)->i_gl);
> +		return 0;
> +	}
>  
> -	gfs2_log_flush(ip->i_gl->gl_sbd, ip->i_gl);
> +	if (sync_state != 0) {
> +		if (!datasync)
> +			ret = sync_inode(inode, &wbc);

filemap_fdatawrite() would be simpler.
