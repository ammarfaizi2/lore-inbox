Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbVL1GNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbVL1GNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVL1GNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:13:34 -0500
Received: from hera.kernel.org ([140.211.167.34]:50817 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932484AbVL1GNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:13:33 -0500
Date: Tue, 27 Dec 2005 23:33:25 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Badari Pulavarty <pbadari@us.ibm.com>, fche@redhat.com
Cc: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
       systemtap@sources.redhat.com
Subject: Re: Better pagecache statistics ?
Message-ID: <20051228013325.GA4144@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain> <20051201152029.GA14499@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201152029.GA14499@dmt.cnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Badari, any improvements on the {add_to,remove_from}_page_cache hooks?

> I just started playing with SystemTap yesterday. First
> thing I want to record is "what is the latency of 
> direct reclaim".

I've come up with something which works, though pretty dumb and
inefficient.

I'm facing three problems, maybe someone has a clue on how to improve 
the situation.

a) nanosecond timekeeping 

Since the systemtap language does not support "struct" abstraction, but
simply "long/string/array" types, there is no way to easily return more
than one value from a function. Is it possible to pass references down
to functions so as to return more than one value? 

I failed to find any way to do that.

For nanosecond timekeeping one needs second/nanosecond tuple (struct
timespec).

b) ERROR: MAXACTION exceeded near identifier 'log' at ttfp_delay.stp:49:3

The array size is capped to a maximum. Is there any way to configure
SystemTap to periodically dump-and-zero the arrays? This makes lots of
sense to any statistical gathering code.

c) Hash tables

It would be better to store the log entries in a hash table, the present
script uses the "current" pointer as a key into a pair of arrays,
incrementing the key until a free one is found (which can be very
inefficient).

A hash table would be much more efficient, but allocating memory inside
the scripts is tricky. A pre-allocated, pre-sized pool of memory could 
work well for this purpose. The "dump-array-entries-to-userspace" action
could be used to free them.

So both b) and c) could be fixed with the same logic:

- dump entries to userspace if memory pool is getting short 
on free entries.
- periodically dump entries to userspace (akin to "bdflush").

And finally, there seems to be a bug which results in _very_ large
(several seconds) delays - that seems unlikely to really happening.

Thoughts?

/* 
 * ttfp_delay - measure direct reclaim latency 
 */

global count_try_to_free_pages
global count_exit_try_to_free_pages

global entry_array_us
global exit_array_us

global entry_array_ms
global exit_array_ms

function get_currentpointer:long () %{
	THIS->__retvalue = (int) current;
%}

probe kernel.function("try_to_free_pages")
{
	current_p = get_currentpointer();
	++count_try_to_free_pages;
	while (entry_array_us[current_p])
		++current_p;

	entry_array_us[current_p] = gettimeofday_us();
	entry_array_ms[current_p] = gettimeofday_ms();
}

probe kernel.function("try_to_free_pages").return
{
	current_p = get_currentpointer();
	++count_exit_try_to_free_pages;
	while (exit_array_us[current_p])
		++current_p;

	exit_array_us[current_p] = gettimeofday_us();
	exit_array_ms[current_p] = gettimeofday_ms();
}

probe begin { log("starting probe") }

probe end
{
	log("ending probe")
	log ("calls to try_to_free_pages: " . string(count_try_to_free_pages));
	log ("returns from try_to_free_pages: " . string(count_exit_try_to_free_pages));
	foreach(var in entry_array_us) {
		pos++;
		log ("try_to_free_pages (" . string(pos) .  ") delta: " . string(exit_array_us[var] - entry_array_us[var]) . "us " .string (exit_array_ms[var] - entry_array_ms[var]) . "ms ");
	}

}


example output, running a 800MB "dd" copy on the background.

[root@dmt examples]# stap -g ttfp_delay.stp 
starting probe
ending probe
calls to try_to_free_pages: 387
returns from try_to_free_pages: 373
try_to_free_pages (1) delta: 15028us 15ms 
try_to_free_pages (2) delta: 47677211us 47677ms 
try_to_free_pages (3) delta: 39us 0ms 
try_to_free_pages (4) delta: 35us 0ms 
try_to_free_pages (5) delta: 152us 0ms 
try_to_free_pages (6) delta: 104us 0ms 
try_to_free_pages (7) delta: 353us 0ms 
try_to_free_pages (8) delta: 61us 0ms 
try_to_free_pages (9) delta: 187us 0ms 
try_to_free_pages (10) delta: 55us 0ms 
try_to_free_pages (11) delta: 50us 0ms 
try_to_free_pages (12) delta: 30us 0ms 
try_to_free_pages (13) delta: 31us 0ms 
try_to_free_pages (14) delta: 42us 0ms 
try_to_free_pages (15) delta: 37us 0ms 
try_to_free_pages (16) delta: 178us 0ms 
try_to_free_pages (17) delta: 34us 0ms 
try_to_free_pages (18) delta: 37us 0ms 
try_to_free_pages (19) delta: 35us 0ms 
try_to_free_pages (20) delta: 34us 0ms 
try_to_free_pages (21) delta: 65us 0ms 
...

