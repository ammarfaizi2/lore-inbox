Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUECUom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUECUom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUECUom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:44:42 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:37023 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263963AbUECUoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:44:34 -0400
Message-ID: <004001c4314f$6f455a50$0202a8c0@boxa>
From: "Bill Catlan" <wcatlan@yahoo.com>
To: "Willy Tarreau" <willy@w.ods.org>
Cc: <linux-kernel@vger.kernel.org>
References: <003201c4309c$fd93cd90$0202a8c0@boxa> <20040503053418.GB10228@alpha.home.local>
Subject: Re: Possible to delay boot process to boot from USB subsystem?
Date: Mon, 3 May 2004 16:44:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Willy.  I like to automatic looping of Randy's patch (I had it working
nicely on a 2.4.18 kernel) because I don't have to set a time in case one
machine takes longer than another.

So far, however, I haven't got Randy's patch working for a newer kernel, so I
may try yours.

Would I only have to run make in the directory where I'm patching the file, then
make bzImage, make modules_install, and make install from the top level to apply
your patch?  Compiling all of my modules takes a long time, with random lock-ups
during compile gumming up the works as well. :-/  Any tips appreciated.

Thanks.

Bill

----- Original Message ----- 
From: "Willy Tarreau" <willy@w.ods.org>
To: "Bill Catlan" <wcatlan@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, May 03, 2004 1:34 AM
Subject: Re: Possible to delay boot process to boot from USB subsystem?


> Hi,
>
> I include the following patch in all my kernels. It adds a "setuptime" boot
> option which allows one to specify how many milliseconds to wait before
> mounting the root FS. I usually wait 2500 ms to boot on USB flash, but I
> once saw a machine which required a bit more (4 sec). The advantage is that
> if it isn't enough, just reboot and change the paramter.
>
> Regards,
> Willy
>
>
> diff -urN linux-2.4.23-rc3/init/main.c linux-2.4.23-rc3-setuptime/init/main.c
> --- linux-2.4.23-rc3/init/main.c Fri Oct 10 08:47:16 2003
> +++ linux-2.4.23-rc3-setuptime/init/main.c Sun Nov 23 18:12:19 2003
> @@ -127,6 +127,7 @@
>
>  static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
>  char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
> +static int setuptime; /* time(ms) to let devices set up before root mount */
>
>  static int __init profile_setup(char *str)
>  {
> @@ -137,6 +138,15 @@
>
>  __setup("profile=", profile_setup);
>
> +static int __init setuptime_setup(char *str)
> +{
> +    int par;
> +    if (get_option(&str,&par)) setuptime = par;
> + return 1;
> +}
> +
> +__setup("setuptime=", setuptime_setup);
> +
>  static int __init checksetup(char *line)
>  {
>   struct kernel_param *p;
> @@ -553,12 +563,26 @@
>
>  extern void prepare_namespace(void);
>
> +static int finish_setup()
> +{
> + int tleft;
> + if (setuptime) {
> + printk("Waiting %d ms for devices to set up.\n", setuptime);
> + tleft = setuptime * HZ / 1000;
> + while (tleft) {
> + set_current_state(TASK_INTERRUPTIBLE);
> + tleft = schedule_timeout(tleft);
> + }
> + }
> +}
> +
>  static int init(void * unused)
>  {
>   struct files_struct *files;
>   lock_kernel();
>   do_basic_setup();
>
> + finish_setup();
>   prepare_namespace();
>
>   /*
>

