Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264905AbUDWShe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUDWShe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 14:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbUDWShe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 14:37:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264905AbUDWShb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 14:37:31 -0400
Subject: [2.4 patch] fix O(N^2) dquot sync behaviour
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jan Kara <jack@ucw.cz>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       crosser@rol.ru, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040422151820.GC7506@atrey.karlin.mff.cuni.cz>
References: <20040422151820.GC7506@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed; boundary="=-kpLtEcv/uNpSB9nQJIoD"
Organization: 
Message-Id: <1082745435.2100.181.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2004 19:37:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kpLtEcv/uNpSB9nQJIoD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 2004-04-22 at 16:18, Jan Kara wrote:

>   when there are lots of dirty dquots the vfs_quota_sync() is too slow
> (it has O(N^2) behaviour). Attached patch implements list of dirty
> dquots for each superblock and quota type. Using this lists sync is
> trivially linear. Attached patch is against 2.6.5 with journalled quota
> and previous patch for hash table size. Please apply.

The O(N^2) behaviour is present on 2.4 too, but fortunately there's a
simple way to bring that down to O(N) without the complexity of adding
new lists and locking.  This patch simply rotates the dquot list-head
after each dquot write, so that the next scan walks the list starting
after the entry just processed.

For 40,000 dirty dquots, this brings sync time from 7 minutes and 50
seconds down to 0.8 seconds. :-)  On 2.4, we have BKL while doing this
list manipulation.  Jan Kara has acked this; please apply.

Cheers,
 Stephen


--=-kpLtEcv/uNpSB9nQJIoD
Content-Disposition: inline; filename=dquot-refile.patch
Content-Type: text/plain; name=dquot-refile.patch; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux-2.4/fs/dquot.c.=3DK0000=3D.orig
+++ linux-2.4/fs/dquot.c
@@ -397,6 +397,10 @@ restart:
 			wait_on_dquot(dquot);
 		if (dquot_dirty(dquot))
 			sb->dq_op->write_dquot(dquot);
+		/* Move the inuse_list head pointer to just after the
+		 * current dquot, so that we'll restart the list walk
+		 * after this point on the next pass. */
+		list_move(&inuse_list, &dquot->dq_inuse);
 		dqput(dquot);
 		goto restart;
 	}

--=-kpLtEcv/uNpSB9nQJIoD--
