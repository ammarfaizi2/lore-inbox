Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271550AbRIGHWl>; Fri, 7 Sep 2001 03:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271568AbRIGHWc>; Fri, 7 Sep 2001 03:22:32 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:20748 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S271550AbRIGHW0>;
	Fri, 7 Sep 2001 03:22:26 -0400
Message-ID: <20010907112935.A26353@castle.nmd.msu.ru>
Date: Fri, 7 Sep 2001 11:29:35 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, Wietse Venema <wietse@porcupine.org>
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <20010906235157.D11046@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010906235157.D11046@mea-ext.zmailer.org>; from "Matti Aarnio" on Thu, Sep 06, 2001 at 11:51:57PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti,

On Thu, Sep 06, 2001 at 11:51:57PM +0300, Matti Aarnio wrote:
> On Thu, Sep 06, 2001 at 01:39:48PM -0400, Wietse Venema wrote:
> > Andrey Savochkin:
> > > > That is not practical. Surely there is an API to find out if an IP
> > > > address connects to the machine itself. If every UNIX system on
> > > > this planet can do it, then surely Linux can do it.
> > > 
> > > Let me correct you: you need to recognize not addresses that result in
> > > connecting to the _machine_ itself, but connecting to the same _MTA_.
> > 
> > The SMTP RFC requires that user@[ip.address] is correctly recognized
> > as a final destination.  This requires that Linux provides the MTA
> > with information about IP addresses that correspond with INADDR_ANY.
> 
> 	[ This is one of (at least) three different things that
> 	  have been mentioned in this thread, but lets limit
> 	  into only this one thing in this email ...  ]
> 
> 	Why that needs a list of all addresses in the system ?
> 
> 	Reception can query with standard BSD API what is
> 	the local address of the socket _at_the_moment_ at
> 	receiving side.  (  getsockname()  )
> 
> 	Is there, really, any reason to detect locally anything else ?

The question is about what to do if you got a message to root@[10.0.0.1]
through a socket with local address (getsockname()) being 192.193.194.165.
If the local address is 10.0.0.1 also, there is no problem, the message is
clearly for your MTA.

Technically, Andi proposed to do route lookup at the moment of receiving the
message to check if it's local.
It provides a very close approximation to whether the address is "local" from
the point of view of networking engine.
But I'm not convinced that it's what you really want and need to check.

[snip]
> 
> > I am susprised that it is not possible to ask such information up
> > front (same with netmasks), and that an application has to actually
> > query a complex oracle, again and again, for every IP address.
> 
> 	Of course it can be asked for, and ZMailer does it all
> 	the time when it considers contacting remote servers.
> 	If IP address of the remote server appears to be any
> 	of the local ones (or an invalidone), the message gets
> 	rejected with "a configuration error detected, this
> 	must be looping"...

Right.
But how do you check for the destination IP being in the "local ones"?
Will I get this error if I type a message to root@[127.0.0.2] in a telnet
session to your MTA with 127.0.0.3 source address?
BTW, does ZMailer listen on INADDR_ANY by default?

There are different acceptable solutions.
If the message is delivered to root in the above example, it may be ok.
If I get an error, some people may agree to live with that, not sure about
Wietse :-)
Peter told us how he checked for local addresses in autofs, and that's what
may be done at the sending time in MTAs.
Alternatively, you may connect to port 25 on the target and by some "magic"
way determine that you talk to yourself.
But again I'm unsure if that's what you want and need to check.

The absolutely error-prone solution would be to listen on one specific IP
address and handle this address and only it as local in destinations.
That's how mail works on my own system now :-)
But it isn't very flexible.

My suggestion was to allow the administrator to list "local" IP addresses in
the configuration file, for example, in terms of prefixes, like 127.0.0.0/8
and 192.193.194.165/32.  It's a policy not technical decision, anyway.
If the MTA listens on INADDR_ANY, you should list all addresses connection to
which lead to socket lookup on this system, i.e. all "local" addresses from
the networking configuration's point of view.
If the MTA listens on specific addresses, list them.
The configuration file syntax may be optimized whatever way you want, but the
idea is clear.

The advantages are:
 1. MTA never makes mistakes in what addresses to consider as "local"
 2. you can have several different MTA on the same system
 3. you can have policies which addresses to accept connections on, and it
    won't cause any problems in mail delivery.

Best regards
		Andrey
