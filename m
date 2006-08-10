Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWHJVsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWHJVsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWHJVsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:48:18 -0400
Received: from main.gmane.org ([80.91.229.2]:56225 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750733AbWHJVsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:48:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH for review] [13/145] x86_64: Add abilty to enable/disable
 nmi watchdog with sysctl
Date: Thu, 10 Aug 2006 21:48:02 +0200
Organization: Palacky University in Olomouc
Message-ID: <44DB8D72.9040800@flower.upol.cz>
References: <20060810 935.775038000@suse.de> <20060810193525.B5A4813B90@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 158.194.192.40
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <20060810193525.B5A4813B90@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> r
> 
> From: dzickus <dzickus@redhat.com>
> 
> Adds a new /proc/sys/kernel/nmi call that will enable/disable the nmi
> watchdog.
> 
> Signed-off-by:  Don Zickus <dzickus@redhat.com>
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> ---
>  arch/i386/kernel/nmi.c   |   52 +++++++++++++++++++++++++++++++++++++++++++++++
>  arch/x86_64/kernel/nmi.c |   48 +++++++++++++++++++++++++++++++++++++++++++
>  include/asm-i386/nmi.h   |    1 
>  include/asm-x86_64/nmi.h |    1 
>  include/linux/sysctl.h   |    1 
>  kernel/sysctl.c          |   11 +++++++++
>  6 files changed, 114 insertions(+)

Hallo, Andi Kleen.

I'm a kernelnewbie, so any *answer* to this will be very appreciated.

Files 'nmi.c' from both archs don't match, obviously. But lets see, how.

cd /tmp/
diff -purN /tmp/ia32.c /tmp/amd64.c
--- /tmp/ia32.c	2006-08-10 21:12:19.292953750 +0200
+++ /tmp/amd64.c	2006-08-10 21:11:49.503092000 +0200
@@ -10,16 +10,12 @@
  +		return 0;
  +
  +	if (atomic_read(&nmi_active) < 0) {
-+		printk(KERN_WARNING "NMI watchdog is permanently disabled\n");
++		printk( KERN_WARNING "NMI watchdog is permanently disabled\n");
  +		return -EINVAL;

Something is wrong;

-+	if (nmi_watchdog == NMI_DEFAULT) {
-+		if (nmi_known_cpu() > 0)
-+			nmi_watchdog = NMI_LOCAL_APIC;
-+		else
-+			nmi_watchdog = NMI_IO_APIC;
-+	}
++	/* if nmi_watchdog is not set yet, then set it */
++	nmi_watchdog_default();

i don't know about nmi, but please drop a word why this is different in both files;

  +
  +	if (nmi_watchdog == NMI_LOCAL_APIC)
  +	{
@@ -32,7 +28,7 @@
  +		 * for some reason these functions don't work
  +		 */
  +		printk("Can not enable/disable NMI on IO APIC\n");
-+		return -EINVAL;
++		return -EIO;

and this;

  +#if 0
  +		if (nmi_watchdog_enabled)
  +			enable_timer_nmi_watchdog();
@@ -40,7 +36,7 @@
  +			disable_timer_nmi_watchdog();
  +#endif
  +	} else {
-+		printk( KERN_WARNING
++		printk(KERN_WARNING

dup.

  +			"NMI watchdog doesn't know what hardware to touch\n");
  +		return -EIO;
  +	}

Maybe this must be one file for both archs ?

Thanks.

--
-o--=O`C
  #oo'L O
<___=E M

