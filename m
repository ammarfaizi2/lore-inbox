Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSEJRZ2>; Fri, 10 May 2002 13:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316081AbSEJRZ1>; Fri, 10 May 2002 13:25:27 -0400
Received: from bitmover.com ([192.132.92.2]:64160 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316080AbSEJRZ1>;
	Fri, 10 May 2002 13:25:27 -0400
From: Larry McVoy <lm@bitmover.com>
Date: Fri, 10 May 2002 10:25:24 -0700
Message-Id: <200205101725.g4AHPOH05574@work.bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: BK problem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, we've got a problem in one of Linus' trees and it has started to
propagate around.  I need your help to track it down and fix it.
Please run the following script on your Linux BK trees and contact
me if it tells you to do so.  You can fix up the tree by doing the
following (warning: takes lots and lots of CPU time so if you don't
need the tree it may well be faster to reclone tomorrow after I finish
fixing the trees on bkbits).

cp SCCS/s.ChangeSet .		# save it just in case
bk checksum -vf ChangeSet	# takes ~15 minutes on 1Ghz K7

The set of trees which I know are bad on bkbits are:

    gkernel/main
    linus/linux-2.5
    linux-isdn/linux-2.5.export
    linuxvm/linus-2.5
    ppc/for-linus-ppc64

Here's the script, the usage is

	sh SH list of roots of the trees

------------ cut here and store in SH ------------------
#!/bin/sh

test -z "$1" && {
	echo "Usage: $0 repo [repo repo...]"
	exit 0
}
ID="torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864"
HERE=`pwd`
for tree in "$@"
do	cd $HERE
	test -f $tree/SCCS/s.ChangeSet || continue
	cd $tree
	test "`bk identity`" = "$ID" || {
		# echo Skipping $tree because ID does not match
		continue
	}
	for i in 20020507175820 20020507172730 20020507171942 \
		20020507171816 20020507165445
	do	bk findkey -t$i ChangeSet
	done | bk prs -hnd:KEY: - | bk _keysort > /tmp/k$$
	test -s /tmp/k$$ || {
		echo $tree is OK, does not have the bad keys
		rm /tmp/k$$
		continue
	}
	cmp -s /tmp/k$$ - <<EOF
greg@kroah.com|ChangeSet|20020507171816|03715
greg@kroah.com|ChangeSet|20020507171942|33284
greg@kroah.com|ChangeSet|20020507175820|37065
ink@jurassic.park.msu.ru|ChangeSet|20020507165445|24759
mochel@segfault.osdl.org|ChangeSet|20020507172730|37035
EOF
	test $? -eq 0 || {
		echo =========================================================
		echo $tree needs fixing, contact lm@bitmover.com
		echo =========================================================
		rm /tmp/k$$
		continue
	}
	echo $tree is fine, it has the fixed keys
	rm /tmp/k$$
done
