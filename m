Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263794AbUDMWoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 18:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263797AbUDMWoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 18:44:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:41684 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263794AbUDMWn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 18:43:59 -0400
Date: Tue, 13 Apr 2004 15:39:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: dl8bcu@dl8bcu.de
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH] sort out CLOCK_TICK_RATE usage, 2nd try  [3/3]
Message-Id: <20040413153908.50131465.rddunlap@osdl.org>
In-Reply-To: <20040413220230.D7047@Marvin.DL8BCU.ampr.org>
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
	<20040413215833.A7047@Marvin.DL8BCU.ampr.org>
	<20040413215932.B7047@Marvin.DL8BCU.ampr.org>
	<20040413220109.C7047@Marvin.DL8BCU.ampr.org>
	<20040413220230.D7047@Marvin.DL8BCU.ampr.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


General comment:  diffstat -p1 patch_file
would be a good addition.


On Tue, 13 Apr 2004 22:02:30 +0000 Thorsten Kranzkowski wrote:

| 
| 3/3	use CLOCK_TICK_RATE where 1193182 constant was used in timing 
| 	calculations
| 
| 
| diff -urN linux-2.6.5-2a/drivers/input/joystick/analog.c linux-2.6.5-3a/drivers/input/joystick/analog.c
| --- linux-2.6.5-2a/drivers/input/joystick/analog.c	Sun Apr 11 14:24:48 2004
| +++ linux-2.6.5-3a/drivers/input/joystick/analog.c	Tue Apr 13 18:38:03 2004
| @@ -142,7 +142,7 @@
|  
|  #ifdef __i386__
|  #define GET_TIME(x)	do { if (cpu_has_tsc) rdtscl(x); else x = get_time_pit(); } while (0)
| -#define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?1193182L/HZ:0)))
| +#define DELTA(x,y)	(cpu_has_tsc?((y)-(x)):((x)-(y)+((x)<(y)?CLOCK_TICK_RATE/HZ:0)))
|  #define TIME_NAME	(cpu_has_tsc?"TSC":"PIT")
|  static unsigned int get_time_pit(void)
|  {

* Add spaces around operators please.  It's much more readable
that way.

| diff -urN linux-2.6.5-2a/sound/oss/pas2_pcm.c linux-2.6.5-3a/sound/oss/pas2_pcm.c
| --- linux-2.6.5-2a/sound/oss/pas2_pcm.c	Thu Dec 18 02:58:28 2003
| +++ linux-2.6.5-3a/sound/oss/pas2_pcm.c	Tue Apr 13 18:39:22 2004
| @@ -62,13 +63,13 @@
|  
|  	if (pcm_channels & 2)
|  	{
| -		foo = (596590 + (arg / 2)) / arg;
| -		arg = (596590 + (foo / 2)) / foo;
| +		foo = ((CLOCK_TICK_RATE/2) + (arg / 2)) / arg;
| +		arg = ((CLOCK_TICK_RATE/2) + (foo / 2)) / foo;

* Add spaces around operators, as:     ((CLOCK_TICK_RATE / 2)


And finally, does this change support (or allow) CLOCK_TICK_RATE
to be a variable instead of a #define?

as in include/asm-i386/mach-pc9800/setup_arch_pre.h:
int CLOCK_TICK_RATE;

and include/asm-i386/timex.h:
#ifdef CONFIG_X86_PC9800
   extern int CLOCK_TICK_RATE;

More likely (IMO), X86_PC9800 sub-arch will have to be changed
(if it ever works).

--
~Randy
