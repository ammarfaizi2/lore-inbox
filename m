Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264331AbRFDRDV>; Mon, 4 Jun 2001 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264305AbRFDQfR>; Mon, 4 Jun 2001 12:35:17 -0400
Received: from [24.142.58.202] ([24.142.58.202]:14601 "EHLO
	sakhalin.northfork.com") by vger.kernel.org with ESMTP
	id <S264334AbRFDQeG>; Mon, 4 Jun 2001 12:34:06 -0400
Message-ID: <3B1BB85B.360CE0F6@northforknet.com>
Date: Mon, 04 Jun 2001 09:33:31 -0700
From: Mark Hayden <mark@northforknet.com>
Organization: North Fork Networks
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux networking and disk IO issues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently released a clusted storage system for Linux (the software
in binary form and manual can be downloaded from
www.northforknet.com).  This software, you can create a highly
available storage cluster out of standard PC hardware.

During this work, we encountered a number of problems with the Linux
kernel.  I believe these all apply to the current kernels (though I'm
working with the 2.4.2 kernel).  If you respond, please CC me
directly, since I follow Linux kernel development through weekly
summaries in Linux Weekly News.

regards, Mark Hayden
mark@northforknet.com

* The Linux networking stack requires all skbuff buffers to be
  contiguous.  As far as I can tell, this makes it impossible to
  write high-bandwidth UDP applications on Linux.  For instance, the
  kernel will drop a fragmented 8KB message if it cannot allocate 8KB
  of contiguous memory to reassemble it into.  I have found that it
  is relatively easy to enter regimes where this can cause massive
  packet loss.

* readv()/writev().  Linux serializes scatter/gather IO operations
  into an operation for each iovec entry.  This is the relevent code
  from a 2.4-series kernel:

	/* VERIFY_WRITE actually means a read, as we write to user space */
	fn = (type == VERIFY_WRITE ? file->f_op->read :
	      (io_fn_t) file->f_op->write);

	ret = 0;
	vector = iov;
	while (count > 0) {
		void * base;
		size_t len;
		ssize_t nr;

		base = vector->iov_base;
		len = vector->iov_len;
		vector++;
		count--;

		nr = fn(file, base, len, &file->f_pos);

		if (nr < 0) {
			if (!ret) ret = nr;
			break;
		}
		ret += nr;
		if (nr != len)
			break;
	}

  This causes several problems:

  * For writes, it forces read-modify-write when the individual
    iovecs are not block-aligned.

  * For reads, it prevents all the read requests from being presented
    at the same time to the IO system.  This is a problem for raw IO
    without read-ahead.

* There is no preadv(), pwritev().  (The pread/pwrite() system calls
  combine a llseek with a read/write system call.)  This means that
  if you want to have multiple threads in a process write random
  blocks using scatter-gather, you need to open() a device file
  multiple times and make the extra llseek() calls.

* The requirement that everything about operations to raw character
  device files (length, offset in file, *and* address in memory) has
  to be 512-byte aligned is a real hassle.

* There are several assumptions in the kernel that make it very
  difficult to write virtual block devices that convert IO operations
  into networked RPC requests.  For instance, if you run the normal
  NBD device where the server is on the same machine in the client,
  you will likely deadlock your system.  Our software distribution
  includes a patch to the 2.4.2 kernel that prevents these deadlock
  scenarios with NBD, but it is something of a hack (I want to thank
  Stephen Tweedie for his help in developing this work-around, though
  of course the hack is my responsibility.)  I don't know what could
  be done to fix these problems correctly, without a major changes to
  block IO in the kernel.
