Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbUBZT0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbUBZTYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:24:38 -0500
Received: from fungus.teststation.com ([212.32.186.211]:11529 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S262942AbUBZTYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:24:17 -0500
Date: Thu, 26 Feb 2004 20:24:08 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Alain Fauconnet <alain@ait.ac.th>
cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs broken in 2.4.25? (Too many open files in system)
In-Reply-To: <20040226110903.GC621@ait.ac.th>
Message-ID: <Pine.LNX.4.44.0402262000040.3800-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Alain Fauconnet wrote:

> I get random 'Too many open files in system'. E.g.:
> 
> # /usr/local/samba/bin/smbmount //w98box/c /dosc -o password=xxxxx
> # ls /dosc
> /bin/ls: /dosc: Too many open files in system
> (command repeated several times: hit up arrow and enter... and then:)
> # ls /dosc
> ASD.LOG*       BIN/          CONFIG.TXT*  MSDOS.SYS*       SUHDLOG.---*
> AUTOEXEC.001*  BOOTLOG.DMA*  CONFIG.W95*  MSDOS.W95*       SUHDLOG.BAK*
> (...works!)

The "too many files" part is what smbfs translates the server error into.
ethereal calls it a "Non specific error code" (ERRSRV/ERRerror).

The problem here is that for some reason win98 doesn't always handle that 
a client requests info on the / inode with too short interval. It 
often understands the request (for me about 14 times out of 15), but 
sometimes it just fails.


2.4.25 has some code that was backported from 2.6, where the "win95" 
codepath was changed. I need to check that, but it probably doesn't work 
there either.

Patch below works for me. It is copied from the smbfs readdir code that 
happens to have the same problem with win9x.
(Well, it's the same request so ... :)

/Urban


diff -urN -X exclude linux-2.4.25-orig/fs/smbfs/proc.c linux-2.4.25-smbfs/fs/smbfs/proc.c
--- linux-2.4.25-orig/fs/smbfs/proc.c	Thu Feb 26 17:41:19 2004
+++ linux-2.4.25-smbfs/fs/smbfs/proc.c	Thu Feb 26 20:21:21 2004
@@ -2615,9 +2615,18 @@
 	struct inode *inode = dir->d_inode;
 	int result;
 
+ retry:
 	result = smb_proc_getattr_trans2_std(server, dir, attr);
-	if (result < 0)
+	if (result < 0) {
+		if (server->rcls == ERRSRV && server->err == ERRerror) {
+			/* a damn Win95 bug - sometimes it clags if you 
+			   ask it too fast */
+			current->state = TASK_INTERRUPTIBLE;
+			schedule_timeout(HZ/5);
+			goto retry;
+		}
 		goto out;
+	}
 
 	/*
 	 * None of the other getattr versions here can make win9x

