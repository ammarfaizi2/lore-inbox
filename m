Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSGSW33>; Fri, 19 Jul 2002 18:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGSW32>; Fri, 19 Jul 2002 18:29:28 -0400
Received: from [209.184.141.189] ([209.184.141.189]:13074 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317117AbSGSW31>;
	Fri, 19 Jul 2002 18:29:27 -0400
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
From: Austin Gonyou <austin@digitalroadkill.net>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020719170359.E28941@sventech.com>
References: <20020719163350.D28941@sventech.com>
	 <20020719135225.A4048@greenhydrant.com>
	  <20020719170359.E28941@sventech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 19 Jul 2002 17:32:25 -0500
Message-Id: <1027117945.7776.11.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-19 at 16:03, Johannes Erdfelt wrote:
> On Fri, Jul 19, 2002, David Rees <dbr@greenhydrant.com> wrote:
> > On Fri, Jul 19, 2002 at 04:33:50PM -0400, Johannes Erdfelt wrote:
> > > I recently upgraded a web server I run to a the 2.4.19rc2aa1 kernel to
> > > see how much better the VM is.
> > > 
> > > It seems to be better than the older 2.4 kernels used on this machine,
> > > but there seems to be lots of motion in the cache for all of the free
> > > memory that exists:
> > > 
> > >    procs                      memory    swap          io     system  cpu
> > >  3  0  0 106036 502288  10812  67236   0   0     0     0  802   494  46  37  17
> > >  5  0  2 106032 476188  10844  91496   0   0     4   316  905   573  54  37   8
> > > 16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
> > > 10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
> > >  0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
> > >  0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14  77
...

> Web server. The only writing is for the log files, which is relatively
> minimal.

But IMHO, you are using prefork, and not a threaded model correct?

> 
> One thing also, is there is lots of process creation in this example.
> For a variety of reasons, PHP programs are forked often from the Apache
> server.

Also, here, even as a DSO, which I think you may not be running PHP as,
(cgi vs. dso), you will use a bit of memory, on top of apache, every
time the new child is created by apache to handle incoming requests.

> The systems running an older kernel (like RedHat's 2.4.9-21) are much
> more consistent in their usage of memory. There are no 150MB swings in
> cache utiliziation, etc.

Hrrmmm....I'd suggest a 2.4.17 or 2.4.19-rc1-aa2 in that case. I promise
you'll see drastic improvements over that kernel.

> What's really odd in the vmstat output is the fact that there is no disk
> I/O that follows these wild swings. Where is this cache memory coming
> from? Or is the accounting just wrong?

I think the accounting is quite correct. Let's look real quick. 

<vmstat>
> > >    procs                      memory    swap          io     system  cpu
> > >  3  0  0 106036 502288  10812  67236   0   0     0     0  802   494  46  37  17
> > >  5  0  2 106032 476188  10844  91496   0   0     4   316  905   573  54  37   8
> > > 16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
> > > 10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
> > >  0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
> > >  0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14 
</vmstat>

Now let's take a closer look....

<vmstat2>
> > > 16  0  2 106032 355400  10844 203880   0   0     4     0  909   540  51  49   0
> > > 10  0  2 106024 340108  10852 221548   0   0    28     0  975   659  36  64   0
</vmstat2>


Notice you're memory utilization jumps here as your free is given to
cache.

<vmstat3>
> > >  0  0  0 106024 528340  10852  43572   0   0     4     0  569   426  17  17  67
> > >  0  1  0 106024 531304  10852  43612   0   0     4     0  542   342   9  14 
</vmstat3>

And then back again, probably on process termination.

At that rate, it's all in-memory shuffling going on, and for preforks,
that very likely is the case.

> JE
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
