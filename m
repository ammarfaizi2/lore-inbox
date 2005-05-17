Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVEQDBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVEQDBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 23:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVEQDBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 23:01:33 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:29707 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261315AbVEQDBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 23:01:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iffH+PAws62q37n4xVEFBHJCRRZcrut1KNmUCpW6vK0K/aO2zIvri3PHSA4Ra3MbK7zRj4gGgXuUaDEoZYNpKOKY6SropxD5NlTWwv4jPpDuoFNk1qRA6DEMGS6UFtGNNOL6jRzsiDvPB801lgWZQ4BakVOeNGwr605xE/b77Pc=
Message-ID: <2cd57c900505162001608ac4b5@mail.gmail.com>
Date: Tue, 17 May 2005 11:01:23 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Christoph Lameter <christoph@lameter.com>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       shai@scalex86.org, ak@suse.de, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505161934220.25315@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
	 <20050516150907.6fde04d3.akpm@osdl.org>
	 <Pine.LNX.4.62.0505161934220.25315@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Christoph Lameter <christoph@lameter.com> wrote:
> On Mon, 16 May 2005, Andrew Morton wrote:
> 
> > So yes, the time has come around again to work out what we're going to do
> > about this.  I'd be a bit worried about allowing users to set HZ=724,
> > simply because nobody tests with that, and it might expose odd timing
> > relationships and unfortunate arithmetic rounding artifacts.  So if we're
> > going to do this thing it might be better to just offer 100, 250 and 1000.
> 
> Ok. Here is the patch allowing 100, 250 and 1000 HZ for i386 and x86_64:
> 
> -----
> 
> Make the timer frequency selectable. The timer interrupt may cause bus
> and memory contention in large NUMA systems since the interrupt occurs
> on each processor HZ times per second.
> 
> Signed-off-by: Christoph Lameter <christoph@lameter.com>
> Signed-off-by: Shai Fultheim <shai@scalex86.org>
> 
> Index: linux-2.6.12-rc4/arch/i386/Kconfig
> ===================================================================
> --- linux-2.6.12-rc4.orig/arch/i386/Kconfig     2005-05-17 02:19:55.000000000 +0000
> +++ linux-2.6.12-rc4/arch/i386/Kconfig  2005-05-17 02:27:12.000000000 +0000
> @@ -1133,6 +1133,20 @@
>           a work-around for a number of buggy BIOSes. Switch this option on if
>           your computer crashes instead of powering off properly.
> 
> +config HZ
> +       int "Frequency of the Timer Interrupt (100, 250 or 1000 per second)"
> +       range 100 1000
> +       default 1000
> +       help
> +         Allows the configuration of the timer frequency. It is customary
> +         to have the timer interrupt run at 1000 HZ but 100 HZ may be more
> +         beneficial for servers and NUMA systems that do not need to have
> +         a fast response for user interaction and that may experience bus
> +         contention and cacheline bounces as a result of timer interrupts.
> +         Note that the timer interrupt occurs on each processor in an SMP
> +         environment leading to NR_CPUS * HZ number of timer interrupts
> +         per second.
> +
>  endmenu
> 
>  source "arch/i386/kernel/cpu/cpufreq/Kconfig"
> Index: linux-2.6.12-rc4/include/asm-i386/param.h
> ===================================================================
> --- linux-2.6.12-rc4.orig/include/asm-i386/param.h      2005-05-17 02:15:57.000000000 +0000
> +++ linux-2.6.12-rc4/include/asm-i386/param.h   2005-05-17 02:30:22.000000000 +0000
> @@ -1,8 +1,19 @@
> +#include <linux/config.h>
> +
>  #ifndef _ASMi386_PARAM_H
>  #define _ASMi386_PARAM_H
> 
>  #ifdef __KERNEL__
> -# define HZ            1000            /* Internal kernel timer frequency */
> +#if CONFIG_HZ == 1000
> +#define HZ 1000                                /* Internal kernel timer frequency */
> +#elif CONFIG_HZ == 250
> +#define CONFIG_HZ 250

You mean #define HZ 250 here.
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
