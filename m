Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVAXGzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVAXGzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVAXGwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:52:55 -0500
Received: from mail.fgi.fi ([193.167.184.252]:5278 "EHLO mail.fgi.fi")
	by vger.kernel.org with ESMTP id S261453AbVAXGvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:51:43 -0500
From: Andris Pavenis <pavenis@latnet.lv>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] [Bug 3736] Bug in tty_io.c after changes between 2.6.9-rc1-bk1 and 2.6.9-rc1-bk2
Date: Mon, 24 Jan 2005 08:50:21 +0200
User-Agent: KMail/1.7.91
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501240850.21416.pavenis@latnet.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried to fix a bug 
 http://bugzilla.kernel.org/show_bug.cgi?id=3736
which appeared between kernels 2.6.9-rc1-bk1 and 2.6.9-rc1-bk2.

Suceeded to localize it to part of changes in drivers/char/tty_io.c.
I guess changes were according changelog:
 
-----------------------------------
ChangeSet@1.1843.2.184, 2004-08-24 12:29:18-07:00, 
viro@parcelfarce.linux.theplanet.co.uk
  [PATCH] /dev/ptmx open() fixes
  
  If tty_open() fails for a normal serial device, we end up doing cleanups
  that should only happen for failed open of /dev/ptmx.  The results are
  not pretty - devpts et.al.  end up very confused.  That's what gave
  problems with ptmx.
  
  This splits ptmx file_operations from the normal case and cleans up both
  tty_open() and (new) ptmx_open().  Survived serious beating.
-----------------------------------

Finally located that a problem seems to be a simple typo (

--- linux-2.6.10/drivers/char/tty_io.c~1 2004-12-24 23:34:58.000000000 +0200
+++ linux-2.6.10/drivers/char/tty_io.c 2005-01-22 10:54:32.000000000 +0200
@@ -1148,7 +1148,7 @@ static inline void pty_line_name(struct 
  int i = index + driver->name_base;
  /* ->name is initialized to "ttyp", but "tty" is expected */
  sprintf(p, "%s%c%x",
-   driver->subtype == PTY_TYPE_SLAVE ? "tty" : driver->name,
+   driver->subtype == PTY_TYPE_SLAVE ? "pty" : driver->name,
    ptychar[i >> 4 & 0xf], i & 0xf);
 }
 
At least as I tested, it fixes the problem on one of systems on which I 
tested.

Andris
