Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbVF0Www@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbVF0Www (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbVF0Www
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:52:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2486 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbVF0Wtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:49:55 -0400
Date: Mon, 27 Jun 2005 15:50:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, pb@linuxtv.org
Subject: Re: [DVB patch 17/51] flexcop: add big endian register definitions
Message-Id: <20050627155046.1c44bbdd.akpm@osdl.org>
In-Reply-To: <20050627121412.899787000@abc>
References: <20050627120600.739151000@abc>
	<20050627121412.899787000@abc>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@linuxtv.org> wrote:
>
> From: Patrick Boettcher <pb@linuxtv.org>
> 
> Add big-endian register definitions for running on a PowerPC.
> (Thanks to Paavo Hartikainen for testing.)
> 
> ...
> +	struct {
> +		u32 dma_address0                   :30;
> +		u32 dma_0No_update                 : 1;
> +		u32 dma_0start                     : 1;
> +	} dma_0x0;
>...
> +
> +	struct {
> +		u32 dma_0start                     : 1;
> +		u32 dma_0No_update                 : 1;
> +		u32 dma_address0                   :30;
> +	} dma_0x0;

Oh dear.  This is a good demonstration of the downside of trying to use
compiler bitfields to represent hardware registers.  I have vague memories
of writing BFINS and BFEXT in 3c59x to stomp this problem.

I don't think there's any guarantee that the code you have there will work
on all architectures/compiler versions btw.

Also...  The code appears to be assuming that BE architectures will
bit-reverse their bitfields.  Is that right?  I'd expect them to only
byte-reverse them?

IOW:

   31 30 ... 15 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00

   |--------------- dma_address0 --------------------|
                                                       | dma_0No_update
                                                          | dma_0start

versus

   31 30 29 28 27 26 25 24 23 ... 08 07 06 05 04 03 02 01 00

   |--------------| dma_address0
                           |---- more of dma_address0 -----|
                     | dma_0No_update
                        | dma_0start

or something like that...  Brain hurts.
