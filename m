Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWCRTgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWCRTgR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWCRTgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:36:17 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:64987 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750819AbWCRTgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:36:16 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -mm: PM=y, VT=n doesn't compile
Date: Sat, 18 Mar 2006 20:34:58 +0100
User-Agent: KMail/1.9.1
Cc: Adrian Bunk <bunk@stusta.de>, pavel@suse.cz, linux-kernel@vger.kernel.org
References: <20060317171814.GO3914@stusta.de> <20060317175019.7c000847.akpm@osdl.org>
In-Reply-To: <20060317175019.7c000847.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182034.58629.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 02:50, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> >  swsusp-pm-refuse-to-suspend-devices-if-wrong-console-is-active.patch
> >  causes the following compile error with CONFIG_PM=y, CONFIG_VT=n:
> > 
> >  <--  snip  -->
> > 
> >  ...
> >    LD      .tmp_vmlinux1
> >  drivers/built-in.o: In function `device_suspend': undefined reference to `fg_console'
> >  drivers/built-in.o: In function `device_suspend': undefined reference to `vc_cons'
> >  make: *** [.tmp_vmlinux1] Error 1
> 
> Right, thanks.  I'll drop that patch.
> 
> Guys, please don't go poking around in the vt subsystems's internal data
> structures from within power management code.
> 
> Write a nice little helper function, put that in vt.c, give it a static
> inline `return 0' stub in the header file, then call that.

OK, I will, but the changes in kernel/power/user.c in that patch are necessary
for the userland suspend we're working on right now.

Could you please accept the following patch instead of that one?

---
From: "Rafael J. Wysocki" <rjw@sisk.pl>

Remove the console-switching code from the suspend part of the swsusp
userland interface and let the userland tools switch the console.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/user.c |    3 ---
 1 files changed, 3 deletions(-)

Index: linux-2.6.16-rc6-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/user.c
+++ linux-2.6.16-rc6-mm2/kernel/power/user.c
@@ -138,12 +138,10 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		down(&pm_sem);
-		pm_prepare_console();
 		disable_nonboot_cpus();
 		if (freeze_processes()) {
 			thaw_processes();
 			enable_nonboot_cpus();
-			pm_restore_console();
 			error = -EBUSY;
 		}
 		up(&pm_sem);
@@ -157,7 +155,6 @@ static int snapshot_ioctl(struct inode *
 		down(&pm_sem);
 		thaw_processes();
 		enable_nonboot_cpus();
-		pm_restore_console();
 		up(&pm_sem);
 		data->frozen = 0;
 		break;
