Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129505AbQJZTz2>; Thu, 26 Oct 2000 15:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129629AbQJZTzS>; Thu, 26 Oct 2000 15:55:18 -0400
Received: from mail1.digital.com ([204.123.2.50]:53516 "EHLO mail1.digital.com")
	by vger.kernel.org with ESMTP id <S129628AbQJZTzF> convert rfc822-to-8bit;
	Thu, 26 Oct 2000 15:55:05 -0400
Date: Thu, 26 Oct 2000 12:51:23 -0700 (PDT)
From: jg@pa.dec.com (Jim Gettys)
Message-Id: <200010261951.MAA18919@pachyderm.pa.dec.com>
X-Mailer: Pachyderm (client pachyderm.pa-x.dec.com, user jg)
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dan Kegel <dank@alumni.caltech.edu>,
        "Eric W. Biederman" <ebiederm@biederman.org>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10010260936330.2460-100000@penguin.transmeta.com>
Subject: Re: Linux's implementation of poll() not scalable?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note that there is another aspect to the efficiency / performance of the 
select/poll style of interfaces not immediately obvious, but which occurs 
as a result of how some (streaming/batching) protocols work.

An X server does not call select all that often (probably one of the two items most frequently used that care; 
though I believe getting the Apache case right is more important).

X is such a streaming protocol: it is a feature that I don't have to do 
extra reads or system calls to deal with more data arriving from a client.  
An X server doesn't want one event generated for each incoming TCP segment: 
it merely needs to know there is data available on a file descriptor as 
a binary condition.  I really don't want to have to do one operation per 
segment; this is less efficient than the current situation.

Similarly, it is a feature that with one call I can find out that there
is work to do on multiple file descriptors.

In short, the X server does a select, and then loops across all the file
descriptors with work to do before doing another select: the system call
overhead gets amortized across multiple clients and buffers received from
the client.  As the server gets busier, it is more and more likely
that there is more than one client with work to do, and/or multiple
TCP segments have arrived to process (in the common single client
is busy case).  So we make the system call less and less often
as a fraction of work done.

This has the happy consequence that the select caused overhead DROPS as
a fraction of total work as the X server gets busier, and X is most efficient
at the point in time you care the most: when you have the most work to
do.  The system call is returning more information each time it is called,
and some of that information is aggregated as well (additional data arriving).
It doesn't practically matter how efficient the X server is when
you aren't busy, after all.

This aggregation property is therefore important, and there needs to be
some way to achieve this, IMHO.

Web servers often have similar behavior, though since most current
HTTP clients don't implement streaming behavior, the benefit is currently
much lower (would that HTTP clients start driving HTTP servers the
way the HTTP/1.1 protocol allows...  Sigh...).  Right now, scaling
to large numbers of descriptors is most urgent for big web servers.

So I want an interface in which I can get as many events as possible
at once, and one in which the events themselves can have appropriate
aggregation behavior.  It isn't quite clear to me if the proposed interface
would have this property.

As I said in early talks about X: "X is an exercise in avoiding system
calls"....

			- Jim Gettys
--
Jim Gettys
Technology and Corporate Development
Compaq Computer Corporation
jg@pa.dec.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
