Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbULABn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbULABn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULABkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:40:20 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:17082 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261192AbULABgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:36:41 -0500
Message-ID: <41AD1FE2.3030500@comcast.net>
Date: Tue, 30 Nov 2004 20:35:30 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System
References: <41ABF7C5.5070609@comcast.net> <200411301828.iAUISgf8031548@turing-police.cc.vt.edu>
In-Reply-To: <200411301828.iAUISgf8031548@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
| On Mon, 29 Nov 2004 23:32:05 EST, John Richard Moser said:
|
| (Somebody else can address the performance issues - I'll stick to the
| parts I understand.. ;)
|
|
|>- - A design based around preventing information leaking by guaranteed
|>secure erasure of data (insofar that the journal even will finish wiping
|>out data when replaying a transaction)
|
|
| Consider carefully what threat model you have here - your choices will be
| constrained by it.  If you don't know your threat model, it's time to look
| for other features to design around...
|

:)

| (your comment indicates a level of confusion regarding what paranoia
is desired)
|
| Note well that you need to define "Guaranteed secure erasure" - at
least for
| US DOD contractors, DOD 5220-22.M requires 3 over-writes (a character, its
| complement, and random) and verify).  That's good for SECRET and below
- - but

I've read DOD 5220-22.M chapte. . . oh fuck  it *cut* *paste*

Strips of up to 512 contiguous bytes may be written at a time during the
erasure, and may possibly consist of overwrite all affected locations
with a random pattern, binary zeros, binary ones, then a random
character and verifying, as derived by combining the methods given in
DOD 5220.22-M[6], Chapter 8, section 8-306, for sanitizing removable and
non-removable rigid disks using method (d) and EEPROMs (i.e. memory
cards for digital cameras and music players) (h).


^^^  From my original notes in the document I'm writing where I first
alluded to a new "secure" file system (which quickly became a much
higher goal).

| TOP SECRET and higher still require physical destruction of the media.
  Also,
| they punt on the issue of over-writing a sector that's been
re-allocated by
| the hardware (apparently the chances of critical secret data being left in
| a reallocated block but still actually readable are "low enough" not
to worry).
|

I can't make the FS burn the disk, sorry.  You need to use kerosene.

| Also, 5220-22.M is more concerned with the exposure of "You surplus
the machine
| and forgot to wipe the drives" - there's a whole *different* set of rules
| regarding how you keep an attacker who steals the system (physical access
| issues) or gets root access (this is a *tough* one) from scavenging the
| drives....
|

hey I'm working for general setting.  Nobody said this was going to be
"We've taken care of everything, just rm -rf / and you're good to go."
There are certain guarantees that I can't make from the FILE SYSTEM;
they require outside forces.  What I can guarantee is that you won't
crack open shopping_list.txt after a crash and see a part of previously
erased secret_military_assult_on_iranian_nuclear_breeder_reactors.txt

|
|>2)  Are there any other security concerns aside from information leaking
|>(deleted data being left over on disk, which may pop up in incompletely
|>written files)?
|
|
| Which of the following are you worried about:
|
| 1) On a filesystem that does metadata journalling but not data
journalling,
| it's possible for a file to be extended by a write(), the metadata is
| journalled, but the system fails before the actual data makes it to
disk.  As a
| result, after the system comes up, stale data is present in the file,
causing a
| small data exposure

Clipped that off already, that's what I was talking about in the
original message ("information leaking").

| and large reliability issues (opening a file with
| OpenOffice will almost certainly cause Very Bad Errors if it's a file
that was
| in the process of being saved when the system went down, so you're
actually
| reading blocks of somebody else's old Fortran source code...)

I can't help data loss; it's impossible.  The data either gets to disk
or it doesn't.  Unless one big write() was made between fopen() and
fclose(), you have a window of fuxxx0rzd data if the machine goes down--
even with roll forward and roll back full data journaling.

| Note that this
| exposure does *NOT* need you to clear data out of the journal - merely to
| journal data (or find other ways to guarantee you never allocate a
stale block
| of data).  This is why I suggest that you're unclear regarding your threat
| model.
|

If I make numorous write() calls from an app, the fs will journal them
seprately, or periodically, or run out of journal space (actually my
journal design would expand the journal until it ran out of FS space)
trying to heuristically determine what is one write and prevent data
destruction.

When you talk about data loss, remember that even full journaling relies
on data making it to disk.  Stop trying to make it safe to flip the big
switch; you're not gonna do it.

| 2) If you're worried about a well-funded attacker managing to scavenge
secure
| data out of the journal, what do you do about the attacker scavenging
*the rest
| of the disk, including existing files*?  (Hint - cryptoloop is the correct
| answer here, unless you think Jaari Russo is right, in which case *his*
| encrypted filesystem stuff is the right answer).

cryptoloop or crypt extensions is a nice answer; though the journal
needs to be non-crypt.  Cryptoloop + journal == bad, unless journal is
on another device.  :)

as for well-funded attackers, eh.  The built-in secure erase is mainly
paranoia, although it makes `rm -rf /` THE utility to perform the above
erasure method on all file data.  Encryption extensions are the only way
to ensure instant destruction (secure delete takes time) without a
degausser :)  Of course, I could rm -f ~/.fs/my_cypher_key and a cypher
extension would be left keyless.  Cypher *extension* mind you; I'm not
designing encryption into the core of the FS, just leaving it a
possibility in the future (xattrs-- this is the same intention ext2 had
originally iirc regarding compression).

|
| Alternatively, you may wish to consider a filesystem that does crypto on a
| per-file basis - be prepared to deal with some very hairy
key-management and
| information leakage problems if you pursue this route...
|

yeah, could embed the user's keys into the FS and use a utility to erase
them in emergency; and I could also use a special key loaded from a
floppy or usb stick and kept (frobnicated) in memory to encrypt "more
sensitive" files.  Need to destroy the keys?  blow_my_key or
blow_all_keys, and set fire to your usb stick.

| In any case, both cryptoloop and Jaari's loop-aes address the "disk
captured by
| the attacker" issues, but don't do much for "attacker gets root" -
that's a
| whole DIFFERENT set of problems...
|

"attacker gets root" is doable, but only with a multilayered
defense-in-depth matrix with host based intrusion prevention systems.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBrR/hhDd4aOud5P8RAoo+AJ9fdn18OaGn56I0LHxgA0LdDQiPHACfb/D5
V3MiVjkdazvy1x3ObdOzJ0w=
=Hh25
-----END PGP SIGNATURE-----
