Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVHZHUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVHZHUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 03:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVHZHUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 03:20:19 -0400
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:30707 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932546AbVHZHUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 03:20:18 -0400
Date: Fri, 26 Aug 2005 09:20:08 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org, tom.anderl@gmail.com
Subject: Re: [OT] volatile keyword
Message-ID: <20050826092008.55553521@localhost>
In-Reply-To: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005 13:44:55 -0700 (PDT)
Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> int main (void) {
>     pthread_t other;
> 
>     data.lock = 1;
>     data.value = 1;
>     pthread_create(&other, NULL, thread, NULL);
>     while ((volatile unsigned long)(data.lock));
>     printf("Value is %lu.\n", data.value);
>     pthread_join(other, NULL);
> 
>     return 0;
> }

The "correct" way should be:

	while (*(volatile unsigned long*)(&data.lock));

With only: "while ((volatile unsigned long)(data.lock))" GCC isn't
forced to read to memory simply because "data.lock" isn't volatile.
What than you do with "data.lock" value doesn't change anything. IOW
you should get the same assembly code with and without the cast.


SUMMARY

"(volatile unsigned long)(data.lock)" means:
	- take the value of "data.lock" (that isn't volatile so can be
	cached)
	- cast it to "volatile" (a no-op, since we already HAVE the
	value)


"*(volatile unsigned long*)(&data.lock)":
	- take the address of "data.lock"
	- cast it to "volatile"
	- read from _memory_ the value of data.lock (through the
	volatile pointer)


Other ways can be:
	- use read memory barrier:
		while (data.lock)
			rmb();
	- use everything that implies a memory barrier (eg: locking...)


PS: everything I've said is rigorously NOT tested. :-)

-- 
	Paolo Ornati
	Linux 2.6.13-rc7 on x86_64
