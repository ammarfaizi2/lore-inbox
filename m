Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265164AbUEYXTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbUEYXTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 19:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUEYXTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 19:19:06 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:60803
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265164AbUEYXS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 19:18:58 -0400
From: Rob Landley <rob@landley.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Date: Tue, 25 May 2004 18:16:05 -0500
User-Agent: KMail/1.5.4
Cc: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405251655.43185.rob@landley.net> <20040525220826.GC1609@elf.ucw.cz>
In-Reply-To: <20040525220826.GC1609@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405251816.05497.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 May 2004 17:08, Pavel Machek wrote:

> > Doesn't asynchronous sendfile has the little problem your process can
> > exit before the sendfile is complete?
>
> Hmm, it has...
>
> > I'm not sure how much of a help it really is, since fork() isn't brain
> > surgery if you want it to be asynchronous, and the lifetime rules are
> > really explicit then.  (With a ps that does thread grouping, this isn't
> > too bad from a clutter standpoint, even.  And you automatically get a
> > SIGCHLD when the sendfile is complete, too...)
>
> Right.
>
> > Of course if the syscall can make the sendfile outlive the process that
> > fired it off, then by all means it sounds good.  I dunno how much extra
> > work that is for the kernel, though.
>
> Well, it would be "interesting" to stop that sendfile then. You could
> not kill it etc.

Well, logically what you're doing is redirecting an existing filehandle so it 
points to something else.  Instead of reading from this pipe, you're now 
reading from this file or from this network socket, or this other process's 
stdout.  So any intermediate processes going away is theoretically okay as 
long as the anchors at each end remain (process/filesystem/network connection 
generating the data, process/filesystem/network connection receiving the 
data).

The easy way to make the semantics work out right is that such an asynchronous 
sendfile would effectively close the file in question from the point of view 
of the process that did the sendfile.  It would pretty much have to be part 
of the semantics of any asynchronous sendfile call: welding together the two 
filehandles would behave like a single direction shutdown(2) as far as the 
process that called sendfile is concerned.  (That way, if you do an async 
sendfile in each direction, the filehandle is closed both ways, but you don't 
HAVE to if you don't want to.  You can feed data to a child process from a 
script file or something, and just deal with the responses coming back.)

This would mean that in theory the process that did the sendfile could go away 
without too much ambiguity about what should happen.  (The bits that are 
already closed from the process's point of view are unaffected by the process 
exiting.)  I dunno what's needed to clean that up in the kernel.

I also don't know if it's a good idea, because as you noticed the fire and 
forget nature of the thing means that killing it afterwards is something we 
haven't got a semantic for if the thing at the other end is NOT a pipe to a 
processes.  (We kill processes.  We don't have a kill for network connections 
or for files in the filesystem that are no longer associated with any 
process.  This is theoretically existing problem, by the way.  Check out 
SO_LINGER in man 7 socket...)

There are a number of interesting "no process involved" cases, actually.  Do 
an asynchronous sendfile from one file to another and the disk fills up; who 
do you report the error to?  And if you do a sendfile from one network socket 
to another, both of which are outbound connections to the internet, then how 
do you interrupt it later if those other systems decide to keep talking 
through your system for two days?

Possibly the rule would have to be that a filehandle must remain open in SOME 
process context somewhere, or it gets closed (even if it was in the middle of 
an asynchronous sendfile).  That would make sense, really; that's how we 
handle incoming data from a network connection when the process in question 
exits.  We don't care that the datastream had data in transit, coming from 
the network into the receive buffer.  It go bye-bye when the last process 
that had it open closes it, and the in-flight data is discarded.

That sounds like a workable semantic to me.  Opinions?


It might even be possible for other I/O on the filehandle to block until the 
async sendfile finishes, but that's getting a bit fancy in the absence of 
known real world use cases asking for that feature.  It would let you add in 
something like SIGIO to let you know when you need to close the filehandle 
and get any error code (like "disk full" or whatever).  But I'd probably hold 
off on that until somebody actually came up with a real world use case for 
it.

> I guess async sendfile is bad idea after all.

Well, one thread per sendfile does smell a little bit like the java way of 
doing things, but synchronous sendfile is the 90% solution.  I can always 
make my own wrapper to do the fork() and an atexit() hook to detach and 
daemonify if I really care.  The kernel doesn't really have to do this for 
me.  And since 2.6 already has some infrastructure to group threads so ps 
doesn't look so terrible...

My opinion is that a synchronous sendfile that works in a generic context 
would be an improvement over what's there now, and something I actually have 
a couple existing uses for.  Cleaning it up to work async can remain a to-do 
item for later (including working out under what circumstances, if any, it 
might be a good idea).

Low hanging fruit, and all that.

> 								Pavel

Rob

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

