Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbREZAaX>; Fri, 25 May 2001 20:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbREZAaN>; Fri, 25 May 2001 20:30:13 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:26969 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262215AbREZAaK>; Fri, 25 May 2001 20:30:10 -0400
Date: Fri, 25 May 2001 20:29:38 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@toomuch.toronto.redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.31.0105251700350.15549-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105252007020.3806-100000@toomuch.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Linus Torvalds wrote:

> So I think I'll buy some experimentation. That HIGHMEM change is too ugly
> to live, though, I'd really like to hear more about why something that
> ugly is necessary.

Highmem systems currently manage to hang themselves quite completely upon
running out of memory in the normal zone.  One of the failure modes is
looping in __alloc_pages from get_unused_buffer_head to map a dirty page.
Another results in looping on allocation of a bounce page for writing a
dirty highmem page back to disk.

Also, note that the current highmem design for bounce buffers is
inherently unstable.  Because all highmem pages that are currently in
flight must have bounce buffers allocated for them, we require a huge
amount of bounce buffers to guarentee progress while submitting io.  The
-ac kernels have a patch from Ingo that provides private pools for bounce
buffers and buffer_heads.  I went a step further and have a memory
reservation patch that provides for memory pools being reserved against a
particular zone.  This is needed to prevent the starvation that irq
allocations can cause.

Some of these cleanups are 2.5 fodder, but we really need something in 2.4
right now, so...

		-ben

