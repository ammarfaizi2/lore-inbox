Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbUKQS6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUKQS6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUKQS6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:58:13 -0500
Received: from p508F03A7.dip0.t-ipconnect.de ([80.143.3.167]:55606 "EHLO
	mail.morknet.de") by vger.kernel.org with ESMTP id S262496AbUKQSxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:53:49 -0500
Message-ID: <419B9E06.6020100@morknet.de>
Date: Wed, 17 Nov 2004 19:52:54 +0100
From: "Steffen A. Mork" <linux-dev@morknet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: de, en, el
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] dss1_divert ISDN module compile fix for kernel 2.6.8.1
References: <419B662D.5020904@morknet.de> <58cb370e0411170828365d1982@mail.gmail.com>
In-Reply-To: <58cb370e0411170828365d1982@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir Milter (version: 1.1; AVE: 6.28.0.12; VDF: 6.28.0.78; host: mail.morknet.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus and Bartlomiej,

>>when I switched my installation from kernel 2.4 to 2.6 I
>>recognized that the ISDN module dss1_divert was marked
>>incompilable (config option CONFIG_CLEAN_COMPILE must
>>be turned off). The compile problem was the obsolete using
>>of kernel 2.4 critical sections. I replaced the cli() stuff
>>with spinlocks as explained in the Documentation/spinlocks.txt
>>file. After that the module compiles and runs as expected.
> 
> 
> This looks wrong, you are using many private spinlocks instead
> of one global spinlock.
OK, thank you. I went into the copy/paste trap. I corrected the patch to
a global spinlock and tested it successfully.

The corrected patch is applied to kernel 2.6.8.1 and should work for
all 2.6 versions. You may also download the patch via http, too:

http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert.diff

Signed-off-by: Steffen A. Mork <linux-dev@morknet.de>

diff -uprN -X dontdiff linux-vanilla/drivers/isdn/divert/divert_init.c linux-2.6.8.1/drivers/isdn/divert/divert_init.c
--- linux-vanilla/drivers/isdn/divert/divert_init.c	2004-08-14 12:55:47.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/divert/divert_init.c	2004-11-17 17:50:38.000000000 +0100
@@ -12,6 +12,7 @@
  #include <linux/module.h>
  #include <linux/version.h>
  #include <linux/init.h>
+
  #include "isdn_divert.h"

  MODULE_DESCRIPTION("ISDN4Linux: Call diversion support");
@@ -59,23 +60,23 @@ static int __init divert_init(void)
  /* Module deinit code */
  /**********************/
  static void __exit divert_exit(void)
-{ unsigned long flags;
+{
+  unsigned long flags;
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
diff -uprN -X dontdiff linux-vanilla/drivers/isdn/divert/divert_procfs.c linux-2.6.8.1/drivers/isdn/divert/divert_procfs.c
--- linux-vanilla/drivers/isdn/divert/divert_procfs.c	2004-08-14 12:56:22.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/divert/divert_procfs.c	2004-11-17 17:42:00.000000000 +0100
@@ -22,6 +22,7 @@
  #include <linux/isdnif.h>
  #include "isdn_divert.h"

+
  /*********************************/
  /* Variables for interface queue */
  /*********************************/
@@ -215,10 +216,9 @@ isdn_divert_ioctl(struct inode *inode, s
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

diff -uprN -X dontdiff linux-vanilla/drivers/isdn/divert/isdn_divert.c linux-2.6.8.1/drivers/isdn/divert/isdn_divert.c
--- linux-vanilla/drivers/isdn/divert/isdn_divert.c	2004-08-14 12:55:34.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/divert/isdn_divert.c	2004-11-17 19:39:32.000000000 +0100
@@ -11,6 +11,7 @@

  #include <linux/version.h>
  #include <linux/proc_fs.h>
+
  #include "isdn_divert.h"

  /**********************************/
@@ -47,54 +48,53 @@ static struct deflect_struc *table_head
  static struct deflect_struc *table_tail = NULL;
  static unsigned char extern_wait_max = 4; /* maximum wait in s for external process */

+spinlock_t divert_lock = SPIN_LOCK_UNLOCKED;
+
  /***************************/
  /* timer callback function */
  /***************************/
  static void deflect_timer_expire(ulong arg)
-{ unsigned long flags;
+{
+  unsigned long flags;
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
@@ -224,13 +222,12 @@ int deflect_extern_action(u_char cmd, ul
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
@@ -239,12 +236,12 @@ int deflect_extern_action(u_char cmd, ul
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
@@ -256,12 +253,12 @@ int deflect_extern_action(u_char cmd, ul
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
@@ -284,8 +281,7 @@ int insertrule(int idx, divert_rule *new

    ds->rule = *newrule; /* set rule */

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);

    if (idx >= 0)
     { ds1 = table_head;
@@ -313,7 +309,7 @@ int insertrule(int idx, divert_rule *new
          table_head = ds; /* first element */
     }

-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
    return(0);
  } /* insertrule */

@@ -325,12 +321,11 @@ int deleterule(int idx)
    unsigned long flags;

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
@@ -339,8 +334,7 @@ int deleterule(int idx)
       return(0);
     }

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);
    ds = table_head;

    while ((ds) && (idx > 0))
@@ -349,7 +343,8 @@ int deleterule(int idx)
     }

    if (!ds)
-   { restore_flags(flags);
+   {
+     spin_unlock_irqrestore(&divert_lock, flags);
       return(-EINVAL);
     }

@@ -363,7 +358,7 @@ int deleterule(int idx)
     else
       table_head = ds->next; /* start of chain */

-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
    kfree(ds);
    return(0);
  } /* deleterule */
@@ -474,10 +469,9 @@ int isdn_divert_icall(isdn_ctrl *ic)
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
@@ -525,12 +519,11 @@ int isdn_divert_icall(isdn_ctrl *ic)

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
@@ -544,8 +537,7 @@ void deleteprocs(void)
  { struct call_struc *cs, *cs1;
    unsigned long flags;

-  save_flags(flags);
-  cli();
+  spin_lock_irqsave(&divert_lock, flags);
    cs = divert_head;
    divert_head = NULL;
    while (cs)
@@ -554,7 +546,7 @@ void deleteprocs(void)
       cs = cs->next;
       kfree(cs1);
     }
-  restore_flags(flags);
+  spin_unlock_irqrestore(&divert_lock, flags);
  } /* deleteprocs */

  /****************************************************/
@@ -769,8 +761,8 @@ int prot_stat_callback(isdn_ctrl *ic)
     }

    if (cs1->ics.driver == -1)
-   { save_flags(flags);
-     cli();
+   {
+     spin_lock_irqsave(&divert_lock, flags);
       del_timer(&cs1->timer);
       if (cs1->prev)
         cs1->prev->next = cs1->next; /* forward link */
@@ -778,7 +770,7 @@ int prot_stat_callback(isdn_ctrl *ic)
         divert_head = cs1->next;
       if (cs1->next)
         cs1->next->prev = cs1->prev; /* back link */
-     restore_flags(flags);
+     spin_unlock_irqrestore(&divert_lock, flags);
       kfree(cs1);
     }

@@ -826,15 +818,14 @@ int isdn_divert_stat_callback(isdn_ctrl
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
diff -uprN -X dontdiff linux-vanilla/drivers/isdn/divert/isdn_divert.h linux-2.6.8.1/drivers/isdn/divert/isdn_divert.h
--- linux-vanilla/drivers/isdn/divert/isdn_divert.h	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1/drivers/isdn/divert/isdn_divert.h	2004-11-17 18:59:16.000000000 +0100
@@ -114,6 +114,8 @@ struct divert_info
  /**************/
  /* Prototypes */
  /**************/
+extern spinlock_t divert_lock;
+
  extern ulong if_used; /* number of interface users */
  extern int divert_dev_deinit(void);
  extern int divert_dev_init(void);
diff -uprN -X dontdiff linux-vanilla/drivers/isdn/i4l/Kconfig linux-2.6.8.1/drivers/isdn/i4l/Kconfig
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



