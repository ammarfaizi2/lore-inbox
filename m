Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUDSDFm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 23:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUDSDFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 23:05:42 -0400
Received: from mail.shareable.org ([81.29.64.88]:56995 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264257AbUDSDFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 23:05:34 -0400
Date: Mon, 19 Apr 2004 04:04:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric <eric@cisu.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Process Creation Speed
Message-ID: <20040419030456.GA11717@mail.shareable.org>
References: <200404170219.i3H2JYal007333@localhost.localdomain> <200404180044.02850.eric@cisu.net> <20040419003026.GC11064@mail.shareable.org> <200404182115.20922.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404182115.20922.eric@cisu.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> > Wrong explanation.  CGI does not "read from disk each time".  Files,
> > including executables, are cached in RAM.  Platter speed is irrelevant
> > unless your server is overloaded, which this one plainly isn't.
>
> Ok ok my explanation is a bit off. But you;re still looking in the
> wrong place. 100ms isn't that long, and by just tweaking this you
> won't achieve with regular CGI what fastCGI does.

That's true: FastCGI is a good solution, as are mod_perl and similar.

But the reasons you give for it are bogus.

> And what happens when your CGI is removed from disk cache due to a
> spike in requests?  It has to be read again, degrading
> performance. You can't count on an object being is disk cache every
> time if the system isn't under load.

What you miss is that pages being removed from the cache affects
FastCGI and CGI identically.

_Parts_ of a CGI image will be removed from memory if there is paging
pressure due to other requests (not for this CGI).  The whole file is
not dropped out in one go, but individual pages are.  If it isn't used
for a long time, it may all go.

Exactly the same thing happens to a long-running FastCGI process:
individual pages are dropped under memory pressure, when those pages
aren't currently being used.  This occurs even though the FastCGI
process lasts over multiple requests.

File paging is determined by the pattern in which pages are actually
being used at any time, and has very little to do with whether pages
are part of a running process.

> What about filesystems that use access timestamps? This will
> have to be written to the disk every time the application is run, so
> under some circumstances just being in disk cache isn't enough.

No: the timestamp is written to disk later, asynchronously, and if
there are many requests which update the timestamp it will still only
be written once per update period (30 seconds or so on ext2, 5 seconds
on ext3 I think).  It's very unlikely to affect response time.

Note that static pages (served directly by the webserver) also update
the access timestamp: the effect of these is much worse than any CGI
program.  You should use the "noatime" mount option if this is ever a
problem.

> >From http://www.fastcgi.com/devkit/doc/fcgi-perf.htm
> 
> "CGI applications couldn't perform in-memory caching, because they exited 
> after processing just one request. Web server APIs promised to solve this 
> problem. But how effective is the solution?"
> 
> "FastCGI is designed to allow effective in-memory caching. Requests
> are routed from any child process to a FastCGI application
> server. The FastCGI application process maintains an in-memory
> cache."
> 
> Look at these two statements and you will realize that they are
> optimizing memory access patterns too. Normally, even if the file is
> in disk cache it will still have to get copied to an area that the
> webserver child process can work with. This wastes memory. So if you
> have 100-1000 clients and a 100k CGI application, it may be in disk
> cache once, but parts of it are getting fed to child processes each
> time it needs to be run. How long, or how many clients before it
> gets bumped out of disk cache? Or how about a plain waste of memory
> that could go to more webserver children.

Every one of these claims is technically bogus, even the ones from
fastcgi.com, but the gist is accurate.

They are bogus because CGI programs are able to maintain in-memory
caches as well.  That's what storing data in cache files, database
servers, shared memory, memcached and so forth accomplish.  Also, the
copying you describe is not necessary.  That's why we have mmap().

They are accurate because it is much more complicated to do those
things in single-request CGI than FastCGI (or an equivalent like
mod_perl), and there is no point: writing a persistent server is much
easier than writing a complicated sharing scheme among CGI processes.

Probably the biggest speedup in practice is when people write CGI
programs in scripting languages, or with complex libraries, which
incurs a huge initialisation cost for each request.  The
initialisation doesn't occur with every request when using FastCGI.
That tends to make the difference between 0.5 requests per second and
100 requests per second.  It's a shame you didn't mention that :)

> "With multi-threading you run an application process that is
> designed to handle several requests at the same time. The threads
> handling concurrent requests share process memory, so they all have
> access to the same cache.  Multi-threaded programming is complex --
> concurrency makes programs difficult to test and debug -- but with
> FastCGI you can write single threaded or multithreaded
> applications."
>
> Moreover they can turn a normal application into a (pseudo)threaded 
> application which has significant benefits for SMP systems as well as a 
> system that just handles many concurrent connections.

True, although sometimes you find that forked applications run faster
than threaded, especially on SMP.

> If you want CGI to perform faster, you will need a solution like FastCGI, or 
> to rewrite your webserver's CGI APIs. If you want information on howto 
> optimize CGI, post on your webserver's mailing list or fastCGI lists, there 
> is no need to toy with the kernel. IMHO this is a userspace issue.
> [...]
> I would benchmark the server under both kernels. Also remember there
> are different scheduler algorithms and VM tunables. Check the
> Documentation folder in the kernel source. However, I have never
> tweaked those for a webserver so someone else would have to
> recommend a good setup for a webserver.

With all of this I agree.  Especially that it's a userspace issue.

Fwiw, all good webservers have built-in capabilities for persistent
CGI-handling processes, more or less equivalent to FastCGI.  You said
that FastCGI requires a process to be created for every request.  I
thought this wasn't true, as the protocol doesn't require it, but if
it is true that's a large overhead, as 7.5ms per request is
significant, and that would be a reason to _not_ use FastCGI and use
the web server's built-in capabilities instead.

None of this answers the question which is relevant to linux-kernel:
why does process creation take 7.5ms and fail to scale with CPU
internal clock speed over a factor of 4 (600MHz x86 to 2.2GHz x86).

Perhaps it is because we still don't have shared page tables.
That would be the most likely dominant overhead of fork().

Alternatively, the original poster may have included program
initialisation time in the 7.5ms, and that could be substantial if
there are many complex libraries being loaded.

-- Jamie
