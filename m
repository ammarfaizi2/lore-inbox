Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbXAHV2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXAHV2n (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 16:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbXAHV2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 16:28:43 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44791 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbXAHV2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 16:28:42 -0500
Date: Mon, 8 Jan 2007 13:27:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: [PATCH 15/24] Unionfs: Privileged operations workqueue
Message-Id: <20070108132755.41c27142.akpm@osdl.org>
In-Reply-To: <1168229598972-git-send-email-jsipek@cs.sunysb.edu>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	<1168229598972-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Jan 2007 23:13:07 -0500
"Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:

> From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> 
> Workqueue & helper functions used to perform privileged operations on
> behalf of the user process.
> 
> Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
> Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
> +
>
> ...
>
> +#include "union.h"
> +
> +/* Super-user IO work Queue - sometimes we need to perform actions which
> + * would fail due to the unix permissions on the parent directory (e.g.,
> + * rmdir a directory which appears empty, but in reality contains
> + * whiteouts).
> + */
> +
> +struct workqueue_struct *sioq;

Rather a terse identifier for a global symbol.

> +int __init init_sioq(void)
> +{
> +	int err;
> +
> +	sioq = create_workqueue("unionfs_siod");
> +	if (!IS_ERR(sioq))
> +		return 0;
> +
> +	err = PTR_ERR(sioq);
> +	printk(KERN_ERR "create_workqueue failed %d\n", err);
> +	sioq = NULL;
> +	return err;
> +}
> +
> +void __exit stop_sioq(void)
> +{
> +	if (sioq)
> +		destroy_workqueue(sioq);
> +}
> +
> +void run_sioq(work_func_t func, struct sioq_args *args)
> +{
> +	INIT_WORK(&args->work, func);
> +
> +	init_completion(&args->comp);
> +	while (!queue_work(sioq, &args->work)) {
> +		/* TODO: do accounting if needed */
> +		schedule();
> +	}

That's a busywait.

> +	wait_for_completion(&args->comp);
> +}
> +
>
> ...
>
> +void __delete_whiteouts(struct work_struct *work) {

Misplaced brace.


