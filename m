Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSEZN3N>; Sun, 26 May 2002 09:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316078AbSEZN3M>; Sun, 26 May 2002 09:29:12 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:2792 "EHLO
	postfix2-2.free.fr") by vger.kernel.org with ESMTP
	id <S316070AbSEZN3L>; Sun, 26 May 2002 09:29:11 -0400
Message-Id: <200205261203.g4QC3ad27554@colombe.home.perso>
Date: Sun, 26 May 2002 14:03:33 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: 2.4.19-pre8-ac5 swsusp panic
To: matthias.andree@stud.uni-dortmund.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205260654.g4Q6sld07709@colombe.home.perso>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26 Mai, Pour: matthias.andree@stud.uni-dortmund.de a écrit :
> Le 26 Mai, Matthias Andree a écrit :
>> On Sat, 25 May 2002, fchabaud@free.fr wrote:
>> 
>>> Le 24 Mai, Matthias Andree a écrit :
>>> > I tried SysRq-D and finally got a kernel "panic: Request while ide driver
>>> > is blocked?"
>>> > 
>>> > Before that, I saw "waiting for tasks to stop... suspending kreiserfsd",
>>> > nfsd exiting, "Freeing memory", "Syncing disks beofre copy", then some
>>> > "Probem while suspending", then some "Resume" and finally the panic.
>>> > 
>>> > It may be worth noting that one swap partition is on a SCSI drive, and
>>> > that my IDE drives were in standby (not idle) mode, i. e. their spindle
>>> > motors were stopped.
>>> 
>>> AFAIK swap partition under SCSI is not supported for the moment.
>> 
>> Gee. Swsusp should know when it must panic later and not start in the
>> first place. If that's true: swsusp people, consider this a feature
>> request ;-)
>> 
> 
> I'll do it. Besides I don't imagine it's too difficult to support SCSI,
> but I had no time before for doing this.

To prevent problems with SCSI, maybe something like that ?

Index: suspend.c
===================================================================
RCS file: /home/cvs/linux-src/kernel/Attic/suspend.c,v
retrieving revision 1.3
diff -u -r1.3 suspend.c
--- suspend.c   2002/05/26 11:49:24     1.3
+++ suspend.c   2002/05/26 11:56:25
@@ -745,6 +745,9 @@
 #ifdef CONFIG_BLK_DEV_IDE
        ide_disk_unsuspend();
 #endif
+#ifdef CONFIG_BLK_DEV_SD
+# error  Do not use SCSI swap partition while using software suspend
+#endif
 }
 
 /* Called from process context */
@@ -753,7 +756,7 @@
 #ifdef CONFIG_BLK_DEV_IDE
        ide_disk_suspend();
 #else
-#error Are you sure your disk driver supports suspend?
+# error Are you sure your disk driver supports suspend?
 #endif
        if(!pm_suspend_state) {
                if(pm_send_all(PM_SUSPEND,(void *)3)) {


--
Florent Chabaud         ___________________________________
SGDN/DCSSI/SDS/LTI     | florent.chabaud@polytechnique.org
http://www.ssi.gouv.fr | http://fchabaud.free.fr

