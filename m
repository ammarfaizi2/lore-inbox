Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTDEVvZ (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 16:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbTDEVvZ (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 16:51:25 -0500
Received: from almesberger.net ([63.105.73.239]:14606 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262680AbTDEVvX (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 16:51:23 -0500
Date: Sat, 5 Apr 2003 19:02:43 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel@vger.kernel.org, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [RFC/FYI] reliable markers (hooks/probes/taps/...)
Message-ID: <20030405190243.B19288@almesberger.net>
References: <20030403070758.A18709@almesberger.net> <20030404224652.A19288@almesberger.net> <3E8F0DEF.C50FB29C@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8F0DEF.C50FB29C@opersys.com>; from karim@opersys.com on Sat, Apr 05, 2003 at 12:10:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> We've already got a small program that does this for LTT statements
> which we plan to use in the future: genevent.

This looks like a clear improvement, and the markup needed in the
kernel is also pretty straightforward.

But my approach actually goes a bit further: I don't even need to
know types, because I can extract them from debugging information.
Clearly, there is a limit on how useful this is. E.g. if a variable
changes its type from "int" to "struct something *", anything using
it will need to know. But at least changes like "int" -> "unsigned
long" or -> "whatever_t" don't need to be synchronized.

Furthermore, the markers are for desperate cases, where the
debugging information does not allow us to find arguments or
variables, or even the location for placing the breakpoint. On
function entry, it should be possible to access arguments without
any markup in the code. I'll examine that part soon.

Generally, my idea is to gather as much useful information from
debugging data as possible. A few observations so far (based on
using DWARF2 information; all this is on the kernel, with the usual
optimizations):

 - gcc provides accurate type and name information

 - location of static or extern functions is accurate, but there
   doesn't seem to be a reliable means for determining where the
   function prologue ends [10000]

 - the location of inlined functions is less accurate than for
   non-inlined functions [10003]

 - labels (as in "goto foo;") are completely erratic (that's one
   reason for markers) [10001, 10002, 10003]

 - variable locations information is frequently only useful if
   we're after the prologue, and it does not accurately reflect
   register copies, and such (that's another reason for markers)
   [10005]

 - call frame information seems to be almost sufficient for
   emulating a function return. "Almost" because I also need to
   analyze the add N,%esp instruction following the call. I'm
   not sure yet if there isn't a better way, though.

The numbers in square brackets are the gcc PRs I've submitted.
(http://gcc.gnu.org/cgi-bin/gnatsweb.pl)

Without optimization, some things look better, of course.

I'm not sure how much help we can expect from the gcc side. Some
of these things may just be too hard to fix. And others can't be
usefully fixed at all (e.g. the markers tell gcc where the focal
points are, where it has to relax optimization for accessibility).

Some thing I haven't looked at yet:

 - using line numbers to specify locations. With optimization, I
   expect total disaster here. Also, line numbers are too volatile
   for few things but manual debugging.

 - passing structures as arguments, or returning them from functions

 - unusual (i.e. large) alignment settings. Perhaps I'll eventually
   need to know CFLAGS in order to reconstruct some things.

> Of course this is just a begining. We're open to suggestions and
> contributions.

Same thing here :-) My goal is to reduce the markup that has to
be done on the kernel to the bare minimum. The "reliable markers"
are the least intrusive way I could think of for handling those
cases where nothing else works (e.g. in the middle of a function).

It would be nice to have a "global" clobber, though. I.e. one that
flushes and invalidates all values cached in registers, and that
forces all evaluations happening prior in the nominal execution
flow to be carried out, including initialization of function-local
variables. That way, reliable markers wouldn't need the list of
things that might be looked at.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
