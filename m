Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280073AbRJaFIe>; Wed, 31 Oct 2001 00:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280074AbRJaFIY>; Wed, 31 Oct 2001 00:08:24 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:18921 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S280073AbRJaFIT>; Wed, 31 Oct 2001 00:08:19 -0500
Date: Wed, 31 Oct 2001 14:08:44 +0900
Message-ID: <y9ls8kgz.wl@nisaaru.dvs.cs.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Robert Love <rml@tech9.net>
Cc: linus@transmeta.com, laughing@shared-source.org,
        linux-kernel@vger.kernel.org, tytso@thunk.org, andrewm@uow.edu.au
Subject: Re: [PATCH] tty race on con_close and con_flush_chars
In-Reply-To: <1004411636.807.262.camel@phantasy>
In-Reply-To: <1004403868.809.147.camel@phantasy>
	<1004411636.807.262.camel@phantasy>
User-Agent: Wanderlust/2.7.5 (Too Funky) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.7 () APEL/10.3 MULE XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At 29 Oct 2001 22:13:55 -0500,
Robert Love wrote:
> 
> Someone pointed out (via private email) that a race can still exist
> between checking that vt is non-zero and acquiring the semaphore,
> especially since we can sleep doing that.
> 
> I agree; the following patch should alleviate that race.

Your patch only fixes con_flush_chars(), but the same races exists in
do_con_write() and maybe con_unthrottle(). I think the patch below is
better because the oops would never happen with this patch.


diff -r -u -N linux.org/drivers/char/console.c linux/drivers/char/console.c
--- linux.org/drivers/char/console.c	Tue Oct 30 18:55:17 2001
+++ linux/drivers/char/console.c	Tue Oct 30 19:07:08 2001
@@ -2424,7 +2424,6 @@
 		return;
 	if (tty->count != 1) return;
 	vcs_make_devfs (MINOR (tty->device) - tty->driver.minor_start, 1);
-	tty->driver_data = 0;
 }
 
 static void vc_init(unsigned int currcons, unsigned int rows, unsigned int cols, int do_clear)



> 
> diff -u linux-2.4.13-ac5/drivers/char/console.c
> linux/drivers/char/console.c
> --- linux-2.4.13-ac5/drivers/char/console.c	Mon Oct 29 17:27:19 2001
> +++ linux/drivers/char/console.c	Mon Oct 29 22:11:27 2001
> @@ -2387,8 +2387,14 @@
>  		return;
>  
>  	pm_access(pm_con);
> +
> +	/*
> +	 * If we raced with con_close(), `vt' may be null. 
> +	 * Hence this bandaid.   - akpm
> +	 */
>  	acquire_console_sem();
> -	set_cursor(vt->vc_num);
> +	if (vt)
> +		set_cursor(vt->vc_num);
>  	release_console_sem();
>  }
>  
> 
> 	Robert Love
> 
