Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKRDvq>; Sun, 17 Nov 2002 22:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261416AbSKRDvp>; Sun, 17 Nov 2002 22:51:45 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:131 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261411AbSKRDvo>; Sun, 17 Nov 2002 22:51:44 -0500
Message-ID: <3DD8657E.7020203@redhat.com>
Date: Sun, 17 Nov 2002 19:58:54 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211171938250.8451-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211171938250.8451-100000@home.transmeta.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> So when the child eventually creates a new thread, it needs to know to 
> ignore the other thread slots, even though they _look_ valid. They were 
> valid in the parent, they aren't valid in the child.
> 
> No?

They don't have to be as such.  It's a simple list operation (move all
active threads except the active one on the free list).  That's it.  No
more work especially no resetting of the TID fields.


> I follow your argument, and I don't dislike it per se. I just think that 
> you end up having to do other setup for pthreads-after-fork _anyway_, no?

I don't walk the thread descriptors.  I don't write into them.  I move
entire double-linked lists with a dozen or so instructions.  Regardless
of how many threads were active in the parent.


> Basically, I don't see the patch and bits making sense. I see it
> potentially _working_. But that's a different issue - and "working" to me
> is sometimes a much less potent argument than "makes sense".

With the flag and/or two settid pointers available the thread descriptor
for the one thread in the new process is correct and complete from the
first instruction on.  The address of the thread descriptor is the same
in parent and child and the only field which needs changing is the tid.
 I don't know what else to say.  For correct operation the thread
descriptor must be complete and correct and if the kernel doesn't help
setting the descriptor up correctly there always will be a time period
when it is not complete and effectively points to the parent thread in
the old process.  If the clone() flag would not be available I would
probably ignore the problem for now but when it becomes a problem the
only way for user-level code to handle the problem is to disable signals
around fork calls in the parent and then re-enable them after fork() and
after setting up the descriptor in the new process.  And this still
wouldn't help with debuggers etc.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE92GV+2ijCOnn/RHQRAiWpAJ9xxRkqVFFXyMcGwy8Y6udvtpqrvgCfRqm4
msw9MdH4MZ/+57JS9+OKlJQ=
=MWxi
-----END PGP SIGNATURE-----

