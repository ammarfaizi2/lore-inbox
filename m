Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSKSFnM>; Tue, 19 Nov 2002 00:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbSKSFnM>; Tue, 19 Nov 2002 00:43:12 -0500
Received: from picante.ne.client2.attbi.com ([24.91.80.18]:2555 "EHLO
	habanero.picante.com") by vger.kernel.org with ESMTP
	id <S267096AbSKSFnK>; Tue, 19 Nov 2002 00:43:10 -0500
Message-Id: <200211190549.gAJ5nGmU007542@habanero.picante.com>
From: Grant Taylor <gtaylor+lkml_ihdeh111902@picante.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Date: Tue, 19 Nov 2002 00:49:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Mark Mielke <mark@mark.mielke.cc> writes:

> We're talking about one extra field to a data structure.

Hmm.  As it happens, it looks like Davide is going to err on the side
of the kitchen sink; that neatly makes us both more or less happy,
even if it's still ugly ;)


Meanwhile, in the more important caveat department (Dan, this will
appeal to you), I found a while back that signals cause pain with
epoll.

For example, sometimes TCP reads return EAGAIN when in fact they have
data.  This seems to stem from the case where the signal is found
before the first segment copy (from tcp.c circa 1425, there's even a
handy FIXME note there).  If you use epoll and get an EAGAIN, you have
no idea if it was a signal or a real empty socket unless you are also
very careful to notice when you got a signal during the read.

	do {
		struct sk_buff * skb;
		u32 offset;

		/* Are we at urgent data? Stop if we have read anything. */
		if (copied && tp->urg_data && tp->urg_seq == *seq)
			break;

		/* We need to check signals first, to get correct SIGURG
		 * handling. FIXME: Need to check this doesnt impact 1003.1g
		 * and move it down to the bottom of the loop
		 */
		if (signal_pending(current)) {
			if (copied)
				break;
			copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
			break;
		}

		/* Next get a buffer. */

		skb = skb_peek(&sk->receive_queue);
		do {
	


-- 
Grant Taylor - gtaylor<at>picante.com - http://www.picante.com/~gtaylor/
   Linux Printing Website and HOWTO:  http://www.linuxprinting.org/
