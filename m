Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUCYQl7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 11:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUCYQl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 11:41:58 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:13543 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263355AbUCYQlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:41:39 -0500
Message-ID: <40630BC0.2090807@free.fr>
Date: Thu, 25 Mar 2004 17:41:36 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Svedberg <thsv@am.chalmers.se>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm2 still does not boot but it progress : seems to
 be console font related
References: <406172C9.8000706@free.fr> <406302A9.8030805@am.chalmers.se>
In-Reply-To: <406302A9.8030805@am.chalmers.se>
Content-Type: multipart/mixed;
 boundary="------------070809090405060701010900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070809090405060701010900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Thomas Svedberg wrote:
> I have these hangs as well, just tried 2.6.5-rc2-mm3 and they are still 
> there.
> However setting video=radeonfb:off as boot parameter solves the problem, 
> if this can be of any help.
> More info on request.

Yes because the console-screen.sh shell script checks for /dev/fb. Could 
you try the patceh suggested by Andrew in this thread (I'm not sure it 
is in mm3). I attached it for your convenience.

-- eric



--------------070809090405060701010900
Content-Type: text/x-patch;
 name="console-devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="console-devfs.patch"

diff -puN drivers/char/vt.c~a drivers/char/vt.c
--- 25/drivers/char/vt.c~a	2004-03-24 09:49:10.285591688 -0800
+++ 25-akpm/drivers/char/vt.c	2004-03-24 09:50:54.355770616 -0800
@@ -2471,10 +2471,13 @@ static int con_open(struct tty_struct *t
 				tty->winsize.ws_row = video_num_lines;
 				tty->winsize.ws_col = video_num_columns;
 			}
+			release_console_sem();
 			vcs_make_devfs(tty);
+			goto out;
 		}
 	}
 	release_console_sem();
+out:
 	return ret;
 }
 
@@ -2484,11 +2487,13 @@ static void con_close(struct tty_struct 
 	if (tty && tty->count == 1) {
 		struct vt_struct *vt;
 
-		vcs_remove_devfs(tty);
 		vt = tty->driver_data;
 		if (vt)
 			vc_cons[vt->vc_num].d->vc_tty = NULL;
 		tty->driver_data = 0;
+		release_console_sem();
+		vcs_remove_devfs(tty);
+		return;
 	}
 	release_console_sem();
 }

_



--------------070809090405060701010900--
