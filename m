Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284948AbRLFCwA>; Wed, 5 Dec 2001 21:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284950AbRLFCvv>; Wed, 5 Dec 2001 21:51:51 -0500
Received: from [202.135.142.194] ([202.135.142.194]:59657 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S284948AbRLFCve>; Wed, 5 Dec 2001 21:51:34 -0500
Date: Thu, 6 Dec 2001 13:52:24 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-Id: <20011206135224.12c4b123.rusty@rustcorp.com.au>
In-Reply-To: <20011204.220511.71088411.davem@redhat.com>
In-Reply-To: <20011204163646.M7439@work.bitmover.com>
	<20011204.183601.22018455.davem@redhat.com>
	<20011204192317.N7439@work.bitmover.com>
	<20011204.220511.71088411.davem@redhat.com>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2001 22:05:11 -0800 (PST)
"David S. Miller" <davem@redhat.com> wrote:

> The problem areas of scalability, for which no real solution is
> evident yet, involve the file name lookup tree data structures,
> ie. the dcache under Linux.  All accesses here are tree based, and
> everyone starts from similar roots.  So you can't per-node or
> per-branch lock as everyone traverses the same paths.  Furthermore you
> can't use "special locks" as in #1 since this data structure is
> neither heavy reader nor heavy writer.

Yes.  dbench on 4-way was showing d_lookup hurting us, but replacing
dcache_lock with a rw_lock (Anton Blanchard provided an atomic_dec_and_wlock)
and a separate lock for the unused list DIDN'T HELP ONE BIT.

Why?  Because there's no contention on the lock!  The problem is almost
entirely moving the cacheline around (which is the same for a rw lock).

I'd love to say that I can solve this with RCU, but it's vastly non-trivial
and I haven't got code, so I'm not going to say that. 8)

Rusty.
-- 
  Anyone who quotes me is an idiot. -- Rusty Russell.
