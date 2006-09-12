Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWILNUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWILNUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 09:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWILNUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 09:20:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57009 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030206AbWILNUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 09:20:22 -0400
Subject: Re: Spinlock debugging
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Bird <ajb@spheresystems.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609120847.39655.ajb@spheresystems.co.uk>
References: <200609111632.27484.ajb@spheresystems.co.uk>
	 <200609111738.21818.ajb@spheresystems.co.uk>
	 <1157995492.23085.191.camel@localhost.localdomain>
	 <200609120847.39655.ajb@spheresystems.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 14:43:48 +0100
Message-Id: <1158068628.6780.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-12 am 08:47 +0100, ysgrifennodd Andrew Bird:
> Alan
> 	thanks that did the trick. 
> One further question, on the later kernels 2.6.17+, I don't have low_latency 
> set. Can I still guarantee that after calling tty_flip_buffer_push() I have 
> made space in the tty for my buffer? For example, is this legal? 

It makes no guarantee in any kernel.

In the new tty case however tty_buffer_request_room() will only fail if
you have 64K queued or the box is completely out of atomic memory and
also doing stuff like dropping network packets and console keystrokes.

So all you need in your IRQ handler is

	if (tty_insert_flip_string(tty, buf, size))
		tty_flip_buffer_push(tty);

the rest will occur automatically. Hinting with tty_buffer_request_room
may improve performance for some workloads (notably virtualized uarts)
or when using DMA but otherwise the above should be fine.

Most existing drivers were a straight conversion so at the moment try
too hard.


