Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWECVp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWECVp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 17:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWECVp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 17:45:58 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:56722 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751364AbWECVp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 17:45:58 -0400
Message-ID: <44592491.4060503@tlinx.org>
Date: Wed, 03 May 2006 14:45:53 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] kernel facilities for cache prefetching
References: <346556235.24875@ustc.edu.cn>
In-Reply-To: <346556235.24875@ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> Pre-caching reloaded ;)
> I/O ANALYSE...
> SCHEME/GOAL(s)...
>   
    Some good analysis and ideas.  I don't know if it is wanted, but I'd
like to add a 'few cents' referring to the pre-fetch mechanism in
XP, which addresses both boot and application prefetch and has the
benefit of showing measurable performance improvements (compare the
boot time of an NT4 system to XP; maybe a 5-8x performance boost?).

    1. As you mention; reading files "sequentially" through the file
system is "bad" for several reasons.  Areas of interest:
    a) don't go through the file system.  Don't waste time doing
directory lookups and following file-allocation maps;  Instead,
use raw-disk i/o and read sectors in using device & block number.
    b) Be "dynamic"; "Trace" (record (dev&blockno/range) blocks
starting ASAP after system boot and continuing for some "configurable"
number of seconds past reaching the desired "run-level" (coinciding with
initial disk quiescence).  Save as "configurable" (~6-8?) number of
traces to allow finding the common initial subset of blocks needed.
    c) Allow specification of max# of blocks and max number of "sections"
(discontiguous areas on disk);
    d) "Ideally", would have a way to "defrag" the common set of blocks.
I.e. -- moving the needed blocks from potentially disparate areas of
files into 1 or 2 contiguous areas, hopefully near the beginning of
the disk (or partition(s)).

    That's the area of "boot" pre-caching.

Next is doing something similar for "application" starts.  Start tracing
when an application is loaded & observe what blocks are requested for
that app for the first 20 ("configurable") seconds of execution.  Store
traces on a per-application basis.  Again, it would be ideal if the
different files (blocks, really), needed by an application could be
grouped so that sequentially needed disk-blocks are stored sequentially
on disk (this _could_ imply the containing files are not contiguous).

Essentially, one wants to do for applications, the same thing one does
for booting.  On small applications, the benefit would likely be negligible,
but on loading a large app like a windowing system, IDE, or database app,
multiple configuration files could be read into the cache in one large
read.

    That's "application" pre-caching.

    A third area -- that can't be easily done in the kernel, but would
require a higher skill level on the part of application and library
developers, is to move towards using "delay-loaded" libraries.  In
Windows, it seems common among system libraries to use this feature. 
An obvious benefit -- if certain features of a program are not used,
the associated libraries are never loaded.  Not loading unneeded parts
of a program should speed up initial application load time, significantly.

    I don't know where the "cross-over" point is, but moving to demand
loaded "so's" can cause extreme benefits for interactive usage.  In
addition to load-time benefits, additional benefits are gained by not
wasting memory on unused libraries and program features.

    In looking at the distro I use, many unused libraries are linked in
with commonly used programs.  For a small office or home setup, I rarely
have a need for LDAP, internationalized libraries, & application support
for virtually any hardware & software configuration.

    This isn't a kernel problem -- the kernel has dynamically loadable
modules to allow loading only of hardware & software drivers that are
needed in a particular kernel.  User applications that I have been
exposed to in Linux usually don't have this adaptability -- virtually
everything is loaded at execution time -- not as needed during
program execution. 

    I've seen this feature used on Unix systems to dynamically present
feature interfaces depending on the user's software configuration.  On
linux, I more often see a "everything, including the kitchen sink"
approach, where every possible software configuration is supported
via "static", shared libraries that must be present and loaded into
memory before the program begins execution.

    This has the potential to have a greater benefit as the application
environment becomes more complex if you think about how the number
of statically loaded, sharable libraries have increased (have seen
addition of ldap, pam, and most recently, selinux libraries that are
required for loading before application execution).

    Good luck in speeding these things up.  It might require some
level of cooperation in different areas (kernel, fs utils,
distro-configuration, application design and build...etc).

-linda




