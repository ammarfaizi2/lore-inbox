Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUJFNsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUJFNsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUJFNsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:48:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8421 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269168AbUJFNr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:47:58 -0400
Date: Wed, 6 Oct 2004 09:01:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, sct@redhat.com
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
Message-ID: <20041006120158.GA8024@logos.cnet>
References: <16733.50382.569265.183099@segfault.boston.redhat.com> <20041005112752.GA21094@logos.cnet> <16739.61314.102521.128577@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16739.61314.102521.128577@segfault.boston.redhat.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 09:13:38AM -0400, Jeff Moyer wrote:
> ==> Regarding Re: [patch rfc] towards supporting O_NONBLOCK on regular files; Marcelo Tosatti <marcelo.tosatti@cyclades.com> adds:

Hi Jeff!

> Hi, Marcelo,
> 
> The text below was taken from the following standard:
> 
> IEEE Std 1003.1, 2004 Edition
> The Open Group Technical Standard
> Base Sepcifications, Issue 6
> Includes IEEE Std 1003.1-2001, IEEE Std 1003.1-2001/Cor 1-2002
> 
> 
> open()
> 
> O_NONBLOCK When opening a FIFO with O_RDONLY or O_WRONLY set:
>  o If O_NONBLOCK is set, an open( ) for reading-only shall return without
>    delay. An open( ) for writing-only shall return an error if no process
>    currently has the file open for reading.
>  o If O_NONBLOCK is clear, an open( ) for reading-only shall block the
>    calling thread until a thread opens the file for writing. An open( ) for
>    writing-only shall block the calling thread until a thread opens the file
>    for reading.
> 
> When opening a block special or character special file that supports non-
> blocking opens:
>  o If O_NONBLOCK is set, the open( ) function shall return without blocking
>    for the device to be ready or available. Subsequent behavior of the device
>    is device-specific.
>  o If O_NONBLOCK is clear, the open( ) function shall block the calling
>    thread until the device is ready or available before returning.
> 
>  Otherwise, the behavior of O_NONBLOCK is unspecified.
> 
> read()
> 
> When attempting to read a file (other than a pipe or FIFO) that supports
> non-blocking reads and has no data currently available:
>  o If O_NONBLOCK is set, read( ) shall return -1 and set errno to [EAGAIN].

This implies read(O_NONBLOCK) should never block.

Maybe your code should pass down __GFP_FAIL in the gfp_mask 
to the page_cache_alloc() to avoid blocking reclaiming pages,
and possibly pass info down to the block layer 
"if this is going to block, fail".

We have a bdi_congested() check before doing the readahead (dont RA
if the queue is full). Check if that really works - I'm afraid
it can block because the check is not done at each page 
submitted, but rather at each readahead operation (which 
can be several pages large).

>  o If O_NONBLOCK is clear, read( ) shall block the calling thread until
>    some data becomes available.
>  o The use of the O_NONBLOCK flag has no effect if there is some data
>    available.
> 
> write()
> 
> When attempting to write to a file descriptor (other than a pipe or FIFO)
> that supports non- blocking writes and cannot accept the data immediately:
>   o If the O_NONBLOCK flag is clear, write( ) shall block the calling
>     thread until the data can be accepted.
>   o If the O_NONBLOCK flag is set, write( ) shall not block the thread. If
>     some data can be written without blocking the thread, write( ) shall
>     write what it can and return the number of bytes written. Otherwise, it
>     shall return -1 and set errno to [EAGAIN].
> 
> 
> Thanks!
> 
> Jeff
