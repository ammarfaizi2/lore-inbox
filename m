Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267394AbUH1JuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267394AbUH1JuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 05:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267413AbUH1JuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 05:50:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:17033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267394AbUH1JpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:45:13 -0400
Date: Sat, 28 Aug 2004 02:43:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [3/4] eliminate bh waitqueue hashtable
Message-Id: <20040828024319.70cf343b.akpm@osdl.org>
In-Reply-To: <20040828092337.GK5492@holomorphy.com>
References: <20040826014745.225d7a2c.akpm@osdl.org>
	<20040828052627.GA2793@holomorphy.com>
	<20040828053112.GB2793@holomorphy.com>
	<20040827231713.212245c5.akpm@osdl.org>
	<20040828063419.GA5492@holomorphy.com>
	<20040827234033.2b6e1525.akpm@osdl.org>
	<20040828064829.GB5492@holomorphy.com>
	<20040828092040.GH5492@holomorphy.com>
	<20040828092210.GJ5492@holomorphy.com>
	<20040828092337.GK5492@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> +static inline int wait_on_bit(void *word, int bit,
>  +				int (*wait)(void *), unsigned mode)
>  +{
>  +	DEFINE_WAIT_BIT(q, word, bit);
>  +	wait_queue_head_t *wqh = bit_waitqueue(word, bit);
>  +
>  +	return __wait_on_bit(wqh, &q, word, bit, wait, mode);
>  +}

It worries me a bit (sic) that we're calling the relatively expensive
bit_waitqueue() even if the bit is not set.

Maybe it should be

static inline int wait_on_bit(...)
{
	if (test_bit(...))
		out_of_line_wait_on_bit(...);
}
