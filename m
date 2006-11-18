Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755950AbWKREUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbWKREUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 23:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755964AbWKREUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 23:20:05 -0500
Received: from 1wt.eu ([62.212.114.60]:17669 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1755950AbWKREUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 23:20:04 -0500
Date: Sat, 18 Nov 2006 05:19:59 +0100
From: Willy Tarreau <w@1wt.eu>
To: Marc Snider <msnider@bluenotenetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read/Write multiple network FDs in a single syscall context switch?
Message-ID: <20061118041958.GB577@1wt.eu>
References: <5A09CDB9FC09B1478DF679F4C698D1DB5CA2D5@johnleehooker.bluenote.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5A09CDB9FC09B1478DF679F4C698D1DB5CA2D5@johnleehooker.bluenote.local>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 04:40:30PM -0500, Marc Snider wrote:
> I've searched long and hard prior to posting here, but have been unable to locate a kernel mechanism providing the ability to read or write multiple FDs in a single userspace to kernel context switch.
> 
> We've got a userspace network application that uses epoll to wait for packet arrival and then reads a single frame off of dozens of separate FDs (sockets), operates on the payload and then forwards along by writing to dozens of other separate FDs (sockets).   At high loads we invariably have many dozens of socket FDs to read and write.
> 
> If 50 separate frames are received on 50 separate sockets then we are at present doing 50 separate reads and then 50 separate writes, thus resulting in over a hundred distinct (and seemingly unnecessary) user to kernel space and kernel to user space context switches.   Is there a mechanism I've missed which allows many network FDs to be read or written in a single syscall?   For example, something analogous to the recv() and send() calls but instead providing a vector for the parameters and return value?
> 
> I picture something like:
> 
>      ssize_t *recvMultiple(int *s, void **buf, size_t *len, int *flags)         and
>      ssize_t *sendMultiple(int *s, void **buf, size_t *len, int *flags)
> 
> 
> The user would have to be careful about not using blocking sockets with these types of multiple FD operations, but it seems to me that such a kernel mechanism would allow a user space process to eliminate dozens or even hundreds of unnecessary context switches when servicing multiple network FDs...    The cycle savings for an application like ours would be huge.   I am confused about why I've been unable to locate such a mechanism considering the perceived performance advantages and ubiquitous nature of user applications that service many network FDs...

You should take a look at the "Kernel Mode Linux" patch. While it doesn't
provide the feature you want, it addresses this specific context switch
problem by making your app run in kernel space, thus considerably reducing
the cost of the system calls.

Regards,
Willy

