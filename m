Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbUAZOgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 09:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbUAZOgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 09:36:00 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:27619 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263726AbUAZOf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 09:35:58 -0500
Message-ID: <401537AB.60505@wanadoo.fr>
Date: Mon, 26 Jan 2004 15:52:11 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oprofile per-cpu buffer overrun
References: <20040126023715.GA3166@zaniah> <20040125200701.3c7b769a.akpm@osdl.org> <20040126103237.GA52771@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> On Sun, Jan 25, 2004 at 08:07:01PM -0800, Andrew Morton wrote:
> 
> 
>>When implementing a circular buffer it is better to not constrain the head
>>and tail indices - just let them grow and wrap without bound.  You only need
>>to bring them in-bounds when you actually use them to index the buffer.

neat!

> I'm not sure why that's better.

We win in increment_head/increment_tail:

static void increment_head(struct oprofile_cpu_buffer * b)
{
- 
unsigned long new_head = b->head_pos + 1;
	wmb();
- 
if (new_head < (b->buffer_size))
- 
	b->head_pos = new_head;
- 
else
- 
	b->head_pos = 0;
+ 
b->head_pos++;
}

for this added cost when accessing the buffer:

b->buffer[b->head & b->buffer_size_mask];

Modulo use is not worth but with buffer_size a power of 2
it's probably a win, I'll try and measure this later, not
urgent since the problem is fixed, I added it in our todo.

regards,
Phil

