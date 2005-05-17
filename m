Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVEQRfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVEQRfl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVEQRem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 13:34:42 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:45464 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S261909AbVEQRdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 13:33:22 -0400
Date: Tue, 17 May 2005 10:33:17 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>, Serge Hallyn <serue@us.ibm.com>
Subject: Re: [patch 1/7] BSD Secure Levels: printk overhaul
In-Reply-To: <20050517152303.GA2814@halcrow.us>
Message-ID: <Pine.LNX.4.62.0505171029310.8764@twinlark.arctic.org>
References: <20050517152303.GA2814@halcrow.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Michael Halcrow wrote:

> This is the first in a series of seven patches to the BSD Secure
> Levels LSM.  It overhauls the printk mechanism in order to reduce the
> unnecessary usage of the .text area.  Thanks to Brad Spengler for the
> suggestion.

it also changes the rate limiting from per message to global... so
one noisy message could shut off other non-noisy messages.  was that
intentional?

-dean

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
> +static void seclvl_printk(int verb, const char *fmt, ...)
> +{
> +	va_list args;
> +	va_start(args, fmt);
> +	if (verbosity >= verb) {
> +		static unsigned long _prior;
> +		unsigned long _now = jiffies;
> +		if ((_now - _prior) > HZ) {
> +			vprintk(fmt, args);
> +		}
> +		_prior = _now;
> +	}
> +	va_end(args);
> +}
