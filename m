Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbSKNU3w>; Thu, 14 Nov 2002 15:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbSKNU3w>; Thu, 14 Nov 2002 15:29:52 -0500
Received: from holomorphy.com ([66.224.33.161]:25546 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265242AbSKNU3v>;
	Thu, 14 Nov 2002 15:29:51 -0500
Date: Thu, 14 Nov 2002 12:34:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114203411.GG22031@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Mosberger-Tang <David.Mosberger@acm.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0211132239370.3817-100000@imladris.surriel.com> <08a601c28bbb$2f6182a0$760010ac@edumazet> <20021114141310.A25747@infradead.org> <ugel9oavk4.fsf@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ugel9oavk4.fsf@panda.mostang.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002 15:20:10 +0100, Christoph Hellwig <hch@infradead.org> said:
Christoph> mount -t hugetlbfs whocares /huge
Christoph> fd = open("/huge/nose", ..)
Christoph> mmap(.., fd, ..)

On Thu, Nov 14, 2002 at 09:51:55AM -0800, David Mosberger-Tang wrote:
> One potential downside of this is that programmers might expect
> mremap(), mprotect() etc. to work on the returned memory at the
> granularity of base-pages.  I'm not sure though whether that was part
> of the reason Linus wanted separate syscalls.
> 	--david

I'm not entirely sure. There is quite a bit about this filesystem that
assumes the user already knows what he's doing, for instance:

(1) CAP_IPC_LOCK is required to access anything on it
(2) only mmap() and truncate() are supported
(3) ->f_op->mmap() will hand -EINVAL back to userspace instead of
	automatically placing the vma, for explicit and 0 start adresses
(4) ->f_op->mmap() will also hand back -EINAL if one attempts to mmap()
	beyond the end of the file 

There is the assumption that the user knows what he's doing here, and
he'd better anyway, because he's capable(CAP_IPC_LOCK). Some easy
accommodations could be made, for instance, implicitly truncating the
file to be larger if mmap()'d beyond the end of it, and automatic
placement is easily doable. But I'm not concerned about it at all; the
primary user (IBM's DB2 database) is perfectly capable of dealing with
these constraints on its usage by tweaking buffer pool and other
parameters. Of course, other users may be accommodated if desired.


Bill
