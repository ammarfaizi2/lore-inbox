Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265138AbUEYV5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265138AbUEYV5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUEYV5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:57:52 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54403
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265138AbUEYV4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:56:53 -0400
From: Rob Landley <rob@landley.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Date: Tue, 25 May 2004 16:55:42 -0500
User-Agent: KMail/1.5.4
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405121139.58742.rob@landley.net> <20040520134955.GA5215@openzaurus.ucw.cz>
In-Reply-To: <20040520134955.GA5215@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405251655.43185.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 May 2004 08:49, Pavel Machek wrote:
> Hi!

> > For years now I've wanted to use a sendfile variant to tell the system to
> > connect two filehandles from userspace.  Not just web servers want to
> > marshall data from one filehandle into another, things like netcat want
> > to do it between a pipe and a network connection, and I've wrote a couple
> > of data dispatcher daemons that wanted to do it between two network
> > connections.
> >
> > Unfortunately, sendfile didn't work generically when I tried it (back
> > under 2.4).  Would this infrastructure be a step in the right direction
> > to eliminate gratuitous poll loops (where nobody but me EVER seems to get
> > the "shutdown just one half of the connection" thing right.  My netcat
> > can handle "echo 'GET /' | netcat www.slashdot.org 80".  The standard
> > netcat can't. Yes, I plan to fix the one in busybox eventually...)
>
> Ugh. Yes, some syscalls like that were proposed... but to
> make programming easier, you'd need asynchronous
> sendfile to help you with programming, right?
>
> 				Pavel

Doesn't asynchronous sendfile has the little problem your process can exit 
before the sendfile is complete?

I'm not sure how much of a help it really is, since fork() isn't brain surgery 
if you want it to be asynchronous, and the lifetime rules are really explicit 
then.  (With a ps that does thread grouping, this isn't too bad from a 
clutter standpoint, even.  And you automatically get a SIGCHLD when the 
sendfile is complete, too...)

Of course if the syscall can make the sendfile outlive the process that fired 
it off, then by all means it sounds good.  I dunno how much extra work that 
is for the kernel, though.

I had a "star server" daemon that was allowing machines behind firewalls to 
talk to each other by ssh-ing in to a machine that wasn't behind a firewall, 
which would then route traffic between them.  It boiled down to connecting 
together incoming network sockets, which meant that each connection went 
through five processes on the star server: incoming ssh, redirector program 
that ssh ran (which sent it the data to a loopback network connection), the 
dispatcher daemon that handled the loopback connections and figured out who 
should connect to who, and then the redirector and the ssh session for the 
"outgoing" connection.  Both redirectors basically wanted to exit after 
connecting their stdin and stdout to a network socket on loopback, but 
couldn't because they had to run a poll loop to shovel data back and forth.  
Similarly the dispatcher daemon had the mother of all poll loops that 
basically implemented bidirectional sendfile by hand between pairs of network 
sockets.

Anyway, real world example of something ugly that made me want sendfile to be 
more generic.  (Netcat's another.)  I doubt the star server could have been 
cleaned up _too_ much since it was an ugly idea to begin with (on many 
levels), but my boss wanted it, and customers wanted it, so...

Rob

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

