Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269107AbUINCFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbUINCFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUINCEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:04:21 -0400
Received: from holomorphy.com ([207.189.100.168]:50575 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269107AbUINCCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:02:43 -0400
Date: Mon, 13 Sep 2004 19:02:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Ingo Molnar <mingo@elte.hu>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040914020236.GE9106@holomorphy.com>
References: <1095045628.1173.637.camel@cube> <20040913075743.GA15722@elte.hu> <1095083649.1174.1293.camel@cube> <20040913142437.GB9106@holomorphy.com> <1095087244.2191.1383.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095087244.2191.1383.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 10:24, William Lee Irwin III wrote:
>> How do you propose to queue pid's? This is space constrained. I don't
>> believe it's feasible and/or desirable to attempt this, as there are
>> 4 million objects to track independent of machine size.

On Mon, Sep 13, 2004 at 10:54:04AM -0400, Albert Cahalan wrote:
> As we've seen elsewhere in this thread, things break
> when you go above 0xffff anyway. So 128 KiB of RAM
> should do the job. With a 4-digit PID, 20000 bytes
> would be enough.
> Supposing you fix rwsem counts and /proc inodes and so on,
> a large machine could handle 4 million objects easily.
> A small machine has far, far, less need to support that.

The feature of supporting more threads is there and meant to be
supported, so "> 32K breaks anyway" doesn't really fly; it should
be fixed.

The rwsems just want ia32 to use generic rwsems. /proc/ is a much
bigger mess but far from insurmountable. I suppose someone has to
be willing to mess with it for that to be fixed, and it may need
other vfs-related help (ino64_t support?).


On Mon, 2004-09-13 at 10:24, William Lee Irwin III wrote:
>> The general
>> tactic of cyclic order allocation is oriented toward making this rare
>> and/or hard to trigger by having a reuse period long enough that what
>> processes there are after a pid wrap are likely to have near-indefinite
>> lifetimes. i.e. it's the closest feasible approximation of LRU. If you
>> truly want/need reuse to be gone, 64-bit+ pid's are likely best.

On Mon, Sep 13, 2004 at 10:54:04AM -0400, Albert Cahalan wrote:
> That's too unwieldy for the users, it breaks glibc,
> and you'll still hit the problems after wrap-around.
> Besides, Linus vetoed this a year or two ago.
> Reducing the dangers of a small PID space allows for
> just the opposite size change, which is much nicer for
> the users.

Reducing the PID space so the pid's can be formatted in 4 digits
doesn't sound particularly compelling. 64-bit pid's wrapping sounds
rather unlikely, but if so, 128-bit pids are more likely to withstand
various physical arguments against pid wrapping ever happening.

The middle ground is already where kernel/pid.c stands, so I'd prefer
to leave this alone unless you have deeper concerns about it than
4-column displays and pid reuse problems (which want larger pid spaces,
not smaller). The primary complaint I've heard about pid reuse is
actually that smaller pid spaces (e.g. 32K) wrap far too quickly,
sometimes numerous times per second on larger systems with parallel
process creation activity. It's unclear what the pid wrap speeds are
for the workloads they reported is with the now-permissible pid_max
(in fact, I've since forgotten who reported this).


-- wli
