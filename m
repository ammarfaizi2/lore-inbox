Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUIVREo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUIVREo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUIVREo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:04:44 -0400
Received: from mato.luukku.com ([193.209.83.251]:24272 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S266250AbUIVREl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:04:41 -0400
Message-ID: <4151B0DB.A0DA0135@users.sourceforge.net>
Date: Wed, 22 Sep 2004 20:05:31 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <41505AA1.A51DEE50@users.sourceforge.net> <20040921212620.GA15559@apps.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Tue, Sep 21, 2004 at 07:45:21PM +0300, Jari Ruusu wrote:
> > How about implementing /etc/fstab option parsing code that is compatible
> > with existing libc /etc/fstab parsing code:
> >
> > defaults,noauto,comment=kudzu,rw
> >                 ^^^^^^^^^^^^^
> 
> Is there such libc parsing code? Can you tell me which libc?
> Which file? Invoked for what function calls?

man setmntent

SYNOPSIS
       #include <stdio.h>
       #include <mntent.h>
       FILE *setmntent(const char *filename, const char *type);
       struct mntent *getmntent(FILE *filep);
       int addmntent(FILE *filep, const struct mntent *mnt);
       int endmntent(FILE *filep);
       char *hasmntopt(const struct mntent *mnt, const char *opt);

Mount is not the only piece of code that parses fstab. Even swapon and
swapoff programs that are part of util-linux were broken by this change. The
'comment=fubar' mount option requires two line change to mount.c, and most
of all, does not break any existing fstab parsing code.

Your fstab options comment change means that all code that parses fstab
needs to be modified to understand the new comment separator sequence. If
they are not modified, they will mis-parse the comment separator sequence
and mis-parse options beyond the comment separator sequence.

Not directly related to above, but you need to release new version of
util-linux soon anyway. You intruduced this type of gems to util-linux-2.12e

--- util-linux-2.12d/mount/lomount.c	Sun Jul 11 20:26:41 2004
+++ util-linux-2.12e/mount/lomount.c	Fri Sep 17 01:28:58 2004

+	memset(&loopinfo64, 0, sizeof(loopinfo64));
 
 	close (fd);
---------------^^
+
+	if (i) {
+		ioctl (fd, LOOP_CLR_FD, 0);
-----------------------^^
+		return 1;
+	}
+
 	if (verbose > 1)
 		printf(_("set_loop(%s,%s,%llu): success\n"),
 		       device, file, offset);
 	return 0;
-
- fail:
-	(void) ioctl (fd, LOOP_CLR_FD, 0);
-	close (fd);
-	return 1;
 }

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
