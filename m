Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280647AbRKST3r>; Mon, 19 Nov 2001 14:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280653AbRKST3i>; Mon, 19 Nov 2001 14:29:38 -0500
Received: from pat.uio.no ([129.240.130.16]:13018 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S280647AbRKST3W>;
	Mon, 19 Nov 2001 14:29:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15353.23941.858943.218040@charged.uio.no>
Date: Mon, 19 Nov 2001 20:29:09 +0100
To: kuznet@ms2.inr.ac.ru
Cc: b.lammering@science-computing.de, linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
In-Reply-To: <200111191909.WAA21357@ms2.inr.ac.ru>
In-Reply-To: <15353.21949.239139.993379@charged.uio.no>
	<200111191909.WAA21357@ms2.inr.ac.ru>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

     > I do no think this was right, to be honest. write_space with
     > udp is too hairy thing to use it correctly. :-) Anyway, it is
     > enough to select right sndbuf. Right is... well, default value
     > is right. :-)

The sndbuf is by default 64k, so that should indeed suffice to fit all
the possible varieties of NFS datagram.

The problem is that when EAGAIN is returned by sendmsg, we want to put
the RPC request to sleep (and have rpciod deal with other pending
requests), and then reactivate it as soon as sock_wspace() reports
that the available free buffer space is large enough to fit the next
request.

Assuming that sock_wfree() always gets called whenever an skb is
released and that sock_wspace() does indeed reflect more or less the
maximum message size for which there is free buffer space (I allow a
couple of kilobytes for extra padding) then the current UDP code
should be correct and race-free.

Cheers,
   Trond
