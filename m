Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267383AbUH1Jgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267383AbUH1Jgu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUH1Jgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:36:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:8580 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267383AbUH1Jgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:36:32 -0400
Date: Sat, 28 Aug 2004 02:34:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [2/4] consolidate bit waiting code patterns
Message-Id: <20040828023436.4879983a.akpm@osdl.org>
In-Reply-To: <20040828092210.GJ5492@holomorphy.com>
References: <20040826014745.225d7a2c.akpm@osdl.org>
	<20040828052627.GA2793@holomorphy.com>
	<20040828053112.GB2793@holomorphy.com>
	<20040827231713.212245c5.akpm@osdl.org>
	<20040828063419.GA5492@holomorphy.com>
	<20040827234033.2b6e1525.akpm@osdl.org>
	<20040828064829.GB5492@holomorphy.com>
	<20040828092040.GH5492@holomorphy.com>
	<20040828092210.GJ5492@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> +int __sched __wait_on_bit_lock(wait_queue_head_t *wq, struct wait_bit_queue *q,
>  +			void *word, int bit,
>  +			int (*wait)(void *), unsigned mode)
>  +{
>  +	int ret;
>  +
>  +	while (test_and_set_bit(bit, word)) {
>  +		prepare_to_wait_exclusive(wq, &q->wait, mode);
>  +		if (test_bit(bit, word)) {
>  +			if ((ret = (*wait)(word)))
>  +				return ret;
>  +		}
>  +	}
>  +	finish_wait(wq, &q->wait);
>  +	return 0;
>  +}

Some comments over this thing would be nice.

The `wait' argument seems to be misnamed.  It typically points at
sync_page(), yes?   Maybe it should be called `action' or `kick' or
something.

If (*wait)() returns non-zero then it looks to me like the callers will get
confused, thinking that the page did come unlocked?

If (*wait)() returns non-zero then we need to run finish_wait(), no?
