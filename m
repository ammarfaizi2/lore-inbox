Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbTLINsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265852AbTLINsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:48:06 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:7165 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id S265851AbTLINsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:48:02 -0500
Date: Tue, 09 Dec 2003 14:45:12 +0100
From: Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH 2.4.23, 2.6.0-test11] fix d_type in readdir in isofs
In-reply-to: <20031209100959.GB4176@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <200312091445.12134.domen@coderock.org>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
References: <200312091047.33015.domen@coderock.org>
 <20031209100959.GB4176@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 of December 2003 11:09, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Dec 09, 2003 at 10:47:32AM +0100, Domen Puncer wrote:
> > Hi!
> >
> > Played with scandir, and noticed iso9660's files d_type is always 0,
> > so here's a fix.
>
> No, it isn't.  DT_UNKNOWN is "I don't know; make no assumptions".
> DT_REG is "regular file".  Returning it when object in question is
> e.g. a symlink is wrong.

Right, then how about this partial fix:
--- c/fs/isofs/dir.c	2003-08-23 01:58:53.000000000 +0200
+++ a/fs/isofs/dir.c	2003-12-09 14:37:45.000000000 +0100
@@ -230,7 +230,8 @@
 			}
 		}
 		if (len > 0) {
-			if (filldir(dirent, p, len, filp->f_pos, inode_number, DT_UNKNOWN) < 0)
+			if (filldir(dirent, p, len, filp->f_pos, inode_number,
+					(de->flags[0]&2)?DT_DIR:DT_UNKNOWN) < 0)
 				break;
 		}
 		filp->f_pos += de_len;


Or maybe we should read inode->i_mode, if it's not too time expensive?

