Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbUCJQhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUCJQhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:37:07 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:38651 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262698AbUCJQhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:37:00 -0500
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
From: Albert Cahalan <albert@users.sf.net>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       corliss@digitalmages.com, riel@redhat.com, jerj@coplanar.net
In-Reply-To: <Pine.LNX.4.53.0403100940240.12833@gockel.physik3.uni-rostock.de>
References: <1078883951.2232.501.camel@cube>
	 <Pine.LNX.4.53.0403100940240.12833@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Organization: 
Message-Id: <1078936898.2232.571.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Mar 2004 11:41:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-10 at 04:08, Tim Schmielau wrote:
> On Wed, 9 Mar 2004, Albert Cahalan wrote:
> 
>> First of all, none of this matters much if the format
>> is given a sysctl. The old format is default for now,
>> and the new one is default (only?) in a couple years.
>> Sun appears to have done something like this.
> 
> Yeah, if we even want to introduce a new syscall for this...
> But Documentation/Changes is not an empty file, i.e., we
> require people to upgrade userspace anyways.

In that case, don't forget to upgrade atop.
That's a version of top that uses BSD process
accounting to grab the transient processes
that wouldn't be seen in /proc before they die.

>> When fixing it, note that a 5-bit binary exponent
>> with denormals would beat the current float format.
> 
> Yes, but only by a short head.

It's by 8 bits, with a stable 11-bit fraction
instead of a 10-bit to 12-bit variable-size one.

old: 1xxxxxxxxxxyy000000000000000000000
new: 1xxxxxxxxxxx000000000000000000000000000000

That's a 42-bit number instead of a 36-bit one.
The old base-8 exponent is wasteful, plus the old
format stores the leading 1 instead of using an
implied 1 and special exponent for leading 0.

> And, since comp_t is hard-coded into 
> current GNU acct tools, we can't keep source compatibility
> (not that this matters too much anyways...)
> I'm open for suggestions in this direction. Any reasonable ideas to
> get more precision? (e.g. 16 bit mantissa and 4 bit base-whatever 
> exponent?) 

a. just what I said
b. 32-bit IEEE float (easy enough to encode by hand)
c. raw data -- is the space saving all that critical?
d. raw data with gzip-style compression

(note that gzip's deflate algorithm is in the kernel)

> > Regarding the existing struct though...
> > 
> > Let's take a close look at this. I think there are 2 bytes
> > of padding on all Linux ports, and another 2 available
> > on everything except maybe m68k and/or arm. (that is, ports
> > that will put a u32 on any u16 boundry) Here is the current
> > struct, compactly formatted with 64-bit blocking:
> > 
> > struct linux_acct {
> >         char   ac_flag;        // Flags
> > // 1 pad byte
> 
> Yep, but depending on architecure I think the compiler is free to insert
> the padding either before or after ac_flags.

I doubt it. I think the C standard has something to
say about this. In any case, I just checked a mix of
big-endian and little-endian boxes:

32-bit BE SPARC
64-bit BE SPARC
32-bit BE PowerPC
32-bit LE i386
64-bit LE x86-64
64-bit LE Alpha

In every case, 1-byte padding came after ac_flag.

I'm pretty sure ac_comm is too big as well. It has
room for 17 bytes. It needs room for 15, plus a '\0'
if you want one.



