Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbUKQO4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbUKQO4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUKQO4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:56:21 -0500
Received: from p508F03A7.dip0.t-ipconnect.de ([80.143.3.167]:41781 "EHLO
	mail.morknet.de") by vger.kernel.org with ESMTP id S262336AbUKQOzR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:55:17 -0500
Message-ID: <419B662D.5020904@morknet.de>
Date: Wed, 17 Nov 2004 15:54:37 +0100
From: "Steffen A. Mork" <linux-dev@morknet.de>
Reply-To: linux-dev@morknet.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: de, en, el
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: trivial@rustcorp.com.au, torvalds@osdl.org
Subject: [PATCH] dss1_divert ISDN module compile fix for kernel 2.6.8.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir Milter (version: 1.1; AVE: 6.28.0.12; VDF: 6.28.0.77; host: mail.morknet.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developer,

when I switched my installation from kernel 2.4 to 2.6 I
recognized that the ISDN module dss1_divert was marked
incompilable (config option CONFIG_CLEAN_COMPILE must
be turned off). The compile problem was the obsolete using
of kernel 2.4 critical sections. I replaced the cli() stuff
with spinlocks as explained in the Documentation/spinlocks.txt
file. After that the module compiles and runs as expected.

The patch is applied to kernel 2.6.8.1 and should work for
all 2.6 versions. You may also download the patch via http, too:

http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert.diff

Signed-off-by: Steffen A. Mork <linux-dev@morknet.de>


diff -uprN -X /home/sm/dontdiff linux-vanilla/drivers/isdn/divert/divert_init.c linux-2.6.8.1/drivers/isdn/divert/divert_init.c
--- linux-vanilla/drivers/isdn/divert/divert_init.c	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/divert/divert_init.c	2004-11-05 08:50:02.000000000 +0100
@@ -12,6 +12,7 @@
#include <linux/module.h>
#include <linux/version.h>
#include <linux/init.h>
+
#include "isdn_divert.h"

MODULE_DESCRIPTION("ISDN4Linux: Call diversion support");
@@ -59,23 +60,24 @@ static int __init divert_init(void)
/* Module deinit code */
/**********************/
static void __exit divert_exit(void)
-{ unsigned long flags;
+{
+  unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
   int i;

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);
   divert_if.cmd = DIVERT_CMD_REL; /* release */
   if ((i = DIVERT_REG_NAME(&divert_if)) != DIVERT_NO_ERR)
    { printk(KERN_WARNING "dss1_divert: error %d releasing module\n",i);
-     restore_flags(flags);
+     spin_unlock_irqrestore(&divert_lock, flags);
      return;
    }
   if (divert_dev_deinit())
    { printk(KERN_WARNING "dss1_divert: device busy, remove cancelled\n");
-     restore_flags(flags);
+     spin_unlock_irqrestore(&divert_lock, flags);
      return;
    }
-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
   deleterule(-1); /* delete all rules and free mem */
   deleteprocs();
   printk(KERN_INFO "dss1_divert module successfully removed \n");
diff -uprN -X /home/sm/dontdiff linux-vanilla/drivers/isdn/divert/divert_procfs.c linux-2.6.8.1/drivers/isdn/divert/divert_procfs.c
--- linux-vanilla/drivers/isdn/divert/divert_procfs.c	2004-08-14 12:56:22.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/divert/divert_procfs.c	2004-11-05 08:49:57.000000000 +0100
@@ -22,6 +22,7 @@
#include <linux/isdnif.h>
#include "isdn_divert.h"

+
/*********************************/
/* Variables for interface queue */
/*********************************/
@@ -181,6 +182,7 @@ isdn_divert_ioctl(struct inode *inode, s
	divert_ioctl dioctl;
	int i;
	unsigned long flags;
+	spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
	divert_rule *rulep;
	char *cp;

@@ -215,10 +217,9 @@ isdn_divert_ioctl(struct inode *inode, s
		case IIOCMODRULE:
			if (!(rulep = getruleptr(dioctl.getsetrule.ruleidx)))
				return (-EINVAL);
-			save_flags(flags);
-			cli();
+            spin_lock_irqsave(&divert_lock, flags);
			*rulep = dioctl.getsetrule.rule;	/* copy data */
-			restore_flags(flags);
+			spin_unlock_irqrestore(&divert_lock, flags);
			return (0);	/* no copy required */
			break;

diff -uprN -X /home/sm/dontdiff linux-vanilla/drivers/isdn/divert/isdn_divert.c linux-2.6.8.1/drivers/isdn/divert/isdn_divert.c
--- linux-vanilla/drivers/isdn/divert/isdn_divert.c	2004-08-14 12:55:34.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/divert/isdn_divert.c	2004-11-05 08:49:20.000000000 +0100
@@ -11,6 +11,7 @@

#include <linux/version.h>
#include <linux/proc_fs.h>
+
#include "isdn_divert.h"

/**********************************/
@@ -51,50 +52,48 @@ static unsigned char extern_wait_max = 4
/* timer callback function */
/***************************/
static void deflect_timer_expire(ulong arg)
-{ unsigned long flags;
+{
+  unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
   struct call_struc *cs = (struct call_struc *) arg;

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);
   del_timer(&cs->timer); /* delete active timer */
-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);

   switch(cs->akt_state)
    { case DEFLECT_PROCEED:
        cs->ics.command = ISDN_CMD_HANGUP; /* cancel action */
        divert_if.ll_cmd(&cs->ics);                   	
-       save_flags(flags);
-       cli();
+       spin_lock_irqsave(&divert_lock, flags);
        cs->akt_state = DEFLECT_AUTODEL; /* delete after timeout */
        cs->timer.expires = jiffies + (HZ * AUTODEL_TIME);
        add_timer(&cs->timer);
-       restore_flags(flags);
+       spin_unlock_irqrestore(&divert_lock, flags);
        break;

      case DEFLECT_ALERT:
        cs->ics.command = ISDN_CMD_REDIR; /* protocol */
        strcpy(cs->ics.parm.setup.phone,cs->deflect_dest);
        strcpy(cs->ics.parm.setup.eazmsn,"Testtext delayed");
-       divert_if.ll_cmd(&cs->ics);                   	
-       save_flags(flags);
-       cli();
+       divert_if.ll_cmd(&cs->ics);
+       spin_lock_irqsave(&divert_lock, flags);
        cs->akt_state = DEFLECT_AUTODEL; /* delete after timeout */
        cs->timer.expires = jiffies + (HZ * AUTODEL_TIME);
        add_timer(&cs->timer);
-       restore_flags(flags);
+       spin_unlock_irqrestore(&divert_lock, flags);
        break;

      case DEFLECT_AUTODEL:
      default:
-       save_flags(flags);
-       cli();
+       spin_lock_irqsave(&divert_lock, flags);
        if (cs->prev)
          cs->prev->next = cs->next; /* forward link */
         else
          divert_head = cs->next;
        if (cs->next)
          cs->next->prev = cs->prev; /* back link */
-       restore_flags(flags);
+       spin_unlock_irqrestore(&divert_lock, flags);
        kfree(cs);
        return;

@@ -110,6 +109,7 @@ int cf_command(int drvid, int mode,
                u_char proc, char *msn,
                u_char service, char *fwd_nr, ulong *procid)
{ unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
   int retval,msnlen;
   int fwd_len;
   char *p,*ielenp,tmp[60];
@@ -166,10 +166,9 @@ int cf_command(int drvid, int mode,
   cs->ics.parm.dss1_io.datalen = p - tmp; /* total len */
   cs->ics.parm.dss1_io.data = tmp; /* start of buffer */

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);
   cs->ics.parm.dss1_io.ll_id = next_id++; /* id for callback */
-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
   *procid = cs->ics.parm.dss1_io.ll_id;

   sprintf(cs->info,"%d 0x%lx %s%s 0 %s %02x %d%s%s\n",
@@ -187,11 +186,10 @@ int cf_command(int drvid, int mode,

   if (!retval)
    { cs->prev = NULL;
-     save_flags(flags);
-     cli();
+     spin_lock_irqsave(&divert_lock, flags);
      cs->next = divert_head;
      divert_head = cs;
-     restore_flags(flags);
+     spin_unlock_irqrestore(&divert_lock, flags);
    }
   else
    kfree(cs);
@@ -206,6 +204,7 @@ int deflect_extern_action(u_char cmd, ul
{ struct call_struc *cs;
   isdn_ctrl ic;
   unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
   int i;

   if ((cmd & 0x7F) > 2) return(-EINVAL); /* invalid command */
@@ -224,13 +223,12 @@ int deflect_extern_action(u_char cmd, ul
    { case 0: /* hangup */
        del_timer(&cs->timer);
        ic.command = ISDN_CMD_HANGUP;
-       i = divert_if.ll_cmd(&ic);                   	
-       save_flags(flags);
-       cli();
+       i = divert_if.ll_cmd(&ic);
+       spin_lock_irqsave(&divert_lock, flags);
        cs->akt_state = DEFLECT_AUTODEL; /* delete after timeout */
        cs->timer.expires = jiffies + (HZ * AUTODEL_TIME);
        add_timer(&cs->timer);
-       restore_flags(flags);
+       spin_unlock_irqrestore(&divert_lock, flags);
      break;

      case 1: /* alert */
@@ -239,12 +237,12 @@ int deflect_extern_action(u_char cmd, ul
        del_timer(&cs->timer);
        ic.command = ISDN_CMD_ALERT;
        if ((i = divert_if.ll_cmd(&ic)))
-	{ save_flags(flags);
-          cli();
+	{
+          spin_lock_irqsave(&divert_lock, flags);
           cs->akt_state = DEFLECT_AUTODEL; /* delete after timeout */
           cs->timer.expires = jiffies + (HZ * AUTODEL_TIME);
           add_timer(&cs->timer);
-          restore_flags(flags);
+          spin_unlock_irqrestore(&divert_lock, flags);
         }
        else
           cs->akt_state = DEFLECT_ALERT;
@@ -256,12 +254,12 @@ int deflect_extern_action(u_char cmd, ul
        strcpy(cs->ics.parm.setup.eazmsn, "Testtext manual");
        ic.command = ISDN_CMD_REDIR;
        if ((i = divert_if.ll_cmd(&ic)))
-	{ save_flags(flags);
-          cli();
+	{
+          spin_lock_irqsave(&divert_lock, flags);
           cs->akt_state = DEFLECT_AUTODEL; /* delete after timeout */
           cs->timer.expires = jiffies + (HZ * AUTODEL_TIME);
           add_timer(&cs->timer);
-          restore_flags(flags);
+          spin_unlock_irqrestore(&divert_lock, flags);
         }
        else
           cs->akt_state = DEFLECT_ALERT;
@@ -277,6 +275,7 @@ int deflect_extern_action(u_char cmd, ul
int insertrule(int idx, divert_rule *newrule)
{ struct deflect_struc *ds,*ds1=NULL;
   unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

   if (!(ds = (struct deflect_struc *) kmalloc(sizeof(struct deflect_struc),
                                               GFP_KERNEL)))
@@ -284,8 +283,7 @@ int insertrule(int idx, divert_rule *new

   ds->rule = *newrule; /* set rule */

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);

   if (idx >= 0)
    { ds1 = table_head;
@@ -313,7 +311,7 @@ int insertrule(int idx, divert_rule *new
         table_head = ds; /* first element */
    }

-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
   return(0);
} /* insertrule */

@@ -323,14 +321,14 @@ int insertrule(int idx, divert_rule *new
int deleterule(int idx)
{ struct deflect_struc *ds,*ds1;
   unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

   if (idx < 0)
-   { save_flags(flags);
-     cli();
+   { spin_lock_irqsave(&divert_lock, flags);
      ds = table_head;
      table_head = NULL;
      table_tail = NULL;
-     restore_flags(flags);
+     spin_unlock_irqrestore(&divert_lock, flags);
      while (ds)
       { ds1 = ds;
         ds = ds->next;
@@ -339,8 +337,7 @@ int deleterule(int idx)
      return(0);
    }

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);
   ds = table_head;

   while ((ds) && (idx > 0))
@@ -349,7 +346,8 @@ int deleterule(int idx)
    }

   if (!ds)
-   { restore_flags(flags);
+   {
+     spin_unlock_irqrestore(&divert_lock, flags);
      return(-EINVAL);
    }

@@ -363,7 +361,7 @@ int deleterule(int idx)
    else
      table_head = ds->next; /* start of chain */

-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
   kfree(ds);
   return(0);
} /* deleterule */
@@ -391,6 +389,7 @@ divert_rule *getruleptr(int idx)
int isdn_divert_icall(isdn_ctrl *ic)
{ int retval = 0;
   unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
   struct call_struc *cs = NULL;
   struct deflect_struc *dv;
   char *p,*p1;
@@ -474,10 +473,9 @@ int isdn_divert_icall(isdn_ctrl *ic)
             else
               cs->timer.expires = 0;
            cs->akt_state = dv->rule.action;
-           save_flags(flags);
-           cli();
+           spin_lock_irqsave(&divert_lock, flags);
            cs->divert_id = next_id++; /* new sequence number */
-           restore_flags(flags);
+           spin_unlock_irqrestore(&divert_lock, flags);
            cs->prev = NULL;
            if (cs->akt_state == DEFLECT_ALERT)
              { strcpy(cs->deflect_dest,dv->rule.to_nr);
@@ -525,12 +523,11 @@ int isdn_divert_icall(isdn_ctrl *ic)

   if (cs)
    { cs->prev = NULL;
-     save_flags(flags);
-     cli();
+     spin_lock_irqsave(&divert_lock, flags);
      cs->next = divert_head;
      divert_head = cs;
      if (cs->timer.expires) add_timer(&cs->timer);
-     restore_flags(flags);
+     spin_unlock_irqrestore(&divert_lock, flags);

      put_info_buffer(cs->info);
      return(retval);
@@ -543,9 +540,9 @@ int isdn_divert_icall(isdn_ctrl *ic)
void deleteprocs(void)
{ struct call_struc *cs, *cs1;
   unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);
   cs = divert_head;
   divert_head = NULL;
   while (cs)
@@ -554,7 +551,7 @@ void deleteprocs(void)
      cs = cs->next;
      kfree(cs1);
    }
-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
} /* deleteprocs */

/****************************************************/
@@ -701,6 +698,7 @@ int prot_stat_callback(isdn_ctrl *ic)
{ struct call_struc *cs, *cs1;
   int i;
   unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;

   cs = divert_head; /* start of list */
   cs1 = NULL;
@@ -769,8 +767,8 @@ int prot_stat_callback(isdn_ctrl *ic)
    }

   if (cs1->ics.driver == -1)
-   { save_flags(flags);
-     cli();
+   {
+     spin_lock_irqsave(&divert_lock, flags);
      del_timer(&cs1->timer);
      if (cs1->prev)
        cs1->prev->next = cs1->next; /* forward link */
@@ -778,7 +776,7 @@ int prot_stat_callback(isdn_ctrl *ic)
        divert_head = cs1->next;
      if (cs1->next)
        cs1->next->prev = cs1->prev; /* back link */
-     restore_flags(flags);
+     spin_unlock_irqrestore(&divert_lock, flags);
      kfree(cs1);
    }

@@ -792,6 +790,7 @@ int prot_stat_callback(isdn_ctrl *ic)
int isdn_divert_stat_callback(isdn_ctrl *ic)
{ struct call_struc *cs, *cs1;
   unsigned long flags;
+  spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
   int retval;

   retval = -1;
@@ -826,15 +825,14 @@ int isdn_divert_stat_callback(isdn_ctrl
         cs = cs->next;
         if (cs1->ics.driver == -1)
           {
-            save_flags(flags);
-            cli();
+            spin_lock_irqsave(&divert_lock, flags);
             if (cs1->prev)
               cs1->prev->next = cs1->next; /* forward link */
             else
               divert_head = cs1->next;
             if (cs1->next)
               cs1->next->prev = cs1->prev; /* back link */
-            restore_flags(flags);
+            spin_unlock_irqrestore(&divert_lock, flags);
             kfree(cs1);
           }
       }
diff -uprN -X /home/sm/dontdiff linux-vanilla/drivers/isdn/i4l/Kconfig linux-2.6.8.1/drivers/isdn/i4l/Kconfig
--- linux-vanilla/drivers/isdn/i4l/Kconfig	2004-08-14 12:55:10.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/i4l/Kconfig	2004-11-17 13:34:09.983567648 +0100
@@ -99,7 +99,7 @@ config ISDN_DRV_LOOP

config ISDN_DIVERSION
	tristate "Support isdn diversion services"
-	depends on BROKEN && BROKEN_ON_SMP
+	depends on ISDN && ISDN_I4L
	help
	  This option allows you to use some supplementary diversion
	  services in conjunction with the HiSax driver on an EURO/DSS1



