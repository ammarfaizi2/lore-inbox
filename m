Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUAGXMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUAGXMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:12:14 -0500
Received: from 217-13-7-10.dd.nextgentel.com ([217.13.7.10]:28166 "EHLO
	minerva.hungry.com") by vger.kernel.org with ESMTP id S262686AbUAGXMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:12:10 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Increase recursive symlink limit from 5 to 8
From: Petter Reinholdtsen <pere@hungry.com>
Message-Id: <E1AeMqJ-00022k-00@minerva.hungry.com>
Date: Thu, 08 Jan 2004 00:12:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The comment in do_follow_link() do not match the code.  The comment
explain that the limit for recursive symlinks are 8, but the code
limit it to 5.  This is the current comment:

  /*
   * This limits recursive symlink follows to 8, while
   * limiting consecutive symlinks to 40.
   *
   * Without that kind of total limit, nasty chains of consecutive
   * symlinks can cause almost arbitrarily long lookups.
   */

I discovered it when I ran into a problem with the following symlinks
producing the error message "Too many levels of symbolic links" when I
tried to run /usr/lib/sendmail in our current software configuration.

  /usr/lib/sendmail      -> /local/sbin/sendmail
  /local/sbin/sendmail   -> /store/store/diskless/.exim/ver-4.22/sbin/sendmail
  /store/store/diskless/.exim/ver-4.22/sbin/sendmail -> /local/sbin/exim
  /local/sbin/exim ->
    /store/store/diskless/.exim/ver-4.22/sbin/exim@386linuxlibc62

As you can see, this have to visit exactly 5 files to reach the real
file "/store/store/diskless/.exim/ver-4.22/sbin/exim@386linuxlibc62".

I discovered this when testing Debian for the first time using this
software configuration.  RedHat did not have any problems follwing the
links, which suggests to me that they already increased the limit.

The fix seem to be to bring the code in sync with the comment of the
function, and increase the limit from 5 to 8.

--- linux-2.4.24/fs/namei.c.orig     Wed Jan  7 23:46:03 2004
+++ linux-2.4.24/fs/namei.c  Wed Jan  7 23:46:34 2004
@@ -335,7 +335,7 @@
 static inline int do_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
        int err;
-       if (current->link_count >= 5)
+       if (current->link_count >= 8)
                goto loop;
        if (current->total_link_count >= 40)
                goto loop;

(I'm not on this mailing list, and do not really know how to proceed
to increase the chances of this patch being accepted into the official
source.  Please CC me if you reply. :)
