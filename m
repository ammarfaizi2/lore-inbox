Return-Path: <linux-kernel-owner+w=401wt.eu-S1946010AbWLVJrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946010AbWLVJrH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 04:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946002AbWLVJrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 04:47:07 -0500
Received: from brick.kernel.dk ([62.242.22.158]:13527 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946015AbWLVJrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 04:47:06 -0500
Date: Fri, 22 Dec 2006 10:48:59 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: saeed bishara <saeed.bishara@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using splice/vmsplice to improve file receive performance
Message-ID: <20061222094858.GP17199@kernel.dk>
References: <c70ff3ad0612211121g3c5aaa28s9b738e9c79f9c2be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c70ff3ad0612211121g3c5aaa28s9b738e9c79f9c2be@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21 2006, saeed bishara wrote:
> Hi,
> I'm trying to use the splice/vmsplice system calls to improve the
> samba server write throughput, but before touching the smbd, I started
> to improve the ttcp tool since it simple and has the same flow. I'm
> expecting to avoid the "copy_from_user" path when using those
> syscalls.
> so far, I couldn't make any improvement, actually the throughput get
> worst. the new receive flow looks like this (code also attached):
> 1. read tcp packet (64 pages) to page aligned buffer.
> 2. vmsplice the buffer to pipe with SPLICE_F_MOVE.
> 3. splice the pipe to the file, also with SPLICE_F_MOVE.
> 
> the strace shows that the splice takes a lot of time. also when
> profiling the kernel, I found that the memcpy() called to often !!

(didn't see this until now, axboe@suse.de doesn't work anymore)

I'm assuming that you mean you vmsplice with SPLICE_F_GIFT, to hand
ownership of the pages to the kernel (in which case SPLICE_F_MOVE will
work, otherwise you get a copy)? If not, that'll surely cost you a data
copy.

This sounds remarkably like a recent thread on lkml, you may want to
read up on that. Basically using splice for network receive is a bit of
a work-around now, since you do need the one copy and then vmsplice that
into a pipe. To realize the full potential of splice, we first need
socket receive support so you can skip that step (splice from socket to
pipe, splice pipe to file).

There was no test code attached, btw.

-- 
Jens Axboe

