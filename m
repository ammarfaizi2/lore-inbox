Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbTBCKXY>; Mon, 3 Feb 2003 05:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbTBCKXY>; Mon, 3 Feb 2003 05:23:24 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:11273 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265305AbTBCKXX>; Mon, 3 Feb 2003 05:23:23 -0500
Date: Mon, 3 Feb 2003 10:32:54 +0000
From: John Levon <levon@movementarian.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, ak@suse.de,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030203103254.GA25619@compsoc.man.ac.uk>
References: <200301280121.CAA13798@harpo.it.uu.se> <20030202124235.GA133@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202124235.GA133@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18fduI-0008uu-00*ylZp68ILxcI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 01:42:35PM +0100, Pavel Machek wrote:

> This one should be okay. [oprofile not tested because I don't know how
> to use it...

It's not hard you know[1].

> -struct pm_dev * set_nmi_pm_callback(pm_callback callback)
> +static int nmi_resume(struct device *dev, u32 level)
>  {
> -	apic_pm_unregister(nmi_pmdev);
> -	return apic_pm_register(PM_SYS_DEV, 0, callback);
> -}
> +	if (level != RESUME_POWER_ON)
> +		return 0;
> +	setup_apic_nmi_watchdog();
> +	return 0;

I don't pretend to understand the PM layer at all, but it looks like
that both nmi.c's and oprofile's resume functions will get called. This
won't work: if oprofile has control of the perfctr's/nmi stuff, you
can't let the NMI watchdog's resume() be called, as it may conflict with
what oprofile is trying to resume.

> +        return device_register(&device_nmi);

There's some evil spaces in your patch.

regards
john

[1] opcontrol --setup --vmlinux=/boot/vmlinux --ctr0-count=20000
	--ctr0-event=CPU_CLK_UNHALTED && opcontrol --start
