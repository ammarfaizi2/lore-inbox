Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268590AbUILJnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268590AbUILJnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUILJnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:43:40 -0400
Received: from holomorphy.com ([207.189.100.168]:27780 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268577AbUILJng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:43:36 -0400
Date: Sun, 12 Sep 2004 02:43:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912094333.GK2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20040912085609.GK32755@krispykreme> <20040912093943.GA10356@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912093943.GA10356@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 11:39:43AM +0200, Ingo Molnar wrote:
> --- linux/kernel/pid.c.orig	
> +++ linux/kernel/pid.c	
> @@ -103,7 +103,7 @@ int alloc_pidmap(void)
>  	pidmap_t *map;
>  
>  	pid = last_pid + 1;
> -	if (pid >= pid_max)
> +	if (unlikely(pid >= pid_max))
>  		pid = RESERVED_PIDS;

Well, this part won't change the wrapping behavior.

On Sun, Sep 12, 2004 at 11:39:43AM +0200, Ingo Molnar wrote:
>  	offset = pid & BITS_PER_PAGE_MASK;
> @@ -116,6 +116,10 @@ int alloc_pidmap(void)
>  		 * slowpath and that fixes things up.
>  		 */
>  return_pid:
> +		if (unlikely(pid >= pid_max)) {
> +			clear_bit(offset, map->page);
> +			goto failure;
> +		}
>  		atomic_dec(&map->nr_free);
>  		last_pid = pid;
>  		return pid;

This is too late; it hands back a hard failure without resetting last_pid.


-- wli
