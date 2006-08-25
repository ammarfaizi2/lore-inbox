Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWHYN6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWHYN6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHYN6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:58:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61931 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932303AbWHYN6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:58:50 -0400
Date: Fri, 25 Aug 2006 14:58:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@suse.de>, nfs@lists.sourceforge.net
Subject: Re: [NFS] kthread: update lockd to use kthread
Message-ID: <20060825135824.GA10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Cedric Le Goater <clg@fr.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Neil Brown <neilb@suse.de>, nfs@lists.sourceforge.net
References: <44EEA5E5.6000509@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EEA5E5.6000509@fr.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	host->h_nsmstate = newstate;
>  	if (!host->h_reclaiming++) {
> +		struct task_struct* task;
> +
>  		nlm_get_host(host);
>  		__module_get(THIS_MODULE);
> -		if (kernel_thread(reclaimer, host, CLONE_KERNEL) < 0)
> +		task = kthread_run(reclaimer, host, "%s-reclaim", host->h_name);
> +		if (IS_ERR(task))
>  			module_put(THIS_MODULE);

Folks, this kind of patches is really useless.  If I wanted to just replace
kernel_thread() with kthread_run() I could do it myself in a day or two.

The whole point of the kthread API is that we now have a coherent set
of functions that deal with all aspects of kernel thread handling.  And
a conversion to that always involves rething the whole way a driver
uses kernel threads, and that's a good thing because most users were
buggy or at least rather odd.

sunrpc is not an exception to that, the thread handling is very interesting,
including things like using signals for various things possibly not waiting
for threads to exit.

If you don't feel like poking into all these nasty internal leave the
conversation to someone else, preferably a nfs developer.

