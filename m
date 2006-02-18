Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWBRNfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWBRNfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWBRNfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:35:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751226AbWBRNfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:35:15 -0500
Date: Sat, 18 Feb 2006 13:34:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, rusty@rustcorp.com.au,
       LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
Subject: Re: kbuild: Section mismatch warnings
Message-ID: <20060218133459.GA14141@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>, rusty@rustcorp.com.au,
	LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
	Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
	B.Zolnierkiewicz@elka.pw.edu.pl, kkeil@suse.de,
	linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
	dwmw2@infradead.org
References: <20060217214855.GA5563@mars.ravnborg.org> <20060217224702.GA25761@mars.ravnborg.org> <200602171949.27532.dtor_core@ameritech.net> <20060218121414.GA5273@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218121414.GA5273@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 01:14:14PM +0100, Sam Ravnborg wrote:
> It hits only arrays - so I took a look into moduleparam.h.
> Looks like an __initdata tag is missing?
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index b5c98c4..e67eafd 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -147,6 +147,7 @@ extern int param_get_invbool(char *buffe
>  /* Comma-separated array: *nump is set to number they actually specified. */
>  #define module_param_array_named(name, array, type, nump, perm)		\
>  	static struct kparam_array __param_arr_##name			\
> +	__initdata							\
>  	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
>  	    sizeof(array[0]), array };					\
>  	module_param_call(name, param_array_set, param_array_get, 	\
> 
> 
> With this change static struct kparam_array __param_arr_##name is placed
> in .init.data.
> This made the warnings in drivers/input/joystick/db9 disappear.
> 
> And with db9 marked __initdata there should be nothing wrong in
> using __initdata for __param_arr_##name as I see it.

What happens to /sys/module/*/parameters/foo if you read/write it?
Probably worth checking to ensure there isn't an oops lurking as a
result of this change.

(Maybe we need to poison the free'd init sections at boot time just
to make sure we catch possible errors like this.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
