Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVBJV7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVBJV7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVBJV7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:59:37 -0500
Received: from waste.org ([216.27.176.166]:61671 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261860AbVBJV7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:59:33 -0500
Date: Thu, 10 Feb 2005 13:59:20 -0800
From: Matt Mackall <mpm@selenic.com>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] BSD Secure Levels: printk overhaul, 2.6.11-rc2-mm1 (1/8)
Message-ID: <20050210215920.GB2474@waste.org>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 01:21:08PM -0600, Michael Halcrow wrote:
> This is the first in a series of eight patches to the BSD Secure
> Levels LSM.  It overhauls the printk mechanism in order to reduce the
> unnecessary usage of the .text area.  Thanks to Brad Spengler for the
> suggestion.
> 
> Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

> Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
> ===================================================================
> --- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 14:55:44.799527472 -0600
> +++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 14:56:18.527400056 -0600
> @@ -101,22 +101,20 @@
>  
>  #define MY_NAME "seclvl"
>  
> -/**
> - * This time-limits log writes to one per second.
> - */
> -#define seclvl_printk(verb, type, fmt, arg...)			\
> -	do {							\
> -		if (verbosity >= verb) {			\
> -			static unsigned long _prior;		\
> -			unsigned long _now = jiffies;		\
> -			if ((_now - _prior) > HZ) {		\
> -				printk(type "%s: %s: " fmt,	\
> -					MY_NAME, __FUNCTION__ ,	\
> -					## arg);		\
> -				_prior = _now;			\
> -			}					\
> -		}						\
> -	} while (0)
> +static void seclvl_printk( int verb, const char * fmt, ... )
> +{
> +	va_list args;
> +	va_start( args, fmt );
> +	if (verbosity >= verb) {
> +		static unsigned long _prior;
> +		unsigned long _now = jiffies;
> +		if ((_now - _prior) > HZ) {
> +			vprintk( fmt, args );
> +		}
> +		_prior = _now;
> +	}
> +	va_end( args );
> +}

This could be done with a seclvl_printk macro wrapping a
__seclvl_printk function that provides __FUNCTION__, leaving the
callers the same.

-- 
Mathematics is the supreme nostalgia of our time.
