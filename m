Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262674AbRFSCr1>; Mon, 18 Jun 2001 22:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263437AbRFSCrR>; Mon, 18 Jun 2001 22:47:17 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:14856 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S262674AbRFSCrA>; Mon, 18 Jun 2001 22:47:00 -0400
Date: Mon, 18 Jun 2001 19:46:58 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Jan Hudec <bulb@ucw.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <a05101001b75435c7291d@[192.168.239.105]>
Message-ID: <Pine.LNX.4.33.0106181922230.5361-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Jonathan Morton wrote:

> >  > >  > Btw: can the aplication somehow ask the tcp/ip stack what was
> >>  >actualy acked?
> >>  >>  (ie. how many bytes were acked).
> >>  >
> >>  >no, but it's not necessarily a useful number anyhow -- because it's
> >>  >possible that the remote end ACKd bytes but the ACK never arrives.  so you
> >>  >can get into a situation where the remote application has the entire
> >>  >message but the local application doesn't know.  the only way to solve
> >>  >this is above the TCP layer.  (message duplicate elimination using an
> >>  >unique id.)
> >>
> >>  No, because if the ACK doesn't reach the sending machine, the sender
> >>  will retry the data until it does get an ACK.
> >
> >if the network goes down in between, the sender may never get the ACK.
> >the sender will see a timeout eventually.  the receiver may already be
> >done with the connection and closed it and never see the error.  if it
> >were a protocol such as SMTP then the sender would retry later, and the
> >result would be a duplicate message.  (which you can eliminate above the
> >TCP layer using unique ids.)
>
> But, if the sender does not attempt to close the socket until the ACK
> returns, then the receiver will see an unfinished connection and
> (hopefully) realise that the message is unsafe and not attempt to
> send it.

suppose the network goes away and doesn't come back.  the ACK never gets
through.

> With SMTP, the last piece of data is a QUIT anyway, which occurs
> after the end-of-message marker - once the QUIT is sent and/or
> received, both ends know that the connection is finished with and
> will close the socket independently of each other.  If the network
> disappears before the QUIT comes along, the receiver should be
> discarding messages and the sender retrying later.

QUIT is the last step of a session which can include multiple messages. a
single message begins with the "MAIL FROM:<foo>" and ends with the . that
terminates the DATA section.  after that the smtp server sends back the
"250 OK".  the smtp client is now free to sit on the connection "forever",
possibly beginning another "MAIL FROM:<foo>".  (i.e. connection caching in
sendmail.)

but in the meanwhile, the smtp server has moved the message into its next
phase of delivery as soon as it sends back the "250 OK", which could
include having forwarded it off the box, or to a mailing list, etc.

so in this example where you want to consider network failure is after the
smtp client has sent the trailing "." closing the DATA section, and that
data has been received by the smtp server.  then the network fails before
the ACK (and "250 OK") returns to the smtp client.

in this case the client has no choice but to resend later.  (both sides
should get an error eventually assuming the implementors don't suck,
unlike in some other protocols such as HTTP/0.9 and HTTP/1.0 where the
protocol itself is flawed.)  the result is probably a message duplicate.

so what you were asking about was, what if the smtp server in this case
could find out that the "250 OK" was never ACKd.  in that case just move
the network failure a little later in the series of events... and also
consider cases where the TCP stack ACKs but the application never gets to
read() the data (system failures).

basically these transactional semantics have to occur above TCP/IP itself.
this is where QUIT comes in.  and to some extent, message-IDs for
duplicate elimination.  (in HTTP/1.1 the introduction of chunked transfer
encoding to handle variable length dynamic responses in the face of
network failures... but folks building web forms still need to put
unique-ids into the forms to handle the duplicate message problem.)

i guess knowing the number of ACK'd bytes might be a useful debugging aid,
but i'd fear it being misused by app writers.

-dean

