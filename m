Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUBRCtT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUBRCtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:49:19 -0500
Received: from dp.samba.org ([66.70.73.150]:56468 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262355AbUBRCtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:49:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16434.53912.10089.216436@samba.org>
Date: Wed, 18 Feb 2004 13:48:56 +1100
To: "Robert White" <rwhite@casabyte.com>
Cc: <linux-kernel@vger.kernel.org>, "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Al Viro'" <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Neil Brown'" <neilb@cse.unsw.edu.au>
Subject: RE: UTF-8 and case-insensitivity
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAABSIByOpdrUqd8yc+ZmEhqQEAAAAA@casabyte.com>
References: <16433.38038.881005.468116@samba.org>
	<!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAABSIByOpdrUqd8yc+ZmEhqQEAAAAA@casabyte.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,

Just about everything in your posting is either years out of date or
just totally wrong. 

 > OK, so I wrote the below, but then in the summary I realized that there was
 > a significant factor that doesn't fit in with the rest of the post.  Case
 > insensitivity, and more generally locale equivalence rules, is a security
 > nightmare.  Consider the number of different file names that "su" could map
 > to if you apply case insensitivity (4) and/or worse yet the various accents
 > and umlats (?,etc) that sort-equivalent for "u" in some locales.  The user
 > types "su" and runs "S(u-umlat)" etc. 

This is no different from the "stupid admin puts . in $PATH"
problem. Simple solutions:

 1) don't mount your root filesystem with case insensitive naming
 2) use a sane $PATH
 3) don't allow untrusted users to create files in your $PATH
 4) don't run bash in case insensitive mode if you can't for some
    you can't do (1) or (2) or (3)

any of (1), (2) or (3) solves this. 


 > In point of fact the entire windows application space has a
 > singular active locale at any one time and there is a well-defined
 > but horrible layer of indirection where "long names" like "My
 > Documents" become "real names" like "MYDOCU~1".  Essentially every
 > windows file name is subject to a double-indirect file name
 > translation.  The first pass is the strcasecmp() locale-dependent
 > traversal of the "long name" list.  The second is the strcasecmp()
 > frozen-locale-spec-dependent traversal of (US Latin?) 8.3 file
 > naming standard list of media elements (files/directories).

this is just total crap. That might have been true for msdos and even
possibly win9x, but its totally untrue for NTFS. There are enough
stupidities in windows without having to invent more.

NTFS is case insensitive at the filesystem level. In fact, its
selectable whether its case sensitive or case insensitive per-process
(a process can switch between the two models). The case mapping table
is built into the filesystem itself. That mapping has absolutely
*zero* to do with US Latin or any other legacy multi-byte encoding.

What you have done is the equivalent of stating that Linux can only do
14 character filenames, because once upon a time Linux had a
filesystem called minix. We've moved beyond that and so has windows. 

 > In point of fact, Windows is *not* "properly" case insensitive at the file
 > system level.  Use "dir /x" more often on your windows box to relive the
 > experience.  The "real" file names are mangled to good old 8.3 uppercase
 > internally(1).  You don't usually have to think about this, but if you have
 > ever lost the long-to-short file name mapping on a drive you know the hell
 > that ensues.  (see also iso9660.)

again, this is just complete crap. NTFS has had the ability to
completely disable 8.3 "alternative name" support for ages. Microsoft
is even starting to use this switch in their published benchmark
results, and I suspect it will become the default in a couple of
years. 

We've been through the same transition in Samba:

  - Samba 0.x only supported 8.3
  - Samba 1.x was oriented towards 8.3, but also supported long names
  - Samba 2.x and 3.x is oriented towards long names, and can disable 8.3
    names to some extent
  
by the time Samba 4.x comes out (I am working on it now) we may see a
significant number of sites disabling 8.3 completely. 

 > The thing is, to match this ersatz "functionality" on a system where more
 > than one locale may be used at the same time, you end up with a kind of
 > Cartesian product of user locales and filesystem native locales.  The cost
 > could get extreme and can only really be amortized if Linux were to declare
 > our own 8.3 style pronouncement for the character classes used for the
 > "real" file name storage (etc).

you are *way* out of date here. All recent windows apps use the UCS-2
interfaces which provides a single charset encoding across all
locales. I've heard that they may be redefining this as UCS-16 to
allow for an even larger range of characters, although I haven't seen
this popping up on the wire yet (then again, I just might not have
noticed). I wish they had chosen UTF-8 instead of UCS-2, but at least
they chose something and got it into every part of the OS years ago.

 > Late stage case insensitivity isn't that hard to put in a linux application,
 > just crack open your file selection dialog boxes and have them use
 > strcasecmp() in all their select/sort logic.  Also then replace open() with
 > CaseOpen() which does a find/search operation before daring to
 > creat().

Have you read *any* of what I've been saying about how expensive this is??

 > That is, in every practical way, how Windows handles these problems.  It
 > just happens in some fairly interesting and hard-to-predict places depending
 > on context.

No, that is *not* how current versions of windows do things. 

 > So what was I saying... Oh yea...
 > 
 > -- Single Locale storage standard required to prevent multiplicative cost.

windows has this. Linux doesn't.

 > -- Not that hard to fake case insensitivity "when necessary".

ditto

 > -- Cheaper in CPU/Space to mix case.

ditto

 > -- Native file names in native locales simplifies administration and
 > expectations. (not elaborated above, but true.)

?? single locale storage makes this just a no-op

 > -- Case insensitivity and locale equivalence leads to uncertainties about
 > what/which file may be intended in a given context, which could often lead
 > to exploitable error.

and that is just a complete load of crap. Windows has had exploitable
bugs due to case insensitivity, but the cause was things like leaving
directories in the search path writeable by unprivileged users. It was
*not* due to anything fundamentally insecure about case-insensitive
names in filesystems. 

 > (1) The actual truth is a tad uglier than this, the media can have the 8.3
 > names stored in interesting ways, but essentially a "toupper()" is done on
 > every file name as it is retrieved and processed.  This cuts out a lot of
 > possibilities and leads to a lot of "tildes of shame" in even some of the
 > more harmless seeming name conflicts.

oh i get it, you're just a troll ....

Cheers, Tridge
