Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbUK3Scd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbUK3Scd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUK3Saj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:30:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52145 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262243AbUK3S2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:28:48 -0500
Message-Id: <200411301828.iAUISgf8031548@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System 
In-Reply-To: Your message of "Mon, 29 Nov 2004 23:32:05 EST."
             <41ABF7C5.5070609@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <41ABF7C5.5070609@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1869105040P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Nov 2004 13:28:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1869105040P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Nov 2004 23:32:05 EST, John Richard Moser said:

(Somebody else can address the performance issues - I'll stick to the
parts I understand.. ;)

> - - A design based around preventing information leaking by guaranteed
> secure erasure of data (insofar that the journal even will finish wiping
> out data when replaying a transaction)

Consider carefully what threat model you have here - your choices will be
constrained by it.  If you don't know your threat model, it's time to look
for other features to design around...

(your comment indicates a level of confusion regarding what paranoia is desired)

Note well that you need to define "Guaranteed secure erasure" - at least for
US DOD contractors, DOD 5220-22.M requires 3 over-writes (a character, its
complement, and random) and verify).  That's good for SECRET and below - but
TOP SECRET and higher still require physical destruction of the media.  Also,
they punt on the issue of over-writing a sector that's been re-allocated by
the hardware (apparently the chances of critical secret data being left in
a reallocated block but still actually readable are "low enough" not to worry).

Also, 5220-22.M is more concerned with the exposure of "You surplus the machine
and forgot to wipe the drives" - there's a whole *different* set of rules
regarding how you keep an attacker who steals the system (physical access
issues) or gets root access (this is a *tough* one) from scavenging the
drives....

> 2)  Are there any other security concerns aside from information leaking
> (deleted data being left over on disk, which may pop up in incompletely
> written files)?

Which of the following are you worried about:

1) On a filesystem that does metadata journalling but not data journalling,
it's possible for a file to be extended by a write(), the metadata is
journalled, but the system fails before the actual data makes it to disk.  As a
result, after the system comes up, stale data is present in the file, causing a
small data exposure and large reliability issues (opening a file with
OpenOffice will almost certainly cause Very Bad Errors if it's a file that was
in the process of being saved when the system went down, so you're actually
reading blocks of somebody else's old Fortran source code...)  Note that this
exposure does *NOT* need you to clear data out of the journal - merely to
journal data (or find other ways to guarantee you never allocate a stale block
of data).  This is why I suggest that you're unclear regarding your threat
model.

2) If you're worried about a well-funded attacker managing to scavenge secure
data out of the journal, what do you do about the attacker scavenging *the rest
of the disk, including existing files*?  (Hint - cryptoloop is the correct
answer here, unless you think Jaari Russo is right, in which case *his*
encrypted filesystem stuff is the right answer).

Alternatively, you may wish to consider a filesystem that does crypto on a
per-file basis - be prepared to deal with some very hairy key-management and
information leakage problems if you pursue this route...

In any case, both cryptoloop and Jaari's loop-aes address the "disk captured by
the attacker" issues, but don't do much for "attacker gets root" - that's a
whole DIFFERENT set of problems...


--==_Exmh_1869105040P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBrLvZcC3lWbTT17ARAr9YAKDXgBcUakoIPySzor05CgrnVFcs6ACeN4Ln
60RTKoza5Q/hQFUPB6YhKgo=
=lWbJ
-----END PGP SIGNATURE-----

--==_Exmh_1869105040P--
