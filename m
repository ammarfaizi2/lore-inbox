Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbUKQVSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbUKQVSY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbUKQVQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:16:08 -0500
Received: from p508F03A7.dip0.t-ipconnect.de ([80.143.3.167]:50747 "EHLO
	mail.morknet.de") by vger.kernel.org with ESMTP id S262569AbUKQVO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:14:56 -0500
Message-ID: <419BBF21.9070305@morknet.de>
Date: Wed, 17 Nov 2004 22:14:09 +0100
From: "Steffen A. Mork" <linux-dev@morknet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: de, en, el
MIME-Version: 1.0
To: torvalds@osdl.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] dss1_divert ISDN module compile fix for kernel 2.6.8.1
References: <419B662D.5020904@morknet.de>	 <58cb370e0411170828365d1982@mail.gmail.com>	 <419B9E06.6020100@morknet.de> <58cb370e04111712074d85e17e@mail.gmail.com>
In-Reply-To: <58cb370e04111712074d85e17e@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir Milter (version: 1.1; AVE: 6.28.0.12; VDF: 6.28.0.78; host: mail.morknet.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus and Bartlomiej,

> Moreover, you must make sure that there is no other code (ie. in generic
> ISDN code) doing cli() stuff on objects that you are protecting by a spinlock
> etc., I've checked divert driver and it looks OK.
> 
> 
>>OK, thank you. I went into the copy/paste trap. I corrected the patch to
>>a global spinlock and tested it successfully.
> 
> 
> Great.
> 
> Please do "interdiff" between the old and the new patch
> and send it to Linus (he has already merged the old patch).
the interdiff patch is appended to this mail and the link is:

http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert-patch1-2-patch2.diff

Signed-off-by: Steffen A. Mork <linux-dev@morknet.de>

> Thanks.
Thank you.



> Bartlomiej
Steffen

diff -uprN -X dontdiff linux-2.6.8.1-patch1/drivers/isdn/divert/divert_init.c linux-2.6.8.1-patch2/drivers/isdn/divert/divert_init.c
--- linux-2.6.8.1-patch1/drivers/isdn/divert/divert_init.c	2004-11-05 08:50:02.000000000 +0100
+++ linux-2.6.8.1-patch2/drivers/isdn/divert/divert_init.c	2004-11-17 17:50:38.000000000 +0100
@@ -62,7 +62,6 @@ static int __init divert_init(void)
  static void __exit divert_exit(void)
  {
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
    int i;

    spin_lock_irqsave(&divert_lock, flags);
diff -uprN -X dontdiff linux-2.6.8.1-patch1/drivers/isdn/divert/divert_procfs.c linux-2.6.8.1-patch2/drivers/isdn/divert/divert_procfs.c
--- linux-2.6.8.1-patch1/drivers/isdn/divert/divert_procfs.c	2004-11-05 08:49:57.000000000 +0100
+++ linux-2.6.8.1-patch2/drivers/isdn/divert/divert_procfs.c	2004-11-17 17:42:00.000000000 +0100
@@ -182,7 +182,6 @@ isdn_divert_ioctl(struct inode *inode, s
  	divert_ioctl dioctl;
  	int i;
  	unsigned long flags;
-	spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
  	divert_rule *rulep;
  	char *cp;

diff -uprN -X dontdiff linux-2.6.8.1-patch1/drivers/isdn/divert/isdn_divert.c linux-2.6.8.1-patch2/drivers/isdn/divert/isdn_divert.c
--- linux-2.6.8.1-patch1/drivers/isdn/divert/isdn_divert.c	2004-11-05 08:49:20.000000000 +0100
+++ linux-2.6.8.1-patch2/drivers/isdn/divert/isdn_divert.c	2004-11-17 19:39:32.000000000 +0100
@@ -48,13 +48,14 @@ static struct deflect_struc *table_head
  static struct deflect_struc *table_tail = NULL;
  static unsigned char extern_wait_max = 4; /* maximum wait in s for external process */

+spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
+
  /***************************/
  /* timer callback function */
  /***************************/
  static void deflect_timer_expire(ulong arg)
  {
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
    struct call_struc *cs = (struct call_struc *) arg;

    spin_lock_irqsave(&divert_lock, flags);
@@ -109,7 +110,6 @@ int cf_command(int drvid, int mode,
                 u_char proc, char *msn,
                 u_char service, char *fwd_nr, ulong *procid)
  { unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
    int retval,msnlen;
    int fwd_len;
    char *p,*ielenp,tmp[60];
@@ -204,7 +204,6 @@ int deflect_extern_action(u_char cmd, ul
  { struct call_struc *cs;
    isdn_ctrl ic;
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
    int i;

    if ((cmd & 0x7F) > 2) return(-EINVAL); /* invalid command */
@@ -275,7 +274,6 @@ int deflect_extern_action(u_char cmd, ul
  int insertrule(int idx, divert_rule *newrule)
  { struct deflect_struc *ds,*ds1=NULL;
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

    if (!(ds = (struct deflect_struc *) kmalloc(sizeof(struct deflect_struc),
                                                GFP_KERNEL)))
@@ -321,7 +319,6 @@ int insertrule(int idx, divert_rule *new
  int deleterule(int idx)
  { struct deflect_struc *ds,*ds1;
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

    if (idx < 0)
     { spin_lock_irqsave(&divert_lock, flags);
@@ -389,7 +386,6 @@ divert_rule *getruleptr(int idx)
  int isdn_divert_icall(isdn_ctrl *ic)
  { int retval = 0;
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
    struct call_struc *cs = NULL;
    struct deflect_struc *dv;
    char *p,*p1;
@@ -540,7 +536,6 @@ int isdn_divert_icall(isdn_ctrl *ic)
  void deleteprocs(void)
  { struct call_struc *cs, *cs1;
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

    spin_lock_irqsave(&divert_lock, flags);
    cs = divert_head;
@@ -698,7 +693,6 @@ int prot_stat_callback(isdn_ctrl *ic)
  { struct call_struc *cs, *cs1;
    int i;
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

    cs = divert_head; /* start of list */
    cs1 = NULL;
@@ -790,7 +784,6 @@ int prot_stat_callback(isdn_ctrl *ic)
  int isdn_divert_stat_callback(isdn_ctrl *ic)
  { struct call_struc *cs, *cs1;
    unsigned long flags;
-  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
    int retval;

    retval = -1;
diff -uprN -X dontdiff linux-2.6.8.1-patch1/drivers/isdn/divert/isdn_divert.h linux-2.6.8.1-patch2/drivers/isdn/divert/isdn_divert.h
--- linux-2.6.8.1-patch1/drivers/isdn/divert/isdn_divert.h	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1-patch2/drivers/isdn/divert/isdn_divert.h	2004-11-17 18:59:16.000000000 +0100
@@ -114,6 +114,8 @@ struct divert_info
  /**************/
  /* Prototypes */
  /**************/
+extern spinlock_t divert_lock;
+
  extern ulong if_used; /* number of interface users */
  extern int divert_dev_deinit(void);
  extern int divert_dev_init(void);



