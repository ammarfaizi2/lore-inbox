Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTE0BGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTE0BF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:05:57 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:45689 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262431AbTE0BES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:04:18 -0400
Date: Mon, 26 May 2003 18:17:33 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@transmeta.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [patch?] truncate and timestamps
Message-Id: <20030526181733.2d43976e.akpm@digeo.com>
In-Reply-To: <1053992553.17151.18.camel@dhcp22.swansea.linux.org.uk>
References: <UTC200305230017.h4N0Hqn05589.aeb@smtp.cwi.nl>
	<Pine.LNX.4.44.0305221726300.19226-100000@home.transmeta.com>
	<20030523011751.GC14406@parcelfarce.linux.theplanet.co.uk>
	<1053992553.17151.18.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 01:17:31.0080 (UTC) FILETIME=[BEBD3C80:01C323ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Gwe, 2003-05-23 at 02:17, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> > Andries had shown that there is _no_ consensus.  Ergo, POSIX can take
> > a hike and we should go with the behaviour convenient for us.  It's that
> > simple...
> 
> Skipping the update on a truncate not changing size is a performance win
> although not a very useful one.

It makes the AIM7 & AIM9 numbers look good ;)

An open(O_TRUNC) of a zero-length file is presumably not totally uncommon,
so not calling into the fs there may benefit some things.

> I don't think we can ignore the standard
> however. For one it simply means all the vendors have to fix it so they
> can sell to Government etc. 

I think this patch will put us back to the 2.4 behaviour while preserving
the speedup.  It's a bit dopey (why do the timestamp update in the fs at
all?) but changing this stuff tends to cause subtle problems...




diff -puN fs/attr.c~truncate-timestamp-fix fs/attr.c
--- 25/fs/attr.c~truncate-timestamp-fix	2003-05-22 22:10:18.000000000 -0700
+++ 25-akpm/fs/attr.c	2003-05-22 22:14:06.000000000 -0700
@@ -68,10 +68,17 @@ int inode_setattr(struct inode * inode, 
 	int error = 0;
 
 	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size != inode->i_size)
+		if (attr->ia_size != inode->i_size) {
 			error = vmtruncate(inode, attr->ia_size);
-		if (error || (ia_valid == ATTR_SIZE))
-			goto out;
+			if (error || (ia_valid == ATTR_SIZE))
+				goto out;
+		} else {
+			/*
+			 * We skipped the truncate but must still update
+			 * timestamps
+			 */
+			ia_valid |= ATTR_MTIME|ATTR_CTIME;
+		}
 	}
 
 	lock_kernel();

_

