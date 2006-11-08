Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965822AbWKHOqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965822AbWKHOqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965893AbWKHOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:46:04 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:9880 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965891AbWKHOqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:46:00 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Date: Wed, 8 Nov 2006 15:43:26 +0100
User-Agent: KMail/1.9.1
Cc: David Chinner <dgc@sgi.com>, Eric Sandeen <sandeen@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-devel@redhat.com, Ingo Molnar <mingo@elte.hu>,
       Srinivasa DS <srinivasa@in.ibm.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <20061108082722.GH8394166@melbourne.sgi.com> <20061108142511.GG30653@agk.surrey.redhat.com>
In-Reply-To: <20061108142511.GG30653@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611081543.28548.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 8 November 2006 15:25, Alasdair G Kergon wrote:
> On Wed, Nov 08, 2006 at 07:27:22PM +1100, David Chinner wrote:
> > But it's trivial to detect this condition - if (sb->s_frozen != SB_UNFROZEN)
> > then the filesystem is already frozen and you shouldn't try to freeze
> > it again. It's simple to do, and the whole problem then just goes away....
>  
> So is that another vote in support of explicitly supporting multiple concurrent
> freeze requests, letting them all succeed, and only thawing after the last one
> has requested its thaw?  (It's not enough just to check SB_UNFROZEN - also need
> to track whether any other outstanding requests to avoid risk of it getting
> unfrozen while something independent believes it still to be frozen.)

So, I think, we need the following patch to fix freeze_filesystems().

Will it be enough to cover the interactions with dm?

Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 fs/buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc5-mm1/fs/buffer.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/fs/buffer.c
+++ linux-2.6.19-rc5-mm1/fs/buffer.c
@@ -264,7 +264,7 @@ void freeze_filesystems(void)
 	 */
 	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
 		if (!sb->s_root || !sb->s_bdev ||
-		    (sb->s_frozen == SB_FREEZE_TRANS) ||
+		    (sb->s_frozen != SB_UNFROZEN) ||
 		    (sb->s_flags & MS_RDONLY) ||
 		    (sb->s_flags & MS_FROZEN))
 			continue;
