Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266855AbUBRATK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUBRASn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:18:43 -0500
Received: from mail.inter-page.com ([12.5.23.93]:14605 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S266855AbUBRAQ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:16:29 -0500
From: "Robert White" <rwhite@casabyte.com>
To: <tridge@samba.org>, <linux-kernel@vger.kernel.org>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Al Viro'" <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Neil Brown'" <neilb@cse.unsw.edu.au>
Subject: RE: UTF-8 and case-insensitivity
Date: Tue, 17 Feb 2004 16:16:11 -0800
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAABSIByOpdrUqd8yc+ZmEhqQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <16433.38038.881005.468116@samba.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I wrote the below, but then in the summary I realized that there was
a significant factor that doesn't fit in with the rest of the post.  Case
insensitivity, and more generally locale equivalence rules, is a security
nightmare.  Consider the number of different file names that "su" could map
to if you apply case insensitivity (4) and/or worse yet the various accents
and umlats (?,etc) that sort-equivalent for "u" in some locales.  The user
types "su" and runs "S(u-umlat)" etc. 

====

In point of fact (ok in point of "technically abstract truth"), it is a "bad
thing" that Windows (and seemingly only Windows these days) is case
insensitive.  It is sometimes said that windows is really an application and
not an OS.  If you ignore the occasionally snide *way* it is said you can
find some technical truth to the matter.

In point of fact the entire windows application space has a singular active
locale at any one time and there is a well-defined but horrible layer of
indirection where "long names" like "My Documents" become "real names" like
"MYDOCU~1".  Essentially every windows file name is subject to a
double-indirect file name translation.  The first pass is the strcasecmp()
locale-dependent traversal of the "long name" list.  The second is the
strcasecmp() frozen-locale-spec-dependent traversal of (US Latin?) 8.3 file
naming standard list of media elements (files/directories).

In point of fact, Windows is *not* "properly" case insensitive at the file
system level.  Use "dir /x" more often on your windows box to relive the
experience.  The "real" file names are mangled to good old 8.3 uppercase
internally(1).  You don't usually have to think about this, but if you have
ever lost the long-to-short file name mapping on a drive you know the hell
that ensues.  (see also iso9660.)

So the application file naming interface wedge thingy (in windows) creates
and maintains the mixed case names as an illusion.  It just happens to be an
illusion planted so deeply in the application space that it appears to be
coming up from the "operating system level".

OK, as time has moved on, some later versions of later file systems *may* (I
honestly don't know) have modified the double-indirection model, but if they
have, they must have done so in a guaranteed-to-look-the-same way.  Either
way it ends up being quite costly.

Further, the model only really works because a DOS (and therefore windows)
based program invariably and individually takes responsibility for doing all
sorts of tasks like wildcard expansions (etc) in the application space
(often "free" through comctl32.dll).  [This tends to be foreign to Linux
(UNIX) programmers where shells and such do the expansion.]

The line is then blurred further by the subsequent steady creep of
wildcarding and file selection back into common DLLs.  (more comctl32.dll
and friends.)

The thing is, to match this ersatz "functionality" on a system where more
than one locale may be used at the same time, you end up with a kind of
Cartesian product of user locales and filesystem native locales.  The cost
could get extreme and can only really be amortized if Linux were to declare
our own 8.3 style pronouncement for the character classes used for the
"real" file name storage (etc).

Late stage case insensitivity isn't that hard to put in a linux application,
just crack open your file selection dialog boxes and have them use
strcasecmp() in all their select/sort logic.  Also then replace open() with
CaseOpen() which does a find/search operation before daring to creat().
That is, in every practical way, how Windows handles these problems.  It
just happens in some fairly interesting and hard-to-predict places depending
on context.

It is easier, IMHO, to bring the users into the 20th century (let alone the
21st 8-) by making them mean what they say (if they deign to step out from
behind their GUIs).

So what was I saying... Oh yea...

-- Single Locale storage standard required to prevent multiplicative cost.
-- Not that hard to fake case insensitivity "when necessary".
-- Cheaper in CPU/Space to mix case.
-- Native file names in native locales simplifies administration and
expectations. (not elaborated above, but true.)
-- Case insensitivity and locale equivalence leads to uncertainties about
what/which file may be intended in a given context, which could often lead
to exploitable error.


Rob.

(1) The actual truth is a tad uglier than this, the media can have the 8.3
names stored in interesting ways, but essentially a "toupper()" is done on
every file name as it is retrieved and processed.  This cuts out a lot of
possibilities and leads to a lot of "tildes of shame" in even some of the
more harmless seeming name conflicts.




