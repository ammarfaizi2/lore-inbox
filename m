Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262509AbSIZMfy>; Thu, 26 Sep 2002 08:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262511AbSIZMfy>; Thu, 26 Sep 2002 08:35:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11537 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262509AbSIZMfx>; Thu, 26 Sep 2002 08:35:53 -0400
Message-Id: <200209261236.g8QCaCp04179@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Further info on underflow in /proc/meminfo
Date: Thu, 26 Sep 2002 15:30:29 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is roughly how it is generated:
...
struct sysinfo i;
...
si_meminfo(&i);
    val->bufferram = atomic_read(&buffermem_pages);
...
pg_size = atomic_read(&page_cache_size) - i.bufferram;
...
sprintf("cached: %d",B(pg_size));
...


On my box I have:

# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  30322688 27533312  2789376        0 19501056 18446744073699565568
Swap: 100655104  8732672 91922432                  ^^^^^^^^^^^^^^^^^^^^
MemTotal:        29612 kB           
...

so, page_cache_size-buffermem_pages<0 and after it got scaled pages->bytes
we have LARGE "cached:" value! :-)

# uname -a
Linux pegasus 2.4.18-pre6mhv_ll #2 SMP Wed Mar 27 11:17:36 GMT+2 2002 i686 unknown
--
vda
