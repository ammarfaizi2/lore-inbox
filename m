Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTDFGms (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 01:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbTDFGms (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 01:42:48 -0500
Received: from web21203.mail.yahoo.com ([216.136.130.22]:34642 "HELO
	web21203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262845AbTDFGmq (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 01:42:46 -0500
Message-ID: <20030406065419.91429.qmail@web21203.mail.yahoo.com>
Date: Sat, 5 Apr 2003 22:54:19 -0800 (PST)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: failure due to swapper and inet_sock_destruct
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using the 2.4.20 kernel in a fairly high stress
bursty network environment. Every so often, I see the
following error message from the kernel:

Attempt to release TCP socket in state 10 cfbfd540

I put some tracking in the kernel, and determined that
this cfbfd540 was specifically the sk1 used in
inet_tcp_listen and looking at the sport of 0x17, it
is the telnet daemon. So it was created by xinetd for
the telnet  listening socket.

The failure often happens during a period of
inactivity. The call to inet_sock_destruct happened in
the swapper context. My first question is whether
anyone has observed this behavior before. Secondly, in
order to debug the problem, I'd like to understand
what  could trigger the swapper to call
inet_sock_destruct. I did further determine that the
call did not come from either tcp_close or
tcp_destroy_sock. Looking at the code, it looks like
the only call to inet_sock_destruct only happens from
sk_free. sk_free looks to be used by sock_put which
happens from sock_wfree, sklist_remove_socket, etc.
Anyway, I'll keep investigating but I could use any
help/advice on what would trigger the destruction of
an sk without a call to close the parent listening
socket. Any reason why it happened in the swapper
context? 

Thanks,
Melkor




 


__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
