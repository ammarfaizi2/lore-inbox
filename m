Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267989AbUH1Wl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267989AbUH1Wl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUH1Wl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:41:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:2958 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267989AbUH1WjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:39:19 -0400
Date: Sat, 28 Aug 2004 15:37:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [4/5] eliminate bh waitqueue hashtable
Message-Id: <20040828153728.38e7f85a.akpm@osdl.org>
In-Reply-To: <20040828201107.GV5492@holomorphy.com>
References: <20040828200549.GR5492@holomorphy.com>
	<20040828200659.GS5492@holomorphy.com>
	<20040828200841.GT5492@holomorphy.com>
	<20040828200951.GU5492@holomorphy.com>
	<20040828201107.GV5492@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> +static inline int wait_on_bit(void *word, int bit,
>  +				int (*action)(void *), unsigned mode)
>  +{
>  +	DEFINE_WAIT_BIT(q, word, bit);
>  +	wait_queue_head_t *wqh;
>  +
>  +	if (!test_bit(bit, word))
>  +		return 0;
>  +
>  +	wqh = bit_waitqueue(word, bit);
>  +	return __wait_on_bit(wqh, &q, word, bit, action, mode);
>  +}

This is still all inlined.  Given that we're going to schedule away,
don't you think we should out-of-line the slowpath?  As I said yesterday:

static inline int wait_on_bit(...)
{
	if (test_bit(...))
		return out_of_line_wait_on_bit(...);
	return 0;
}

I merged this latest batch into -mm.
