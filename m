Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVCBRVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVCBRVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVCBRTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:19:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:16573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262370AbVCBRIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:08:06 -0500
Date: Wed, 2 Mar 2005 09:07:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: Improving mmap() support for !MMU further
Message-Id: <20050302090734.5a9895a3.akpm@osdl.org>
In-Reply-To: <9420.1109778627@redhat.com>
References: <9420.1109778627@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> Hi Linus,
> 
> I'd like to improve mmap() support on !MMU still further by overloading struct
> backing_dev_info::memory_backed to hold flags describing what the backing
> device is capable of with respect to direct memory access.

->memory_backed is already overloaded in various awkward ways.  It would be
good to fix that up first, then add enhancements in a later patch.

Furthermore I'd suggest that we remove ->memory_backed and simply add a
bunch of new booleans to backing_dev_info rather than futzing with
bitflags.  Those booleans could be bitfields, of course.

And those fields should refer to device capabilities and not to device
characteristics: "what it can do" rather than "what it is".  So
"contributes to dirty memory" and "needs writeback" are good and "is a ram
disk thingy" is bad.

So in 2.6.11 as-is, we have:

bdi->dirty_memory_acct		Contributes to dirty memory accounting
bdi->needs_writeback		Needs writeback

>  (*) If bdi->memory_backed is 0, then the backing device is not accessible as
>      memory.

Not sure what this means.

>  (*) If the bdi->memory_backed is non-zero, then it's a bit mask of the
>      following:
> 
> 	#define BDI_NO_WRITEBACK	0x00000001

Invert the sense of this, use ->needs_writeback

> 	#define BDI_MEMORY_BACKED	0x00000001

Lose this.

> 	#define BDI_CAN_MAP_DIRECT	0x00000002

bdi->can_map_direct

> 	#define BDI_CAN_MAP_COPY	0x00000004

bdi->can_map_copy

> 	#define BDI_CAN_READ_MAP	VM_MAYREAD
> 	#define BDI_CAN_WRITE_MAP	VM_MAYWRITE
> 	#define BDI_CAN_EXEC_MAP	VM_MAYEXEC

A separate field in backing_dev_info?


That `membacked' stuff in the !NOMMU implementation of do_mmap_pgoff()
looks like it could benefit from some rework as a result of the above as
well.  It all looks rather inferential.
