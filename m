Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUCWNGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 08:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUCWNGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 08:06:24 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:59915 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262536AbUCWNGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 08:06:22 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1
Date: Tue, 23 Mar 2004 14:05:56 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, piotr@larroy.com
References: <20040316015338.39e2c48e.akpm@osdl.org> <20040322195450.GB2306@larroy.com> <20040322193502.41704cda.akpm@osdl.org>
In-Reply-To: <20040322193502.41704cda.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403231405.56777@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 March 2004 04:35, Andrew Morton wrote:

Hi Andrew,

thanks alot. All is back to normal and running smooth and fine! :)

> >  > /proc/meminfo, /proc/vmstat and /proc/slabinfo.  Also sysrq-M.
> A memory leak was introduced in the ext3 changes.
>  25-akpm/fs/jbd/commit.c |    8 ++++++++
>  1 files changed, 8 insertions(+)
>
> diff -puN fs/jbd/commit.c~jbd-move-locked-buffers-leak-fixes
> fs/jbd/commit.c ---
> 25/fs/jbd/commit.c~jbd-move-locked-buffers-leak-fixes	2004-03-22
> 19:34:37.492865816 -0800 +++ 25-akpm/fs/jbd/commit.c	2004-03-22
> 19:34:41.987182576 -0800
> @@ -296,6 +296,13 @@ write_out_data:
>  		}
>  	}
>
> +	if (bufs) {
> +		spin_unlock(&journal->j_list_lock);
> +		ll_rw_block(WRITE, bufs, wbuf);
> +		journal_brelse_array(wbuf, bufs);
> +		spin_lock(&journal->j_list_lock);
> +	}
> +
>  	/*
>  	 * Wait for all previously submitted IO to complete.
>  	 */
> @@ -322,6 +329,7 @@ write_out_data:
>  			jh->b_transaction = NULL;
>  			jbd_unlock_bh_state(bh);
>  			journal_remove_journal_head(bh);
> +			put_bh(bh);
>  		} else {
>  			jbd_unlock_bh_state(bh);
>  		}
