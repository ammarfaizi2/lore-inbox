Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUHFRO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUHFRO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268221AbUHFRLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:11:24 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:12173 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S268199AbUHFRJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:09:25 -0400
Date: Fri, 6 Aug 2004 19:08:32 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
Message-ID: <20040806170832.GA898@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <1091754711.1231.2388.camel@cube> <20040806094037.GB11358@k3.hellgate.ch> <20040806104630.GA17188@holomorphy.com> <20040806120123.GA23081@k3.hellgate.ch> <1091800948.1231.2454.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091800948.1231.2454.camel@cube>
X-Operating-System: Linux 2.6.8-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Aug 2004 10:02:28 -0400, Albert Cahalan wrote:
> > Tools reading statm would have to be updated anyway, so I'd rather
> > think about what could be done with a new (or just different) file.
> 
> Even if the existing fields are indeed mostly junk, you can always
> add new fields to the end.

I don't like it, but it is a possible solution. It only works for tools
reading proc, though. Humans don't parse such files well.

> > what a good solution would look like. Files like /proc/pid/status
> > are human-readable and maintenance-friendly (the parser can recognize
> > unknown values and gets a free label along with it; obsolete fields can
> > be removed).
> 
> If you're just spewing the values with a perl script, sure.
> I'm not sure this matters.

It matters to me. I like to have tools that don't need updates to
cope with new fields. Having to wait for tool authors to catch up with
kernels is annoying.

> Normal C programs don't work that way. Unknown values are useless.
> What am I supposed to do with an unknown value? I can't even tell
> what data type it is. Maybe 12345 is really a string. I'm going

You could e.g. restrict automatic fields to long. There are other
solutions possible.

> to rely on the values I need, so you can't freely delete things.
> If I didn't need the values, I wouldn't read the file at all.

Not all programs work like that.

> > The downside is the performance aspect you pointed out:
> > Reading that file for every process just to grep for one or two values
> > is slow, and some of the unused data items might be expensive for the
> > kernel to produce in the first place.
> 
> You're using grep??? That's a script then. You can tolerate

No. s/grep/look for/

> getting your info from "ps" output. It's not a performance
> issue for you. For ps, performance is a problem. Thus ps must
> get priority in the design of /proc files.

ps can get priority in statm for all I care. I am interested in other
files and mechanisms.

> > A light-weight interface for tools could work like this (ugly):
> >
> > $ cat /proc/pid.provided
> > Name SleepAVG Pid Tgid PPid VmSize VmLck VmData [...]
> > $ cat /proc/10235/VmSize.VmData
> > 3380 144
> 
> It's hard to imagine parsing that. I suppose I'm expected to
> dynamicly create a sscanf format using the numbered-parameter
> notation? Maybe I have to fill a table with pointers to... Ugh.

The interface was just to illustrate the kind of functionality I'm
considering. It's ugly, but it's not that hard to use, either.

> If it's going to be this dynamic, then just give me DWARF2 debug
> info and the raw data. Like this:
> 
> /proc/DWARF2
> /proc/1000/mm_struct
> /proc/1000/signal_struct
> /proc/1000/sighand_struct
> /proc/1000/task/1024/thread_info
> /proc/1000/task/1024/task_struct
> /proc/1000/task/1024/fs_struct

That's different. The overhead would be prohibitive. Also, this exposes
internal kernel structures.

> > Or use netlink maybe? It sure would be nice to monitor all processes
> > with lower overhead, and to have tools that can deal with new data
> > items without an update.
> 
> I've been thinking netlink might be good.

Alright. Maybe we can move our discussion into this direction?

> > I am also interested in a related problem -- finding a better way for
> > tools to access process information. Preferably a generic way so we
> > don't need to keep tools and kernel in sync forever. I have some ideas,
> > but I don't know if they are acceptable as solutions (and if the problem
> > actually exists as I see it).
> 
> Look at other systems. FreeBSD, AIX, and Solaris all have
> superior ways of getting process data. Being compatible, at
> least for the basic info, would be good.

Quite frankly, in this area I care more about good than about compatible.

> FreeBSD: binary sysctl data with built-in process selection
> AIX:     dedicated syscall, somewhat resembling directory reads
> Solaris: binary /proc, including arrays for per-thread data
> 
> Somebody can research Tru64, HP-UX, MacOS X, and IRIX.
> 

> > Most of the current problems with proc are related to tools: They don't
> > like changes and some of them are very sensitive to resource usage
> > (because they may make hundreds of calls per second on typical systems).
> 
> Make that 2000 /proc reads per second or more. This is too slow.
> I need to read about 1 million /proc files per second.

Depends on your definition of typical. Obviously, it grows with the
number of processes and time resolution.

> > If we want to facilitate the use of additional information in tools,
> > I see two possible strategies:
> >
> > - Design a new solution that enables tools to discover the fields
> >   that are available and to ask for a subset (as I sketched out in my
> >   previous post). This would remove the need for inflexible solutions
> >   like statm.
> 
> That's useless.

Your opinion has been duly noted.

> If I didn't need the data, I wouldn't be trying to read it.
> If I haven't written code to use new data, I sure won't be
> caring to know the name of the new data.
> 
> > - Split proc information by new criteria: Slow, expensive items should
> >   not be in the same file as information that tools typically
> >   and frequently read. For instance, you could have status_basic,
> >   status_exotic, and status_slow. Even status_basic could have a format
> >   similar to /proc/pid/status, but would be shorter and contain only
> >   the most frequently used values (like statm today -- with all the
> >   problems that come with such a pre-made selection).
> 
> Split by:
> 1. locking
> 2. security.

Hmmm... How does this translate to a netlink interface? Can you elaborate?

Roger
