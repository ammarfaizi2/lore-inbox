Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUKISYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUKISYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUKISYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:24:40 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:24357 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261609AbUKISYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:24:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Y0K0XmiTuawe69F8bbSnQspXSy/20HZ1e2vvuMgZ5asE4o1gqPake6VIDRHqOScglJXrhR/OMdSvFQSZtQr45rZ8tkl5p/Ps62VTtwohh2ESzeO+Q3J4Ww7QIe+W5oYNl60h9J2y8q3ZbS3/XNMKXOMEk0bvZaPlBvQjQc0eWh8=
Message-ID: <9dda34920411091024431b832a@mail.gmail.com>
Date: Tue, 9 Nov 2004 13:24:07 -0500
From: Paul Blazejowski <diffie@gmail.com>
Reply-To: Paul Blazejowski <diffie@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm3
Cc: Greg KH <greg@kroah.com>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       diffie@blazebox.homeip.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries Brouwer <andries.brouwer@cwi.nl>
In-Reply-To: <20041108212747.33b6e14a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9dda349204110611043e093bca@mail.gmail.com>
	 <20041107024841.402c16ed.akpm@osdl.org>
	 <20041108075934.GA4602@elte.hu>
	 <20041107234225.02c2f9b6.akpm@osdl.org>
	 <20041108224259.GA14506@kroah.com>
	 <20041108212747.33b6e14a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004 21:27:47 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > So I don't see how that could be failing here.  And why I don't see this
> >  on my boxes...
> 
> OK, progress.  The oops is due to CONFIG_LEGACY_PTY_COUNT=512.  I assume
> anything greater than 256 will trigger it.
> 
> - tty_register_driver() calls tty_register_device() for 512 devices.
> 
> - tty_register_device() calls pty_line_name() for the 512 devices, but
>   pty_line_name() only understands 256 devices.  After that, it starts
>   returning duplicated names.
> 
> - class_simple_device_add() gets an -EEXIST return from
>   class_device_register() and then tries to kfree local variable s_dev, but
>   it's already free.  Presumably all that icky refcounting under
>   class_device_register() did this for us already.  Can you fix this one
>   Greg?  Just enable slab debugging, set CONFIG_LEGACY_PTY_COUNT=512 and
>   watch the fun.
> 
> As for the limitation of 256 legacy ptys: we should either raise it by
> cooking up new device names or limit it to 256 in config.  The latter, I
> guess.  Is there a requirement to support more than 256 legacy ptys?
> 
> Limit the number of legacy ptys to 256.  pty_line_name() isn't capable of
> generating more than 256 unique names.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  25-akpm/drivers/char/Kconfig |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -puN drivers/char/Kconfig~limit-CONFIG_LEGACY_PTY_COUNT drivers/char/Kconfig
> --- 25/drivers/char/Kconfig~limit-CONFIG_LEGACY_PTY_COUNT       2004-11-08 21:22:46.843719848 -0800
> +++ 25-akpm/drivers/char/Kconfig        2004-11-08 21:23:23.496147832 -0800
> @@ -478,6 +478,7 @@ config LEGACY_PTYS
>  config LEGACY_PTY_COUNT
>         int "Maximum number of legacy PTY in use"
>         depends on LEGACY_PTYS
> +       range 1 256
>         default "256"
>         ---help---
>           The maximum number of legacy PTYs that can be used at any one time.
> _
> 
> 

Andrew,

Changing the CONFIG_LEGACY_PTY_COUNT to 256 fixes the boot issue.

The 512 number came from very old slackware .config file that i seem
to still use :-)

Thanks for your help

Paul B.

-- 
FreeBSD the Power to Serve!
