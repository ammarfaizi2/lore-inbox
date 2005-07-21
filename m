Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVGUUF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVGUUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 16:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVGUUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 16:05:29 -0400
Received: from digitalimplant.org ([64.62.235.95]:35768 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261865AbVGUUF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 16:05:27 -0400
Date: Thu, 21 Jul 2005 13:05:13 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] Syncthreads support.
In-Reply-To: <1121923564.2936.231.camel@localhost>
Message-ID: <Pine.LNX.4.50.0507211254140.12779-100000@monsoon.he.net>
References: <1121923564.2936.231.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Jul 2005, Nigel Cunningham wrote:

> This patch implements a new PF_SYNCTHREAD flag, which allows upcoming
> the refrigerator implementation to know that a thread is syncing data to
> disk. This allows the refrigerator to be more reliable, even under heavy
> load, because it can separate userspace processes that are submitting
> I/O from those trying to sync it and freezing the former first. We can
> thus ensure that syncing processes complete their work more quickly and
> the refrigerator is far less likely to incorrectly give up (thinking a
> syncing process is completely failing to enter the refrigerator).

I don't have any strong feelings for this, one way or another. It seems
kinda hacky, and it needs to be discussed publically, and it seems like it
definitely seems like it doesn't need to go in immediately.

I have just a couple of suggestions below..

>  int fsync_super(struct super_block *sb)
>  {
> +	int ret;
> +
> +	/* A safety net. During suspend, we might overwrite
> +	 * memory containing filesystem info. We don't then
> +	 * want to sync it to disk. */
> +	BUG_ON(test_suspend_state(SUSPEND_DISABLE_SYNCING));

Please do not add any new BUG()s. Figure out another way to gracefully
fail, perhaps some place else.

> +	current->flags |= PF_SYNCTHREAD;

Is all the modification of current->flags safe? It seems like you could be
pre-empted in the middle and things could get wacky.

Another note is that these changes will have to go through Al Viro, who
might have some suggestions on the Right(tm) way to do it.


	Pat
