Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRI1FrV>; Fri, 28 Sep 2001 01:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275842AbRI1FrC>; Fri, 28 Sep 2001 01:47:02 -0400
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:34544 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S275844AbRI1Fq6>; Fri, 28 Sep 2001 01:46:58 -0400
From: junio@siamese.dhis.twinsun.com
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link failur in Linux 2.4.9-ac16 around apm.o and sysrq.o
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
	<7v8zezki0b.fsf@siamese.dhis.twinsun.com>
Date: 27 Sep 2001 22:47:21 -0700
In-Reply-To: <7v8zezki0b.fsf@siamese.dhis.twinsun.com>
Message-ID: <7v1ykrkgt2.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JNH" == junio  <junio@siamese.dhis.twinsun.com> writes:

JNH> 2.4.9-ac16 fails to link with CONFIG_APM=y and
JNH> CONFIG_MAGIC_SYSRQ=n.  This is because apm.c unconditionally
JNH> makes calls to functions (__sysrq_lock_table and friends)
JNH> defined in sysrq.c.

JNH> I can think of a couple of different approaches to work this
JNH> around, but is there an established proper way to resolve this
JNH> kind of dependency in the kernel code?

The approaches I listed as (1) and (3) in my previous message
are non solutions, since it will result in a kernel where apm.o
makes calls into sysrq functions, whose proper operations would
depend on sysrq.o to have been properly initialized by other
parts of the kernel, which still think CONFIG_MAGIC_SYSRQ is not
defined.

The below should be a better fix.

--- 2.4.9-ac16.sffix/arch/i386/kernel/apm.c	Thu Sep 27 12:46:43 2001
+++ 2.4.9-ac16.sffix/arch/i386/kernel/apm.c	Thu Sep 27 22:41:53 2001
@@ -201,7 +201,9 @@
 #include <asm/uaccess.h>
 #include <asm/desc.h>
 
+#ifdef CONFIG_MAGIC_SYSRQ
 #include <linux/sysrq.h>
+#endif
 
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
@@ -697,12 +699,16 @@
 		                        struct kbd_struct *kbd, struct tty_struct *tty) {
 	        apm_power_off();
 }
+#ifdef CONFIG_MAGIC_SYSRQ
 struct sysrq_key_op sysrq_poweroff_op = {
 	handler:        handle_poweroff,
 	help_msg:       "Off",
 	action_msg:     "Power Off\n"
 };
-
+#else
+# define register_sysrq_key(ig,no) /*re*/
+# define unregister_sysrq_key(ig,no) /*re*/
+#endif
 
 #ifdef CONFIG_APM_DO_ENABLE
 static int apm_enable_power_management(int enable)


