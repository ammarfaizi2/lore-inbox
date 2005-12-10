Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVLJQHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVLJQHE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 11:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVLJQHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 11:07:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55997 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964792AbVLJQHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 11:07:02 -0500
Date: Sat, 10 Dec 2005 17:06:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Message-ID: <20051210160641.GB5047@elf.ucw.cz>
References: <200512072246.06222.rjw@sisk.pl> <20051209191735.GB4658@elf.ucw.cz> <200512092308.19644.rjw@sisk.pl> <200512101421.57918.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512101421.57918.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The tunable may be useful to people who'd like to achieve the
> > maximum efficiency of suspend/resume and it would be a nice
> > feature to have, I think, but let's say we'll try to implement it
> > in the future, if still needed/wanted.
> 
> Actually the tunable turned out to be quite easy to implement and I think
> I'll need it for userspace swsusp (the suspend-handling userspace
> process will need to tell the kernel how much space there is for the
> image).

Looks mostly okay to me, small comments below.

> Index: linux-2.6.15-rc5-mm1/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.15-rc5-mm1.orig/kernel/power/disk.c	2005-12-10 13:12:18.000000000 +0100
> +++ linux-2.6.15-rc5-mm1/kernel/power/disk.c	2005-12-10 13:20:38.000000000 +0100
> @@ -367,9 +367,34 @@
>  
>  power_attr(resume);
>  
> +static ssize_t image_size_show(struct subsystem * subsys, char *buf)
> +{
> +	return sprintf(buf, "%u\n", image_size);
> +}
> +
> +static ssize_t image_size_store(struct subsystem * subsys, const char * buf, size_t n)
> +{
> +	int len;
> +	char *p;
> +	unsigned int size;
> +
> +	p = memchr(buf, '\n', n);
> +	len = p ? p - buf : n;

len and p are unused.

> +	if (sscanf(buf, "%u", &size) == 1) {
> +		image_size = size < MAX_IMAGE_SIZE ? size : MAX_IMAGE_SIZE;
> +		return n;

Why the limit? We may want to allow very big images when someone wants
"as similar to suspended system as possible".

> Index: linux-2.6.15-rc5-mm1/kernel/power/power.h
> ===================================================================
> --- linux-2.6.15-rc5-mm1.orig/kernel/power/power.h	2005-12-10 13:12:18.000000000 +0100
> +++ linux-2.6.15-rc5-mm1/kernel/power/power.h	2005-12-10 13:20:46.000000000 +0100
> @@ -53,10 +53,12 @@
>  extern struct pbe *pagedir_nosave;
>  
>  /*
> - * Preferred image size in MB (set it to zero to get the smallest
> + * Maximum image size in MB (set it to zero to get the smallest
>   * image possible)
>   */

In fact this is not maximum. If more than 500MB can't be freed, well,
it will not be freed. Very improbable, but possible.

> -#define IMAGE_SIZE	500
> +#define MAX_IMAGE_SIZE	500
> +

With runtime configuration, we should not need additional
compile-time config. OTOH /proc tunables should have descritption in
Documentation/.

								Pavel
-- 
Thanks, Sharp!
