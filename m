Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUDAA2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 19:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUDAA2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 19:28:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:62412 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261615AbUDAA2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 19:28:51 -0500
Date: Wed, 31 Mar 2004 16:30:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: sct@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20040331163055.792accf6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	<Pine.LNX.4.58.0403311433240.1116@ppc970.osdl.org>
	<1080776487.1991.113.camel@sisko.scot.redhat.com>
	<Pine.LNX.4.58.0403311550040.1116@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> I'd be perfectly happy with a set of file cache control operations, 
> including
> 
>  - start writeback in [a,b]
>  - wait for [a,b] stable
>  - and maybe "punch hole in [a,b]"

Yup, there are a number of linux-specific fadvise() extensions we
can/should be adding, including "start writeback on this byte range for
flush" and "start writeback on this byte range for data integrity" and
"wait on writeback of this byte range".

Some of these are needed internally for the fs-AIO implementation, and also
for an O_SYNC which only writes the pages which the writer wrote.  It's
pretty simple, and it'll be happening.

One wrinkle is that we'd need to add the start/end loff_t pair to the
a_ops->writepages() prototype.  But instead I intend to put the start/end
info into struct writeback_control and pass it that way.  It seems sleazy
at first but when you think about it, it isn't.  It provides forward and
backward compatability, it recognises that it's just a hint and that
filesystems can legitimately sync the whole file and it produces
smaller+faster code.

We might need a wait_on_page_writeback_range() a_op though.
