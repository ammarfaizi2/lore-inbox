Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTATRhV>; Mon, 20 Jan 2003 12:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbTATRhV>; Mon, 20 Jan 2003 12:37:21 -0500
Received: from ns.tasking.nl ([195.193.207.2]:47121 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S266308AbTATRhU>;
	Mon, 20 Jan 2003 12:37:20 -0500
Date: Mon, 20 Jan 2003 18:45:10 +0100
From: Dick Streefland <dick.streefland@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/cmdline broken since 2.4.19
Message-ID: <20030120174510.GA12451@altium.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: Altium BV, Amersfoort, The Netherlands
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading /proc/cmdline one character at a time produces garbage since
kernel version 2.4.19:

$ cat /proc/cmdline
auto BOOT_IMAGE=2.4.20-x78 ro root=302 nomodules
$ dd bs=1 if=/proc/cmdline | od -x
49+0 records in
49+0 records out
0000000 0200 5555 0006 0000 622d 7361 0068 5555
0000020 5555 cfcf cfcf cfcf 5555 5555 0000 0000
0000040 02f7 5555 000b 0000 6c6e 4e5f 404c 7565
0000060 0072
0000061

The following patch fixes this:

--- linux-2.4.20/fs/proc/proc_misc.c.orig	Wed Dec  4 11:01:33 2002
+++ linux-2.4.20/fs/proc/proc_misc.c	Mon Jan 20 18:33:02 2003
@@ -422,9 +422,9 @@
 				 int count, int *eof, void *data)
 {
 	extern char saved_command_line[];
-	int len;
+	int len = 0;
 
-	len = snprintf(page, count, "%s\n", saved_command_line);
+	proc_sprintf(page, &off, &len, "%s\n", saved_command_line);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------
