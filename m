Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269491AbUJSQJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269491AbUJSQJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 12:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269496AbUJSQI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 12:08:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13196 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269495AbUJSQHE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:07:04 -0400
Message-ID: <41753B99.5090003@pobox.com>
Date: Tue, 19 Oct 2004 12:06:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Larry McVoy <lm@bitmover.com>, support@bitmover.com, torvalds@osdl.org,
       akpm@osdl.org
Subject: BK kernel workflow
References: <41752E53.8060103@pobox.com> <20041019153126.GG18939@work.bitmover.com>
In-Reply-To: <20041019153126.GG18939@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although tangential to the problem, I thought LKML and BitMover (and 
maybe Andrew or Linus as well) might be interested in a general 
description of my workflow.


For net drivers in the Linux kernel, there exists two patch queues, 
net-drivers-2.6 and netdev-2.6 (and corresponding 2.4 versions). 
net-drivers-2.6 could be described as the "upstream immediately" or "for 
Linus" queue, and netdev-2.6 could be described as the "testing" queue.

When receive a patch from some random person on the Internet, fixing a 
net driver bug in the "8139too" driver, I do

1) create "topic-specific" repo, if it doesn't already exist

Key point:  when dealing with a large number of incoming changes, like I 
do, sorting the changes locally into logically separate _sets of 
changes_ (one set per repo) has a lot of advantages, given that 
BitKeeper doesn't allow changeset "cherrypicking".

	cd /spare/repo/netdev-2.6	# not a repo, just a subdir
	bk clone -ql ../linux-2.6 8139too

2) move the email containing the patch, in my MUA, to 25_Patches mbox

3) merge the patch into the topic-specific repo, using Linus's patch 
importing tools,

	cd 8139too && dotest < /garz/nsmail/25_Patches

4) pull the topic-specific repo into "collector" repo, and merge conflicts

	cd ALL && bk pull ../8139too

5) build and test 'ALL' repo [heh... usually...]

6) push 'ALL' to external netdev-2.6 repos on gkernel.bkbits.net and 
kernel.bkbits.net

7) Andrew's workflow includes automatically pulling netdev-2.6 repo into 
his more-experimental "-mm" tree for wider review and testing.

[time passes]

8) Linus and Andrew release the latest and greatest 2.6.N stable release.

9) every day or so, I 'bk pull' a few "topic-specific" repos into a 
local clone of net-drivers-2.6, test that, and send it off to Linus/Andrew.

Key point:  thanks to the daily snapshots, my changes show up broken up 
across several daily snapshots, rather than "one big huge lump of 
changes that's been waiting to go in".

	cd /spare/repo
	bk clone -ql linux-2.6 net-drivers-2.6
	bk pull ../netdev-2.6/8139too
	bk pull ../netdev-2.6/viro-sparse-annotations
	bk pull ../netdev-2.6/janitor
	bk pull ../netdev-2.6/misc
	bk push && bk push kernel.bkbits.net:net-drivers-2.6

	# and then email Linus/Andrew the output of
	# bk-make-sum + gcapatch (see Documentation/BK-usage)


