Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314234AbSDRFCq>; Thu, 18 Apr 2002 01:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314235AbSDRFCq>; Thu, 18 Apr 2002 01:02:46 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:26118 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S314234AbSDRFCp>;
	Thu, 18 Apr 2002 01:02:45 -0400
Date: Thu, 18 Apr 2002 14:01:55 +0900 (JST)
Message-Id: <20020418.140155.85418444.taka@valinux.co.jp>
To: jakob@unthought.net
Cc: davem@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020416034120.R18116@unthought.net>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been thinking about your comment, and I realized it was a good
suggestion.
There are no problem with the zerocopy NFS, but If you want to
use UDP sendfile for streaming or something like that, you wouldn't
get good performance.

jakob> > the semaphore is required to serialize sending data as many knfsd kthreads
jakob> > use the same socket.
jakob> 
jakob> Won't this serialize too much ?  I mean, consider the situation where we
jakob> have file-A and file-B completely in cache, while file-C needs to be
jakob> read from the physical disk.
jakob> 
jakob> Three different clients (A, B and C) request file-A, file-B and file-C
jakob> respectively. The send of file-C is started first, and the sends of files
jakob> A and B (which could commence immediately and complete at near wire-speed)
jakob> will now have to wait (leaving the NIC idle) until file-C is read from
jakob> the disks.
jakob> 
jakob> Even if it's not the entire file but only a single NFS request (probably 8kB),
jakob> one disk seek (7ms) is still around 85 kB, or 10 8kB NFS requests (at 100Mbit).
jakob> 
jakob> Or am I misunderstanding ?   Will your UDP sendpage() queue the requests ?

There may be many threads on a streaming server and they would share
the same UDP socket. UDP_CORK mechanism requires semaphore to serialize
sending data and it would block each other for a long time because
sendfile() might have the threads sleep in BIO as you said.

You may say we can use MSG_MORE instead of UDP_CORK.
When we use it, we have to make multiple queue for each destination for
clientns. But we can't link pages to the queue as sendfile() have no
arguments specifying the destination.

client UDP sockets
+---------+
|dest:123 |---------+
|         |         |
+---------+         | server
                    V UDP socket
+---------+        +---------+ <--- thread1
|dest:123 |------->|src:123  | <--- thread2
|         |        |dest:ANY | <--- thread3
+---------+        +---------+ <--- thread4
                    A
+---------+         |
|dest:123 |---------+
|         |
+---------+

Shall I make a multiple queue based on pid instead of destitation address ?
Any idea is welcome!

Thank you,
Hirokazu Takahashi
