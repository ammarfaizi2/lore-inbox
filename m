Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbUK2XYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUK2XYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUK2XWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:22:45 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:63115 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261881AbUK2XUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:20:33 -0500
Date: Mon, 29 Nov 2004 15:01:48 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 7/10 CKRM:  Resource controller for number of tasks
Message-ID: <20041129230148.GA20828@kroah.com>
References: <E1CYqbf-00059Z-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqbf-00059Z-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:50:39AM -0800, Gerrit Huizenga wrote:
> +static spinlock_t stub_lock = SPIN_LOCK_UNLOCKED;
> +
> +static get_ref_t real_get_ref = NULL;
> +static put_ref_t real_put_ref = NULL;
> +
> +void ckrm_numtasks_register(get_ref_t gr, put_ref_t pr)
> +{
> +	spin_lock(&stub_lock);
> +	real_get_ref = gr;
> +	real_put_ref = pr;
> +	spin_unlock(&stub_lock);
> +}
> +
> +int numtasks_get_ref(void *arg, int force)
> +{
> +	int ret = 1;
> +	spin_lock(&stub_lock);
> +	if (real_get_ref) {
> +		ret = (*real_get_ref) (arg, force);
> +	}
> +	spin_unlock(&stub_lock);
> +	return ret;
> +}
> +
> +void numtasks_put_ref(void *arg)
> +{
> +	spin_lock(&stub_lock);
> +	if (real_put_ref) {
> +		(*real_put_ref) (arg);
> +	}
> +	spin_unlock(&stub_lock);
> +}
> +
> +EXPORT_SYMBOL(ckrm_numtasks_register);
> +EXPORT_SYMBOL(numtasks_get_ref);
> +EXPORT_SYMBOL(numtasks_put_ref);

Why are these functions used instead of calling the real functions?
They are only ever used to register a single set of functions anyway.

Oh, and void * is to be avoided at all costs...

thanks,

greg k-h
