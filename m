Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbUDSCOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 22:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbUDSCOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 22:14:45 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:17128 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264242AbUDSCOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 22:14:40 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: Process Creation Speed
Date: Sun, 18 Apr 2004 21:15:20 -0500
User-Agent: KMail/1.6.1
References: <200404170219.i3H2JYal007333@localhost.localdomain> <200404180044.02850.eric@cisu.net> <20040419003026.GC11064@mail.shareable.org>
In-Reply-To: <20040419003026.GC11064@mail.shareable.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404182115.20922.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 April 2004 19:30, you wrote:
> Eric wrote:
> > > It matters to me because the Common Gateway Interface spawns and
> > > destroys a process to handle each request, and I wish it were just
> > > fast, rather than having to use FastCGI.
> >
> > 	The difference in speed between regular and FastCGI shouldnt
> > be related to process creation time. The speed up you see from
> > FastCGI is because it doesn't have to be read from disk each
> > time. So, you're really looking for performace enhancements in the
> > wrong place. Tweaking process creation can't make your platters spin
> > faster.
>
> Wrong explanation.  CGI does not "read from disk each time".  Files,
> including executables, are cached in RAM.  Platter speed is irrelevant
> unless your server is overloaded, which this one plainly isn't.
Ok ok my explanation is a bit off. But you;re still looking in the wrong 
place. 100ms isn't that long, and by just tweaking this you won't achieve 
with regular CGI what fastCGI does. And what happens when your CGI is removed 
from disk cache due to a spike in requests? It has to be read again, 
degrading performance. You can't count on an object being is disk cache every 
time if the system isn't under load. What about filesystems that use access 
timestamps? This will have to be written to the disk every time the 
application is run, so under some circumstances just being in disk cache 
isn't enough.

>From http://www.fastcgi.com/devkit/doc/fcgi-perf.htm

"CGI applications couldn't perform in-memory caching, because they exited 
after processing just one request. Web server APIs promised to solve this 
problem. But how effective is the solution?"

"FastCGI is designed to allow effective in-memory caching. Requests are routed 
from any child process to a FastCGI application server. The FastCGI 
application process maintains an in-memory cache."

Look at these two statements and you will realize that they are optimizing 
memory access patterns too. Normally, even if the file is in disk cache it 
will still have to get copied to an area that the webserver child process can 
work with. This wastes memory. So if you have 100-1000 clients and a 100k CGI 
application, it may be in disk cache once, but parts of it are getting fed to 
child processes each time it needs to be run. How long, or how many clients 
before it gets bumped out of disk cache? Or how about a plain waste of memory 
that could go to more webserver children. 

"With multi-threading you run an application process that is designed to 
handle several requests at the same time. The threads handling concurrent 
requests share process memory, so they all have access to the same cache. 
Multi-threaded programming is complex -- concurrency makes programs difficult 
to test and debug -- but with FastCGI you can write single threaded or 
multithreaded applications."

Moreover they can turn a normal application into a (pseudo)threaded 
application which has significant benefits for SMP systems as well as a 
system that just handles many concurrent connections.


IMHO, the problem still isn't related to creation time, but is an inherit 
problem of the webserver's API's. Furthermore, if I read correctly, fastCGI 
still has to spawn a child process each time a request comes in, so even if 
you tuned process creation time, fastCGI would STILL be faster. Look at it 
mathematically. Say the time it takes for fastCGI to run a CGI(F) is 10 
units. A regular server CGI implementation(C) is 100. If you shorten process 
creation time by five units(S) then C-S > F-S ALWAYS, you just would be 
helping both implementations by the SAME AMOUNT.

If you want CGI to perform faster, you will need a solution like FastCGI, or 
to rewrite your webserver's CGI APIs. If you want information on howto 
optimize CGI, post on your webserver's mailing list or fastCGI lists, there 
is no need to toy with the kernel. IMHO this is a userspace issue.

To answer your other question, 2.6 should perform better in a webserver 
application because of improvements to the VM system and the scheduler, but 
not directly because of shortend process creation time(if it was even 
shortened in 2.6). I would benchmark the server under both kernels. Also 
remember there are different scheduler algorithms and VM tunables. Check the 
Documentation folder in the kernel source. However, I have never tweaked 
those for a webserver so someone else would have to recommend a good setup 
for a webserver. 

Anyone feel free to correct me if Im wrong on some parts. Sorry for the 
longwinded reply but I could use a good refresher on this. 
--Eric Bambach
