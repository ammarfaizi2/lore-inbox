Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTGOFQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTGOFQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:16:15 -0400
Received: from palrel12.hp.com ([156.153.255.237]:7881 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262321AbTGOFQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:16:12 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16147.37268.946613.965075@napali.hpl.hp.com>
Date: Mon, 14 Jul 2003 22:31:00 -0700
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
In-Reply-To: <20030714214510.17e02a9f.davem@redhat.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
	<20030714214510.17e02a9f.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Scott, somehow I never received your original response so I'm
 replying based on what I saw in the linux.kernel newgroup...]

 Scott> Do you have any data to share?

Sure, I don't see why not.  Here are the number I got:

TSO disabled:

 $ modprobe InterruptThrottleRate=0,0,0,0 TSO=0,0,0,0
 $ netperf -l 30 -c -C -H foobar -- -s64K -S64K
 TCP STREAM TEST to foobar
 Recv   Send    Send                          Utilization       Service Demand
 Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
 Size   Size    Size     Time     Throughput  local    remote   local   remote
 bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

 131070 131072 131072    30.00       897.16   34.07    35.00    3.111   3.196

TSO enabled:

 $ modprobe InterruptThrottleRate=0,0,0,0 TSO=1,1,1,1
 $ netperf -l 30 -c -C -H foobar -- -s64K -S64K
 TCP STREAM TEST to foobar
 Recv   Send    Send                          Utilization       Service Demand
 Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
 Size   Size    Size     Time     Throughput  local    remote   local   remote
 bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

 131070 131072 131072    30.00       894.09   11.65    34.48    1.068   3.159

This looks roughly like you'd expect: with TSO, slightly lower
throughput but much less CPU overhead.

With ftp, things get stranger: fetching a 2GByte file via ftp get
(from the remote end):

TSO disabled:

 ftp> get big.iso /dev/null
 local: /dev/null remote: big.iso
 200 PORT command successful.
 150 Opening BINARY mode data connection for 'big.iso' (2038628352 bytes).
 226 Transfer complete.
 2038628352 bytes received in 18.17 secs (109554.5 kB/s)

 ftp server CPU utilization: ~ 40%

With TSO enabled:

 ftp> get big.iso /dev/null
 local: /dev/null remote: big.iso
 200 PORT command successful.
 150 Opening BINARY mode data connection for 'big.iso' (2038628352 bytes).
 226 Transfer complete.
 2038628352 bytes received in 21.16 secs (94070.2 kB/s)

 ftp server CPU utilization: ~ 15%

So we get almost 15% of throughput drop.  This was with plain "netkit
fptd".  AFAIK, it does a simple read/write loop (not sendfile()).

	--david
