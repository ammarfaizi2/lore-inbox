Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSGOSat>; Mon, 15 Jul 2002 14:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSGOSas>; Mon, 15 Jul 2002 14:30:48 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14864 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317579AbSGOSao>; Mon, 15 Jul 2002 14:30:44 -0400
Date: Mon, 15 Jul 2002 20:33:35 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020715183335.GB20665@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gsn2lt3ro.fsf@egghead.curl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Patrick J. LoPresti wrote:

> One other thing.  I think this statement is misleading:
> 
>     IF your server is stable and not prone to crashing, and/or you
>     have the write cache on your hard drives battery backed, you
>     should strongly consider using the writeback journaling mode of
>     Ext3 versus ordered.
> 
> This makes it sound like data=writeback is somehow unsafe when
> machines crash.  I do not think this is true.  If your application

Well, if your fsync() completes...

> (e.g., Postfix) is written correctly (which it is), so it calls
> fsync() when it is supposed to, then data=writeback is *exactly* as
> safe as any other journalling mode.  "Battery backed caches" and the
> like have nothing to do with it.  And if your application is written
> incorrectly, then other journalling modes will reduce but not
> eliminate the chances for things to break catastrophically on a crash.

...then you're right. If the machine crashes amidst the fsync()
operation, but has scheduled meta data before file contents, then
journal recovery can present you a file that contains bogus data which
will confuse some applications. I believe Postfix will recover from
this condition either way, see its file is hosed and ignore or discard
it (depending on what it is), but software that blindly relies on a
special format without checking will barf.

All of this assumes two things:

1. the application actually calls fsync()

2. the application can detect if fsync() succeeded before the crash
(like fsync -> fchmod -> fsync, structured file contents, whatever).

> So if the partition is dedicated to correct applications, like a mail
> spool is, then data=writeback is perfectly safe.  If it is faster,
> too, then it really is a no-brainer.

These ordering promises also apply to applications that do not call
fsync() or that cannot detect hosed files. Been there, seen that, with
CVS on unpatched ReiserFS as of Linux-2.4.19-presomething: suddenly one
,v file contained NUL blocks. The server barfed, the (remote!) client
segfaulted... yes, it's almost as bad as it can get.

Not catastrophic, tape backup available, but it gave some time to
restore the file and investigate this issue nonetheless. It boiled down
to "nobody's fault, but missing feature". With data=ordered or
data=journal, I would have either had my old ,v file around or a proper
new one.

I'm now using Chris Mason's data-logging patches to try and see how
things work out, I had one crash with an old version, then updated to
the -11 version and have yet to see something break again.

I'd certainly appreciate if these patches were merged early in
2.4.20-pre so they get some testing and can be in 2.4.20 and Linux had
two file systems with data=ordered to choose from.

Disclaimer: I don't know anything except the bare existence, about XFS
or JFS. Feel free to add comments.

-- 
Matthias Andree
