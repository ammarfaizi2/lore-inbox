Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272192AbSISWYe>; Thu, 19 Sep 2002 18:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272780AbSISWYd>; Thu, 19 Sep 2002 18:24:33 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:42248 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S272192AbSISWYc>; Thu, 19 Sep 2002 18:24:32 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
Date: Thu, 19 Sep 2002 22:29:10 +0000 (UTC)
Organization: Cistron
Message-ID: <amdj3m$b69$1@ncc1701.cistron.net>
References: <8XBysGvmw-B@khms.westfalen.de> <Pine.LNX.4.44.0209191324310.1277-100000@home.transmeta.com>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1032474550 11465 62.216.29.67 (19 Sep 2002 22:29:10 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0209191324310.1277-100000@home.transmeta.com>,
Linus Torvalds  <torvalds@transmeta.com> wrote:
>
>On 19 Sep 2002, Kai Henningsen wrote:
>> 
>> On the contrary: it says that this can never happen - the new session has  
>> no controlling terminal, and can't get the old one unless the old session  
>> loses it first.
>
>Hmm.. I read it as "the tty stays with the stale group", which is
>problematic. But if all the places that set a new controlling terminal
>check that it's not already used by some other non-session then I guess 
>we're still ok..

No, it said that if a new session is created the tty stays with
the old session group which is by no means stale.

A session leader cannot create a new session, since the session-id
is the pid of the leader. Only children can create a new session,
and at that point the tty is not the controlling tty of the
_newly created_ session. Ofcourse the original session still
exists, and the tty is still the controlling tty of that session.

Only if the new session leader opens a tty that hasn't been
associated with a session yet will it become the controlling
tty of that session.

So to assocciate a tty with another session, you'll have to
disassociate it with the existing session by a) killing all
processes in the session or b) calling TIOCNOTTY. Then another
session can open it and it will become the controlling tty
of the other session (if it didn't have a controlling tty
yet, that is!)

A session can also steal away a controlling tty from another
session by using TIOCSCTTY (if its root) but the tty will
first be disassociated from the old session and only then
will it become the controlling tty of the stealing session.

See drivers/char/tty_io.c::tiocsctty() for how it loops
over all tasks to do this ..

Mike.

