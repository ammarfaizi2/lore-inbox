Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155532AbPF2XKS>; Tue, 29 Jun 1999 19:10:18 -0400
Received: by vger.rutgers.edu id <S155489AbPF2XDl>; Tue, 29 Jun 1999 19:03:41 -0400
Received: from 00-60-67-24-29-83.bconnected.net ([209.53.17.55]:1395 "EHLO lambdamoo.to") by vger.rutgers.edu with ESMTP id <S155455AbPF2XAU>; Tue, 29 Jun 1999 19:00:20 -0400
Date: Tue, 29 Jun 1999 15:58:15 -0700 (PDT)
From: Jonathan Walther <krooger@debian.org>
To: linux-kernel@vger.rutgers.edu
cc: torvalds@transmeta.com
Subject: FWD: *BSD Samba enhancements kick Linux/NT ass
Message-ID: <Pine.LNX.3.96.990629155611.5163A-100000@lambdamoo.to>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

---------- Forwarded message ----------
Date: Tue, 29 Jun 1999 22:07:15 +0000 (GMT)
From: Terry Lambert <tlambert@primenet.com>
To: "Jordan K. Hubbard" <jkh@zippy.cdrom.com>
Cc: seth@freebie.dp.ny.frb.org, tlambert@primenet.com, krooger@debian.org,
    jesus.monroy@usa.net, advocacy@FreeBSD.ORG
Subject: Re: [Linux vs. NT, take 2.]

> > Is there any validity to the discussion on -hackers that real-world
> > application performance doesn't corroborate the poor benchmark results
> > (as far as FreeBSD is concerned)?  I'm less concerned that benchmarks
> 
> Plenty.  Netbench is notorious for not actually testing the load
> balancing abilities or performance degradation curve as the number of
> users increases, both important factors in "real life" testing.
> Unfortunately, real-life testing is not easily quantified and so we
> have netbench instead.  Until somebody writes something better, that
> will be the benchmark to jury-rig your responses for in order to come
> out ahead on benchmark tests. :-)

The difference between the standalone test that Julian was using
and the netbench test is not insignificant.

However, even the Netbench test is somewhat representative, in that
it uses actual code stripped out of Lotus Notes, Word Perfect, and
other real applications to create the client load.

The thing that is unrealistic about netbench is that it performs
its operations back to back, so instead of "create a file", "edit
a long time", "save the edits", it becomes "create a file", "save
the edits".

If anything, this is a bias *in favor* of large data caches, and
would be pro-FreeBSD.


There are a number of obvious fixes one could make to SAMBA to
ensure that the SAMBA numbers were much better; I ran into this
same benchmark (and the much tougher LANPERF benchmark, which
_does_ similate the "edit a long time" delay) when working on the
NetWare for UNIX server product.  There are also a number of
obvious changes to FreeBSD that would speed up the benchmark, as
well.  Here are some of them:

1)	SAMBA should cache the first 9k of any executable file;
	the clients loader behaviour for executable files is
	repetitive and non-sequential during the first 9k.  Caching
	the first 9k will have the following effects:

	A)	The data will be there for the repetitive
		non-sequential requests when the requests
		are made

	B)	The requests, since they will result in
		cache hits, will not, by their non-sequential
		nature, defeat sequential access detection
		based read-ahead.

2)	FreeBSD should export an API that does SMB globbing in
	the kernel.  This will mean that only data matching the
	pattern need be pushed over the user/kernel boundary,
	which will reduce the amount of data pushed by a directory
	iteration by one half (directory iteration is done
	seperately for files and directories by the clients).
	SAMBA must be modified to utilize this interface.

3)	SMB clients, by the nature of the NETBIOS calls that
	a client must initiate to get data, are in fact a
	combination of other calls and a "stat" in almost all
	cases.  There are several things you can do about this:

	A)	When FreeBSD is doing a directory iteration, it
		should pre-fault the inode of each file returned
		during the iteration (perhaps using the API in #2,
		above), in the expectation that the stat
		information will be requested as well.

	B)	The API in #2, above, should probably return the
		stat information, as well as merely the file name.

	C)	It is reasonable to want to modify or provide
		aternative versions of the open, close, and other
		calls that return stat information, as well.

4)	SMB clients will do case insensitive lookups for files
	that they want to execute or open.  The SAMBA code must
	implement case insensitivity in user space code.  In
	the case of a "miss" (e.g. a case mismatch on the stored
	vs. the requested file name), the SAMBA code must iterate
	the directory (very expensive) in order to select the
	matching file name.  This implies that there would be a
	significant benefit from performing the case insensitive
	lookup in the kernel.  This is _not_ a variant of #2,
	above, since it means alternate interfaces for state, open,
	unlink, rename, and other file-name taking calls.

These changes alone would result in a significant performance
increase for SAMBA clients.

More advanced changes would be useful as well.  For example, if
you examine the locality model for SMB using programs, you conclude
that the following would also be useful:

5)	A method for triggering read-ahead behaviour from user
	space to usefully trade on the fact that the nature of
	the client/server communication is request/response.  The
	read-into-cache could be occurring while the client is
	receiving and acting on the data sent it, prior to the
	next request.  The trigger would be pulled after the send
	to the client, prior to the engine sleeps waiting for
	more client requests.  As a suggestion, a read of zero
	bytes would make a useful read-ahead trigger.

6)	Add to the kernel based globbing a negative hit cache
	based on pattern indices instead of actual strings,
	per the standard negative hit directory entry lookup
	cache.

7)	Add to the case insensitve searches a hit lookaside
	cache.  This could be as simple as placing the looked
	up name, as well as the matching name, into the directory
	entry lookup cache.

8)	WINDOWS clients are well known to search many locations
	for a file, frequently for many different files in a
	single program instance.  By implementing predictive
	lookaside cacheing, it should be possible to satisfy
	the first failing request with the sixth (succesful)
	request predicted for the file, based on past searches
	of a similar nature.  This is functually similar to an
	inversion of the FreeBSD use of /usr/compat/.

9)	Clearly, a lot of time is wasted in translating SMB
	locks in and out.  This is both because SMB locks are
	non-coelesced, by definition, resulting in a redundant
	UNIX "shadow" being maintained for interoperability,
	and because locks at negative and/or "outrageous" file
	offsets are often used by programs, such as Excel and
	Word, to implement internal semaphores.


This list is hardly exhaustive, but you should get the idea... a
few simple changes (except the globbing and case insensitivity
changes, since FreeBSD's lookup API is incapable of forwarding
POSIX namespace escapes more than one path component deep because
of the way its currentl [mis]written and the locking, due to the
architectural deficiencies in the locking code not permitting
non-coelescing locks via a parameter change), probably capable
of being encapsulated in a single kernel module, would result
in a significant performance improvement, with no other changes.

Now if you wanted to go "whole hog", you would probably turn around
SMB reads and writes seperately from all other SMB operations, and
load a kernel module that knew about SMB reads and writes in order
to do the dirty work... this would resolve the fact that readfile()
is useless for SMB (and any other protocol that depends on data
object size and/or a canonical wire format different from the
cannonical storage format, e.g. POP3, IMAP4, SMTP, ACAP, LDAP, etc.).


					Terry Lambert
					terry@lambert.org
---
Any opinions in this posting are my own and not those of my present
or previous employers.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
