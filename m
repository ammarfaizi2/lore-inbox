Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbTJMLoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTJMLoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:44:17 -0400
Received: from asplinux.ru ([195.133.213.194]:7949 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261692AbTJMLoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:44:13 -0400
From: Kirill Korotaev <kk@sw.ru>
Reply-To: kk@sw.ru
Organization: SWsoft
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Date: Mon, 13 Oct 2003 15:45:01 +0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200310131318.09234.kk@sw.ru> <20031013040821.19b3745e.akpm@osdl.org> <20031013111931.GH16158@holomorphy.com>
In-Reply-To: <20031013111931.GH16158@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310131545.01779.kk@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> Untested brute-force forward port to 2.6.0-test7-bk4. No idea if the
> >>  locking is correct or if list movement is done in all needed places.
>
> On Mon, Oct 13, 2003 at 04:08:21AM -0700, Andrew Morton wrote:
> > My preferred approach to this would be to move all the global inode lists
> > into the superblock so both they and inode_lock become per-sb.
> > It is a big change though.  And, amazingly, nobody has yet hit sufficient
> > inode_lock contention to warrant it.
> > Yes, I bet that this search will hurt like hell on a really big box which
> > has thousands of auto-expiring NFS mounts.  Please test your patch and
> > I'll queue it up while we think about it some more.
>
> Generally dcache_lock stands in front of inode_lock, even with the
> current hashtable RCU code. inode_lock has been seen before in unusual
> situations I don't remember offhand, though generally it's not #1.
> The workloads used for, say, benchmark testing don't adequately model
> situations like what you just mentioned (or a number of other real-life
> usage cases), so per-sb inode_lock may be worth considering on a priori
> grounds, though it would probably be better to actually set something
> up to test that scenario.
This patch can be tested quite easily. Main changes are in invalidate_list.
This path can be triggered by umount/quota off.
So I tested it the following way:
1. mounting/working/umounting partition (and turning quota on/off)
2. running memeater to call prune_icache when partition was mounted
to test that lists are ok.

All other places should be ok, since simple list_add/list_del is inserted.

Kirill

