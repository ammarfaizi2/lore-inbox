Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932790AbWAKFrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWAKFrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWAKFrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:47:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23741 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932553AbWAKFrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:47:11 -0500
Date: Tue, 10 Jan 2006 21:46:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: cpw@sgi.com, linux-kernel@vger.kernel.org, clameter@sgi.com,
       lhms-devel@lists.sourceforge.net, taka@valinux.co.jp,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH 2/5] Direct Migration V9: migrate_pages() extension
Message-Id: <20060110214648.4d54da7c.akpm@osdl.org>
In-Reply-To: <20060110224124.19138.36811.sendpatchset@schroedinger.engr.sgi.com>
References: <20060110224114.19138.10463.sendpatchset@schroedinger.engr.sgi.com>
	<20060110224124.19138.36811.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> +	for(i = 0; i < 10 && page_mapped(page); i++) {
>  +		int rc = try_to_unmap(page);
>  +
>  +		if (rc == SWAP_SUCCESS)
>  +			break;
>  +		/*
>  +		 * If there are other runnable processes then running
>  +		 * them may make it possible to unmap the page
>  +		 */
>  +		schedule();
>  +	}

The schedule() in state TASK_RUNNING simply won't do anything unless this
process happens to have been preempted.  You'll find that an ndelay(100) is
about as useful.

So I'd suggest that this part needs a bit of a rethink.  If we really need
to run other processes then try a schedule_timeout_uninterruptible(1).  If
not, just remove the loop.

Please stick a printk in there, work out how often and under which
workloads that loop is actually doing something useful.
