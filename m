Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVBBRt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVBBRt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 12:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVBBRt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 12:49:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47020 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262446AbVBBRtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 12:49:35 -0500
Subject: Re: Memory leak in 2.6.11-rc1?
From: Dave Hansen <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lennert Van Alboom <lennert.vanalboom@ugent.be>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       alexn@dsv.su.se, kas@fi.muni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz>
	 <20050124125649.35f3dafd.akpm@osdl.org>
	 <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>
	 <200502021030.06488.lennert.vanalboom@ugent.be>
	 <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 09:49:20 -0800
Message-Id: <1107366560.5540.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there's still something funky going on in the pipe code, at
least in 2.6.11-rc2-mm2, which does contain the misordered __free_page()
fix in pipe.c.  I'm noticing any leak pretty easily because I'm
attempting memory removal of highmem areas, and these apparently leaked
pipe pages the only things keeping those from succeeding.

In any case, I'm running a horribly hacked up kernel, but this is
certainly a new problem, and not one that I've run into before.  Here's
output from the new CONFIG_PAGE_OWNER code:

Page (e0c4f8b8) pfn: 00566606 allocated via order 0
[0xc0162ef6] pipe_writev+542
[0xc0157f48] do_readv_writev+288
[0xc0163114] pipe_write+0
[0xc0134484] ltt_log_event+64
[0xc0158077] vfs_writev+75
[0xc01581ac] sys_writev+104
[0xc0102430] no_syscall_entry_trace+11

And some more information about the page (yes, it's in the vmalloc
space)

page: e0c4f8b8
pfn: 0008a54e 566606
count: 1
mapcount: 0
index: 786431
mapping: 00000000
private: 00000000
lru->prev: 00200200
lru->next: 00100100
        PG_locked:      0
        PG_error:       0
        PG_referenced:  0
        PG_uptodate:    0
        PG_dirty:       0
        PG_lru: 0
        PG_active:      0
        PG_slab:        0
        PG_highmem:     1
        PG_checked:     0
        PG_arch_1:      0
        PG_reserved:    0
        PG_private:     0
        PG_writeback:   0
        PG_nosave:      0
        PG_compound:    0
        PG_swapcache:   0
        PG_mappedtodisk:        0
        PG_reclaim:     0
        PG_nosave_free: 0
        PG_capture:     1


-- Dave

