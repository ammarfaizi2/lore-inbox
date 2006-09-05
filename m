Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWIEUU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWIEUU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWIEUU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 16:20:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:7598 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030250AbWIEUU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 16:20:28 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44FDDBE7.1040906@s5r6.in-berlin.de>
Date: Tue, 05 Sep 2006 22:19:51 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking
 detected
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>	 <20060905111306.80398394.akpm@osdl.org> <a44ae5cd0609051249y767eed58ja1fe1b27858f5cd@mail.gmail.com>
In-Reply-To: <a44ae5cd0609051249y767eed58ja1fe1b27858f5cd@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> I am having trouble with backing out the git-ieee1394 patches. 

Take a look at
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/broken-out/series

There are a number of 1394 subsystem patches; the last one is
ieee1394-sbp2-more-help-in-kconfig.patch. (That's supposed that no
further external patches touch ieee1394.) The order of patches in
patch-series is how they were applied.

Not all of these patches depend on each other, but some do. So the
safest way to unapply them is to follow the exact reverse order.

One tool to make this a little bit easier is quilt. This should be
available as a package for most distributions. I haven't tried it myself
yet, but akpm's "broken-out" patch distribution can be manipulated by
quilt. I guess it works like the following method --- which has the
drawback that you cannot use it with your existing linux-2.6.18-rc5-mm1
build. (Except with a trick, see below.)

Install linux-2.6.18-rc5.
Unpack
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/2.6.18-rc5-mm1-broken-out.tar.bz2

Rename the broken-out directory to "linux-2.6.18-rc5/patches".
Copy your linux-2.6.18-rc5-mm1/.config to linux-2.6.18-rc5.

Apply all the patches, in the order given by patches/series:
$ cd linux-2.6.18-rc5
$ quilt push -a

Fetch all of
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/hot-fixes/
and add it on top of all regular mm1 patches:
$ quilt import ~/hot-fixes/*.patch
$ quilt push -a

Now open patches/series in an editor. Find the ieee1394 patches. Move
all of them to the bottom of the series file. Save it. You can now
revert each 1394 patch by
$ quilt pop

Build the kernel as usual.

Now to the trick I mentioned before. To avoid starting from
linux-2.6.18-rc5 even though you already built and booted
2.6.18-rc5-mm1, perform the steps above on top of 2.6.18-rc5 until and
including the step where you imported and pushed the hot-fixes. After
that, just copy the patches/ and .pc/ directories over to your existing
2.6.18-rc5-mm1. Check the effect with
$ cd ../2.6.18-rc5-mm1
$ quilt top
This should give a message that the last hot fix is topmost. It should
now be possible to run "quilt pop" etc.

Anyway; manually removing the ieee1394 patches by looking at the order
in the series file may be faster than setting up quilt and the second
kernel source tree.
-- 
Stefan Richter
-=====-=-==- =--= --=-=
http://arcgraph.de/sr/
