Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVDHHRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVDHHRd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVDHHRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:17:32 -0400
Received: from jose.lug.udel.edu ([128.175.60.112]:5321 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S262719AbVDHHRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:17:21 -0400
From: ross@lug.udel.edu
Date: Fri, 8 Apr 2005 03:17:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408071720.GA23128@jose.lug.udel.edu>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2005 at 09:42:04PM -0700, Linus Torvalds wrote:
> In the meantime (and because monotone really _is_ that slow), here's a
> quick challenge for you, and any crazy hacker out there: if you want to
> play with something _really_ nasty (but also very _very_ fast), take a
> look at kernel.org:/pub/linux/kernel/people/torvalds/.

Interesting.  I like it, with one modification (see below).

> First one to send me the changelog tree of sparse-git (and a tool to
> commit and push/pull further changes) gets a gold star, and an honorable
> mention. I've put a hell of a lot of clues in there (*).

Here's a partial solution.  It does depend on a modified version of
cat-file that behaves like cat.  I found it easier to have cat-file
just dump the object indicated on stdout.  Trivial patch for that is included.

Two scripts are included:

1) makechlog.sh takes an object and generates a ChangeLog file
consisting of all the parents of the given object.  It's probably
breakable, but correctly outputs the sparse-git changes when run on
HEAD.  Handles multiple parents and breaks cycles.

This adds a line to each object "me <sha1>".  This lets a change
identify itself.

It takes 35 seconds to produce all the change history on my box.  It
produces a single file named "ChangeLog".

2) chkchlog.sh uses the "me" entries to verify that #1 didn't miss any
parents.  It's mostly to prove my solution reasonably correct ::-)

The patch is below, the scripts are attached, and everything is
available here:

http://lug.udel.edu/~ross/git/

Now to see what I come up with for commit, push, and pull...

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37


--- cat-file.orig.c     2005-04-08 01:53:54.000000000 -0400
+++ cat-file.c  2005-04-08 01:57:51.000000000 -0400
@@ -11,18 +11,11 @@
        char type[20];
        void *buf;
        unsigned long size;
-       char template[] = "temp_git_file_XXXXXX";
-       int fd;
 
        if (argc != 2 || get_sha1_hex(argv[1], sha1))
                usage("cat-file: cat-file <sha1>");
        buf = read_sha1_file(sha1, type, &size);
        if (!buf)
                exit(1);
-       fd = mkstemp(template);
-       if (fd < 0)
-               usage("unable to create tempfile");
-       if (write(fd, buf, size) != size)
-               strcpy(type, "bad");
-       printf("%s: %s\n", template, type);
+       printf ("%s", buf);
 }


--cWoXeonUoKmBZSoM
Content-Type: application/x-sh
Content-Disposition: attachment; filename="makechlog.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A####=0A#### Call this script with an object and it will produ=
ce the change=0A#### information for all the parents of that object=0A####=
=0A# multiple parents test 1d0f4aec21e5b66c441213643426c770dc6dedc0=0A# par=
ents: ffa098b2e187b71b86a76d3cd5eb77d074a2503c=0A# 6860e0d9197c7f52155466c2=
25baf39b42d62f63=0A=0A# regex for parent declarations=0APARENTS=3D"^parent =
[A-z0-9]{40}$"=0ATMP=3D`mktemp`=0A	=0A# takes an object and generates the o=
bject's parent(s)=0Aunpack_parents () {=0A	cat-file $1 > $TMP=0A	echo "me $=
1" >> ChangeLog=0A	cat $TMP >> ChangeLog=0A	echo -e "\n--------------------=
------\n" >> ChangeLog=0A	RENTS=3D`egrep "$PARENTS" $TMP | sed -r s/parent\=
 //g | xargs echo`=0A=0A	# if the last object had no parents, return=0A	if =
! egrep -q "$PARENTS" $TMP; then=0A		return;=0A	fi=0A=0A	#useful for testin=
g=0A	#echo $RENTS=0A	#read=0A	for i in `echo $RENTS`; do=0A		# break cycles=
=0A		if grep -q "me $i" ChangeLog; then=0A			echo "Already visited $i"=0A		=
	continue=0A		else=0A			unpack_parents $i=0A		fi=0A	done =0A}=0A=0Aunpack_p=
arents $1=0Arm $TMP=0A
--cWoXeonUoKmBZSoM
Content-Type: application/x-sh
Content-Disposition: attachment; filename="chkchlog.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0Afor i in `egrep "^parent [A-z0-9]{40}$" ChangeLog | awk '{ pr=
int $2 }'`; do=0A	echo -n "$i: ";=0A	if egrep -q "^me $i" ChangeLog; then=
=0A		echo "found";=0A	else=0A		echo -e "\anot found";=0A	fi=0Adone=0A
--cWoXeonUoKmBZSoM--
