Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWCLIfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWCLIfy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 03:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWCLIfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 03:35:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:49677 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751503AbWCLIfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 03:35:53 -0500
Date: Sun, 12 Mar 2006 09:35:28 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: michal.k.k.piotrowski@gmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       herbert@gondor.apana.org.au
Subject: Re: Linux v2.6.16-rc6
Message-ID: <20060312083528.GA21493@w.ods.org>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <6bffcb0e0603111751i1ed30794s@mail.gmail.com> <20060311.183904.71244086.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311.183904.71244086.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 06:39:04PM -0800, David S. Miller wrote:
> From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
> Date: Sun, 12 Mar 2006 02:51:40 +0100
> 
> > I have noticed this warnings
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> > 148470938:148470943. Repaired.
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/50967 shrinks window
> > 148470938:148470943. Repaired.
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
> > 1124211698:1124211703. Repaired.
> > TCP: Treason uncloaked! Peer 82.113.55.2:11759/59768 shrinks window
> > 1124211698:1124211703. Repaired.
> > 
> > It maybe problem with ktorrent.
> 
> It is a problem with the remote TCP implementation, it is
> illegally advertising a smaller window that it previously
> did.

on 2005/10/27, Herbert Xu provided a patch merged in 2.6.14 to fix some
erroneous occurences of this message (some of them appeared with Linux
on the other side). It would be interesting to know whether the peer
above is Linux or not, because it might be possible that Herbert's fix
needs to be applied to other places ?

Here comes his patch with his interesting analysis for reference, in
case it might give ideas to anybody.

Cheers,
Willy

---
From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 27 Oct 2005 08:47:46 +0000 (+1000)
Subject: [TCP]: Clear stale pred_flags when snd_wnd changes
X-Git-Tag: v2.6.14
X-Git-Url: http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2ad41065d9fe518759b695fc2640cf9c07261dd2

[TCP]: Clear stale pred_flags when snd_wnd changes

This bug is responsible for causing the infamous "Treason uncloaked"
messages that's been popping up everywhere since the printk was added.
It has usually been blamed on foreign operating systems.  However,
some of those reports implicate Linux as both systems are running
Linux or the TCP connection is going across the loopback interface.

In fact, there really is a bug in the Linux TCP header prediction code
that's been there since at least 2.1.8.  This bug was tracked down with
help from Dale Blount.

The effect of this bug ranges from harmless "Treason uncloaked"
messages to hung/aborted TCP connections.  The details of the bug
and fix is as follows.

When snd_wnd is updated, we only update pred_flags if
tcp_fast_path_check succeeds.  When it fails (for example,
when our rcvbuf is used up), we will leave pred_flags with
an out-of-date snd_wnd value.

When the out-of-date pred_flags happens to match the next incoming
packet we will again hit the fast path and use the current snd_wnd
which will be wrong.

In the case of the treason messages, it just happens that the snd_wnd
cached in pred_flags is zero while tp->snd_wnd is non-zero.  Therefore
when a zero-window packet comes in we incorrectly conclude that the
window is non-zero.

In fact if the peer continues to send us zero-window pure ACKs we
will continue making the same mistake.  It's only when the peer
transmits a zero-window packet with data attached that we get a
chance to snap out of it.  This is what triggers the treason
message at the next retransmit timeout.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Arnaldo Carvalho de Melo <acme@mandriva.com>
---

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2239,6 +2239,7 @@ static int tcp_ack_update_window(struct 
 			/* Note, it is the only place, where
 			 * fast path is recovered for sending TCP.
 			 */
+			tp->pred_flags = 0;
 			tcp_fast_path_check(sk, tp);
 
 			if (nwin > tp->max_window) {


----

