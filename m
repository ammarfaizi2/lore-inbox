Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268832AbUILTsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268832AbUILTsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268536AbUILTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:48:52 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29708 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268864AbUILTs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:48:29 -0400
Date: Sun, 12 Sep 2004 21:48:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: alan@lxorguk.ukuu.org.uk, peter@mysql.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)Denial of Service Attack
Message-ID: <20040912194816.GB2780@alpha.home.local>
References: <02b201c498f6$8bb92540$0300a8c0@s> <002501c498f8$0a4ebc20$0200a8c0@wolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002501c498f8$0a4ebc20$0200a8c0@wolf>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Sep 12, 2004 at 12:40:56PM -0600, Wolfpaw - Dale Corse wrote:
> It still seems prudent to me to have some kind of timeout (2 hours,
> or something?) to have it expuldge the connection, because obviously,
> it isn't going to voluntarily close.

Dale,

forgive me for insisting, but it would be criminal to do this. You think
that it's sort of closed while it is not. Consider CLOSE_WAIT as ESTABLISHED.
It is not because one end sends a FIN (shutdown(WRITE)) that the connection
is about to end. The culprit really is the application. It is the application
which trusts the other end too much. The system lets the application work as
it expects it, and should never try to cut the grass below the application's
feet.

You must understand how it is supposed to work, basically like this :

        A                                      B

  shutdown(WRITE)
  A enters FIN_WAIT1
          ------- ACK + FIN  ---------->  select(in[fd],out[fd],) returns in[fd]
                                          B enters CLOSE_WAIT
          <------ ACK + data -----------  read(fd) returns 0
                                          shutdown(SHUT_RD)
                                          Then remove fd from read list.
          <---- ACK + data -------------  select(NULL, out[fd],...)
                  (...)                   write(fd, data)...
          <---- ACK + data -------------  select(NULL, out[fd],...)
          <---- ACK + FIN --------------  shutdown(SHUT_WRITE) or close(fd)
 close(fd)
          ------- ACK ----------------->

If the system closed anything, on B side, since the select() does not check
read events anymore, it would only be woken up for a write even, which could
crash the application in a SIG_PIPE if the writer does not check the error
condition on the socket before writing (like most applications do).

So, let me insist, your proposal is not the right solution to this. The
right solution is to carefully check every application and fix them, the
same way you would fix them to handle time-outs on ESTABLISHED connections.

> This bug also exists with Apache, the default config of SSH,
> and anything controlled by inetd. This is the vast majority of
> popular services on a regular internet server.. That is bad, no?

You didn't wait long enough for each of them. I bet that if you wait up
to 2 minutes, SSH will close, and if you wait 5 or 10 minutes, apache
will close too. As to mysql, I have no idea, and inetd, we obviously both
have a buggy version.

I hope this clarifies a bit the situation,
Willy

