Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUHDCOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUHDCOB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267211AbUHDCOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:14:01 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:9097 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S267226AbUHDCN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:13:56 -0400
Date: Wed, 4 Aug 2004 04:13:32 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804021332.GT2241@dualathlon.random>
References: <20040804015350.GS2241@dualathlon.random> <Pine.LNX.4.44.0408032157160.5948-100000@dhcp83-102.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408032157160.5948-100000@dhcp83-102.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 10:01:12PM -0400, Rik van Riel wrote:
> On Wed, 4 Aug 2004, Andrea Arcangeli wrote:
> > On Tue, Aug 03, 2004 at 09:21:34PM -0400, Rik van Riel wrote:
> > > This is exactly why named hugetlb files are NOT included
> > > in this accounting, only the ones created through the SHM
> > > interface are.
> > 
> > but you're allowing everybody to alloc all RAM in hugetlb files with
> > the change in the previos patch posted by Arjan
> 
> Nope, Arjan's patch (and my incremental) touch hugetlb_zero_setup,
> which only seems to be called from ipc/shm.c
> 
> Normal hugetlb file creation (through the filesystem) isn't touched
> by these patches.

it is:

diff -purN linux-2.6.7/fs/hugetlbfs/inode.c linux/fs/hugetlbfs/inode.c
--- linux-2.6.7/fs/hugetlbfs/inode.c    2004-07-29 11:36:55.744448953
+0200
+++ linux/fs/hugetlbfs/inode.c  2004-07-29 11:38:04.292595263 +0200
@@ -722,7 +722,7 @@ struct file *hugetlb_zero_setup(size_t s
        struct qstr quick_string;
        char buf[16];

-       if (!capable(CAP_IPC_LOCK))
+       if (!can_do_mlock())
                return ERR_PTR(-EPERM);

        if (!is_hugepage_mem_enough(size))


this breaks local security if you set the rlimit to 1 byte (well, 1 byte
== disable_cap_mlock).
