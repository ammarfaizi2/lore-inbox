Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSFPVfs>; Sun, 16 Jun 2002 17:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSFPVfr>; Sun, 16 Jun 2002 17:35:47 -0400
Received: from mail.zmailer.org ([62.240.94.4]:6563 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S316592AbSFPVfn>;
	Sun, 16 Jun 2002 17:35:43 -0400
Date: Mon, 17 Jun 2002 00:35:42 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Chinese subscribers, and bad firewalls...
Message-ID: <20020617003542.N19520@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Something weird is being deployed in China, which does break SMTP
protocol  extension called PIPELINING, as specified by RFC 1854/2197.
(Just carelessly coded firewall, that is..)


The problem is visible when destination system MTA software does
report "PIPELINING" in the SMTP server behaviour capabilities.

Why VGER sees the problem, and most other systems don't, is because
vger runs with MTA software which does full PIPELINING implementation,
whereas most other software only report that thing in their smtp
server's EHLO responses as a cool way to get extra technical credit.
Some of those do the smtp server side implementation (which is fairly
easy exercise in buffering.)


Originally the SMTP protocol is defined as a half-duplex system where
a protocol verb+parameters is sent one line at the time, and a response
is then waited for.   In PIPELINING mode, the protocol exchange is
speeded up by sending all of MAIL FROM + RCPT TO lines + DATA  all in
one (or very few as possible) TCP segment(s), then the sending SMTP
client starts to analyze the responses.  The speedup is so radical
that one can send 1000 recipients across a long latency connections
in the same time as it takes to send one recipient's address.
(Years ago VGER sent most of its outgoing email to few fanout servers,
 tens or hundreds of recipients for each message.  Things got a bit
 slow at one point with that setup before full PIPELINING was
 implemented.  Think of 0.6s roundtrip, and 100 recipients.. )

Most email sending MTAs don't do this full acceleration, as it does
require rather radical changes in the smtp client internal code.
Separate code for speeded up mode, in fact.


This means that (as VGER sends it) MAIL FROM line follows by more
commands in the same TCP segment.  When a carelessly written packet
poking firewall makes presumptions of SMTP still being what RFC 821
defined 20 years ago (august 1982, by the way), things get to go
radically wrong...

What I see at VGER tcpdumping is:

C>: (connect to server)
S<: 220 greeting
C>: EHLO vger.kernel.org
S<: 250-jadajada...
S<: 250 PIPELINING
   (cool, it supports pipelining!)
C>: MAIL FROM:<...>
C>: RCPT TO:<...>
C>: DATA
  (tcp PUSH - all in one segment)
S<: 500  error in command
  (this in its own TCP segment)
S<: 250 Ok
S<: 250 Ok
S<: 354 End data with <CR><LF>.<CR><LF>
 (this in second TCP segment, with SAME starting TCP
  sequence number as that error!)


It has a strange smell of firewall sending its own error report, but
the protocol has made it thru, and the remote end (Postfix in this case,
actually) replies in proper PIPELINING style.


It might be, that the firewall is throwing a spanner in the works by
sending a rejection with same sequence number as the real server would
send.   However the spanner may occasionally be lost, and the real
server's reply makes it to vger, and the protocol just works.
The random success/failure game will again be played with next MAIL FROM
in same connection, of course..


This makes the thing in my opinnion rather weak as an firewall, and
extremely questionable if it should be used in securing the network
in any way.   As always, if a firewall is semi-permeable, it is
very questionable if it secures anything.  If a firewall has a hole
opened thru it for some protocol, the only way to run secure service
on that protocol is to have the real server secure.  No firewall can
do that for you (aside of protocol proxies implementing the service,
in which case we are in service securing, again..)
Non-permeable firewalls are cheap to make - unplug...


What is this product being used in China, I have no idea.
Perhaps it has no easy latin alphabet compatible name at all.

Can anybody tell me ?  Or better, raise the attention of the vendor,
and have this misbehaviour publicly acknowledged, and fixed ?


/Matti Aarnio  -- co-postmaster of vger.kernel.org
