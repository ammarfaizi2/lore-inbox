Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWGZUls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWGZUls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWGZUls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:41:48 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36567 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751138AbWGZUls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:41:48 -0400
Date: Wed, 26 Jul 2006 16:41:42 -0400
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 009 of 9] knfsd: Allow sockets to be passed to nfsd via 'portlist'
Message-ID: <20060726204142.GG31172@fieldses.org>
References: <20060725114207.21779.patches@notabene> <1060725015508.22007@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060725015508.22007@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 11:55:08AM +1000, NeilBrown wrote:
> +		err = nfsd_create_serv();
> +		if (!err) {
> +			int proto = 0;
> +			err = svc_addsock(nfsd_serv, fd, buf, &proto);
> +			/* Decrease the count, but don't shutdown the
> +			 * the service
> +			 */
> +			if (err >= 0)
> +				lockd_up(proto);
> +			nfsd_serv->sv_nrthreads--;
....
> @@ -211,8 +211,6 @@ static inline int nfsd_create_serv(void)
>  			       nfsd_last_thread);
>  	if (nfsd_serv == NULL)
>  		err = -ENOMEM;
> -	else
> -		nfsd_serv->sv_nrthreads++;

I don't understand these sv_nrthreads changes.

> @@ -449,18 +450,23 @@ int one_sock_name(char *buf, struct svc_
>  }
>  
>  int
> -svc_sock_names(char *buf, struct svc_serv *serv)
> +svc_sock_names(char *buf, struct svc_serv *serv, char *toclose)
>  {
> -	struct svc_sock *svsk;
> +	struct svc_sock *svsk, *closesk = NULL;
>  	int len = 0;
>  
>  	if (!serv) return 0;
>  	spin_lock(&serv->sv_lock);
>  	list_for_each_entry(svsk, &serv->sv_permsocks, sk_list) {
>  		int onelen = one_sock_name(buf+len, svsk);
> -		len += onelen;
> +		if (toclose && strcmp(toclose, buf+len) == 0)
> +			closesk = svsk;
> +		else
> +			len += onelen;
>  	}
>  	spin_unlock(&serv->sv_lock);
> +	if (closesk)
> +		svc_delete_socket(closesk);

Am I missing something, or do we end up missing a lockd_down() in this
case?  (Because nfsd_last_thread() isn't going to be calling
lockd_down() for this thread now that we've removed it from
sv_permsocks).

--b.
