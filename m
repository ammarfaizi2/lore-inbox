Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVGYCAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVGYCAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVGYCAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:00:06 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:30363 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261566AbVGYCAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:00:04 -0400
Message-ID: <42E4479F.90609@comcast.net>
Date: Sun, 24 Jul 2005 21:59:59 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fault tolerance. . .
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm playing Skies of Arcadia Legends on my GameCube and noticing that
software bugs continuously produce errors (no scratch on the disk; I can
have an error, reset, play through it easy).  This leads me on and on,
but now it's lead me into thinking about fault tolerance.

Leaving the GameCube and moving to my computer, I'm wondering if
something could be done kernel-end to provide automatic application and
system fault recovery.  Thinking about it, I can come up with a few cute
ideas, though they don't really seem all that realistic.  Still, it
might be fun to share them and see what kinds of comments I get.

I'm thinking of application level fault tolerance using roll-back states
or something weird, to restore the system as affected by that
application to a point before the error.  The obvious visual effect
would be that if an application were to crash, it and potentially
interrelated applications would suddenly reset to a state a few seconds
to a few minutes earlier.

Like I said, this is a really dumb idea, but it's kind of cute to think
about.  In the 5 minutes I think about this, I'll type some crap here,
then go back to my game and leave this for you all so you can take a
break from real work and read something mildly ammusing.

Interrelating applications:

 - Tasks sharing memory are synchronized at state saves
 - Tasks having mappings to files where writing to the mapping writes to
the file have state saves synchronized starting where one could affect
another and ending where they no longer can affect eachother
  - When a process opens a file another process has open for writing,
the two both have a state save made
  - Following state saves are sychronized temporally between the tasks
  - When neither task can affect the other by writing to said file, the
state saves no longer are required to be synchronized
 - Tasks communicating over sockets are synchronized at save states
 - Tasks communicating via pipes are synchronized at save states
 - When a parent is rolled back to precede a fork(), the fork() child dies

"Synchronized" means that when the state is set to be saved for
roll-back in one task, interrelated tasks are also frozen and saved at
the same time.

Saving a state is easy:

 - Lock a spinlock
 - Add an entry to a linked list for a state save, with registers and such
 - Remove entries older than the limit for the oldest save
 - Open spinlock

Maintaining the state is also easy:

 - When a file is changed, track the changes and attach them to the last
state save
 - When memory pages are written to, cache the old copies first
(unfortunately each page has to be made CoW after every state save)

Restoring a state is also easy:

 - At untrapped sigsegv, sigabrt, roll back changes and related changes
 - Repeted incident means rolling back farther

This of course raises many questions and concerns that make this
rediculous and probably not entirely possible:

 - What about huge modifications to files in a short time?  Make a new
file, then write 10,000,000,000 bytes past the end and watch it crash.
 - What about lost work in interrelated applications?
 - Will the system state remain consistent?
 - Will it crash over and over and over?
 - Connecting to named pipes? (easily handled, not discussed here)
 - Crashes are usually trappable, and then programs exit cleanly.  They
won't care about this
 - How does a process know to change course if it gets restored?
 - We can probably use this to do some deep-and-dirty espionage, relying
on the fault tolerance when we crash something trying to leak information
 - Darth Vader will use this to find Luke Skywalker

Anyway, whatever.  Comment if you want, I just thought the idea was
cute.  Not practical, but cute.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC5EeehDd4aOud5P8RAhK/AJ90BXofS/XPJcr5xsGFhqlf9jJiBQCfcbSG
v2Di7VqKv29jlRjoJiphy0c=
=5H6M
-----END PGP SIGNATURE-----
