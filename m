Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276138AbRI1Pos>; Fri, 28 Sep 2001 11:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276136AbRI1Poi>; Fri, 28 Sep 2001 11:44:38 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:23056 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S276135AbRI1PoY>; Fri, 28 Sep 2001 11:44:24 -0400
Message-ID: <3BB49A41.A276AB7E@osdlab.org>
Date: Fri, 28 Sep 2001 08:41:53 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: junio@siamese.dhis.twinsun.com
CC: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link failur in Linux 2.4.9-ac16 around apm.o and sysrq.o
In-Reply-To: <20010927185107.A17861@lightning.swansea.linux.org.uk>
		<7v8zezki0b.fsf@siamese.dhis.twinsun.com> <7v1ykrkgt2.fsf@siamese.dhis.twinsun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

junio@siamese.dhis.twinsun.com wrote:
> 
> >>>>> "JNH" == junio  <junio@siamese.dhis.twinsun.com> writes:
> 
> JNH> 2.4.9-ac16 fails to link with CONFIG_APM=y and
> JNH> CONFIG_MAGIC_SYSRQ=n.  This is because apm.c unconditionally
> JNH> makes calls to functions (__sysrq_lock_table and friends)
> JNH> defined in sysrq.c.
> 
> JNH> I can think of a couple of different approaches to work this
> JNH> around, but is there an established proper way to resolve this
> JNH> kind of dependency in the kernel code?
> 
> The approaches I listed as (1) and (3) in my previous message
> are non solutions, since it will result in a kernel where apm.o
> makes calls into sysrq functions, whose proper operations would
> depend on sysrq.o to have been properly initialized by other
> parts of the kernel, which still think CONFIG_MAGIC_SYSRQ is not
> defined.
> 
> The below should be a better fix.
> 
> --- 2.4.9-ac16.sffix/arch/i386/kernel/apm.c     Thu Sep 27 12:46:43 2001
> +++ 2.4.9-ac16.sffix/arch/i386/kernel/apm.c     Thu Sep 27 22:41:53 2001
> @@ -201,7 +201,9 @@
>  #include <asm/uaccess.h>
>  #include <asm/desc.h>
> 
> +#ifdef CONFIG_MAGIC_SYSRQ
>  #include <linux/sysrq.h>
> +#endif
> 
>  extern unsigned long get_cmos_time(void);
>  extern void machine_real_restart(unsigned char *, int);
> @@ -697,12 +699,16 @@
>                                         struct kbd_struct *kbd, struct tty_struct *tty) {
>                 apm_power_off();
>  }
> +#ifdef CONFIG_MAGIC_SYSRQ
>  struct sysrq_key_op sysrq_poweroff_op = {
>         handler:        handle_poweroff,
>         help_msg:       "Off",
>         action_msg:     "Power Off\n"
>  };
> -
> +#else
> +# define register_sysrq_key(ig,no) /*re*/
> +# define unregister_sysrq_key(ig,no) /*re*/
> +#endif
> 
>  #ifdef CONFIG_APM_DO_ENABLE
>  static int apm_enable_power_management(int enable)

Yes, that looks like a decent temporary workaround for apm.c.

What should be done (IMO of course) is that
linux/include/linux/sysrq.h should provide empty/null definitions
of [un]register_sysrq_key()... and it did do that until
2.4.9-ac15, but those #defines are( were) untyped, and they
should be typed (i.e., return 0), just as the versions
of them that are present when CONFIG_MAGIC_SYSRQ is #defined.

~Randy
