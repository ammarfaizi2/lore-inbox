Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286680AbRLVFGS>; Sat, 22 Dec 2001 00:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286683AbRLVFGI>; Sat, 22 Dec 2001 00:06:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:56837 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286680AbRLVFF4>;
	Sat, 22 Dec 2001 00:05:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jason Thomas <jason@topic.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link errors with internal calls to devexit functions 
In-Reply-To: Your message of "Sat, 22 Dec 2001 13:57:25 +1100."
             <20011222025725.GA629@topic.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Dec 2001 16:05:43 +1100
Message-ID: <5750.1008997543@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 13:57:25 +1100, 
Jason Thomas <jason@topic.com.au> wrote:
>please CC me I'm not on the list.
>
>This patch against 2.4.17 fixes internal calls to devexit functions (which
>is bypasses the devexit_p wrapper) in drivers/media/video/bttv-driver.c and
>drivers/usb/usb-uhci.c, they are the only two I found.
>
>diff -ur linux-2.4.17.orig/drivers/media/video/bttv-driver.c linux-2.4.17/drivers/media/video/bttv-driver.c
>--- linux-2.4.17.orig/drivers/media/video/bttv-driver.c Sat Dec 22 13:39:39 2001
>+++ linux-2.4.17/drivers/media/video/bttv-driver.c      Sat Dec 22 13:46:02 2001
>@@ -2992,7 +2992,9 @@
>        pci_set_drvdata(dev,btv);
> 
>        if(init_bt848(btv) < 0) {
>+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
>                bttv_remove(dev);
>+#endif
>                return -EIO;
>        }
>        bttv_num++;
>diff -ur linux-2.4.17.orig/drivers/usb/usb-uhci.c linux-2.4.17/drivers/usb/usb-uhci.c
>--- linux-2.4.17.orig/drivers/usb/usb-uhci.c    Sat Dec 22 13:39:39 2001
>+++ linux-2.4.17/drivers/usb/usb-uhci.c Sat Dec 22 13:46:38 2001
>@@ -3001,7 +3001,9 @@
>        s->irq = irq;
> 
>        if(uhci_start_usb (s) < 0) {
>+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
>                uhci_pci_remove(dev);
>+#endif
>                return -1;
>        }

I don't like #if defined(MODULE) || defined(CONFIG_HOTPLUG) in open
code.  If the rules for what gets discarded change (again) then those
ifdefs will be out of sync.  That is why __devexit_p() is a wrapper, it
is defined once and only has to be changed once when the rules change.

Define a __devexit_call wrapper in include/linux/init.h at the same
place that __devexit_p is defined and use the wrapper around the calls.
Untested.

#if defined(MODULE) || defined(CONFIG_HOTPLUG)
#define __devexit_p(x) x
#define __devexit_call(x) x
#else
#define __devexit_call(x) do { } while (0)
#define __devexit_p(x) NULL
#endif

	__devexit_call(bttv_remove(dev));
	__devexit_call(uhci_pci_remove(dev));

