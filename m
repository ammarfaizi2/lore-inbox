Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVACIxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVACIxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 03:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVACIxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 03:53:32 -0500
Received: from gprs214-248.eurotel.cz ([160.218.214.248]:30087 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261407AbVACIx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 03:53:26 -0500
Date: Mon, 3 Jan 2005 09:53:12 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: lindqvist@netstar.se, edi@gmx.de, john@hjsoft.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050103085312.GC2099@elf.ucw.cz>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103083154.GA4460@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103083154.GA4460@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > So, I think this bug probably lies in ACPI or swsusp. I highly *highly*
> > doubt it's driver bugs. Hopefully I'll have time later tonight or
> > tomorrow morning to see if I can figure anything else out...
> 
> The following patch is a ridiculously dirty kludge which (very arguably)
> improves the situation somewhat:
> 
> --- linux-2.6.10-bk4/arch/i386/kernel/mpparse.c	2004-12-14 03:17:21.723010806 -0800
> +++ linux-2.6.10-bk4-bkn1/arch/i386/kernel/mpparse.c	2005-01-02 23:43:13.647613575 -0800
> @@ -1091,9 +1091,10 @@
>  		return gsi;
>  	}
>  	if ((1<<bit) & mp_ioapic_routing[ioapic].pin_programmed[idx]) {
> -		Dprintk(KERN_DEBUG "Pin %d-%d already programmed\n",
> +		printk(KERN_DEBUG "Pin %d-%d already programmed\n",
>  			mp_ioapic_routing[ioapic].apic_id, ioapic_pin);
> -		return gsi;
> +		/* return gsi; */
> +		printk(KERN_DEBUG "However, I will reprogram it anyway.\n");
>  	}
>  
>  	mp_ioapic_routing[ioapic].pin_programmed[idx] |= (1<<bit);

Less dirty version of this would be adding __nosavedata atribute to
mp_ioapic_routing... like this?

--- clean/arch/i386/kernel/mpparse.c	2004-12-25 13:34:57.000000000 +0100
+++ linux/arch/i386/kernel/mpparse.c	2005-01-03 09:51:07.000000000 +0100
@@ -868,7 +868,9 @@
 	int			gsi_base;
 	int			gsi_end;
 	u32			pin_programmed[4];
-} mp_ioapic_routing[MAX_IO_APICS];
+};
+
+static struct mp_ioapic_routing __nosavedata mp_ioapic_routing[MAX_IO_APICS];
 
 
 static int mp_find_ioapic (

> With this patch, unloading and reloading 8139too will make it work again
> after a resume -- as long as I boot *without* "noapic". This doesn't fix
> the actual problem (it's still broken after resume, and reloading the
> module still doesn't work for "noapic") but it might provide clues.
> 
> More specifically, this shows that the 
> mp_ioapic_routing[ioapic].pin_programmed[] array is inconsistent with
> the IO-APIC's real configuration after the resume.

Agreed. Also it would be nice if drivers did not have to reinitialize
the interrupts... Proper suspend/resume support for APIC would help
there, too.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
