Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269893AbUJGW6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269893AbUJGW6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269876AbUJGW6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:58:15 -0400
Received: from findaloan.ca ([66.11.177.6]:6112 "EHLO findaloan.ca")
	by vger.kernel.org with ESMTP id S269881AbUJGWq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:46:58 -0400
Date: Thu, 7 Oct 2004 18:42:42 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: "David S. Miller" <davem@davemloft.net>
Cc: Martijn Sipkema <msipkema@sipkema-digital.com>,
       cfriesen@nortelnetworks.com, hzhong@cisco.com, jst1@email.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       davem@redhat.com
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041007224242.GA31430@mark.mielke.cc>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Martijn Sipkema <msipkema@sipkema-digital.com>,
	cfriesen@nortelnetworks.com, hzhong@cisco.com, jst1@email.com,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	davem@redhat.com
References: <00e501c4ac9a$556797d0$b83147ab@amer.cisco.com> <41658C03.6000503@nortelnetworks.com> <015f01c4acbe$cf70dae0$161b14ac@boromir> <4165B9DD.7010603@nortelnetworks.com> <20041007150035.6e9f0e09.davem@davemloft.net> <000901c4acc4$26404450$161b14ac@boromir> <20041007152400.17e8f475.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007152400.17e8f475.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 03:24:00PM -0700, David S. Miller wrote:
> I can't believe this thread has lasted this long.  I think people
> had cotton in their ears when I mentioned that every single 2.4.x
> and 2.6.x existing system out there has this behavior, therefore
> even if we changed the behavior some way today people still need
> to handle this to work on all existing Linux systems.

Nah. Some people hate it when their operating system doesn't do what
it is documented to do. These people include me.

We all know you should use non-blocking sockets for the application
domain we are talking about (one's that use select() / poll() to
determine whether data is available). Sometimes, it doesn't work.
When, you ask? When you are using a higher level language, such as a
version of Perl that didn't provide IO::blocking(), and on some
operating systems, such as HP-UX, it wasn't possible to portably
enable O_NONBLOCK for your sockets. We're talking practice here, so
I'm talking a real live example. Sure, it's nice to demand that people
upgrade to a later version of Perl. Guess what? It isn't happening. It
will be another year or two before we can guarantee people have Perl
5.006 on their system.

Anyways, I'm suspecting that the occurrences of these failures are so
low that they have been either un-reproducable, or people haven't even
noticed. Sometimes a blocking read happens to be ok - you are expecting
data, and eventually it will come. Then, the select() / poll() starts
up again, and the application continues on. For all the observer knows,
there was a load spike, and the application wasn't given enough cpu
seconds to process the request.

> Furthermore, returning -EAGAIN or any other kind of "try again"
> _DOES_ break applications, that's why we changed it to block instead.

This is good. The bad part is select() returning "data available", when
the information it is basing its decision on, is invalid, but it hasn't
taken the resources to prove yet. It's wrong. It's acceptable for
O_NONBLOCK, as no properly implemented application that uses O_NONBLOCK
should fail from seeing O_NONBLOCK in these cases.

Applications that do not set O_NONBLOCK have different expectations.
Blocking after select() says data is ready is wrong. If we want to say
'yes, it is wrong, but it's a corner case, too complicated to work around
and we're assuming that people are using O_NONBLOCK', that is fine. I just
want you to say it. :-)

I don't really care to hear "it's right, because that's how I coded it, and
that's how fast I want it to run."

Cheers,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

