Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSKHSge>; Fri, 8 Nov 2002 13:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSKHSge>; Fri, 8 Nov 2002 13:36:34 -0500
Received: from mons.uio.no ([129.240.130.14]:43219 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S262067AbSKHSgd>;
	Fri, 8 Nov 2002 13:36:33 -0500
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Jeff Dike <jdike@karaya.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 - hang with processes stuck in D
References: <3DC8645B.A0E99A99@digeo.com>
	<200211060308.gA638Ui08714@karaya.com>
	<20021108041755.GD1729@unthought.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 08 Nov 2002 19:43:10 +0100
In-Reply-To: <20021108041755.GD1729@unthought.net>
Message-ID: <shslm437vi9.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jakob Oestergaard <jakob@unthought.net> writes:

     > I suspected NFS problems (looks like someone re-wrote NFS
     > between 2.4.18 and 2.4.20-rc1) - but this is *not* the case.
     > The pauses happen on locally running processes as well.

     > It seems to correlate well with a remote host delivering a mail
     > (using maildir over NFS) - but this is not the only situation
     > in which it happens.

     > Everything using disk, both on NFS clients and locally running
     > processes, just pause. Five seconds after everything is like it
     > never happened.

If you are using HIGHMEM, then the stock 2.4.20-rc1 has a known issue
with an unbalanced kmap. Marcelo has already applied the following
patch in the latest bitkeeper update.

Cheers,
  Trond

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.774   -> 1.775  
#	    net/sunrpc/xdr.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/06	trond.myklebust@fys.uio.no	1.775
# [PATCH] another kmap imbalance in 2.4.x/2.5.x RPC
# 
# >>>>> Andrew Ryan <andrewr@nam-shub.com> writes:
#      > So far so good on the crashes.  I'm able to get through a
#      > complete run of dbench using TCP mounts on 2.4.20rc1, which I
#      > haven't been able to do before this.
# 
# Marcelo, Linus
# 
#   We've uncovered yet another kmap imbalance in the new RPC code. This
# looks like it might be the last one (my debugging printks have been
# unable to unearth any more). One line fix + 4 line comment
# appended. Please apply to both 2.4.20-rc1 and 2.5.45...
# 
# Cheers,
#   Trond
# --------------------------------------------
#
diff -Nru a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
--- a/net/sunrpc/xdr.c	Fri Nov  8 19:42:24 2002
+++ b/net/sunrpc/xdr.c	Fri Nov  8 19:42:24 2002
@@ -244,6 +244,11 @@
 		pglen -= base;
 		base  += xdr->page_base;
 		ppage += base >> PAGE_CACHE_SHIFT;
+		/* Note: The offset means that the length of the first
+		 * page is really (PAGE_CACHE_SIZE - (base & ~PAGE_CACHE_MASK)).
+		 * In order to avoid an extra test inside the loop,
+		 * we bump pglen here, and just subtract PAGE_CACHE_SIZE... */
+		pglen += base & ~PAGE_CACHE_MASK;
 	}
 	for (;;) {
 		flush_dcache_page(*ppage);
