Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTICWW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTICWW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:22:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:56476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263848AbTICWWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:22:54 -0400
Date: Wed, 3 Sep 2003 15:17:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (Simple) Basic Design Flaw in make menuconfig GUI
Message-Id: <20030903151730.5ea69292.rddunlap@osdl.org>
In-Reply-To: <20030903170348.GJ14376@lug-owl.de>
References: <001f01c37229$4bbd0410$1400a8c0@gaussian>
	<20030903083334.6a98a4f5.rddunlap@osdl.org>
	<20030903170348.GJ14376@lug-owl.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003 19:03:48 +0200 Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:

| On Wed, 2003-09-03 08:33:34 -0700, Randy.Dunlap <rddunlap@osdl.org>
| wrote in message <20030903083334.6a98a4f5.rddunlap@osdl.org>:
| > On Wed, 3 Sep 2003 10:40:17 -0400 "Stevo" <stevo@cool3dz.com> wrote:
| > 
| > | PROBLEM: (ocassionally) While I am speeding through the kernel
| > | configuration, I will accidentally hit the "Esc" key one too many times (I'm
| > | sure we've all done this) and it will leave me at the "exit" screen:
| 
| > | can someone please add one more simple choice to the "exit" menu?
| > 
| > Yes, I've needed that choice at times also.
| 
| Like this?
| 
| 
| --- linux-2.6.0-test4-bk5/scripts/kconfig/mconf.c.jbglaw	2003-09-03 18:28:06.000000000 +0200
| +++ linux-2.6.0-test4-bk5/scripts/kconfig/mconf.c	2003-09-03 19:00:31.000000000 +0200
| @@ -773,27 +773,56 @@
|  	tcgetattr(1, &ios_org);
|  	atexit(conf_cleanup);
|  	init_wsize();
| -	conf(&rootmenu);
|  
| -	do {
| -		cprint_init();
| -		cprint("--yesno");
| -		cprint("Do you wish to save your new kernel configuration?");
| -		cprint("5");
| -		cprint("60");
| -		stat = exec_conf();
| -	} while (stat < 0);
| -
| -	if (stat == 0) {
| -		conf_write(NULL);
| -		printf("\n\n"
| -			"*** End of Linux kernel configuration.\n"
| -			"*** Execute 'make' to build the kernel or try 'make help'."
| -			"\n\n");
| -	} else
| -		printf("\n\n"
| -			"Your kernel configuration changes were NOT saved."
| -			"\n\n");
| +	while (1) {
| +		/*
| +		 * Config dialog
| +		 */
| +		conf(&rootmenu);
| +
| +		/*
| +		 * Really quit?
| +		 */
| +		do {
| +			cprint_init();
| +			cprint("--title");
| +			cprint("Save configuration");
| +			cprint("--radiolist");
| +			cprint(radiolist_instructions);
| +			cprint("15");
| +			cprint("70");
| +			cprint("6");
| +
| +			cprint("continue");
| +			cprint("Continue with configuation");
| +			cprint("ON");
| +
| +			cprint("save");
| +			cprint("Save .config and exit");
| +			cprint("OFF");
| +
| +			cprint("exit");
| +			cprint("Don't save .config and exit");
| +			cprint("OFF");
| +
| +			stat = exec_conf();
| +		} while (stat < 0);
| +
| +		if(!strcmp(input_buf, "save")) {
| +			conf_write(NULL);
| +			printf("\n\n"
| +				"*** End of Linux kernel configuration.\n"
| +				"*** Execute 'make' to build the kernel or try 'make help'."
| +				"\n\n");
| +			return 0;
| +		}
| +		if(!strcmp(input_buf, "exit")) {
| +			printf("\n\n"
| +				"Your kernel configuration changes were NOT saved."
| +				"\n\n");
| +			return 0;
| +		}
| +	}
|  
|  	return 0;
|  }

Yes, that works nicely.  Merge and ship it!

--
~Randy
