Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWBYPf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWBYPf1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWBYPf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:35:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41990 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161010AbWBYPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:35:26 -0500
Date: Sat, 25 Feb 2006 16:35:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Fermin Molina <fermin@asic.udl.es>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/locks.c:1932!
Message-ID: <20060225153525.GT3674@stusta.de>
References: <1140189359.22719.51.camel@viagra.udl.net> <1140373675.7883.45.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140373675.7883.45.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 01:27:55PM -0500, Trond Myklebust wrote:
> On Fri, 2006-02-17 at 16:15 +0100, Fermin Molina wrote:
> > Hi,
> > 
> > I run samba sharing NFS mounted shares from another machine. I'm getting
> > the following bugs in console (and in logs), when I stop samba (but not
> > always, I think it depends of stalled locks):
> > 
> > lockd: unexpected unlock status: 7
> > lockd: unexpected unlock status: 7
> > lockd: unexpected unlock status: 7
> > ------------[ cut here ]------------
> 
> Hmm... The problem here is that the server is returning an unexpected
> error: it is normally supposed to return "lock granted" or "grace
> error", but is actually returning "stale filehandle".
> 
> Anyhow, the client should be able to deal with this without Oopsing.


This seems to be a patch that should go into 2.6.16?


> The attached patch ought to fix that. Please could you give it a try?
> 
> Cheers,
>   Trond

> Author: Trond Myklebust <Trond.Myklebust@netapp.com>
> NLM: Ensure we do not Oops in the case of an unlock
> 
> In theory, NLM specs assure us that the server will only reply LCK_GRANTED
> or LCK_DENIED_GRACE_PERIOD to our NLM_UNLOCK request.
> 
> In practice, we should not assume this to be the case, and the code will
> currently Oops if we do.
> 
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> ---
> 
>  fs/lockd/clntproc.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> index 7e89655..da76592 100644
> --- a/fs/lockd/clntproc.c
> +++ b/fs/lockd/clntproc.c
> @@ -644,10 +644,16 @@ nlmclnt_unlock(struct nlm_rqst *req, str
>  
>  	status = nlmclnt_call(req, NLMPROC_UNLOCK);
>  	nlmclnt_release_lockargs(req);
> +	/*
> +	 * Note: the server is supposed to either grant us the unlock
> +	 * request, or to deny it with NLM_LCK_DENIED_GRACE_PERIOD. In either
> +	 * case, we want to unlock.
> +	 */
> +	do_vfs_lock(fl);
> +
>  	if (status < 0)
>  		return status;
>  
> -	do_vfs_lock(fl);
>  	if (resp->status == NLM_LCK_GRANTED)
>  		return 0;
>  


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

