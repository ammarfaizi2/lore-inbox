Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263797AbUCXRwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUCXRwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:52:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:13025 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263797AbUCXRwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:52:39 -0500
Date: Wed, 24 Mar 2004 09:52:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: eric.valette@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2 still does not boot but it progress : seems to be
 console font related
Message-Id: <20040324095236.68cb1deb.akpm@osdl.org>
In-Reply-To: <406172C9.8000706@free.fr>
References: <406172C9.8000706@free.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette <eric.valette@free.fr> wrote:
>
> I have compiled a completely clean, unpatched (I mean except of course 
>  rc2-mm2) and I can still not manage to finish booting. However, this 
>  time, I get a little bit further AND system seems to hang exactly at the 
>  same place each time (which was not the case with rc2-mm1). In fact I 
>  managed to have the same behavior after removing the initramfs patches 
>  from rc2-mm1 and fixing some other things using bk snapshots diffs (SCSI 
>  st driver).
> 
>  It hangs when executing :
>  /etc/init.d/console-screen.sh after displaying:
> 
>  Setting up general console font..
> 
>  Attached is a shell trace of a working session on
>  2.6.5-rc1-mm2. It basically does (twice wonder why!) a loop of :
> 
> 
>  /usr/bin/consolechars --tty=/dev/vc/[X] -f lat0-16
> 
>  I also traced the set of system calls /usr/bin/consolechars does via ptrace.
> 
>  Of course, the same shell script, same binaries and same settings works 
>  for 2.6.5-rc1-mm2

Are you using devfs?  If so, please try the below patch (I don't see why,
but..)

Can a sysrq-T or sysrq-P trace be generated when it has died?  You may need
to alter your initscripts so they do not stick a zero in
/proc/sys/kernel/sysrq.

---

 25-akpm/drivers/char/vt.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

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


