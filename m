Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755962AbWKREYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbWKREYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963AbWKREYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:24:45 -0500
Received: from smtp.osdl.org ([65.172.181.25]:11727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755962AbWKREYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:24:45 -0500
Date: Fri, 17 Nov 2006 20:24:40 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Marc Snider" <msnider@bluenotenetworks.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Read/Write multiple network FDs in a single syscall context
 switch?
Message-ID: <20061117202440.267a9c25@localhost.localdomain>
In-Reply-To: <5A09CDB9FC09B1478DF679F4C698D1DB0482C9@johnleehooker.bluenote.local>
References: <5A09CDB9FC09B1478DF679F4C698D1DB0482C9@johnleehooker.bluenote.local>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006 22:53:26 -0500
"Marc Snider" <msnider@bluenotenetworks.com> wrote:

> Sorry, I must have given the wrong impression with respect to the data.   It is not all the same.   Each ingress socket is associated with an individual egress socket and the packet data being received and transmitted is unique across ingress/egress socket pairs...
>  
> Guess I don't see the difficulties you alluded to below, Stephen.  The userspace app would only ask to receive on sockets where there was already known data available as per Epoll reporting.   I also think it a reasonable constraint to require in this multiple FD operation case that all sockets are mandated as nonblocking, thus a zero or some other unique return value could be provided for each socket that would have blocked in lieu of EWOULDBLOCK.
>  
> Write sockets would only be written to when data was available, so there would be no ambiguity on write operations.   Again, if the request could not be satisfied due to socket buffer overflow or other aberration a nonblocking return code would ensue.
>  
> If all socket FDs referenced were required to be nonblocking then I'm having difficulty understanding how circumstances would differ for a vectorized recvMultiple() or sendMultiple() operation when contrasted with doing multiple individual recv() and/or send() calls on N nonblocking sockets...
>  
> Forgive me if I'm missing something.   It seems to me that the bang for the buck in exponentially reducing the number of context switches required for a userspace application to service many network FDs makes a great deal of sense here.... 
>  
> Regards,
> Marc Snider
> msnider@bluenotenetworks.com
> 

You forget on Linux system calls are cheap, unlike other OS's. A poll/select followed by a receive
is going to be as fast as any recv_any() type interface. Unless you can reduce the number
of copies from kernel to user (or vice versa) there is no point to inventing yet another
network interface.
