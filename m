Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWESUXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWESUXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWESUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:23:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49283 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964817AbWESUXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:23:09 -0400
Date: Fri, 19 May 2006 22:23:30 +0200
From: Jan Kara <jack@suse.cz>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: write_out_data in JBD
Message-ID: <20060519202330.GE14393@atrey.karlin.mff.cuni.cz>
References: <446C3030.2040303@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446C3030.2040303@bull.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Stephen,
  I'm not Stephen but I guess my answer would suffice ;)

> Here is a code fragment starting at "write_out_data:" in
> "journal_commit_transaction()":
> 
> Let's assume that there is a single "jh" on the list.
  OK.

> 
>   while (commit_transaction->t_sync_datalist) {
> 
>       jh = commit_transaction->t_sync_datalist;
>       commit_transaction->t_sync_datalist = jh->b_tnext;
> 
>       // "commit_transaction->t_sync_datalist" happens always
>       // to point at our single "jh"
> 
>       bh = jh2bh(jh);
> 
>       // Assume not locked
>       // Assume dirty
> 
>       if (buffer_dirty(bh)) {
>           get_bh(bh);
>           wbuf[bufs++] = bh;
>           if (bufs == journal->j_wbufsize) {
  Now this would not happen as j_wbufsize is larger than 1. But still
even if it would happen ll_rw_block() would be called, that would clear
a dirty bit and and the next time we see the buffer we take a different
route.
  But actually you are right that if we fail with
bufs==journal->j_wbufsize we would go into the next iteration of the
loop and queue the buffer again. Anyway we agreed to rewrite this code
in another thread :). I just have to make sure we don't have a similar
problem in the new version.

>               ...
>               goto write_out_data;
>           }
>       } else ...
>   }
> 
> I think our single "jh" will be put on "wbuf[]" repeatedly
> ("journal->j_wbufsize" times).


								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
