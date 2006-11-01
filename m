Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992805AbWKAUbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992805AbWKAUbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992808AbWKAUbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:31:40 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:36276 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S2992805AbWKAUbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:31:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: Freeze filesystems during suspend (rev. 2)
Date: Wed, 1 Nov 2006 21:22:41 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
References: <200611011200.18438.rjw@sisk.pl> <200611011853.09633.rjw@sisk.pl> <20061101115458.bb02f1d3.akpm@osdl.org>
In-Reply-To: <20061101115458.bb02f1d3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611012122.42362.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 1 November 2006 20:54, Andrew Morton wrote:
> On Wed, 1 Nov 2006 18:53:07 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +void freeze_filesystems(void)
> > +{
> > +	struct super_block *sb;
> > +
> > +	lockdep_off();
> > +	/*
> > +	 * Freeze in reverse order so filesystems dependant upon others are
> > +	 * frozen in the right order (eg. loopback on ext3).
> > +	 */
> > +	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
> > +		if (!sb->s_root || !sb->s_bdev ||
> > +		    (sb->s_frozen == SB_FREEZE_TRANS) ||
> > +		    (sb->s_flags & MS_RDONLY) ||
> > +		    (sb->s_flags & MS_FROZEN))
> > +			continue;
> > +
> > +		freeze_bdev(sb->s_bdev);
> > +		sb->s_flags |= MS_FROZEN;
> > +	}
> > +	lockdep_on();
> > +}
> > +
> > +/**
> > + * thaw_filesystems - unlock all filesystems
> > + */
> > +void thaw_filesystems(void)
> > +{
> > +	struct super_block *sb;
> > +
> > +	lockdep_off();
> > +
> > +	list_for_each_entry(sb, &super_blocks, s_list)
> > +		if (sb->s_flags & MS_FROZEN) {
> > +			sb->s_flags &= ~MS_FROZEN;
> > +			thaw_bdev(sb->s_bdev, sb);
> > +		}
> > +
> > +	lockdep_on();
> > +}
> 
> argh.
> 
> The uncommented, unchangelogged lockdep_off() calls are completely
> mysterious right now, even before the patch is merged.  They will not
> become less mysterious over time.

Of course.  Sorry.

> Please, take pity upon the readers of your code.  Add a comment.

OK (on top of the previous patch)

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 fs/buffer.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6.19-rc4-mm1/fs/buffer.c
===================================================================
--- linux-2.6.19-rc4-mm1.orig/fs/buffer.c
+++ linux-2.6.19-rc4-mm1/fs/buffer.c
@@ -252,6 +252,11 @@ void freeze_filesystems(void)
 {
 	struct super_block *sb;
 
+	/*
+	 * We are going to take several locks of the same class in a row
+	 * without releasing them until thaw_filesystems() is called and
+	 * lockdep won't know this is all OK.
+	 */
 	lockdep_off();
 	/*
 	 * Freeze in reverse order so filesystems dependant upon others are
@@ -277,6 +282,10 @@ void thaw_filesystems(void)
 {
 	struct super_block *sb;
 
+	/*
+	 * We are going to release several locks of the same class in a row
+	 * and lockdep would complain about it, unnecessarily.
+	 */
 	lockdep_off();
 
 	list_for_each_entry(sb, &super_blocks, s_list)

