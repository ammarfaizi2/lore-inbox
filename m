Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbSLWDT6>; Sun, 22 Dec 2002 22:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSLWDT6>; Sun, 22 Dec 2002 22:19:58 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:60689 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266464AbSLWDT5>; Sun, 22 Dec 2002 22:19:57 -0500
Date: Mon, 23 Dec 2002 01:27:20 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/net/tcp + ipv6 hang
Message-ID: <20021223032720.GA6554@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anders Gustafsson <andersg@0x63.nu>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021223015723.GA17439@gagarin> <20021223024017.GO4942@conectiva.com.br> <20021223030812.GA18409@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223030812.GA18409@gagarin>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 23, 2002 at 04:08:12AM +0100, Anders Gustafsson escreveu:
> On Mon, Dec 23, 2002 at 12:40:17AM -0200, Arnaldo Carvalho de Melo wrote:
 
> > Anders, if you're feeling brave, from the top of my head, think about what
> > happens if somebody only reads the first, say, 10 bytes of /proc/net/tcp,
> > will we unlocking a not held lock at tcp_seq_stop, no? :-)
 
> Yes, I was just looking into the locking... But it's rather messy with locks
> between calls and goto's and I think I'd better get some sleep before saying
> anything for certain. Is there any reason holding the lock between
> listening_get_first() and the first call to listening_get_next(), but not
> between consecutive calls to listening_get_next()? Otherwise we could just
> always release the lock in listening_get_first.
 
> (All this applies to established_get_first/next too.)

We have to hold the lock (tp->syn_wait_lock) because in listening_get_first
we return one of the elements of the list guarded by tp->syn_wait_lock, so
we have to make sure that it doesn't disappears under our feet when we go
to the next one in listening_get_next
 
> OOPS, I just realizes we might be talking about different locks :)

different problem :-)
 
> I was talking about 
> read_[un]lock_bh(&tp->syn_wait_lock); in listening_get_first/next
 
> What lock are you talking about?
> As far as I can see, in TCP_SEQ_STATE_OPENREQ tp->syn_wait_lock is always
> held and in TCP_SEQ_STATE_LISTENING the tcp_listen_lock and so on?

Notice that we call tcp_listen_lock() only in tcp_get_idx, and tcp_get_idx
is not called for the first record, that is the header of /proc/net/tcp,
we're in TCP_SEQ_STATE_LISTENING that is zero (we zeroed the private seq_file
area in tcp_seq_open, so if the userlevel program only asks for, say, four
bytes (like midnight commander's editor, to read the magic number for the file
to decide which viewer is associated with the type indicated by the magic
number) this will be satisfied with just one call to tcp_seq_show, i.e.
only when tcp_seq_start returns (void *), without calling tcp_get_idx to
call tcp_listen_lock(). b00m, we drop a lock not held, got it?

- Arnaldo
