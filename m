Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262837AbRE0Rij>; Sun, 27 May 2001 13:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262843AbRE0RiT>; Sun, 27 May 2001 13:38:19 -0400
Received: from HSE-MTL-ppp74207.qc.sympatico.ca ([64.229.207.238]:20358 "HELO
	oscar.casa.dyndns.org") by vger.kernel.org with SMTP
	id <S262837AbRE0RiI>; Sun, 27 May 2001 13:38:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 + ReiserFS + SMP + umount = oops
Date: Sun, 27 May 2001 13:38:00 -0400
X-Mailer: KMail [version 1.2]
Cc: Rene <kaos@intet.dk>
MIME-Version: 1.0
Message-Id: <01052713380000.19585@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This was reported on the reiserfs list yesterday.  Seems that the cleanup
applied late in  2.4.5-pre affected the locking of the umount process.  This
was posted to fix the problem.

Ed Tomlinson

-----------------------

"Vladimir V. Saveliev" wrote:
> 
> Hi
> 
> Gergely Tamas wrote:
> > 
> > Hi!
> > 
> > Kernel is 2.4.5
> > 
> > I've tried to unmount a reiserfs device (/uu.new) and got a segfault.
>
> Well, sys_umount in 2.4.5 changed to not lock_kernel() at the beginning and to not unlock_kernel() at the end correspondingly.
> journal_begin expectes kernel locked and it oopses when it is not. Maybe reiserfs_put_super should lock_kernel () itself?
> 


Hi,

You are right.
It seems, the next patch can fix umount reiserfs bug in linux-2.4.5 :

diff -urN v2.4.5/fs/reiserfs/super.c linux/fs/reiserfs/super.c
--- v2.4.5/fs/reiserfs/super.c   Sun Apr 29 16:02:25 2001
+++ linux/fs/reiserfs/super.c    Sat May 26 19:10:16 2001
@@ -104,7 +104,8 @@
 {
   int i;
   struct reiserfs_transaction_handle th ;
-  
+
+  lock_kernel() ;  
   /* change file system state to current state if it was mounted with
read-write permissions */
   if (!(s->s_flags & MS_RDONLY)) {
     journal_begin(&th, s, 10) ;
@@ -117,6 +118,7 @@
   ** to do a journal_end
   */
   journal_release(&th, s) ;
+  unlock_kernel() ;
 
   for (i = 0; i < SB_BMAP_NR (s); i ++)
     brelse (SB_AP_BITMAP (s)[i]);



Thanks,
Yura.
