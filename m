Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267954AbTBVW6N>; Sat, 22 Feb 2003 17:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267955AbTBVW6N>; Sat, 22 Feb 2003 17:58:13 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:64439 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S267954AbTBVW6J>; Sat, 22 Feb 2003 17:58:09 -0500
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
From: Albert Cahalan <albert@users.sf.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>, procps-list@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030222135507.5f539bba.akpm@digeo.com>
References: <Pine.LNX.4.44.0302201818060.32324-100000@localhost.localdomain>
	<1045947170.19445.57.camel@cube>  <20030222135507.5f539bba.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Feb 2003 18:04:32 -0500
Message-Id: <1045955073.19444.126.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 16:55, Andrew Morton wrote:
> Albert Cahalan <albert@users.sourceforge.net> wrote:

>> Note that the recent /proc/*/wchan addition was botched.
>> Caching is prevented due to race conditions. This could
>> be fixed by changing the file format to contain:
>>     number, function name
>
> There is not enough detail here for it to be fixed.
>
> What are the race conditions?
>
> What is "number"?

By "number" I mean the numeric wchan. ("ps -o nwchan")
This value is provided in the /proc/*/stat files.

Most tools are stuck reading /proc/*/stat most of
the time. So the nwchan value is being read already.
You can't cache a mapping from nwchan to wchan,
because the values may change from the time you
read /proc/*/stat to the time you read /proc/*/wchan.
This forces reading /proc/*/wchan, even though top
has already seen the same value before and already
has the numeric version of it.

One more thing is needed. There should be a counter,
incremented every time a module is loaded or unloaded.
This allows the cache to be invalidated as needed.
I suppose /proc/stat is a decent place for the counter,
either at the end (safest) or right before intr.

Caching makes a major difference for wchan. Look how
few values are seen: ps -eonwchan= | sort -u | wc -l

Since the current /proc/*/wchan format isn't yet in
a stable kernel release, breaking the format wouldn't
be too bad. I like "%08x %s \n" and "%016lx %s \n"
(note the space on the end) for a nice fast parser and
ease of adding more fields. If you have something against
that space, then "%s %08x\n" and "%s %016lx\n" would do.

Any thoughts on the other stuff? Different modules
and files could have functions with the same name.
Maybe some info about this should be available, at
least if it doesn't slow things down much.


