Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVABQQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVABQQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 11:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVABQQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 11:16:57 -0500
Received: from open.hands.com ([195.224.53.39]:51874 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261265AbVABQQx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 11:16:53 -0500
Date: Sun, 2 Jan 2005 16:26:52 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org, xen-devel@lists.sf.net
Subject: [XEN] using shmfs for swapspace
Message-ID: <20050102162652.GA12268@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

am starting to play with XEN - the virtualisation project
(http://xen.sf.net).

i'll give some background first of all and then the question - at the
bottom - will make sense [when posting to lkml i often get questions
asked that are answered by the background material i also provide...
*sigh*]


each virtual machine requires (typically) its own physical ram (a chunk
of the host's real memory) and some virtual memory - swapspace.  xen
uses 32mb for its shm guest OS inter-communication.

so, in the case i'm setting up, that's 5 virtual machines (only one of
which can get away with having only 32mb of ram, the rest require 64mb)
so that's five lots of 256mbyte swap files.

the memory usage is the major concern: i only have 256mb of ram and
you've probably by now added up that the above comes to 320mbytes.

so i started looking at ways to minimise the memory usage.

first, reducing each machine to only having 32mb of ram, and secondly,
on the host, creating a MASSIVE swap file (1gbyte), making a MASSIVE
shmfs/tmpfs partition (1gbyte) and then creating swap files in the
tmpfs partition!!!

the reasoning behind doing this is quite straightforward: by placing the
swapfiles in a tmpfs, presumably then when one of the guest OSes
requires some memory, then RAM on the host OS will be used until such
time as the amount of RAM requested exceeds the host OSes physical
memory, and then it will go into swap-space.

this is presumed to be infinitely better than forcing the swapspace to
be always on disk, especially with the guests only being allocated
32mbyte of physical RAM.

here's the problems:

1) tmpfs doesn't support sparse files

2) files created in tmpfs don't support block devices (???)

3) as a workaround i have to create a swap partition in a 256mb file,
   (dd if=/dev/zero of=/mnt/swapfile bs=1M count=256 and do mkswap on it)
   then copy the ENTIRE file into the tmpfs-mounted partition.

   on every boot-up.

   per swapfile needed.

eeeuw, yuk.

so, my question is a strategic one:

	* in what other ways could the same results be achieved?

	in other words, what other ways can i publish block
	devices from the master OS (and they must be block
	devices for XEN guest OSes to be able to see them)
	that can be used as swap space, that will be in RAM if possible,
	bearing in mind that they can be recreated at boot time,
	i.e. they don't need to be persistent.

ta,

l.


-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
