Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274222AbRI3VqM>; Sun, 30 Sep 2001 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274224AbRI3VqC>; Sun, 30 Sep 2001 17:46:02 -0400
Received: from cs82093.pp.htv.fi ([212.90.82.93]:50054 "EHLO cs82093.pp.htv.fi")
	by vger.kernel.org with ESMTP id <S274222AbRI3Vpw>;
	Sun, 30 Sep 2001 17:45:52 -0400
Message-ID: <3BB79296.677458C5@welho.com>
Date: Mon, 01 Oct 2001 00:45:58 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp_v4_get_port() and ephemeral ports
In-Reply-To: <3BB75EB4.3268D3FC@kegel.com> <3BB7676C.1213CC84@welho.com> <3BB78291.F8732D4@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:

> Depends on what you mean by real-life situations.  If you actually
> need to handle over ten thousand outgoing connections, this change
> could indeed help relieve port exhaustion.  Think of web spiders
> or web caches on gigabit/sec links.

I should have said most real life situations. The point is simply that
there are relatively few real life applications where port exhaustion
can occur and even there it can be avoided by making the client a little
bit smarter. Granted, web spiders and caches are examples of these
applications.

> Perhaps one could go further, and have the kernel pick an ip address as
> well; that would make the app even easier to code.  [...]
> Making this pick an alias at random
> is kind of a gross thought. [...]

Well, source address selection is really a policy decision and it would
be nice to have the policy tools to affect the source address selection
algorithm. This would be especially interesting with IPv6 where aliases
are par for the course and address privacy is something of an issue.
However, I'm not really sure what the best way of defining that policy
would be.

For your application you would need randomization or round-robin for a
kind of a load balancing. For address privacy you might want to simply
set a preferred address on each interface for outbound connections. From
routing standpoint you would like to select the address that is the best
match (e.g. longest prefix match) for the destination, to ensure
shortest return path. You would also need to combine this with scoping
rules.

> > Or you could even pick a completely empty port range and bind
> > each client socket with the SO_REUSE flag (which is ok, since your
> > clients are using different source addresses).
> 
> SO_REUSE might let my app's connections collide with those
> of other apps, wouldn't it?  Doesn't seem very clean.  A web cache
> or web spider probably wouldn't use SO_REUSE, would it?

As long as you ensure that you don't have any listening sockets in the
port range you're using for the client connections this is a valid
technique. It would actually be especially useful for proxies and web
crawlers. Even though sharing the same source address and port between
multiple client sockets, the kernel still wont allow you to create two
connections to the same {destination address,port} pair, ensuring that
each connection 5-tuple is unique.

Granted, this takes a little book keeping in the application, but to run
out of ports you would have to make thousands of connections to the same
server (as your performance tool does). Even web crawlers can easily
avoid this by rate limiting the connections to a single target and
scanning multiple target hosts in parallel. 

> I guess I'm resigned to managing the ephemeral port number in my app.
> A bit of a pain, but that's life.

It's probably still easiest to do this in the application. :)

Cheers,

	Mika Liljeberg
