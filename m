Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281233AbRKTTj4>; Tue, 20 Nov 2001 14:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281244AbRKTTjh>; Tue, 20 Nov 2001 14:39:37 -0500
Received: from pat.uio.no ([129.240.130.16]:3470 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S281233AbRKTTjc>;
	Tue, 20 Nov 2001 14:39:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15354.45419.978323.438540@charged.uio.no>
Date: Tue, 20 Nov 2001 20:39:23 +0100
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
In-Reply-To: <200111201742.UAA03009@ms2.inr.ac.ru>
In-Reply-To: <shsn11i31g2.fsf@charged.uio.no>
	<200111201742.UAA03009@ms2.inr.ac.ru>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

     > Hello!
    >> I forgot to add: The socket fasync lists use spinlocking in the
    >> same was as RPC does, with sock_fasync() setting
    >> write_lock_bh(&sk->callback_lock), and sock_def_write_space()
    >> doing read_lock(&sk->callback_lock).
    >>
    >> So that would deadlock with the QDIO driver in the exact same
    >> manner as the RPC stuff (albeit probably a lot less
    >> frequently).

     > Please, elaborate. I do not see any way.


Processor 1                                       Processor 2


(Call QDIO bottom half code)
spin_lock(&QDIO_lock);
                                                write_lock_bh(&sk->callback_lock)
dev_kfree_skb_any()
   -> kfree_skb()
                                                 <QDIO hard interrupt>
     -> write_space()
                                                       ->spin_lock(&QDIO_lock)
                                                              (spins...)
        ->read_lock(&sk->callback_lock);
               (spins)


Deadlock - in exactly the same way as with the xprt code...

Cheers,
   Trond
