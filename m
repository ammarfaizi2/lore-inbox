Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132702AbQL2W02>; Fri, 29 Dec 2000 17:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbQL2W0S>; Fri, 29 Dec 2000 17:26:18 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:17586 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S132702AbQL2WZ6>; Fri, 29 Dec 2000 17:25:58 -0500
Message-ID: <3A4D082F.CD3215B0@metabyte.com>
Date: Fri, 29 Dec 2000 13:54:55 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: zaitcev@metabyte.com
Subject: Re: How to write patches
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2000 21:55:27.0137 (UTC) FILETIME=[0D9DD910:01C071E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff's descriprion is very informative, but his emphasis
is somewhat different from what I find difficult with patches.
First, for the life of me I was unable to remeber which
argument goes first (DaveM was mad every time). Second, I kept
forgetting to keep the base tree a diff against that instead of
the latest tree.

So, here is the patch release cycle in my view, with all
small details.

1. I pick a "base" tree which I will hack on. Suppose that
we start with 2.2.17-pre22. So, I download linux-2.2.16.tar.bz2
from Linus place and patch-pre22.bz2 from Alan's place.
THESE MUST BE SAVED after I unpack them.

2. I unpack. Note that I have base release in the directory name.

bzip -d < linux-2.2.16.tar.bz2| tar xf -
mv linux linux-2.2.17-pre22
bzip -d < patch-pre22.bz2| patch -d linux-2.2.17-pre22 -p1

3. One way or another, I make two trees, one of which is "base"
and another is "work".

mkdir linux-2.2.17-pre22-p3
(cd linux-2.2.17-pre22 && tar cf - .)| (cd linux-2.2.17-pre22-p3 && tar xf -)

4. Hack

cd linux-2.2.17-pre22-p3
make oldconfig
(make dep && make bzImage) > build.out 2>&1
........... etc.

The step #4 will take some time, and kernel will get developed
while we sit on it. Normally it takes me anywhere from 3 weeks
to 3 months to come up with something useable.

5. Time to diff and submit, but Oops, Linus published 2.2.17!
Now you will see how it all REALLY works.

5a. Unpack

bzip -d < linux-2.2.17.tar.bz2| tar xf -
mv linux linux-2.2.17

6. Diff your base tree and your changed tree. Do not settle
for .orig files! Diff whole thing!

6a. Get dontdiff from Tigran, it's helpful
wget http://www.moses.uklinux.net/patches/dontdiff

6b. Diff, but notice the argument order!!

diff -urN --exclude-from=dontdiff \
  linux-2.2.17-pre22 linux-2.2.17-pre22-p3 > linux-2.2.17-pre22-p3.diff

6c. In most cases you need to remove junk from your diff,
even with dontdiff.

7. Apply your diff to the new tree (remember,
never touch the base tree):

mkdir linux-2.2.17-p3
(cd linux-2.2.17 && tar cf - .)| (cd linux-2.2.17-p3 && tar xf -)
patch -d linux-2.2.17-p3 -p1 < linux-2.2.17-pre22-p3.diff

If I am lucky, my patch applies cleanly or with a small
fuzz factor. But otherwise there may be a conflict that I
shall resolve by hand:

find linux-2.2.17-p3 -name '*.rej'
# perhaps  cat something.rej >> something && vi something

This part is actually important. If I sent linux-2.2.17-pre22-p3.diff
to Alan, he would try to apply it against then-current 2.2.17
(if not 2.2.18-pre2), get the same conflict, and dump the patch
into the void. Always resolve yourself, do not ride the maintainer.

8. Now I can send the patch to Alan and wait.

9. Once my patch is tentatively applied, say, in 2.2.18-pre2,
I re-download it, and do the whole thing again to make sure
that it was applied right. Alan has a habit of editing patches
on the fly, so I must keep tabs on it.

10. By this time 2.2.17-pre22 base are obsolete so we may
delete them (but evacuate good .config first or you'd start
from defconfig again):

cp linux-2.2.17-pre22-p3/.config linux-2.2.18-pre3/
rm -rf linux-2.2.17-pre22 linux-2.2.17-pre22-p3
# Sometimes I keep linux-2.2.17-pre22-p3.diff a little longer
# after the base moved on, for the sake of slower paced collegues.

And the ball just keeps rolling.

-- Pete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
