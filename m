Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbTJ0A2V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 19:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTJ0A2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 19:28:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:14989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263703AbTJ0A2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 19:28:20 -0500
Date: Sun, 26 Oct 2003 16:28:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Andries.Brouwer@cwi.nl, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>, "David S. Miller" <davem@redhat.com>,
       <kuznet@ms2.inr.ac.ru>
Subject: Re: Linux 2.6.0-test9
In-Reply-To: <Pine.LNX.4.44.0310261607230.3157-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0310261623000.3157-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Oct 2003, Linus Torvalds wrote:
> 
> Andries, what was the situation that led to a TCP lockup? I don't see 
> anything but URG being broken by that patch, so it would be good to verify 
> that your breakage really was URG, to see that it's totally understood..

Btw, final comment: if it really is URG-only breakage, then instead of 
reverting the patch (if it had some other reasons going for it), we could 
change the URG test at the top of the loop from

	if (copied && tp->urg_data && tp->urg_seq == *seq)
		break

to

	if (tp->urg_data && tp->urg_seq == *seq) {
		if (copied)
			break;
		if (signal_pending(current)) {
			copied = timeo ? sock_intr_errno(timeo) : -EAGAIN;
			break;
		}
	}

which gives the right break semantics for URG data.

After that, the only other place where we should check for signal pending 
is probably at the tcp_data_wait() call. All the other signal pending 
checks seem bogus (ie right now a pending signal will mean that we avoid 
doing even TCP-level cleanups, which looks just wrong).

But reverting the change is clearly the "safer" thing to do, I just worry 
that Alexey might have had a real reason for tryign to avoid the EINTR in 
the first place (for non-URG data).

		Linus

