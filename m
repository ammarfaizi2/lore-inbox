Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUHGE65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUHGE65 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 00:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUHGE65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 00:58:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:56244 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266224AbUHGE6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 00:58:55 -0400
Date: Fri, 6 Aug 2004 21:57:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Berkley Shands <berkley@cs.wustl.edu>
Cc: linux-kernel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
Subject: Re: A fix for Re: Severe I/O performance regression 2.6.6 to 2.6.7
 or 2.6.8-rc3
Message-Id: <20040806215716.52e36a54.akpm@osdl.org>
In-Reply-To: <200408061312.i76DChO0000119045@mudpuddle.cs.wustl.edu>
References: <200408061312.i76DChO0000119045@mudpuddle.cs.wustl.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berkley Shands <berkley@cs.wustl.edu> wrote:
>
> Taking the 2.6.6-bk6/mm/readahead.c (a one line change from vanilla 2.6.6/mm/readahead.c)
>  and inserting it into 2.6.7 and 2.6.8-rc3 restores the thread read ahead functionality
>  and througput seen in the 2.6.6 kernel. This does however reduce the single stream read
>  performance from 426MB/Sec (under 2.6.8-rc3) to 386MB/Sec (same as 2.6.6).
>  The major functionality change was to try to detect "random" read performance,
>  if randomness is detected, then NEVER read ahead. In this case, two threads
>  using two different file descriptors to the same file read alternating strides
>  of the file. Since each thread did not do SEQUENTIAL reads, both were treated as random
>  accesses.

Let me attempt to clarify here.  You have two fd's open against the same
file and you are reading in the following manner:

fd1:   0-11k        33-44k        55-66k
fd2:         11-22k        44-55k

yes?

If correct, I think you're expecting a bit too much of the readahead
system.  If you have a real application which is using such access patterns
perhaps it should be taught to use POSIX_FADV_WILLNEED.
