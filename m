Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264319AbUD0T4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbUD0T4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUD0T4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:56:02 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:2254 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264319AbUD0Tzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:55:41 -0400
Date: Tue, 27 Apr 2004 21:55:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-cifs-client@lists.samba.org,
       jra@samba.org
Subject: Re: [PATCH COW] sys_copyfile
Message-ID: <20040427195503.GC2176@wohnheim.fh-wedel.de>
References: <1083081505.12804.65.camel@stevef95.austin.ibm.com> <20040427164220.GB2176@wohnheim.fh-wedel.de> <1083095178.4792.4.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1083095178.4792.4.camel@stevef95.austin.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 April 2004 14:46:19 -0500, Steve French wrote:
> On Tue, 2004-04-27 at 11:42, Jörn Engel wrote:
> 
> > Shouldn't it be rather
> > 
> > 	if (old_nd->dentry->d_inode->i_op->copy)
> > 		return old_nd->dentry->d_inode->i_op->copy(old_nd->dentry,
> > 				mode, new_dentry);
> > 
> > or something similar?  The copy() effectively replaces the complete
> > create/sendfile/possibly-unlink series.
> 
> In some network protocols the client does not know whether the server
> wants to support copy operation or not (perhaps if the files were on
> different server partitions the server might return an error e.g), in
> those cases the filesystem client could return error not supported or
> equivalent and the remainder of your function is executed doing the copy
> the harder way (open/read/close create/write/close) but still faster a
> few percent faster than before your patch.

Makes sense.  Then something like

	if (old_nd->dentry->d_inode->i_op->copy) {
		ret = old_nd->dentry->d_inode->i_op->copy(old_nd->dentry,
				mode, new_dentry);
		if (ret != -ENOSYS)
			return ret;
	}

Also, would it be possible to do essentially the same with sendfile()?
That should bring roughly the same speedup for disk based filesystems,
and would be a bit more general.

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
