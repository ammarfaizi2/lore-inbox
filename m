Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbVKXRsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVKXRsz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKXRsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:48:55 -0500
Received: from science.horizon.com ([192.35.100.1]:39242 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932432AbVKXRsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:48:54 -0500
Date: 24 Nov 2005 12:48:43 -0500
Message-ID: <20051124174843.30544.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] SMP alternatives
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect that with MAP_SHARED + PROT_WRITE being pretty uncommon anyway, 
> we can probably find trivial patterns in the kernel. Like only one process 
> holding that file open - which is what you get with things that use mmap() 
> to write a new file (I think "ld" used to have a config option to write 
> files that way, for example).

Just a bit of practical experience: I use mmap() to write data a LOT,
because msync(MS_ASYNC) is the most portable way to do an async write.

There are two applications.  First, helping the OS not fill up with
dirty pages.  It's basically a way of saying "this page is not going to
be dirtied again for a long time".

Secondly, to reduce the latency of synchronous writes.  If I need to
log operations durably, it helps to

1) fill the log pages, using MS_ASYNC as soon as the page is full
2) when committing a batch, use MS_SYNC to force data to disk
3) report batch successfully committed to stable storage

The aio_ routines are less widely supported some implementations have
very high overhead.  They would allow me to keep working while a commit
is in progress, but the above is simple and reduces the burstiness of
I/O considerably.
