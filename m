Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTLUSj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 13:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTLUSj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 13:39:56 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:38157 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261879AbTLUSjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 13:39:54 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 22 Dec 2003 03:38:41 +0900
In-Reply-To: <3FE492EF.2090202@colorfullife.com>
Message-ID: <8765ga6moe.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

>  void kill_fasync(struct fasync_struct **fp, int sig, int band)
>  {
> -	read_lock(&fasync_lock);
> +	rcu_read_lock();
>  	__kill_fasync(*fp, sig, band);
> -	read_unlock(&fasync_lock);
> +	rcu_read_unlock();
>  }

Usually *fp is NULL, I think. So what about the following test?

void kill_fasync(struct fasync_struct **fp, int sig, int band)
{
	if (*fp) {
		rcu_read_lock();
		__kill_fasync(*fp, sig, band);
		rcu_read_unlock();
	}
}

Or use inline function for testing *fp.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
