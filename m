Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTEONAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 09:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTEONAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 09:00:04 -0400
Received: from smtp2.server.rpi.edu ([128.113.2.2]:18570 "EHLO
	smtp2.server.rpi.edu") by vger.kernel.org with ESMTP
	id S263996AbTEOM76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 08:59:58 -0400
Mime-Version: 1.0
Message-Id: <p0521061cbae93d4b61b2@[128.113.24.47]>
In-Reply-To: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305141749490.28007-100000@home.transmeta.com>
Date: Thu, 15 May 2003 09:12:29 -0400
To: Linus Torvalds <torvalds@transmeta.com>
From: Garance A Drosihn <drosih@rpi.edu>
Subject: Re: [OpenAFS-devel] Re: [PATCH] PAG support, try #2
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, David Howells <dhowells@redhat.com>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <openafs-devel@openafs.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:57 PM -0700 5/14/03, Linus Torvalds wrote:
>On Wed, 14 May 2003, Garance A Drosihn wrote:
>>
>>       For any process where pag != 0, that process will share
>>       tokens with all other processes that have the exact same
>>       pag value as it has.  This is true even if the different
>>       processes are tied to different user ids.
>
>Yeah, and the thing I think it _totally_ and utterly broken is
>that there  can be only one of these per process.
>
>I don't see where the 1:1 idea comes from, except from a bad
>implementation.

Well, personally I would not mind the idea of multiple tokens
for a given AFS cell in a single PAG, but that does brings up
a number of extra implementation problems.  I would be happy
if the linux-implementation of PAG's *allowed* for multiple
tokens-from-a-single-cell, but that we (afs) started out by
still using only one.   Note that a PAG can already contain
multiple AFS tokens, it's just that each token would have to
be from a different AFS cell.  Allowing for multiple
tokens-from-a-single-cell would mean that you would be two
different AFS users at the same time.

Mind you, there are definitely times that I would like that!
But it means you have to answer the same kinds of questions
that you would need to answer if a single unix process was
two different unix uid's at the exact same time.  What if one
userid has explicit access to a file, and the other userid
is explicitly listed as having absolutely no access to the
same file?

>  > There is absolutely no connection between userids and PAG's,
>>  the same way that there is no connection between userids and
>>  process-numbers.  (Roughly speaking:) The 10th person to log
>>  in will get the 10th pag, no matter what userid they happen
>>  to log in as.
>
>And this is also again nothing but the result of a bad
>implementation.
>
>From a system maintenance issue, this is a nightmare. It makes
>joining a group nigh impossible, since now the joiner (login
>or something) has to keep track of what pag's it has used for
>previous logins. Which is fine as  long as you have _one_
>login authority, but it's a total disaster to  require that
>kind of centralization.

You are still thinking about this the wrong way, although that
is probably because I was too terse.  (me? too terse? who would
have thought?).  What I meant was more "the 10th person to log
in after a system reboot will get the 10th pag".  In this sense,
a PAG is *exactly* the same as a process ID.  It is only a value
that is unique across a single machine at any given moment.  Once
you reboot a machine, you can start back at PAG #1 (so to speak).
The PAG #1 which existed before the reboot will have absolutely
no relation to the PAG #1 which exists after the reboot.

There is ZERO connection between login ids and PAG numbers.  It
is entirely for tracking "sessions".  If I am on one machine and
ssh into another one, the session on the remote machine will be
one PAG.  If I ssh into the exact same userid a second time, it
will get a second PAG.  There is absolutely no reason for the
second session to have the slightest idea of what PAG the first
session is using.  It's like saying "the second session has to
know the pid of the first process of the first session".  This
is just a false idea of what the PAG is tracking.

>  > It's tokens which have some relation to userids.  In the world
>>  of AFS, a pag can hold only one token from any one AFS cell
>>  at a given time.  But I can change which "AFS userid" that I
>>  am, without changing which pag I am in, and all processes in
>>  that same pag will instantly become that same "AFS userid".
>
>Yes. And apparently PAG's - as you see them - are nothing but a
>AFS issue.   As such, I think they are totally uninteresting for
>the core kernel, and I will _not_ be applying any patches that
>introduce such a limiting and stupid notion into the core kernel.

I am hoping that if we can get an accurate picture of PAG's, they
will appear much more generally usable.

>I'm interested in a much more generic issue of "user credentials",
>and here a PAG can be _one_ credential that a user holds on to.
>But to be  useful, a user has to be able to have multiple such
>credentials. While one  might be his "AFS userid", another will
>be his NFS mount credentials, and  a third one will be his key
>to decrypt his home directory on that machine.
>
>If it's useful for AFS only, I'm not interested.

I think the concept should be usable for other contexts, too.

A PAG is not a "credential", it is what you would connect
credentials to.  It is not a collection of "user credentials", it
is a collection of "session credentials", where your AFS userid
is just one credential in that collection.  Instead of connecting
credentials to a userid, or a groupid, a PAG is just adding the
new notion of a "session id".  The one difference between this
"session id" and userids is that you don't "join" a session, any
more than you would "join" a process-id.

Any process can get a new PAG and thus change from their current
PAG to some new PAG, but they can not "join" any PAG that already
exists.

-- 
Garance Alistair Drosehn            =   gad@gilead.netel.rpi.edu
Senior Systems Programmer           or  gad@freebsd.org
Rensselaer Polytechnic Institute    or  drosih@rpi.edu
