Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUIMHml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUIMHml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUIMHml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:42:41 -0400
Received: from holomorphy.com ([207.189.100.168]:44681 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266296AbUIMHmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:42:38 -0400
Date: Mon, 13 Sep 2004 00:42:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, cw@f00f.org,
       mingo@elte.hu, anton@samba.org
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040913074230.GW2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	cw@f00f.org, mingo@elte.hu, anton@samba.org
References: <1095045628.1173.637.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095045628.1173.637.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
>> it's getting quite spaghetti ... do we really want to handle
>> RESERVED_PID? There's no guarantee that any root daemon wont stray out
>> of the 1...300 PID range anyway, so if it has an exploitable PID race
>> bug then it's probably exploitable even without the RESERVED_PID
>> protection.

On Sun, Sep 12, 2004 at 11:20:29PM -0400, Albert Cahalan wrote:
> Purpose:
> 1. weak security enhancement
> 2. cosmetic (backwards, IMHO)
> 3. speed (avoid PIDs likely to be used)

Well, weak security enhancement translates to "nop" in my book, but
I guess if that's really what people were trying to arrange...


On Sun, Sep 12, 2004 at 11:20:29PM -0400, Albert Cahalan wrote:
> I'd much prefer LRU allocation. There are
> lots of system calls that take PID values.
> All such calls are hazardous. They're pretty
> much broken by design.
> Better yet, make a random choice from
> the 50% of PID space that has been least
> recently used.

I'd favor fully pseudorandom allocation over LRU or approximate LRU
allocation, as at least pseudorandom is feasible without large impacts
on resource scalability. OTOH the cache characteristics of pseudorandom
allocation are usually poor; perhaps hierarchically pseudorandom
allocation where one probes a sequence of cachelines of the bitmap
according to one PRNG, and within each cacheline probes a random
sequence of bits according to some other PRNG, would resolve that.


On Sun, Sep 12, 2004 at 11:20:29PM -0400, Albert Cahalan wrote:
> Another idea is to associate PIDs with users
> to some extent. You keep getting back the same
> set of PIDs unless the system runs low in some
> global pool and has to steal from one user to
> satisfy another.

The resource tracking and locking implications of this are disturbing.
Would fully pseudorandom allocation be acceptable?


On Sun, Sep 12, 2004 at 11:20:29PM -0400, Albert Cahalan wrote:
> BTW, since pid_max is now adjustable, reducing
> the default to 4 digits would make sense. Try a
> "ps j" to see the use. (column width changes if
> you change max_pid)

Is the maximum possible pid exported by the kernel somehow? Perhaps
it should be; the maximum number of decimal digits required to
represent PID_MAX_LIMIT (4*1024*1024) should suffice in all cases.
Perhaps you need to detect PID_MAX_LIMIT somehow?


-- wli
