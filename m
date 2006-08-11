Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWHKXRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWHKXRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 19:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWHKXRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 19:17:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751258AbWHKXRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 19:17:09 -0400
Date: Fri, 11 Aug 2006 16:16:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-Id: <20060811161655.0ad11259.akpm@osdl.org>
In-Reply-To: <1155334389.3765.18.camel@dyn9047017069.beaverton.ibm.com>
References: <1155172827.3161.80.camel@localhost.localdomain>
	<20060809233940.50162afb.akpm@osdl.org>
	<20060810171755.GA19238@thunk.org>
	<20060810110047.af273a55.akpm@osdl.org>
	<1155334389.3765.18.camel@dyn9047017069.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 15:13:09 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> On Thu, 2006-08-10 at 11:00 -0700, Andrew Morton wrote:
> > On Thu, 10 Aug 2006 13:17:55 -0400
> > Theodore Tso <tytso@mit.edu> wrote:
> > 
> > > On Wed, Aug 09, 2006 at 11:39:40PM -0700, Andrew Morton wrote:
> > > > - replace all brelse() calls with put_bh().  Because brelse() is
> > > >   old-fashioned, has a weird name and neelessly permits a NULL arg.
> > > > 
> > > >   In fact it would be beter to convert JBD and ext3 to put_bh before
> > > >   copying it all over.
> > > 
> > > Wouldn't it be better to preserve in the source code history the
> > > brelse->put_bh conversion?  We can pour a huge number of changes in
> > > ext4 before we submit, but I would have thought it would be easier for
> > > everyone to see what is going on if we submit with just the minimal
> > > changes, and then have patches that address concerns like this one at
> > > a time.
> > > 
> > 
> > I'd suggest that this be one of the cleanups which be done within ext3
> > before taking the ext4 copy.
> 
> 
> Looked at this today -- currently brelse() and __brelse() will check the
> b_count before calling put_bh().  I think it's okay to replace put_bh()
> without checking the b_count, as we always call put_bh() with get_bh
> ()....but want to confirm with you.
> 

I haven't seen that warning come out in a couple of years.

I guess that during development it would be useful to trap underflows in
put_bh().

Like this?


 fs/buffer.c                 |    8 ++++++++
 include/linux/buffer_head.h |    6 +-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -puN include/linux/buffer_head.h~put_bh-debug include/linux/buffer_head.h
--- a/include/linux/buffer_head.h~put_bh-debug
+++ a/include/linux/buffer_head.h
@@ -232,11 +232,7 @@ static inline void get_bh(struct buffer_
         atomic_inc(&bh->b_count);
 }
 
-static inline void put_bh(struct buffer_head *bh)
-{
-        smp_mb__before_atomic_dec();
-        atomic_dec(&bh->b_count);
-}
+void put_bh(struct buffer_head *bh);
 
 static inline void brelse(struct buffer_head *bh)
 {
diff -puN fs/buffer.c~put_bh-debug fs/buffer.c
--- a/fs/buffer.c~put_bh-debug
+++ a/fs/buffer.c
@@ -47,6 +47,14 @@ static void invalidate_bh_lrus(void);
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
+void put_bh(struct buffer_head *bh)
+{
+	WARN_ON(atomic_read(&bh->b_count <= 0);
+        smp_mb__before_atomic_dec();
+        atomic_dec(&bh->b_count);
+}
+EXPORT_SYMBOL(put_bh);
+
 inline void
 init_buffer(struct buffer_head *bh, bh_end_io_t *handler, void *private)
 {
_

