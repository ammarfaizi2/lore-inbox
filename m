Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291817AbSBNSKF>; Thu, 14 Feb 2002 13:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291818AbSBNSJw>; Thu, 14 Feb 2002 13:09:52 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:12994 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291817AbSBNSJh>; Thu, 14 Feb 2002 13:09:37 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202141809.g1EI95x01960@eng2.beaverton.ibm.com>
Subject: [RFC] kiobuf problems with 2.4.17
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Feb 2002 10:09:05 -0800 (PST)
Cc: pbadari@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are having problems with kiobufs on 2.4.17 while running 
database benchmarks (on RAW). Issue here is we get one kiobuf
per device open. Since database processes does lots of opens
we end up allocating lots of kiobufs. So we run out of memory
and start swapping.

These benchmarks ran fine on 2.4.6, since it has only kiobuf
per device.

I have few ideas and need your suggestions/comments on fixing
this issue.

1) Have one kiobuf per process instead of open. Since a process
   cannot do more than one IO at any time, why not maintain 
   one kiobuf per process instead file open ? (With the exception 
   of asyncio).

   This way we can save a lot, if process does lots of opens.
   What am I missing here ?


2) Reduce the size of kiobuf.

   (i) Currently kiobuf has:
		
		struct buffer_head * bh[KIO_MAX_SECTORS];

     Why not make it

		struct buffer_head * bh;

   and them chainup in alloc_kiovec(). We can save almost 4K doing this.

   (ii) kiobuf also has:

		unsigned long blocks[KIO_MAX_SECTORS];

     We don't really need this for RAW IO.  Why not make it

		unsigned long *blocks;

   and NOT allocate it for RAW (for O_DIRECT and other usages we can
   allocated it). This will save another 4K for RAW.

   I made a patch to do (2) and it works fine. 

Please let me know.

Thanks,
Badari
