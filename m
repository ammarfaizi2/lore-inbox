Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbTIOU1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTIOU1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:27:37 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:16388 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261581AbTIOU1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:27:36 -0400
To: linux-kernel@vger.kernel.org
Subject: Monster file_lock_cache entry in /proc/slabinfo
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 15 Sep 2003 16:27:25 -0400
Message-ID: <m3k78923wy.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My notebook has been slowing down the longer it is up for several
kernel versions.  Disk i/o seems to be the chokepoint.

I grabbed slabinfo before today's reboot.  The box had been up for 10
days -- it starts to become painful after about five or six days.

The file_lock_cache entry seemed rather engrossed:

file_lock_cache   2339148 2339148     92   42    1 : \
tunables  120   60    0 : \
slabdata  55694  55694      0

55694 slabs containing 2339148 objs?

The biggest user of file locking would be incoming email.  uucico(8)
polls a remote server, injects the mail to postfix(8) via postfix's
/usr/sbin/sendmail.  Postfix delivers via procmail(1), which pipes
the mail through SpamAssassin and then delivers to foo/. style 
destinations.  The recipies all start with :0:, so a local lock
file is used in each directory.  The destination filesystem is
ext3 with htree (and the default journal style).

I presume something is calling locks_alloc_lock but then failing to
also call locks_free_lock, but /proc/locks only ever shows around 6 or
so entries....

Any suggestions on debugging this?

-JimC

