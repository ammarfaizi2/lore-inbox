Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUGPIYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUGPIYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 04:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUGPIYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 04:24:21 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:52650 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266449AbUGPIYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 04:24:16 -0400
Date: Fri, 16 Jul 2004 10:23:45 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: network receiving performance bad since 2.6.7-bk15
Message-ID: <20040716082345.GA807@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: STfIUqZcgep-OkAVrXvBoTzesDbbKNNSKFJVhSf5TeKNT7ZYxAYAwp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This day I noticed a performance degradation when copying
files from hpux to linux-2.6.8-rc1. 

There is no performance degradation when between linux kernels
if linux is the sending the files, only when receiving.

I switched back to an older kernel (2.6.7-bk13) and with
this kernel copying (in both directions) is as fast as usual. 

I followed kernel-versions upwards and found that receiving network
performance goes bad starting with linux-2.6.7-bk15.

I argue ChangeSet@1.1782 "TCP acts like it is always out of memory" 
is causing this but I'm not sure.

Hardware:
HP-B1000 (1 x 300MHz-P8200)/hpux-10.20
Tyan-2665-Box (2 x 2.4GHz-Xeon, E1000-NIC)/linux-2.6.8-rc1

Below are times measured using nc (netcat) and sftp.

The results are similar, copying files from hpux to linux-2.6.rc1
is very very slow, copying files from hpux to linux-2.6-bk13 is as
fast as one can expect.

Copying files from linux to hpux is fast and independent of the
kernel version used.

The commands used to measure times with nc are
send: (time  cat 100k ) | nc  -n 192.168.168.32 9000
recv: nc -l -p 9000 -v -w 20 > file

The files are generated with dd reading from /dev/urandom.

Copy from hpux to linux-2.6.8-rc1
=================================
100k real    0m0.01s
200k real    0m0.02s
300k real    0m0.03s
400k real    0m0.04s
500k real    0m0.05s
600k real    0m0.06s
700k real    0m20.68s
800k real    1m11.22s

Copy from hpux to linux-2.6.7-bk13
==================================
100k real    0m0.01s
200k real    0m0.02s
300k real    0m0.03s
400k real    0m0.04s
500k real    0m0.05s
600k real    0m0.06s
600k real    0m0.07s
800k real    0m0.08s
900k real    0m0.09s

No difference if linux is sending the files.
============================================

Copy from linux-2.6.7-bk13 to hpux
900k 0.14s real (= 6428 kB/s, the hpux-box isn't faster)

Copy from linux-2.6.8-rc1 to hpux
900k 0.14s real (= 6428 kB/s, the hpux-box isn't faster)


Same, not so exact but more easy measured by using scp ..

Command used on linux: scp hpux:/tmp/files/* /tmp/files
Command used on hpux:  scp /tmp/files/* linux:/tmp/files

Copy the files from hpux to linux-2.6.7-bk13 
============================================

Command issued from linux.
100k                                          100%  100KB 100.0KB/s   00:00
200k                                          100%  200KB 200.0KB/s   00:00
300k                                          100%  300KB 300.0KB/s   00:00
400k                                          100%  400KB 400.0KB/s   00:00
500k                                          100%  500KB 500.0KB/s   00:00
600k                                          100%  600KB 600.0KB/s   00:01
700k                                          100%  700KB 700.0KB/s   00:00
800k                                          100%  800KB 800.0KB/s   00:00
900k                                          100%  900KB 900.0KB/s   00:00

Command issued from hpux.
100k                                          100%  100KB 100.0KB/s   00:00
200k                                          100%  200KB 200.0KB/s   00:00
300k                                          100%  300KB 300.0KB/s   00:00
400k                                          100%  400KB 400.0KB/s   00:00
500k                                          100%  500KB 500.0KB/s   00:00
600k                                          100%  600KB 600.0KB/s   00:00
700k                                          100%  700KB 700.0KB/s   00:00
800k                                          100%  800KB 800.0KB/s   00:00
900k                                          100%  900KB 900.0KB/s   00:01


Copy the files from hpux to linux-2.6.7-rc1
===========================================

Command issued from linux.
100k                                          100%  100KB  33.3KB/s   00:03
200k                                          100%  200KB  33.3KB/s   00:06
300k                                          100%  300KB  37.5KB/s   00:08
400k                                          100%  400KB  36.4KB/s   00:11
500k                                          100%  500KB  35.7KB/s   00:14
600k                                          100%  600KB  37.5KB/s   00:16
700k                                          100%  700KB  35.0KB/s   00:20
800k                                          100%  800KB  36.4KB/s   00:22
900k                                          100%  900KB  36.0KB/s   00:25

Command issued from hpux.
100k                                          100%  100KB 100.0KB/s   00:00
200k                                          100%  200KB  66.7KB/s   00:03
300k                                          100%  300KB  60.0KB/s   00:05
400k                                          100%  400KB  44.4KB/s   00:09
500k                                          100%  500KB  41.7KB/s   00:12
600k                                          100%  600KB  46.2KB/s   00:13
700k                                          100%  700KB  43.8KB/s   00:16
800k                                          100%  800KB  42.1KB/s   00:19
900k                                          100%  900KB  39.1KB/s   00:23

Can someone else using hpux see this too?
Can someone else see this with linux to linux or anyOS to linux copies too?

--
Klaus
