Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274858AbRIUWgG>; Fri, 21 Sep 2001 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274860AbRIUWf5>; Fri, 21 Sep 2001 18:35:57 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:8462 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274858AbRIUWfr>; Fri, 21 Sep 2001 18:35:47 -0400
Date: Fri, 21 Sep 2001 18:36:08 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Linus <torvalds@transmeta.com>
Subject: [PATCH] Magic SysRq alternate fix register functions
Message-ID: <20010921183608.N8188@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Alan <alan@lxorguk.ukuu.org.uk>, Linus <torvalds@transmeta.com>
In-Reply-To: <E15k86n-0005lE-00@the-village.bc.nu> <3BAA3C17.557A2C4E@osdlab.org> <20010921182207.M8188@mueller.datastacks.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921182207.M8188@mueller.datastacks.com>; from crutcher@datastacks.com on Fri, Sep 21, 2001 at 06:22:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

++ 21/09/01 18:22 -0400 - Crutcher Dunnavant:
> I'm not sure if this is sufficient. The low level interfaces need to be
> exposed, and if we are not expecting modules to pay attention to the
> CONFIG_MAGIC_SYSRQ setting, then the all of these interfaces need to be
> overridden.
> 
> However, do we even need this #ifdef CONFIG_MAGIC_SYSRQ block at all?
> What does it matter if modules register or unregister events, if they
> cannot be called?
> 
> The old code only zaped the enable if sysrq was not defined, and that is
> what I'm doing in the table. Some real changes would be neccessary to
> actually drop out the whole system.
> 
> There is also no real reason to try and no-op these functions for speed,
> as they are trivial and FAR outside of the main call path.
> 
> So the way to go I see here is:
>  a) allow the registration functions to always be defined.
> and either:
>  b) handle the return failure in the __sysrq_XXX functions themselves,
>  c) or not.

A 'dont-close-it' patch is attached.

> 
> ++ 20/09/01 11:57 -0700 - Randy.Dunlap:
> > Alan Cox wrote:
> > > 
> > > > Yeah, I considered that, and it doesn't matter to me whether it
> > > > reports 0 or -1, but it's the data pointer that (mostly) requires
> > > > the #ifdefs, unless the data is always present or a dummy data pointer
> > > > is used.... ?
> > > 
> > > #define it to an inline without some arguments ?
> > ~~~~~~~~~~~~~~~~~~
> > I can't get that to work, but someone else may be able to...
> > 
> > Here's another version for you to consider.
> > 
> > The [un]register_sysrq_key() calls return 0 when CONFIG_MAGIC_SYSRQ
> > is not defined/configured.
> > However, it sacrifices one small data structure of 3 pointers.
> > 
> > ~Randy
> > --- linux/arch/i386/kernel/apm.c.org	Mon Sep 17 10:15:45 2001
> > +++ linux/arch/i386/kernel/apm.c	Thu Sep 20 11:51:25 2001
> > @@ -703,6 +703,8 @@
> >  	help_msg:       "Off",
> >  	action_msg:     "Power Off\n"
> >  };
> > +#else
> > +struct sysrq_key_op sysrq_poweroff_op;
> >  #endif
> >  
> >  
> > --- linux/include/linux/sysrq.h.org	Mon Sep 17 10:21:07 2001
> > +++ linux/include/linux/sysrq.h	Thu Sep 20 11:42:15 2001
> > @@ -87,8 +87,17 @@
> >  }
> >  
> >  #else
> > -#define register_sysrq_key(a,b)		do {} while(0)
> > -#define unregister_sysrq_key(a,b)	do {} while(0)
> > +
> > +static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline int unregister_sysrq_key(int key, struct sysrq_key_op *op_p)
> > +{
> > +	return 0;
> > +}
> > +
> >  #endif
> >  
> >  /* Deferred actions */
> 
> 
> -- 
> Crutcher        <crutcher@datastacks.com>
> GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
>     R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$

--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Description: patch-2.4.10-pre13-sysrq_register
Content-Disposition: attachment; filename="patch-2.4.10-pre13-sysrq_register"

--- 2.4.10-pre13.fix_sysrq/include/linux/sysrq.h.fix_sysrq	Fri Sep 21 17:11:20 2001
+++ 2.4.10-pre13.fix_sysrq/include/linux/sysrq.h	Fri Sep 21 18:25:55 2001
@@ -42,7 +42,6 @@
                 struct kbd_struct *, struct tty_struct *);
 
 
-#ifdef CONFIG_MAGIC_SYSRQ
 
 /*
  * Sysrq registration manipulation functions
@@ -55,7 +54,8 @@
 
 extern __inline__ int
 __sysrq_swap_key_ops_nolock(int key, struct sysrq_key_op *insert_op_p,
-				struct sysrq_key_op *remove_op_p) {
+				struct sysrq_key_op *remove_op_p)
+{
 	int retval;
 	if (__sysrq_get_key_op(key) == remove_op_p) {
 		__sysrq_put_key_op(key, insert_op_p);
@@ -86,11 +86,6 @@
 	return __sysrq_swap_key_ops(key, NULL, op_p);
 }
 
-#else
-#define register_sysrq_key(a,b)		do {} while(0)
-#define unregister_sysrq_key(a,b)	do {} while(0)
-#endif
-
 /* Deferred actions */
 
 extern int emergency_sync_scheduled;
--- 2.4.10-pre13.fix_sysrq/arch/i386/kernel/apm.c.fix_sysrq	Fri Sep 21 18:27:06 2001
+++ 2.4.10-pre13.fix_sysrq/arch/i386/kernel/apm.c	Fri Sep 21 18:27:42 2001
@@ -689,7 +689,6 @@
 		(void) apm_set_power_state(APM_STATE_OFF);
 }
 
-#ifdef CONFIG_MAGIC_SYSRQ
 /*
  * Magic sysrq key and handler for the power off function
  */
@@ -703,7 +702,6 @@
 	help_msg:       "Off",
 	action_msg:     "Power Off\n"
 };
-#endif
 
 
 #ifdef CONFIG_APM_DO_ENABLE

--Dzs2zDY0zgkG72+7--
