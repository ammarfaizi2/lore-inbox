Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTJYRma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 13:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbTJYRma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 13:42:30 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:18610 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262750AbTJYRm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 13:42:26 -0400
Date: Sat, 25 Oct 2003 19:42:25 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, Alex Lyashkov <shadow@itt.net.ru>
Subject: Re: Linux 2.4 quota (accounting?) bug ...
Message-ID: <20031025174225.GB24020@DUK2.13thfloor.at>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, Alex Lyashkov <shadow@itt.net.ru>
References: <20031025162640.GA24020@DUK2.13thfloor.at> <20031025163128.GA20786@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025163128.GA20786@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 06:31:28PM +0200, Jan Kara wrote:
>   Hi,
> 
> > a friend of mine, made me aware of the following
> > imbalance, which looks like a minor accounting bug 
> > to me, but might be a quota bug ...
>   Sorry but the code seems correct to me - we get reference to dquot by
> get_dquot_ref() and than we put the reference by dqput(). dqput() is
> correct because something nasty might happen in the mean time and so we
> might be the last holders of the dquot. What do you think is wrong?

dqput() does dqstats.drops++;
which isn't correct if this should be the same as
put_dquot_ref(), but maybe I'm just irritated by 
strange statistics on some kernels showing more
drops than lookups+allocated after sync/quotaoff

best,
Herbert

> 								Honza
> 
> > 
> > fs/dquot.c : 394 vfs_quota_sync()
> > -----------------------------------------------------
> >                 /* Get reference to quota so it won't be invalidated. get_dquot_ref()
> >                  * is enough since if dquot is locked/modified it can't be
> >                  * on the free list */
> > 
> > > 		get_dquot_ref(dquot);
> >  		if (dquot->dq_flags & DQ_LOCKED)
> >  			wait_on_dquot(dquot);
> >  		if (dquot_dirty(dquot))
> >  			sb->dq_op->sync_dquot(dquot);
> > >		dqput(dquot);
> >  		goto restart;
> >  	}
> > 
> > 
> > best,
> > Herbert
> > 
> > 
> -- 
> Jan Kara <jack@suse.cz>
> SuSE CR Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
