Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUEDD7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUEDD7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 23:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264225AbUEDD7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 23:59:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:57510 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264223AbUEDD7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 23:59:11 -0400
Subject: Re: workqueue and pending
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mixxel@cs.auc.dk, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040503201616.6f3b8700.akpm@osdl.org>
References: <40962F75.8000200@cs.auc.dk>
	 <20040503162719.54fb7020.akpm@osdl.org> <1083639081.20092.294.camel@gaston>
	 <20040503201616.6f3b8700.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083642950.29596.299.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 13:55:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  static inline int cancel_delayed_work(struct work_struct *work)
>  {
> -	return del_timer_sync(&work->timer);
> +	int ret;
> +
> +	ret = del_timer_sync(&work->timer);
> +	if (ret)
> +		clear_bit(0, &work->pending);
> +	return ret;
>  }

Heh, I was trying to figure out a simple way to do that and just
didn't figure out del_timer_sync() would actually have a useful
return value :)

It's probably still good to precise explicitely in the comments
that upon return of cancel_delayed_work(), the work queue might
still be pending and that a flush and whoever called this may
still need a flush_scheduled_work() or flush_workqueue() (provided
it's running in a context where that can sleep)

Ben.


