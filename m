Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbRG1Q0n>; Sat, 28 Jul 2001 12:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266929AbRG1Q0X>; Sat, 28 Jul 2001 12:26:23 -0400
Received: from congress95.linuxsymposium.org ([209.151.18.95]:16388 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S266921AbRG1Q0O>; Sat, 28 Jul 2001 12:26:14 -0400
Date: Sat, 28 Jul 2001 12:25:31 -0400
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] using writepage to start io
Message-ID: <86620000.996337531@tiny>
In-Reply-To: <Pine.GSO.4.21.0107281210460.11772-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Saturday, July 28, 2001 12:18:02 PM -0400 Alexander Viro <viro@math.psu.edu> wrote:

> 
> 
> On Sat, 28 Jul 2001, Chris Mason wrote:
> 
>> 
>> Hello everyone,
>> 
>> This is an rfc only, as the code has only been _lightly_ tested.  I'll
>> do more tests/benchmarks next week.
>> 
>> This patch changes fs/buffer.c to use writepage to start i/o,
>> instead of writing buffers directly.  It also changes refile_buffer
>> to mark the page dirty when marking buffers dirty.
> 
> ->writepage() unlocks the page upon completion. How do you deal with that?

writepage funcs are added for use by anonymous pages, and
flush_dirty_buffers and friends are changed to expect writepage to unlock
the page on completion.

Also, end_buffer_io_async is changed to only mark the page up to date
when all the buffers on it are up to date.  This is important when
blocksize is less than the page size, and block_prepare_write/
block_commit_write are used to dirty a buffer in the middle of a
non-up to date page.  If that dirty buffer is written with an
async end_io handler, we don't want the whole page set up to date
by the handler.

-chris






