Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274102AbRI3UhI>; Sun, 30 Sep 2001 16:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274134AbRI3UhD>; Sun, 30 Sep 2001 16:37:03 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:14301 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274102AbRI3UgR>; Sun, 30 Sep 2001 16:36:17 -0400
Message-ID: <3BB78291.F8732D4@kegel.com>
Date: Sun, 30 Sep 2001 13:37:37 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tcp_v4_get_port() and ephemeral ports
In-Reply-To: <3BB75EB4.3268D3FC@kegel.com> <3BB7676C.1213CC84@welho.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Liljeberg wrote:
> 
> Dan Kegel wrote:
> 
> > So far, I've found an implementation of getifaddrs() that makes it
> > easy to retrieve the list of local IP addresses, and modified my
> > benchmark to assign a different local ip address to each user;
> > the users use bind() with that address and a zero port number,
> > and expect the system to assign a port.
> [...]
> > It's tempting to patch tcp_v4_get_port() to check
> > sk->rcv_saddr, and if it's nonzero, allow the
> > same ephemeral port number to be reused on different interfaces.
> [...]
> > Can anyone comment on the wisdom of such a change?
> 
> Hi Dan,

Thanks for the reply!

> It shouldn't break anything as far as I can see. However, patching the
> kernel simply to accommodate a benchmark does not seem the right thing
> to do. Since your client is already binding the source address, why not
> simply bind the port as well? You can easily loop the whole 64K range if
> you want. ... I don't see any reason to
> modify the kernel for this, particularly as it wouldn't really help port
> exhaustion in real-life situations.

Depends on what you mean by real-life situations.  If you actually 
need to handle over ten thousand outgoing connections, this change
could indeed help relieve port exhaustion.  Think of web spiders
or web caches on gigabit/sec links.  

Perhaps one could go further, and have the kernel pick an ip address as 
well; that would make the app even easier to code.  That means
changing connect() rather than bind().  It looks like the ip address for 
ephemeral connect() is picked by tcp_v4_connect / ip_route_connect / 
ip_route_output / ip_route_output_key / ip_route_output_slow / inet_select_addr().  
inet_select_addr() calls for_primary_ifa to iterate through the devices, 
so it doesn't pick up aliases.  Making this pick an alias at random
is kind of a gross thought.  I suppose there could be a socket option
SO_PREFER_ALIASES, and make it pick an alias 'at random'.  That's a change
I'd rather not make, since it looks like socket option space is about used up.

> Or you could even pick a completely empty port range and bind
> each client socket with the SO_REUSE flag (which is ok, since your
> clients are using different source addresses). 

SO_REUSE might let my app's connections collide with those
of other apps, wouldn't it?  Doesn't seem very clean.  A web cache
or web spider probably wouldn't use SO_REUSE, would it?

I guess I'm resigned to managing the ephemeral port number in my app.
A bit of a pain, but that's life.  If this ever starts bugging
lots of people, I'm sure a consensus about how to make life easier
will pop up.
- Dan
