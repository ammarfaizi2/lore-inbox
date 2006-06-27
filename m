Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbWF0Qn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbWF0Qn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWF0QnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:43:25 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:29084 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161182AbWF0QnW (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:43:22 -0400
Message-Id: <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Tue, 27 Jun 2006 12:16:15 +0200."
             <Pine.LNX.4.64.0606271212150.17704@scrub.home>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
            <Pine.LNX.4.64.0606271212150.17704@scrub.home>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151426588_3177P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 12:43:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151426588_3177P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Jun 2006 12:16:15 +0200, Roman Zippel said:

> Could you please try the patch below?
> tv_nsec can shortly become negative, but its absolute value will always be 
> smaller then the current nsec offset.

> Index: linux-2.6-mm/kernel/timer.c
> ===================================================================
> --- linux-2.6-mm.orig/kernel/timer.c	2006-06-27 11:59:19.000000000 +0200
> +++ linux-2.6-mm/kernel/timer.c	2006-06-27 12:10:28.000000000 +0200
> @@ -1129,7 +1129,7 @@ static void update_wall_time(void)
>  	clocksource_adjust(clock, offset);
>  
>  	/* store full nanoseconds into xtime */
> -	xtime.tv_nsec = clock->xtime_nsec >> clock->shift;
> +	xtime.tv_nsec = (s64)clock->xtime_nsec >> clock->shift;
>  	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
>  
>  	/* check to see if there is a new clocksource to use */

Sorry Roman... This may indeed be a legitimate bugfix, but it doesn't
fix the problem I'm seeing.  I've been doing the mm-bisect polka for a bit,
and have it narrowed down to this set of patches:

time-clocksource-infrastructure.patch
time-clocksource-infrastructure-dont-enable-irq-too-early.patch
time-use-clocksource-infrastructure-for-update_wall_time.patch
time-use-clocksource-infrastructure-for-update_wall_time-mark-few-functions-as-__init.patch
time-let-user-request-precision-from-current_tick_length.patch
time-use-clocksource-abstraction-for-ntp-adjustments.patch
time-use-clocksource-abstraction-for-ntp-adjustments-optimize-out-some-mults-since-gcc-cant-avoid-them.patch
time-introduce-arch-generic-time-accessors.patch
hangcheck-remove-monotomic_clock-on-x86.patch
time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
time-i386-conversion-part-2-rework-tsc-support.patch
time-i386-conversion-part-3-enable-generic-timekeeping.patch
time-i386-conversion-part-4-remove-old-timer_opts-code.patch
time-i386-clocksource-drivers.patch
time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy.patch
time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup.patch
time-i386-clocksource-drivers-pm-timer-doesnt-use-workaround-if-chipset-is-not-buggy-acpi_pm-cleanup-fix-missing-to-rename-pmtmr_good-to-acpi_pm_good.patch
time-i386-clocksource-drivers-fix-spelling-typos.patch
time-rename-clocksource-functions.patch
make-pmtmr_ioport-__read_mostly.patch
generic-time-add-macro-to-simplify-hide-mask.patch
time-fix-time-going-backward-w-clock=pit.patch
fix-and-optimize-clock-source-update.patch

Does anybody know offhand if it's safe to bisect through here, or if
there's a gotcha along the way?



--==_Exmh_1151426588_3177P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEoWAccC3lWbTT17ARAuatAKDZjcp6Bsc+qgyB8lMJrvY9tmoDlgCgjGAi
qPszHLHfOCahnEuHWZONSQ0=
=fjvg
-----END PGP SIGNATURE-----

--==_Exmh_1151426588_3177P--
