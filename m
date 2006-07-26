Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWGZGmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWGZGmL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWGZGmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:42:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030419AbWGZGmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:42:10 -0400
Date: Tue, 25 Jul 2006 23:42:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 007 of 9] knfsd: Separate out some parts of nfsd_svc,
 which start nfs servers.
Message-Id: <20060725234202.078ecb48.akpm@osdl.org>
In-Reply-To: <1060725015457.21981@suse.de>
References: <20060725114207.21779.patches@notabene>
	<1060725015457.21981@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 11:54:57 +1000
NeilBrown <neilb@suse.de> wrote:

> 
> Separate out the code for creating a new service, and for creating
> initial sockets.
> 
> Some of these new functions will have multiple callers soon.

In which case they shouldn't be inlined, hmm?

> +static inline int nfsd_create_serv(void)
> +{
> +	int err = 0;
> +	lock_kernel();
> +	if (nfsd_serv) {
> +		nfsd_serv->sv_nrthreads++;
> +		unlock_kernel();
> +		return 0;
> +	}
> +
> +	atomic_set(&nfsd_busy, 0);
> +	nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE,
> +			       nfsd_last_thread);
> +	if (nfsd_serv == NULL)
> +		err = -ENOMEM;
> +	else
> +		nfsd_serv->sv_nrthreads++;
> +	unlock_kernel();
> +	do_gettimeofday(&nfssvc_boot);		/* record boot time */
> +	return err;
> +}
> +

