Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265729AbUFSDFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUFSDFg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 23:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUFSDFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 23:05:36 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:51664 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265729AbUFSDFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 23:05:24 -0400
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ak@suse.de, bcasavan@sgi.com
Content-Type: text/plain
Organization: 
Message-Id: <1087605785.8188.834.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Jun 2004 20:43:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> Brent Casavant writes:

>> On 2.6 based systems, the top command utilizes /proc/[pid]/wchan to
>> determine WCHAN symbol name information.  This information is provided
>> by the kernel function kallsyms_lookup(), which expands a stem-compressed
>
> That sounds more like a bug in your top to me. /proc/*/wchan itself
> does not access kallsyms, it just outputs a number. 
>
> My top doesn't do that.

To get a working WCHAN column on a 2.6.xx kernel, your top
must do that. You also must have CONFIG_KALLSYMS enabled.

> Are you saying your top reads /proc/kallsyms on each redisplay? 
> That sounds completely wrong - it should only read the file once
> and cache it and then look the numbers it is reading from wchan
> in the cache.
>
> Doing the cache in the kernel is the wrong place. This should be fixed
> in user space.

No way, because:

1. kernel modules may be loaded or unloaded at any time
2. the /proc/*/wchan files don't provide both name and address

I'd be happy to make top (and the rest of procps) use a cache
if those problems were addressed. I need a signal sent on
module load/unload, or a real /proc/kallsyms st_mtime that I
can poll. I also need to have the numeric wchan address in
the /proc/*/wchan file, such that it is reliably the same
thing as the function name already found there.

Jesse Barnes writes:

> /proc/<pid>/wchan reports the function name as a string.
> You're arguing that doing that in the kernel is the wrong
> thing to do, right?  If so, it would make sense to change
> its behavior.  Either way, I guess we can fix top to use
> /proc/<pid>/stat instead, and lookup symbols in an external
> System.map file.

This is exactly what top does when /proc/*/wchan is missing.
It does not work well, due to kernel modules, and also due
to the inability to reliably determine if a System.map file
matches the currently running kernel. Also, simply parsing
that file is slow due to the size of it.

Brent Casavant also writes:

> The cache size of 32 items was chosen experimentally.  16 was
> too few to cache all the results on even a small system with
> approximatley 100 tasks, and 64 was too large for all but the
> most extreme cases.

I found that you need about 64 when using a simple hash,
but going to 256 is really cheap so why not? The old procps
symbol cache code (now unused) worked well. I notice that
you are scanning an array for ranges; it is better to hash
on exact address matches. Also, failures get cached and no
attempt was made to keep multiple items in a hash bucket.

Here it is. The rest of the code should be obvious.

typedef struct symb {
  const char *name;
  unsigned KLONG addr;
} symb;
...
static const symb fail = { "?", 0 };
...
static symb hashtable[256];
...
hash = (address >> 4) & 0xff;

> Further work obviously needs to be done for top itself to reduce CPU
> utilization even further, but this is a large first step.  Some quick
> experiments indicate that the slow path has now moved to other areas
> of code, which will be addressed in due course.

Jim and I have already used profilers on top. He mostly used
gprof. I mostly used gcc's ability to call some custom code on
function entry and exit, counting either the function calls or
the CPU cycles they consumed. So, lots of luck to you, but...

(eh, this assumes you're using the all-new top in procps 3.x.x)

If you want things fast, provide the DWARF2 debug info
needed to make use of /dev/mem.  >:-)  The LKCD project
might have a patch for this; they were converting from
STABS to DWARF2 last I heard.

Brent Casavant later writes:

> Hmm.  procps version 3.1.3 introduced the use of /proc/*/wchan
> where possible.  I'm using 2.0.13 normally, which appears to
> have the same behavior (can't find a changelong for the 2
> series at the moment).

Oh. Well. There's your problem. The procps-3.x.x code will only
read /proc/*/wchan for the processes shown on your screen.
It also doesn't corrupt wchan with a buffer overflow.


