Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269333AbUHZSy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269333AbUHZSy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269373AbUHZSwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:52:51 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:50404 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269342AbUHZSkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:40:22 -0400
Message-ID: <412E2E86.8050909@slaphack.com>
Date: Thu, 26 Aug 2004 13:40:06 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Rik van Riel <riel@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261152340.27909-100000@chimarrao.boston.redhat.com> <1093536282.5482.6.camel@leto.cs.pocnet.net>
In-Reply-To: <1093536282.5482.6.camel@leto.cs.pocnet.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Christophe Saout wrote:

| Yes, the main compound stream unaware applications would see would just
| be a writable view of its contents. Probably not trivial to implement
| but doable.

Not the main stream, I think, but we do need a way to make "eight-stream
octopus" files portable.  But there needs to be a copy(2) syscall, and
apps need to start supporting it.  After all, copy-on-write was planned
for Reiser4, now 4.1*.  And don't anyone dare suggest "userland library".

| It should be a simple format. Something simliar to tar. The worst thing

Simple, yes.  Similar to tar, no.

How about a serializer plugin?  foo.mp3/serialize (say) should return
some single stream which contains all of foo.mp3.  It could work for
directories as well, recursively, at least on the same filesystem --
you'd back up by doing

cp /serialize /backup/20040826

This has two potential problems.  One is security -- I want to be able
to serialize foo.mp3 without being root, but root doesn't want me to be
able to serialize /etc and thus get access to shadow.

The second problem is that in order to actually be used for backup, we
need snapshots, which are not done yet*.  Currently, it'd have to lock
the file/directory (recursively), which you don't want to do to entire
live filesystems...  So, no massive backups of live systems yet, but
definitely useful for sending around mp3s and such.

| that can happen is people start writing plugins for every existing
| compound format out there. It should be the other way around, agree on a
| simple compound format and encourage applications to use this one if the
| want to use this advantage.

For the format, I vote for whatever format we're using at the storage
layer.  It'd be a lot faster that way, both in execution time (I think)
and in development time (I'm sure).  Plus, imagine the restore:

cat /backup/20040826 > /dev/hda5
resizefs_reiser4 /dev/hda5


* Disclaimer -- all this is "I think, last I checked".


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQS4uhngHNmZLgCUhAQKTaw//WCHt0Umgaf0GaMUpEr0PLhiXhFTYQqKV
MKgpVt6SjP7lC9k3RbuCnPCLyOJGb9lIqo+Wd+B3b4TcQAQd4OYsSI6WiMPQjxXY
OdNnB7/xYkkd/ULw7/7IGcokyc4FRDjhTyOMe4KscQS/6uhdX1dCriCCzVq7iELx
u3HLulunHv1bwHbnZ6CyEZdQEr3j8XUu62+IXPTc6hWnfRRCvskV8Y4qyyVd8wFY
Kp44TxbJJSzDeWmuI/YYkxVJsPmSoxRLxmw9/B8D72KGNg1SYLnM4ueIc5IV8RH0
kG/o8tzwTRxE/eqfcHP+UBt6yXZR/i84DDogAmJFKP73g9X+U+J5o/kONOBQODhY
qY5LUwQu4UjlzXttMxC4NmZPESdUw85DgC/GhTQlsBMYBcmQHmpLAK67qt83+Kg0
1QqGPqJm4HL4weHLNknJ0DukLNKH7Bw5CVg335IwruaoiKUG7HDgthUhA319FCab
VvYa+bEfeBEw9RorSE/gWM9Hg73luM7eoSzKc9zHgx++cACTi8SBsTFWqI2FU6DX
UyWG5sNPybOiczpPsFu5S5FJBBNM3fLjkfeYgfqxUIjxGTNeUn/g/9I5ShUrCF1o
T+3nd1jFxfoehYGkfGB2YLpdeNVBv4EdKK16j39+iducfJrXnRlL1yjdo/Kte2uz
tTQZw3uTnhU=
=7bBF
-----END PGP SIGNATURE-----
