Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293314AbSBYEDh>; Sun, 24 Feb 2002 23:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293315AbSBYED2>; Sun, 24 Feb 2002 23:03:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:50129 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293314AbSBYEDN>;
	Sun, 24 Feb 2002 23:03:13 -0500
Date: Sun, 24 Feb 2002 23:02:58 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, mingo@elte.hu,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: your mail 
In-Reply-To: <E16fAer-0000vA-00@wagner.rustcorp.com.au>
Message-ID: <Pine.GSO.4.21.0202242230370.1549-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Rusty Russell wrote:

> In message <Pine.GSO.4.21.0202242054410.1329-100000@weyl.math.psu.edu> you writ
> e:
> > 
> > 
> > On Mon, 25 Feb 2002, Rusty Russell wrote:
> > > First, fd passing sucks: you can't leave an fd somewhere and wait for
> > > someone to pick it up, and they vanish when you exit.  Secondly, you
> > 
> > Yes, you can.  Please, RTFS - what is passed is not a descriptor, it's
> > struct file *.  As soon as datagram is sent, descriptors are resolved and
> > after that point descriptor table of sender (or, for that matter, survival
> > of sender) doesn't matter.
> 
> Please explain how I leave a fd somewhere for other processes to grab
> it.  
> 
> And then please explain how they get the fd after I've exited.
> 
> Al, you are one of the most unpleasant people to deal with on this
> list.  This is *not* an honor, and I beg you to consider a different
> approach in future correspondence.

Honour or not, in this case your complaint is hardly deserved.  To
compress the above a bit:

you: <false statement>
me: RTFS.  <short description of the reasons why statement is wrong; further
details could be obtained by reading TFS>

As for your question, SCM_RIGHTS datagram can easily outlive the sending
process.  You will need a helper process (either per-meeting point or
system-wide) to avoid GC killing the thing, but that's it.

Writing such helper is left as an exercise to reader - it _is_ trivial.
To put fd(s):
	connect to (name of AF_UNIX socket)
	sendmsg to it; no OOB data, one byte of data (non-0)
	form an SCM_RIGHTS datagram with fds in question
	sendmsg it to the same socket.
	close the socket
In helper:
	listen on (name)
repeat:
	accept connection
	read one byte
	if it's non-zero
		put fd of connection into a list
		goto repeat
	else
		take first fd from list
		form an SCM_RIGHTS datagram with that fd
		send it into the new connection
		close fd
		close connection
		goto repeat
To get fd(s):
	connect ....
	sendmsg .................................... (0)
	recvmsg and pick fd from the message
	close connection
	recvmsg from fd and pick the set of fds from the message
	close fd

End of story.  In real-life situation you will want to throttle in helper,
etc., but in any case main loop is ~20 lines of code.

