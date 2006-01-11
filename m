Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWAKAOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWAKAOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWAKAOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:14:44 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:54745
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932353AbWAKAOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:14:43 -0500
From: Thomas Gleixner <tglx@linutronix.de>
To: george@mvista.com
Subject: Re: new time code problem
Date: Wed, 11 Jan 2006 00:23:34 +0000
User-Agent: KMail/1.8.2
Cc: john stultz <johnstul@us.ibm.com>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0512220019330.30882@scrub.home> <1136935211.2890.11.camel@cog.beaverton.ibm.com> <43C44A3C.6010803@mvista.com>
In-Reply-To: <43C44A3C.6010803@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601110023.35374.tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 23:58, George Anzinger wrote:
> The 64-bit conversion routine to convert 64-bit nsec time to a time spec.
> gives an unnormalized result if the value being converted is negative.  I
> think there are two ways to go about fixing this.  Most systems will give a
> negative remainder and so need to just normalize.  On the other hand, some
> systems will use div64 to do the division and, I think, it expects unsigned
> numbers.  The attached patch uses the conservative approach of expecting
> the div to be set up for unsigned numbers.
>
> I came accross this when one of my tests set a time near 1 Jan 1970, i.e.
> it is a real problem.

> 
>  kernel/time.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.16-rc/kernel/time.c
> ===================================================================
> --- linux-2.6.16-rc.orig/kernel/time.c
> +++ linux-2.6.16-rc/kernel/time.c
> @@ -702,16 +702,19 @@ void set_normalized_timespec(struct time
>   *
>   * Returns the timespec representation of the nsec parameter.
>   */
> -inline struct timespec ns_to_timespec(const nsec_t nsec)
> +struct timespec ns_to_timespec(const nsec_t nsec)
>  {
>         struct timespec ts;
>  
> -       if (nsec)
> +       if (nsec) return (struct timespec){0, 0};

Err, you mean propably

	if(!nsec)
		return (struct timespec){0, 0};

	tglx

  
