Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSBDAb5>; Sun, 3 Feb 2002 19:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSBDAbq>; Sun, 3 Feb 2002 19:31:46 -0500
Received: from relay1.pair.com ([209.68.1.20]:2321 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S287946AbSBDAbg>;
	Sun, 3 Feb 2002 19:31:36 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C5DD7D7.64A52BB1@kegel.com>
Date: Sun, 03 Feb 2002 16:37:43 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kev <klmitch@MIT.EDU>
CC: Arjen Wolfs <arjen@euro.net>, coder-com@undernet.org,
        feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <200202040007.TAA19301@multics.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kev wrote:
> 
> > The /dev/epoll patch is good, but the interface is different enough
> > from /dev/poll that ircd would need a new engine_epoll.c anyway.
> > (It would look like a cross between engine_devpoll.c and engine_rtsig.c,
> > as it would need to be notified by os_linux.c of any EWOULDBLOCK return values.
> > Both rtsigs and /dev/epoll only provide 'I just became ready' notification,
> > but no 'I'm not ready anymore' notification.)
> 
> I don't understand what it is you're saying here.  The ircu server uses
> non-blocking sockets, and has since long before EfNet and Undernet branched,
> so it already handles EWOULDBLOCK or EAGAIN intelligently, as far as I know.

Right.  poll() and Solaris /dev/poll are programmer-friendly; they give 
you the current readiness status for each socket.  ircu handles them fine.

/dev/epoll and Linux 2.4's rtsig feature, on the other hand, are
programmer-hostile; they don't tell you which sockets are ready.
Instead, they tell you when sockets *become* ready;
your only indication that those sockets have become *unready*
is when you see an EWOULDBLOCK from them.

If this didn't make any sense, maybe seeing how it's used might help.
Look at Poller::clearReadiness() in
http://www.kegel.com/dkftpbench/doc/Poller.html#DOC.9.11 or
http://www.kegel.com/dkftpbench/dkftpbench-0.38/Poller_sigio.cc
and the calls to Poller::clearReadiness() in
http://www.kegel.com/dkftpbench/dkftpbench-0.38/ftp_client_pipe.cc

- Dan
