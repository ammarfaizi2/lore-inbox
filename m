Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWCOWwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWCOWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWCOWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:52:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45833 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932183AbWCOWwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:52:15 -0500
Date: Wed, 15 Mar 2006 23:51:59 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jiri Benc <jbenc@suse.cz>
Cc: Bernd Petrovitsch <bernd@firmix.at>, rusty@rustcorp.com.au,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modpost: fix buffer overflow
Message-ID: <20060315225159.GA11095@mars.ravnborg.org>
References: <20060315154436.4286d2ab@griffin.suse.cz> <1142434648.17627.5.camel@tara.firmix.at> <20060315160858.311e5c0e@griffin.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315160858.311e5c0e@griffin.suse.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 04:08:58PM +0100, Jiri Benc wrote:
> I got SIGABRT in modpost when compiling a module really deeply nested in
> a filesystem (path > 100 chars):
> 
> >   Building modules, stage 2.
> >   MODPOST
> > *** glibc detected *** scripts/mod/modpost: realloc(): invalid next size: 0x0809f588 ***
> > [...]
> 
> This patch fixes that problem.
> 
> Signed-off-by: Jiri Benc <jbenc@suse.cz>
> 
> --- linux-2.6.16-rc6.orig/scripts/mod/modpost.c
> +++ linux-2.6.16-rc6/scripts/mod/modpost.c
> @@ -553,7 +553,8 @@ void __attribute__((format(printf, 2, 3)
>  	va_start(ap, fmt);
>  	len = vsnprintf(tmp, SZ, fmt, ap);
>  	if (buf->size - buf->pos < len + 1) {
> -		buf->size += 128;
> +		while (buf->size - buf->pos < len + 1)
> +			buf->size += 128;
>  		buf->p = realloc(buf->p, buf->size);
>  	}
>  	strncpy(buf->p + buf->pos, tmp, len + 1);

Hi Jiri.

Can I ask you to make a new patch where you change buf_printf() to use
buf_write. And then change buf_write to allocate in chunks also.
This would be cleanest solution.

	Sam
