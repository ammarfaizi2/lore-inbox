Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293625AbSCATJJ>; Fri, 1 Mar 2002 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSCATIF>; Fri, 1 Mar 2002 14:08:05 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:10250 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S293640AbSCATH2>;
	Fri, 1 Mar 2002 14:07:28 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200203011907.WAA08216@ms2.inr.ac.ru>
Subject: Re: Fw: memory corruption in tcp bind hash buckets on SMP?
To: raghuangadi@yahoo.com (Raghu Angadi)
Date: Fri, 1 Mar 2002 22:07:03 +0300 (MSK)
Cc: davem@redhat.com, raghuangadi@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020227203101.78001.qmail@web12305.mail.yahoo.com> from "Raghu Angadi" at Feb 27, 2 12:31:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > > inverted order of insertion into the lists in tw_hashdance() is probably
> > > cleaner fix than inverted order of removal.. 
> > 
> > Why are they not equivalent? Good question? :-)
> 
> they are. with "if (!tb->tb) return;" instead of "if (!tb->pprev) return;".
> silly me was thinking of literal cut-n-paste invertion of the oder :->

However, you were 100% right. They are really not equivalent. :-)

Right solution is to exchange order of insertion. tcp_timewait_kill()
is right and need not changes.


Proof follows:

Main invariant: that guy who inserts/removes socket to/from established
hash table, must make this for binding table. That guy who did not find
socket in established hash, must not touch binding table.

In this case concurrent tcp_timewait_kill()s are happy: socket will
be removed from binding table once and only once, when it is removed
from established hash. The second tcp_timewait_kill() does not find
socket in established table and it must _not_ touch binding table,
despite of socket can be there at the moment.

The mess happens while concurrent remove and insert: insert adds
socket to established table and then to binding table. Racing remove
removes it from established table, but cannot satisfy invariant
because socket is still not in binding table. (This place should
be asserted with a BUG() for future)

The second statement, which completes the proof: removing is possible
only after the socket is added to established hash table (it is evident,
until this time bucket is private to creator).

Alexey
