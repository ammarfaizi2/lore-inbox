Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVJKWe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVJKWe6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVJKWe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:34:57 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:35542 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751259AbVJKWe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:34:57 -0400
Date: Tue, 11 Oct 2005 15:33:56 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510112233.j9BMXuZ0003715@melik.cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, neilb@cse.unsw.edu.au, paulmck@us.ibm.com,
       suzannew@cs.pdx.edu, walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify raid rcu-protected pointer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To provide further background to the recently submitted patch,
please let me note the following in regard to the commented
question in read_balance() of raid1.c

diff linux-2.6.13-rc6/drivers/md/raid1.c linux-2.6.14-rc4/drivers/md/raid1.c

changed to 379,383c419,428
<               while ((new_rdev=conf->mirrors[new_disk].rdev) == NULL ||
<                      !new_rdev->in_sync) {
<                       new_disk++;
<                       if (new_disk == conf->raid_disks) {
<                               new_disk = -1;
---
>               for (rdev = conf->mirrors[new_disk].rdev;
>                    !rdev || !rdev->in_sync
>                            || test_bit(WriteMostly, &rdev->flags);
>                    rdev = conf->mirrors[++new_disk].rdev) {
>
>                       if (rdev && rdev->in_sync)
>                               wonly_disk = new_disk;
>
>                       if (new_disk == conf->raid_disks - 1) {
>                               new_disk = wonly_disk;
392,393c437,444
<       while ((new_rdev=conf->mirrors[new_disk].rdev) == NULL ||
<              !new_rdev->in_sync) {
---
>       for (rdev = conf->mirrors[new_disk].rdev;
>            !rdev || !rdev->in_sync ||
>                    test_bit(WriteMostly, &rdev->flags);
>            rdev = conf->mirrors[new_disk].rdev) {
>

On the second revision section, one would consider rcu_dereference()
on both "rdev =" occurrences, but expr3 is not apparently changing, so
comparing it to the earlier "for loop" elicits my question.
Thank you.
Suzanne
  
