Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWHCOkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWHCOkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWHCOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:40:44 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:14234 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S932420AbWHCOkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:40:43 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take3 1/4] kevent: Core files.
Date: Thu, 3 Aug 2006 16:40:34 +0200
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
References: <11545983603399@2ka.mipt.ru>
In-Reply-To: <11545983603399@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608031640.34513.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 11:46, Evgeniy Polyakov wrote:
> Core files.
>
> This patch includes core kevent files:
>  - userspace controlling
>  - kernelspace interfaces
>  - initialization
>  - notification state machines
>

> +static int kevent_user_wait(struct file *file, struct kevent_user *u,
> +		unsigned int min_nr, unsigned int max_nr, unsigned int timeout,
> +		void __user *buf)
> +{
>

> +	mutex_lock(&u->ctl_mutex);
> +	while (num < max_nr && ((k = kqueue_dequeue_ready(u)) != NULL)) {
> +		if (copy_to_user(buf + num*sizeof(struct ukevent),
> +					&k->event, sizeof(struct ukevent))) {
> +			cerr = -EINVAL;
> +			break;
> +		}


It seems quite wrong to hold ctl_mutex while doing a copy_to_user() (of 
possibly a large amount of data) : A thread can sleep on a page fault and 
other threads cannot make progress.

Eric
