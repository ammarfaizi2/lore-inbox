Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUDSFmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 01:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUDSFmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 01:42:35 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:54407 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S262963AbUDSFma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 01:42:30 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: Process Creation Speed
Date: Mon, 19 Apr 2004 00:43:04 -0500
User-Agent: KMail/1.6.1
References: <200404170219.i3H2JYal007333@localhost.localdomain> <200404182115.20922.eric@cisu.net> <20040419030456.GA11717@mail.shareable.org>
In-Reply-To: <20040419030456.GA11717@mail.shareable.org>
Cc: linux-kernel@vger.kernel.org, "Stephan T. Lavavej" <stl@nuwen.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404190043.04358.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 April 2004 22:04, you wrote:
> Eric wrote:
> > > Wrong explanation.  CGI does not "read from disk each time".  Files,
> > > including executables, are cached in RAM.  Platter speed is irrelevant
> > > unless your server is overloaded, which this one plainly isn't.
> >
> > Ok ok my explanation is a bit off. But you;re still looking in the
> > wrong place. 100ms isn't that long, and by just tweaking this you
> > won't achieve with regular CGI what fastCGI does.
>
> That's true: FastCGI is a good solution, as are mod_perl and similar.
>
> But the reasons you give for it are bogus.


> Every one of these claims is technically bogus, even the ones from
> fastcgi.com, but the gist is accurate.

Ya, I have the gist down, but im by no means an expert programmer (yet), so I 
appreciate your well-thought out and detailed responses instead of just 
flaming or something equally bad.

> They are bogus because CGI programs are able to maintain in-memory
> caches as well.
Across instances and concurrently? It sounds complicated unless you are using 
a persistent server cgi-application....like fastCGI.
> That's what storing data in cache files,
A file is much different than in-memory.
> database servers, shared memory,
Yes, and these would be persistent applications.
> memcached and so forth accomplish.  Also, the 
> copying you describe is not necessary.  That's why we have mmap().

Ok, shot down. Fair enough.

> They are accurate because it is much more complicated to do those
> things in single-request CGI than FastCGI (or an equivalent like
> mod_perl), and there is no point: writing a persistent server is much
> easier than writing a complicated sharing scheme among CGI processes.

Yes, that is what I was going for....just in a sketchy fashion.

> Probably the biggest speedup in practice is when people write CGI
> programs in scripting languages, or with complex libraries, which
> incurs a huge initialisation cost for each request.  The
> initialisation doesn't occur with every request when using FastCGI.
> That tends to make the difference between 0.5 requests per second and
> 100 requests per second.  It's a shame you didn't mention that :)

It is. Now that you mention it, im surprised I didn't think of it. I did some 
research in this area because sysVinit scheme uses huge amounts of scripts 
and the total initialization cost per bootup is probably on the order of 5-15 
seconds depending on machine, etc. etc.... This is the situation that I was 
thinking of, perl, etc.... interpreted languages that have a huge start up 
cost would benefit with fastCGI. There isn't a whole lot you can do with 
regular CGI.

> > "With multi-threading you run an application process that is
> > designed to handle several requests at the same time. The threads
> > handling concurrent requests share process memory, so they all have
> > access to the same cache.  Multi-threaded programming is complex --
> > concurrency makes programs difficult to test and debug -- but with
> > FastCGI you can write single threaded or multithreaded
> > applications."
> >
> > Moreover they can turn a normal application into a (pseudo)threaded
> > application which has significant benefits for SMP systems as well as a
> > system that just handles many concurrent connections.
>
> True, although sometimes you find that forked applications run faster
> than threaded, especially on SMP.

Either way it is still faster. I haven't looked at fastCGI specs, but it seems 
like they were claiming to do some sort of pseudo threading/concurrency for 
performance reasons.

> > If you want CGI to perform faster, you will need a solution like FastCGI,
> > or to rewrite your webserver's CGI APIs. If you want information on howto
> > optimize CGI, post on your webserver's mailing list or fastCGI lists,
> > there is no need to toy with the kernel. IMHO this is a userspace issue.
> > [...]
> > I would benchmark the server under both kernels. Also remember there
> > are different scheduler algorithms and VM tunables. Check the
> > Documentation folder in the kernel source. However, I have never
> > tweaked those for a webserver so someone else would have to
> > recommend a good setup for a webserver.
>
> With all of this I agree.  Especially that it's a userspace issue.

Yep. There isn't a whole lot the kernel can do to help you here.

> Fwiw, all good webservers have built-in capabilities for persistent
> CGI-handling processes, more or less equivalent to FastCGI.  You said
> that FastCGI requires a process to be created for every request.  I
> thought this wasn't true, as the protocol doesn't require it, but if
> it is true that's a large overhead, as 7.5ms per request is
> significant, and that would be a reason to _not_ use FastCGI and use
> the web server's built-in capabilities instead.

Hmmm...lemme look a little more deeply into that. After research I realize 
that I glossed over the fastCGI whitepaper a little too much. 

http://www.fastcgi.com/devkit/doc/fastcgi-whitepaper/fastcgi.htm

"For each request, the server creates a new process and the process 
initializes itself."

Is referring to other CGI implementations and not to itself DOH.

However, just like a normal sever performance will suffer if fastCGI process 
have to be created on demand.

"The Web server creates FastCGI application processes to handle requests. The 
processes may be created at startup, or created on demand."

> None of this answers the question which is relevant to linux-kernel:
> why does process creation take 7.5ms and fail to scale with CPU
> internal clock speed over a factor of 4 (600MHz x86 to 2.2GHz x86).

The reason it doesn't scale is probably because the kernel always runs at a 
specified speed, 100HZ which leaves 10ms(i believe?) timeslices. I would try 
a HZ patch and bump it up to 1000, i bet you would see a big difference then.

> Perhaps it is because we still don't have shared page tables.
> That would be the most likely dominant overhead of fork().
>
> Alternatively, the original poster may have included program
> initialisation time in the 7.5ms, and that could be substantial if
> there are many complex libraries being loaded.

Yea, hopefully Stephan can provide a little more insight into how he obtained 
6.3 ms. 

> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
