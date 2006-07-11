Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWGKKGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWGKKGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWGKKGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:06:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58758 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750905AbWGKKGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:06:07 -0400
Date: Tue, 11 Jul 2006 03:05:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: nagar@watson.ibm.com
Cc: linux-kernel@vger.kernel.org, jlan@sgi.com, csturtiv@sgi.com, pj@sgi.com,
       balbir@in.ibm.com, sekharan@us.ibm.com, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch 6/6] per task delay accounting taskstats interface: fix
 clone skbs for each listener
Message-Id: <20060711030524.39abc3d5.akpm@osdl.org>
In-Reply-To: <1152592599.14142.136.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
	<1152592599.14142.136.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 00:36:39 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

>  	down_write(&listeners->sem);
>  	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
> -		ret = genlmsg_unicast(skb, s->pid);
> +		skb_next = NULL;
> +		if (!list_islast(&s->list, &listeners->list)) {
> +			skb_next = skb_clone(skb_cur, GFP_KERNEL);

If we do a GFP_KERNEL allocation with this semaphore held, and the
oom-killer tries to kill something to satisfy the allocation, and the
killed task gets stuck on that semaphore, I wonder of the box locks up.

Probably it'll work out OK if the semaphore is taken after that task has
had some resources torn down.
