Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUHFQgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUHFQgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUHFQeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:34:23 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:27808 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268171AbUHFQdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:33:45 -0400
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
From: Albert Cahalan <albert@users.sf.net>
To: Roger Luethi <rl@hellgate.ch>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040806120123.GA23081@k3.hellgate.ch>
References: <1091754711.1231.2388.camel@cube>
	 <20040806094037.GB11358@k3.hellgate.ch>
	 <20040806104630.GA17188@holomorphy.com>
	 <20040806120123.GA23081@k3.hellgate.ch>
Content-Type: text/plain
Organization: 
Message-Id: <1091800948.1231.2454.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2004 10:02:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi writes:
> On Fri, 06 Aug 2004 05:11:18 -0700, William Lee Irwin III wrote:

>> Some of the 2.4 semantics just don't make sense. I would not find it
>> difficult to explain what I believe correct semantics to be in a written
>> document.
>
> IMO this is a must for such files (and be it only some comments above
> the code implementing them). I'm afraid that statm is carrying too much
> historical baggage, though -- you would add yet another interpretation
> of those 7 fields.
>
> Tools reading statm would have to be updated anyway, so I'd rather
> think about what could be done with a new (or just different) file.

Even if the existing fields are indeed mostly junk, you can always
add new fields to the end.

> For sysfs we have guidelines (e.g. sysfs.txt: "Attributes should be ASCII
> text files, preferably with only one value per file. It is noted that it
> may not be efficient to contain only value per file, so it is socially
> acceptable to express an array of values of the same type.").

This is being lost. PCI ROM data isn't ASCII unless you use hex.

> I'm not aware of anything comparable for proc, so it's hard to say
> what a good solution would look like. Files like /proc/pid/status
> are human-readable and maintenance-friendly (the parser can recognize
> unknown values and gets a free label along with it; obsolete fields can
> be removed).

If you're just spewing the values with a perl script, sure.
I'm not sure this matters.

Normal C programs don't work that way. Unknown values are useless.
What am I supposed to do with an unknown value? I can't even tell
what data type it is. Maybe 12345 is really a string. I'm going
to rely on the values I need, so you can't freely delete things.
If I didn't need the values, I wouldn't read the file at all.

> The downside is the performance aspect you pointed out:
> Reading that file for every process just to grep for one or two values
> is slow, and some of the unused data items might be expensive for the
> kernel to produce in the first place.

You're using grep??? That's a script then. You can tolerate
getting your info from "ps" output. It's not a performance
issue for you. For ps, performance is a problem. Thus ps must
get priority in the design of /proc files.

You can do this:

ps -eo pid= -o comm= | grep '[f]oo' | ...

Heck, it's even portable!

> It seems that most new information of interest is being added to
> /proc/pid/status and friends these days. Are there any plans to
> accomodate tool authors who are interested in additional information
> but are wary of the increasing costs of these files?

> A light-weight interface for tools could work like this (ugly):
>
> $ cat /proc/pid.provided
> Name SleepAVG Pid Tgid PPid VmSize VmLck VmData [...]
> $ cat /proc/10235/VmSize.VmData
> 3380 144

It's hard to imagine parsing that. I suppose I'm expected to
dynamicly create a sscanf format using the numbered-parameter
notation? Maybe I have to fill a table with pointers to... Ugh.

If it's going to be this dynamic, then just give me DWARF2 debug
info and the raw data. Like this:

/proc/DWARF2
/proc/1000/mm_struct
/proc/1000/signal_struct
/proc/1000/sighand_struct
/proc/1000/task/1024/thread_info
/proc/1000/task/1024/task_struct
/proc/1000/task/1024/fs_struct

> Or use netlink maybe? It sure would be nice to monitor all processes
> with lower overhead, and to have tools that can deal with new data
> items without an update.

I've been thinking netlink might be good.

> I am also interested in a related problem -- finding a better way for
> tools to access process information. Preferably a generic way so we
> don't need to keep tools and kernel in sync forever. I have some ideas,
> but I don't know if they are acceptable as solutions (and if the problem
> actually exists as I see it).

Look at other systems. FreeBSD, AIX, and Solaris all have
superior ways of getting process data. Being compatible, at
least for the basic info, would be good.

FreeBSD: binary sysctl data with built-in process selection
AIX:     dedicated syscall, somewhat resembling directory reads
Solaris: binary /proc, including arrays for per-thread data

Somebody can research Tru64, HP-UX, MacOS X, and IRIX.

> Most of the current problems with proc are related to tools: They don't
> like changes and some of them are very sensitive to resource usage
> (because they may make hundreds of calls per second on typical systems).

Make that 2000 /proc reads per second or more. This is too slow.
I need to read about 1 million /proc files per second.

> If we want to facilitate the use of additional information in tools,
> I see two possible strategies:
>
> - Design a new solution that enables tools to discover the fields
>   that are available and to ask for a subset (as I sketched out in my
>   previous post). This would remove the need for inflexible solutions
>   like statm.

That's useless.

If I didn't need the data, I wouldn't be trying to read it.
If I haven't written code to use new data, I sure won't be
caring to know the name of the new data.

> - Split proc information by new criteria: Slow, expensive items should
>   not be in the same file as information that tools typically
>   and frequently read. For instance, you could have status_basic,
>   status_exotic, and status_slow. Even status_basic could have a format
>   similar to /proc/pid/status, but would be shorter and contain only
>   the most frequently used values (like statm today -- with all the
>   problems that come with such a pre-made selection).

Split by:
1. locking
2. security.



