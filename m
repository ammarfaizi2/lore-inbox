Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUILKhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUILKhW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268634AbUILKhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:37:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25356 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268609AbUILKgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:36:17 -0400
Date: Sun, 12 Sep 2004 12:36:13 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: peter@mysql.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial of Service
Message-ID: <20040912103613.GA15177@alpha.home.local>
References: <026001c4989c$e2bddbb0$0300a8c0@s> <001201c498aa$43b16ce0$0200a8c0@wolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201c498aa$43b16ce0$0200a8c0@wolf>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 03:24:11AM -0600, Wolfpaw - Dale Corse wrote:
 
> This is the odd part, try the exploit,

I have nothing to try it right here.

> they are detached in
> the list, but it appears apache isn't aware of that. If you
> run the code, and do multiple telnets from another window,
> you will see that there are occurrences where a connection
> can't be established, and this is where the problem is. I
> used a stock version of Mysql 3 (latest stable), stock
> apache, on an unmoded Linux box (except it had GrSecurity)
> and I was able to see a noticeable slowdown in web transactions
> with a browser. I was also the only person hitting the machine.

How can you be sure that your problem is not simply related to either apache
or mysql not freeing the connection fast enough ? Apache is very limited in
terms of simultaneous connections, and it is trivial for anyone to block an
apache server by establishing as many connections as it can handle, sending
the start of a request and doing nothing more (and it has a very long default
time out BTW). It might be the same with mysql.

> I am not saying you are incorrect, I'm simply clarifying what
> seems to be occurring with the issue I found.
> 
> Do you happen to know of any solution for sockets stuck in
> CLOSE_WAIT, they seem to stick around forever.

Yes, the only solution is to debug the process and make it sanely close the
socket once it does not need it anymore. Usually, in such circumstances,
you'll find that an strace on the process shows either :
  - a select loop with your socket in the list of the active FDs, but
    nothing in the process will do anything on this FD and the process
    will go back to the select loop => bug in FD handling
 - a select loop which does not include the FD while it has not been released
   => bug in FD releasing code (usually a missing close).

> This bug may be more Mysql then kernel, I don't know - I still
> would tend to think these connections should not be clogging up
> the applications connection queue, and that CLOSE_WAIT should
> have a settable timeout, regardless of what the RFC says about it.

No, CLOSE_WAIT means that the application still has some work to do. Under
no circumstances, the kernel should destroy its ability to work normally !

> I did experience more CLOSE_WAIT's stuck at one point with Mysql..
> we had an issue wherein after calling mysql_close with the C API
> it was still leaving the sessions established, so I had moved the
> timeout on that sql daemon to 20 seconds (its all fast transactions)
> .. This caused a lot of CLOSE_WAIT issues for some reason.

So you've just demonstrated that it's mysql_close which is the culprit.
If it does not really close the connection while you expected it to, it
is the real problem. If you lower the mysql timeout, mysql will close
on its end, but as long as the code using mysql_close() will not close,
of course the socket will remain close_wait. And to be clear, even if
you would have a short CLOSE_WAIT time-out, it would not help because
you would still be running out of file-descriptors after a moment.

> We then
> added something that would go through and use 'close' on the fd of
> the Mysql connection, after mysql_close was called. This had the
> odd effect of the fd being reused by a connection, before it was
> out of CLOSE_WAIT and actually closed, so it would close the new
> Connection, and also the old one :P which led us to this discovery
> that connect() appears to reuse FD's before they are actually fully
> closed.. This is how it appears anyway. Thus my use of specifically
> mysql and connect in the PoC code.

If you manage to write a PoC code which does not involve either apache
not mysql, and which still exhibits the described behaviour, then perhaps
kernel developpers will listen a bit more, but at the moment, you only
showed us how you could trigger a DoS by connecting to a buggy application.

Cheers,
Willy

