Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317316AbSGTCJN>; Fri, 19 Jul 2002 22:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSGTCJN>; Fri, 19 Jul 2002 22:09:13 -0400
Received: from [209.184.141.189] ([209.184.141.189]:62767 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317316AbSGTCJL>;
	Fri, 19 Jul 2002 22:09:11 -0400
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
From: Austin Gonyou <austin@digitalroadkill.net>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020719190452.H28941@sventech.com>
References: <20020719163350.D28941@sventech.com>
	 <20020719135225.A4048@greenhydrant.com>
	 <20020719170359.E28941@sventech.com> <1027117945.7776.11.camel@UberGeek>
	  <20020719190452.H28941@sventech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 19 Jul 2002 21:12:09 -0500
Message-Id: <1027131129.8681.29.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 18:04, Johannes Erdfelt wrote:
> On Fri, Jul 19, 2002, Austin Gonyou <austin@digitalroadkill.net> wrote:
> > On Fri, 2002-07-19 at 16:03, Johannes Erdfelt wrote:
> > > Web server. The only writing is for the log files, which is relatively
> > > minimal.
> > 
> > But IMHO, you are using prefork, and not a threaded model correct?
> 
> Yes, it's a prefork.
OK. 

> > Also, here, even as a DSO, which I think you may not be running PHP as,
> > (cgi vs. dso), you will use a bit of memory, on top of apache, every
> > time the new child is created by apache to handle incoming requests.
> 
> Use both, but for legacy reasons there's still a signficant amount of
> children being forked for the CGI like version (caused by SSI).

Right I understand this fully. 


> The memory size for these children is about 40MB (which is strange in
> itself), and a couple per second get executed. However, they are very
> quick and typically won't see any in ps, but occassionally 1 or 2 will
> be seen.

It "is" a little odd, but that's correct for apache. We see about the
same here. 

> > > The systems running an older kernel (like RedHat's 2.4.9-21) are much
> > > more consistent in their usage of memory. There are no 150MB swings in
> > > cache utiliziation, etc.
> > 
> > Hrrmmm....I'd suggest a 2.4.17 or 2.4.19-rc1-aa2 in that case. I promise
> > you'll see drastic improvements over that kernel.
> 
> 2.4.17 wasn't good last time I tried it, but I've have much better results
> from Andrea's patches. I'll create 2.4.19-rc1-aa2 kernel and see how
> that fares.

Only reason I suggested that was because 2.4.17+aa patches has been good
to me. I'm just stuck on aa I guess...but for most applications I've run
and all our hardware, Dell and otherwise, it works the best so far. 

> > > What's really odd in the vmstat output is the fact that there is no disk
...
> > > from? Or is the accounting just wrong?
> > 
> > I think the accounting is quite correct. Let's look real quick. 
> 
> I suspect it's correct as well, but that doesn't mean something else
> isn't wrong :)
> 
Right....it very well could. 
...
> > 
> > Notice you're memory utilization jumps here as your free is given to
> > cache.
> 
> Are you saying that the cache value is the amount of memory available to
> be used by the cache, or actually used by the cache?
> 
> It was my understanding that it's the memory actually used by the cache.
> If that's the case, I don't understand where the data to fill the cache
> is coming from with these blips.

I think what's happening here, possibly a vmstat thing or not, I'm not
sure, is that the memory is allocated as part of the cost for starting
the new processes, and then while the processes is "running" that memory
is considered cache, then is freed once the process goes away because
Apache deallocates it.(I'm guessing, but that seems to be the order for
what I know of the apache httpd spawn process)


> > <vmstat3>
> > > > >  0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
> > > > >  0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14 
> > </vmstat3>
> > 
> > And then back again, probably on process termination.
> 
> There are couple per second of those processes, so I would expect this
> to happen all of the time or atleast much more often.
> 
> > At that rate, it's all in-memory shuffling going on, and for preforks,
> > that very likely is the case.
> 
> One thing to note as well is a significant amount of system time spent
> during these situations as well. It looks like a lot of time is spent
> managing something.
> 
> It's obvious the workload is inefficient, but it's constantly
> inefficient which is why these blips are strange.
> 

Ahh..I know what you're referring to. If you look you'll see that it's
in system. Hrrmm..we see that here too, but in specific network
topologies. Ours, "i think" we can trace to the logs which we write, but
some systems do it and others don't. Our production systems, which run
the same kernels as our test boxen, don't ever see the behaviour you're
seeing. That is odd. 

Well one thing I can offer is that our processes during the periods of
high system usage are usually just a lot, and hadn't flushed to the disk
yet(the logs) but there's lots of memory in cache during that time until
everything gets cleared out. Maybe this is something similar? Just
curious. 

> JE
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
