Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273883AbRI0Ui4>; Thu, 27 Sep 2001 16:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273894AbRI0Uir>; Thu, 27 Sep 2001 16:38:47 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:18694 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S273888AbRI0Uil>; Thu, 27 Sep 2001 16:38:41 -0400
Message-ID: <3BB38DC9.39A0A9F6@osdlab.org>
Date: Thu, 27 Sep 2001 13:36:25 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Cruise <acruise@infowave.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        jcb@jcb.yi.org, Alan <alan@lxorguk.ukuu.org.uk>, sfr@canb.auug.org.au
Subject: Re: apm suspend broken in 2.4.10
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81A7@earth.infowave.com>
Content-Type: multipart/mixed;
 boundary="------------C95A95DEE71560DBD8E4C7B1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C95A95DEE71560DBD8E4C7B1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alex Cruise wrote:
> 
> Mine displays a similar failure, except my strace shows:
> 
>   ioctl(3, APM_IOC_SUSPEND, 0 ) = -1 EAGAIN (Resource temporarily
> unavailable)
> 
> I also noticed (as reported by a previous poster) that whether you pass
> "apm=on" or "apm=off" to the kernel, apm gets disabled.  When you don't
> specify a setting, it's enabled.  I had a look at the arch/i386/kernel/apm.c
> in 2.4.10 though, and it seemed to make sense.

Verified here.
APM doesn't install if apm=on or apm=off is used in 2.4.10.

Here's a small patch for it.  With this patch, apm thread,
/proc/apm, misc apm_bios device etc. are created.

~Randy
--------------C95A95DEE71560DBD8E4C7B1
Content-Type: text/plain; charset=us-ascii;
 name="apmonoff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apmonoff.patch"

--- linux/arch/i386/kernel/apm.c.org	Mon Sep 17 22:52:35 2001
+++ linux/arch/i386/kernel/apm.c	Thu Sep 27 13:15:33 2001
@@ -1672,7 +1672,7 @@
 		apm_info.realmode_power_off = 1;
 	/* User can override, but default is to trust DMI */
 	if (apm_disabled != -1)
-		apm_info.disabled = 1;
+		apm_info.disabled = apm_disabled;
 
 	/*
 	 * Fix for the Compaq Contura 3/25c which reports BIOS version 0.1
@@ -1699,8 +1699,7 @@
 	}
 
 	if (apm_info.disabled) {
-		if(apm_disabled == 1)
-			printk(KERN_NOTICE "apm: disabled on user request.\n");
+		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
 	if ((smp_num_cpus > 1) && !power_off) {

--------------C95A95DEE71560DBD8E4C7B1--

