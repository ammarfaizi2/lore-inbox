Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVC3EHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVC3EHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 23:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVC3EHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 23:07:03 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:18612 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261534AbVC3EG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 23:06:57 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Date: Wed, 30 Mar 2005 14:06:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16970.9679.874919.876412@cse.unsw.edu.au>
Cc: vherva@viasys.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
In-Reply-To: message from Marcelo Tosatti on Tuesday March 29
References: <20050326162801.GA20729@logos.cnet>
	<20050328073405.GQ16169@viasys.com>
	<20050328165501.GR16169@viasys.com>
	<16968.40186.628410.152511@cse.unsw.edu.au>
	<20050329215207.GE5018@logos.cnet>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 29, marcelo.tosatti@cyclades.com wrote:
> 
> Attached is the backout patch, for convenience.

Thanks.  I had another look, and think I may be able to see the
problem.  If I'm right, it is a problem with this patch.

> diff -Nru a/fs/jbd/commit.c b/fs/jbd/commit.c
> --- a/fs/jbd/commit.c	2005-03-29 18:50:55 -03:00
> +++ b/fs/jbd/commit.c	2005-03-29 18:50:55 -03:00
> @@ -92,7 +92,7 @@
>  	struct buffer_head *wbuf[64];
>  	int bufs;
>  	int flags;
> -	int err = 0;
> +	int err;
>  	unsigned long blocknr;
>  	char *tagp = NULL;
>  	journal_header_t *header;
> @@ -299,8 +299,6 @@
>  			spin_unlock(&journal_datalist_lock);
>  			unlock_journal(journal);
>  			wait_on_buffer(bh);
> -			if (unlikely(!buffer_uptodate(bh)))
> -				err = -EIO;
>  			/* the journal_head may have been removed now */
>  			lock_journal(journal);
>  			goto write_out_data;


I think the "!buffer_update(bh)" test is not safe at this point as,
after the wait_on_buffer which could cause a schedule, the bh may
no longer exist, or be for the same block.  There doesn't seem to be
any locking or refcounting that would keep it valid.

Note the comment "the journal_head may have been removed now".
If the journal_head is gone, the associated buffer_head is likely gone
as well. 

I'm not certain that this is right, but it seems possible and would
explain the symptoms.  Maybe Stephen or Andrew could comments?


> --- a/mm/filemap.c	2005-03-29 18:50:55 -03:00
> +++ b/mm/filemap.c	2005-03-29 18:50:55 -03:00
> @@ -3261,12 +3261,7 @@
>  			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
>  	}
>  	
> -	/*
> -	 * generic_osync_inode always returns 0 or negative value.
> -	 * So 'status < written' is always true, and written should
> -	 * be returned if status >= 0.
> -	 */
> -	err = (status < 0) ? status : written;
> +	err = written ? written : status;
>  out:
>  
>  	return err;

As an aside, this looks extremely dubious to me.

There is a loop earlier in this routine (do_generic_file_write) that
passes a piece-at-a-time of the write request to prepare_write /
commit_write.
Successes are counted in 'written'.  A failure causes the loop to
abort with a status in 'status'.

If some of the write succeeded and some failed, then I believe the
correct behaviour is to return the number of bytes that succeeded.
However this change to the return status (remember the above patch is
a reversal) causes any failure to over-ride any success. This, I
think, is wrong.

NeilBrown
