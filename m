Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130599AbRATS2f>; Sat, 20 Jan 2001 13:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131033AbRATS2Z>; Sat, 20 Jan 2001 13:28:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:23890 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130599AbRATS2Q>; Sat, 20 Jan 2001 13:28:16 -0500
Date: Sat, 20 Jan 2001 19:23:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010120192320.J8717@athlon.random>
In-Reply-To: <20010119221327.C8717@athlon.random> <200101201728.UAA04351@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101201728.UAA04351@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Jan 20, 2001 at 08:28:04PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 08:28:04PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > My argument applies to 2.4. The uncork _won't_ push on the wire the last
> > not mss-sized fragment until it's the last one in the write queue even once
> > cwnd and receiver window allows that. I think 
> 
> Look at the code again. You misread it.

This is possible indeed, but in a few minutes re-read I still understand the
same thing as yesterday: if there's only 1 packet in the write queue pointed by
the send_head the nonagle will remains zero and the tcp_nagle_check will get
nonagle zero as well and it will compute the nagle default algorithm, this last
packet will be delayed normally in function of the nagle algortith.  I can
think of a:
 
        CORK
        write(1)
        UNCORK
 
and the 1 byte of payload will stay there until there will be nothing in flight
and all previously sent data will be acknowledged from the receiver. It seems
even more clear that we can delay the push in the wire of the last packet with
the uncorking if the receiver window or the congestion window forbid us to xmit
such packet immediatly in the uncork call. I admit I didn't looked at all into
the tcp_minshall_check due lack of time (that in turn means I don't know the
semantics of snd_sml), maybe it makes the difference but then I don't see how.
The rest seems quite obvious, packets_out indicates that we sent packets and
that those packets aren't acknowledged yet.  I would have written a testcase to
try in practice what happens but I'm busy, I apologise for bothering if I'm
totally wrong.  However if you have the time you would make me a favour if you
could tell _where_ my understanding of the code is wrong and what exactly I'm
missing.  Thx!

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
