Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTDRPiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTDRPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:38:50 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39510 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263113AbTDRPis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:38:48 -0400
Subject: Re: Deadlock fix for 2.4.20
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20030415151240.GA23547@atrey.karlin.mff.cuni.cz>
References: <20030415151240.GA23547@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050681044.3203.87.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Apr 2003 16:50:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-04-15 at 16:12, Jan Kara wrote:

>   I'm sending you a patch which fixes the deadlock when quota is used on
> ext3. The problem is that in sync_dquots() first dqio_sem is acquired
> and then transaction is started while in the other paths the order is
> inverse... The patch introduces needed framework into quota to allow
> ext3 start transaction before the semaphore is acquired. Please apply.

Please don't, there is at least one major and one minor problem to be
resolved.


> +#define EXT3_OLD_QFMT_BLOCKS 2
> +
> +static int ext3_sync_dquot(struct dquot *dquot)
> +{
> +	int ret;
> +	handle_t *handle;
> +	struct inode *qinode;
> +
> +	lock_kernel();
> +	qinode = dquot->dq_sb->s_dquot.files[dquot->dq_type]->f_dentry->d_inode;
> +	handle = ext3_journal_start(qinode, EXT3_OLD_QFMT_BLOCKS);
> +	if (IS_ERR(handle)) {
> +		unlock_kernel();
> +		return PTR_ERR(handle);
> +	}
> +	unlock_kernel();
> +	ret = old_sync_dquot(dquot);
> +	lock_kernel();
> +	ret = ext3_journal_stop(handle, qinode);
> +	unlock_kernel();
> +	return ret;
> +}
> +#endif

First of all, EXT3_OLD_QFMT_BLOCKS is wrong.  If you "chown" a file to a
new user, you'll potentially allocate new space for a new quota file
entry.  That requires a ton of preallocation.  At the minimum, you have
the inode update; the superblock update for the free block counts; the
group descriptor update, likewise; the bitmap update; possibly one or
more indirect block updates; and (finally) the quota block itself.

You _will_ get buffer-credit assert failures with this value.

Secondly, you're now effectively calling generic_file_write with a
transaction already open.  That's _another_ lock ranking violation. 
generic_file_write() takes i_sem, and then opens a transaction.  With
this new quota code, you can now open a transaction and then take
i_sem.  Boom.  

However, most users don't ever take i_sem on the quota inode in any
other way.  Directly writing to, or truncating, the quota file is a
highly non-recommended activity. :-)

btw, I'm away all next week, so further responses will be slow...

Cheers,
 Stephen

