Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbSKQS5B>; Sun, 17 Nov 2002 13:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbSKQS5B>; Sun, 17 Nov 2002 13:57:01 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:30080
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267562AbSKQS46>; Sun, 17 Nov 2002 13:56:58 -0500
Message-ID: <3DD7E81B.5010706@redhat.com>
Date: Sun, 17 Nov 2002 11:03:55 -0800
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Luca Barbieri <ldb@ldb.ods.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
References: <Pine.LNX.4.44.0211170922020.4425-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0211170922020.4425-100000@home.transmeta.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> This patch is crap, or at least needs a ton more explanation about why you 
> would do something that looks quite this horrible and stupid.

Let me explani the use.  Sorry for all the confusion.  I left Ingo last
night in a state where he didn't have all the info.

The facts:

- - the settid syscall isn't used and is not needed anywhere in libc.so

- - it is only used in the init code of the new libpthread

I.e., all applications but those which are using the new thread code are
unaffected.  No special exec handling.  Set time, when the setid call is
executed, is early enough: it is the very first thing a multi-threaded
application does.  It is the first constructor which is run.  Always and
guaranteed.

The *alternatives* to this is a special whacky way to tell exec to do
this.  I've no idea how this could be implemented at user level since
the registered address is at least in my code not known at link time.
So this is one of these rare situations where Linus and I actually agree
on something.  The settid syscall is not used for exec but instead to
prevent modifying exec.


On to the second part: the clone() change is necessary for situations
where the CLONE_VM bit isn't set (to implement fork()).   Using the
CLONE_SETTID flag nevertheless would mean a data structure in the parent
process would be affected.  This isn't correct.  The data structure
which has to be modified is still in use in the parent.  That's the
whole point of fork(), the child inherits the same environment and might
on its own create more threads.  I.e., the internals of the thread
library must be intact.

With the proposed change the TID is only written to the child's VM.
This is the right semantics since the child is the one which gets
notified in the end and which might get a signal delivered before it had
the chance to set the TID on its own.  This one change saved us from the
mess this could potentially create plus it saves a system call.

And please note: how many normal application (not MT) are calling
getpid() first thing after fork()?  With this patch it can be avoided.
Not a big win but it rectifies an IMO not too well designed since
asymmetric interface.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE91+gb2ijCOnn/RHQRAluVAJ9nZB5/w3MImWbVKXS+nw05W+pfQACgzg/d
BsbD+2ff+BaRiDkbHhu1/9w=
=hnJQ
-----END PGP SIGNATURE-----

