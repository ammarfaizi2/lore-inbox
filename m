Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVEQCrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVEQCrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 22:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVEQCrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 22:47:18 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:60077 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261295AbVEQCrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 22:47:00 -0400
Date: Mon, 16 May 2005 19:46:51 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-Id: <20050516194651.1debabfd.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.62.0505161934220.25315@graphe.net>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw>
	<20050516150907.6fde04d3.akpm@osdl.org>
	<Pine.LNX.4.62.0505161934220.25315@graphe.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005 19:38:36 -0700 (PDT) Christoph Lameter wrote:

| On Mon, 16 May 2005, Andrew Morton wrote:
| 
| > So yes, the time has come around again to work out what we're going to do
| > about this.  I'd be a bit worried about allowing users to set HZ=724,
| > simply because nobody tests with that, and it might expose odd timing
| > relationships and unfortunate arithmetic rounding artifacts.  So if we're
| > going to do this thing it might be better to just offer 100, 250 and 1000.
| 
| Ok. Here is the patch allowing 100, 250 and 1000 HZ for i386 and x86_64:
| 
| -----
| 
| Make the timer frequency selectable. The timer interrupt may cause bus
| and memory contention in large NUMA systems since the interrupt occurs
| on each processor HZ times per second.
| 
| Signed-off-by: Christoph Lameter <christoph@lameter.com>
| Signed-off-by: Shai Fultheim <shai@scalex86.org>
| 
| Index: linux-2.6.12-rc4/arch/i386/Kconfig
| ===================================================================
| --- linux-2.6.12-rc4.orig/arch/i386/Kconfig	2005-05-17 02:19:55.000000000 +0000
| +++ linux-2.6.12-rc4/arch/i386/Kconfig	2005-05-17 02:27:12.000000000 +0000
| @@ -1133,6 +1133,20 @@
|  	  a work-around for a number of buggy BIOSes. Switch this option on if
|  	  your computer crashes instead of powering off properly.
|  
| +config HZ
| +	int "Frequency of the Timer Interrupt (100, 250 or 1000 per second)"
| +	range 100 1000
| +	default 1000
| +	help
| +	  Allows the configuration of the timer frequency. It is customary
| +	  to have the timer interrupt run at 1000 HZ but 100 HZ may be more
| +	  beneficial for servers and NUMA systems that do not need to have
| +	  a fast response for user interaction and that may experience bus
| +	  contention and cacheline bounces as a result of timer interrupts.
| +	  Note that the timer interrupt occurs on each processor in an SMP
| +	  environment leading to NR_CPUS * HZ number of timer interrupts
| +	  per second.
| +
|  endmenu

How about using choice / endchoice to that an improper HZ value
cannot be entered at all?  (instead of using range M N)


|  source "arch/i386/kernel/cpu/cpufreq/Kconfig"
| Index: linux-2.6.12-rc4/include/asm-i386/param.h
| ===================================================================
| --- linux-2.6.12-rc4.orig/include/asm-i386/param.h	2005-05-17 02:15:57.000000000 +0000
| +++ linux-2.6.12-rc4/include/asm-i386/param.h	2005-05-17 02:30:22.000000000 +0000
| @@ -1,8 +1,19 @@
| +#include <linux/config.h>
| +
|  #ifndef _ASMi386_PARAM_H
|  #define _ASMi386_PARAM_H
|  
|  #ifdef __KERNEL__
| -# define HZ		1000		/* Internal kernel timer frequency */
| +#if CONFIG_HZ == 1000
| +#define HZ 1000				/* Internal kernel timer frequency */
| +#elif CONFIG_HZ == 250
| +#define CONFIG_HZ 250
| +#elif CONFIG_HZ == 100
| +#define HZ = 100
| +#else
| +#error "Invalid Timer Interrupt Frequency"
| +#endif
| +
|  # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
|  # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
|  #endif
| Index: linux-2.6.12-rc4/arch/x86_64/Kconfig
| ===================================================================
| --- linux-2.6.12-rc4.orig/arch/x86_64/Kconfig	2005-05-17 02:19:54.000000000 +0000
| +++ linux-2.6.12-rc4/arch/x86_64/Kconfig	2005-05-17 02:26:38.000000000 +0000
| @@ -410,6 +410,20 @@
|  
|  	  If unsure, say Y. Only embedded should say N here.
|  
| +config HZ
| +	int "Frequency of the Timer Interrupt (100, 250 or 1000 per second)"
| +	range 100 1000
| +	default 1000
| +	help
| +	  Allows the configuration of the timer frequency. It is customary
| +	  to have the timer interrupt run at 1000 HZ but 100 HZ may be more
| +	  beneficial for servers and NUMA systems that do not need to have
| +	  a fast response for user interaction and that may experience bus
| +	  contention and cacheline bounces as a result of timer interrupts.
| +	  Note that the timer interrupt occurs on each processor in an SMP
| +	  environment leading to NR_CPUS * HZ number of timer interrupts
| +	  per second.
| +
|  endmenu
|  
|  #
| Index: linux-2.6.12-rc4/include/asm-x86_64/param.h
| ===================================================================
| --- linux-2.6.12-rc4.orig/include/asm-x86_64/param.h	2005-03-02 07:38:10.000000000 +0000
| +++ linux-2.6.12-rc4/include/asm-x86_64/param.h	2005-05-17 02:28:04.000000000 +0000
| @@ -1,8 +1,20 @@
| +#include <linux/config.h>
| +
|  #ifndef _ASMx86_64_PARAM_H
|  #define _ASMx86_64_PARAM_H
|  
|  #ifdef __KERNEL__
| -# define HZ            1000            /* Internal kernel timer frequency */
| +
| +#if CONFIG_HZ == 1000
| +# define HZ 1000            /* Internal kernel timer frequency */
| +#elif CONFIG_HZ == 250
| +# define HZ 250
| +#elif CONFIG_HZ == 100
| +# define HZ 100
| +#else
| +#error "Invalid Timer Interrupt Frequency"
| +#endif
| +|  # define USER_HZ       100          /* .. some user interfaces are in "ticks */
|  #define CLOCKS_PER_SEC        (USER_HZ)       /* like times() */
|  #endif


---
~Randy
