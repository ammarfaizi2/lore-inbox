Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263778AbRFDUE5>; Mon, 4 Jun 2001 16:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263751AbRFDUEr>; Mon, 4 Jun 2001 16:04:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40460 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263730AbRFDUEk>; Mon, 4 Jun 2001 16:04:40 -0400
Subject: Re: Linux networking and disk IO issues
To: mark@northforknet.com (Mark Hayden)
Date: Mon, 4 Jun 2001 21:02:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1BB85B.360CE0F6@northforknet.com> from "Mark Hayden" at Jun 04, 2001 09:33:31 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1570Yt-0005tT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * The Linux networking stack requires all skbuff buffers to be
>   contiguous.  As far as I can tell, this makes it impossible to
>   write high-bandwidth UDP applications on Linux.  For instance, the
>   kernel will drop a fragmented 8KB message if it cannot allocate 8KB
>   of contiguous memory to reassemble it into.  I have found that it
>   is relatively easy to enter regimes where this can cause massive
>   packet loss.

If you are fragmenting messages then you want to optimise the protocol a bit
more. IP fragmentation increases processing overheads and reduces performance
badly in the presence of link congestion and error.

Most modern file sharing protocols are TCP based for good reason

> * readv()/writev().  Linux serializes scatter/gather IO operations
>   into an operation for each iovec entry.  This is the relevent code
>   from a 2.4-series kernel:

Not on a socket. On a file it makes very little difference. Socket readv/writev
behaviour varies by protocol family.

>   * For writes, it forces read-modify-write when the individual
>     iovecs are not block-aligned.

>From cache, of data live in the L1 cache of the CPU

> * There is no preadv(), pwritev().  (The pread/pwrite() system calls
>   combine a llseek with a read/write system call.)  This means that

True. The single unix specification does not include preadv(). Really you want
to take it up with the Opengroup. That said Linux does add syscalls that are
not in SuS sometimes.

> * The requirement that everything about operations to raw character
>   device files (length, offset in file, *and* address in memory) has
>   to be 512-byte aligned is a real hassle.

Welcome to PC hardware. Large amounts of PC hardware genuinely has limitations
of this nature. Most disk controllers can only write whole sectors on a sector
alignment. Many network controllers can only handle burst or 32bit alignment
policies

