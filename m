Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbTLYPMy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 10:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTLYPMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 10:12:54 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:64522 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S264314AbTLYPMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 10:12:52 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@osdl.org>, <lse-tech@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
References: <Pine.LNX.4.44.0312250213120.13730-100000@dbl.q-ag.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 26 Dec 2003 00:11:51 +0900
In-Reply-To: <Pine.LNX.4.44.0312250213120.13730-100000@dbl.q-ag.de>
Message-ID: <873cb9c4p4.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> --- 2.6/fs/fcntl.c	2003-12-04 19:44:38.000000000 +0100
> +++ build-2.6/fs/fcntl.c	2003-12-24 00:15:16.000000000 +0100
> @@ -609,9 +609,15 @@
> 
>  void kill_fasync(struct fasync_struct **fp, int sig, int band)
>  {
> -	read_lock(&fasync_lock);
> -	__kill_fasync(*fp, sig, band);
> -	read_unlock(&fasync_lock);
> +	/* First a quick test without locking: usually
> +	 * the list is empty.
> +	 */
> +	if (*fp) {
> +		read_lock(&fasync_lock);
> +		/* reread *fp after obtaining the lock */
> +		__kill_fasync(*fp, sig, band);
> +		read_unlock(&fasync_lock);
> +	}
>  }

Looks good to me. This should be the enough effect for usual path.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
