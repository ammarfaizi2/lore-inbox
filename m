Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268544AbUILJYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268544AbUILJYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268553AbUILJYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:24:16 -0400
Received: from outbound01.telus.net ([199.185.220.220]:24962 "EHLO
	priv-edtnes56.telusplanet.net") by vger.kernel.org with ESMTP
	id S268544AbUILJYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:24:08 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <willy@w.ods.org>
Cc: <peter@mysql.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial of Service
Date: Sun, 12 Sep 2004 03:24:11 -0600
Message-ID: <001201c498aa$43b16ce0$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <026001c4989c$e2bddbb0$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

> TIME_WAIT status does not eat much resource, since they're in 
> a separate list. I've already had several *millions* of while 
> stressing some equipment, and I can assure you that it's 
> really not a problem as long as you increase your 
> tcp_max_tw_buckets accordingly. There is even no performance 
> impact (I could still get 40000 hits/s with this number of 
> time-waits). As David said, the connection has been closed 
> when it enters TIME_WAIT, so it has been detached from apache.

This is the odd part, try the exploit, they are detached in
the list, but it appears apache isn't aware of that. If you
run the code, and do multiple telnets from another window,
you will see that there are occurrences where a connection
can't be established, and this is where the problem is. I
used a stock version of Mysql 3 (latest stable), stock
apache, on an unmoded Linux box (except it had GrSecurity)
and I was able to see a noticeable slowdown in web transactions
with a browser. I was also the only person hitting the machine.

I am not saying you are incorrect, I'm simply clarifying what
seems to be occurring with the issue I found.

Do you happen to know of any solution for sockets stuck in
CLOSE_WAIT, they seem to stick around forever.

This bug may be more Mysql then kernel, I don't know - I still
would tend to think these connections should not be clogging up
the applications connection queue, and that CLOSE_WAIT should
have a settable timeout, regardless of what the RFC says about it.

I did experience more CLOSE_WAIT's stuck at one point with Mysql..
we had an issue wherein after calling mysql_close with the C API
it was still leaving the sessions established, so I had moved the
timeout on that sql daemon to 20 seconds (its all fast transactions)
.. This caused a lot of CLOSE_WAIT issues for some reason. We then
added something that would go through and use 'close' on the fd of
the Mysql connection, after mysql_close was called. This had the
odd effect of the fd being reused by a connection, before it was
out of CLOSE_WAIT and actually closed, so it would close the new
Connection, and also the old one :P which led us to this discovery
that connect() appears to reuse FD's before they are actually fully
closed.. This is how it appears anyway. Thus my use of specifically
mysql and connect in the PoC code.

Hope that helps some :)

Thanks :)
D.

