Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281468AbRKHIO6>; Thu, 8 Nov 2001 03:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281482AbRKHIOs>; Thu, 8 Nov 2001 03:14:48 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:9743 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S281468AbRKHIOk>;
	Thu, 8 Nov 2001 03:14:40 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111080814.fA88EXn157226@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
To: indigoid@higherplane.net (john slee)
Date: Thu, 8 Nov 2001 03:14:32 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20011108171947.G2430@higherplane.net> from "john slee" at Nov 08, 2001 05:19:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee writes:
> On Wed, Nov 07, 2001 at 07:22:16PM -0500, Albert D. Cahalan wrote:

>> Splitting /proc can be done. Start by mounting procfs twice.
>> Make non-process stuff in /proc invisible, but still available.
>> Then in /kernel the process stuff can be disabled. The proc fs
>> code can even register two filesystem types, with different
>                         ^^^^^^^^^^^^^^^^^^^^
>                         ||||||||||||||||||||
>
> this is the key part.  two filesystems and union mount should
> satisfy backward compatibility needs while lspci and friends
> are migrating to /kern.
>
> this makes it a distribution issue, not a kernel issue, and
> there is no need for special backwards-compatibility stuff in
> either kernfs or procfs.

No, not a union mount. We didn't have that last time I looked,
and I have some doubts that it would work all that well. Even
if it does work, it doesn't provide drop-in kernel compatibility
and doesn't help encourage transition.

It is possible for a single filesystem driver to register more
than one name. For example, once ext3 is fully trusted it could
register an "ext2" type so that we don't need an ext2 driver or
admin headaches. The sysv filesystem driver does in fact register
itself under several different names for compatibility reasons.

So the code in fs/proc could register both "proc" and "kern".
This lets us keep the code intact while preparing for a future
split into separate drivers.

It would be reasonable to have a proc filesystem that could
hide or disable half of the content -- either process files
or the misc junk.

Let's have a filesystem mounted as type "proc" hide everything
but the process directories by default. You can still read
/proc/cpuinfo, but you can't see it when you do "ls /proc".
Let's have  a filesystem mounted as type "kern" disable the
process directories by default.

During transition, you could specify options to get:

1. today's /proc, with perfect compatibility
2. the above, except "ls /proc" won't show misc junk
3. the above, plus a warning when non-process stuff is touched
4. only the process directories
5. misc junk alone, w/o the process directories

The only difference between "proc" and "kern" is the default.
These would be the same:

mount -t proc -o misc-only /mnt/foo
mount -t kern /mnt/foo

After a while the "proc" default changes to #3, then to #4.
Then a while later support for #1, #2, and #3 dies as today's
proc filesystem is finally split in half. Transition done!

