Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751239AbWFERdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWFERdV (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWFERdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:33:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61095 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751239AbWFERdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:33:20 -0400
Date: Mon, 5 Jun 2006 19:35:11 +0200
From: Jan Kara <jack@suse.cz>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
Message-ID: <20060605173511.GA24342@atrey.karlin.mff.cuni.cz>
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu> <1149528339.3111.114.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149528339.3111.114.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-06-05 at 13:00 -0400, Valdis.Kletnieks@vt.edu wrote:
> > Using the -lockdep patch that Ingo had a few days ago, plus Stefan Richter's
> > two patches for ieee1394 (which fixed the *first* locking issue I hit)....
> 
> > [  219.535000] quotaon/1374 is trying to release lock (&inode->i_mutex) at:
> > [  219.535000]  [<c0382ba2>] mutex_unlock+0xd/0xf
> > [  219.535000] but the next lock to release is:
> > [  219.535000]  (&s->s_dquot.dqonoff_mutex){--..}, at: [<c0382a09>] mutex_lock+0xd/0xf
> 
> 
> ok the quota code is playing fun games with unlock order..
> 
> 
> 
> The quota code nests 3 mutexes but releases them in a totally different
> order; mark this as such in the code.
  Yes, it does. It was hard enough to get it to *lock* everything in
the right order and thus avoid all those nasty lock inversion problems so
unlocking is sometimes a bit arbitrary :)..

> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
  Signed-off-by: Jan Kara <jack@suse.cz>
 
> ---
>  fs/dquot.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.17-rc5-mm3/fs/dquot.c
> ===================================================================
> --- linux-2.6.17-rc5-mm3.orig/fs/dquot.c
> +++ linux-2.6.17-rc5-mm3/fs/dquot.c
> @@ -1475,7 +1475,7 @@ static int vfs_quota_on_inode(struct ino
>  		goto out_file_init;
>  	}
>  	mutex_unlock(&dqopt->dqio_mutex);
> -	mutex_unlock(&inode->i_mutex);
> +	mutex_unlock_non_nested(&inode->i_mutex);
>  	set_enable_flags(dqopt, type);
>  
>  	add_dquot_ref(sb, type);
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
