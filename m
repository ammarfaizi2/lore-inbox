Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVDKSct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVDKSct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVDKSci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:32:38 -0400
Received: from [221.216.56.203] ([221.216.56.203]:62946 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261884AbVDKSav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:30:51 -0400
Date: Tue, 12 Apr 2005 02:18:16 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200504111818.j3BIIGT30775@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: New SCM and commit list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-11 Linus Torvalds wrote:
>Then the bad news: the merge algorithm is going to suck. It's going to be
>just plain 3-way merge, the same RCS/CVS thing you've seen before. With no
>understanding of renames etc. I'll try to find the best parent to base the
>merge off of, although early testers may have to tell the piece of crud
>what the most recent common parent was.

	I've been surprised at how well it works to put each character on a
separate line, pipe the input into diff3 and then join the lines
back together.  For example, let's consider the case of
a adding parameters to a function.  Here one version adds a parameter
before the existing parameter, and another version adds another parameter
after the existing parameter:

$ cat orig
call(bar);
$ cat ver1
call(foo,bar);
$ cat ver2
call(bar,baz);
$ charmerge ver1 orig ver2
call(foo,bar,baz);

	A more practically scaled application that I tried was with
another filter that I wrote that would automatically resolve certain
types of diff3 conflicts[1].  With that filter, I took the SCSI
FlashPoint driver, and made an edited version by piping it through GNU
indent, which not only reindents, but also splits and joins lines.
I made a second edited version by changing all 146 instances of
"SYNC" to "GROP" in the original.  It merged apparently successfully,
giving me a GNU indented version with all of the keyword changes.
The version of this resolution program dies if it his a diff3
conflict of a type that it is not prepared to resolve.  I'll post
it once I've got it properly preserving the conflicts that it
doesn't try to fix.  In the meantime, here is an illustrative
script to do get diff3 to do character-based merges, although it
gives garbage results if there are any conflicts.

[1] The type of conflict that was automatically resolved is as follows:

	variant1 = <prepended-new-text><original><appended-new-text>

	result --> <prepended-new-text><variant2><appended-new-text>

	...this is actually exactly the order one would want in the
case where <original> also occurs in variant2, but it was close
enough for this test.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l



#!/bin/sh
# Usage: charmerge ver1_file orig_file ver2_file

lineify() {
	sed 's/\([^\n]\)/\1\
/g'
}

unlineify() {
	awk '/^$/ {print $0} /^..*/ { printf "%s", $0}'
}

tmpdir=/tmp/charmerge.$$

mkdir $tmpdir
lineify < "$1" > $tmpdir/1
lineify < "$2" > $tmpdir/2
lineify < "$3" > $tmpdir/3
diff3 -m $tmpdir/{1,2,3} | unlineify
rm -rf $tmpdir
