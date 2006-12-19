Return-Path: <linux-kernel-owner+w=401wt.eu-S932702AbWLSJGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932702AbWLSJGH (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWLSJGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:06:07 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:31318 "HELO
	smtp101.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932700AbWLSJGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:06:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=hqmHEgIdsu8exO+/gdixgP+aJJgayfEMnFx+jpTAAu9aAi/96P/ZLlzHxL7TOo+jFT2xzT0qYEa5qlO0Sn0jAssY7o1x8eKRguxkZotI/Gjy2qqKWCRYo5Yh8oIM945Gt/ApJTnm/4GHFB/STLr9duQMD+Nf6NAtNeoHAIMaAzc=  ;
X-YMail-OSG: f.3E2zwVM1mHhdL9TgZm9tsGB8vpeHYRRrmRdi6NTqrQVRAqd_ppny7ILGT_tYoPBLdpYBU2cgkBW.NDf6vOebJOpZhWYLrZWxcAfTtDkZdcM5lpExYgtSr7kwctBE_1K_suOCBwyk8dLW2vRb36qe23E9JWZZxGFkP.4hRUl4Qdq_iPhtp4drZn5l5.
From: David Brownell <david-b@pacbell.net>
To: Paul Sokolovsky <pmiscml@gmail.com>
Subject: Re: [PATCH] RTC classdev: Add sysfs support for wakeup alarm (r/w)
Date: Tue, 19 Dec 2006 01:06:01 -0800
User-Agent: KMail/1.7.1
Cc: kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk
References: <1866913935.20061217213036@gmail.com> <200612181659.11473.david-b@pacbell.net> <1619959760.20061219084124@gmail.com>
In-Reply-To: <1619959760.20061219084124@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612190106.01637.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 10:41 pm, Paul Sokolovsky wrote:

> 
>   Do you mean enable_irq_wake()/disable_irq_wake() calls? In what way
> they are buggy? The only "bug" with them I see is that they are not
> implemented for PXA,

Notice how the number of enables and disables don't balance, and then
how the genirq framework handles such unbalanced calls.  Appended see
a "should make it all work" patch.  Test with the "rtcwake.c" program;
I'd expect pxa2[1567]x and sa1100 to work ... but obviously, there are
many more wakeup event sources that could be supported.


>   This is pretty interesting topic for us, and so far in handhelds.org
> ports we don't handle dynamic wakeup configuration at all, so I would
> eagerly expect your samples. In the meantime, I went and hacked
> .set_wake methods for PXA's irq_chips. And that's when I got idea why
> it might haven't been implemented at all - PXA27x's model of wakeup
> sources is a bit weird comparing with nice and clean PXA25x's ;-).

The appended patch is for pxa25x; maybe it needs to be #ifdeffed.

- Dave

==============	CUT HERE

This updates the SA-1100/PXA RTC support:

 - For PXA, copy the sa1100 irqchip set_wake handler; now this RTC
   should be a wakeup event source.  (GPIOs still not supported,
   and the comment is correct for pxa2[156]x not pxa27x.)
 
 - For both PXA and SA1100, mark the RTC platform device as capable
   of being a system wakeup event source before registration.

 - Bugfix the (shared) RTC driver to properly manage wakeup irqs, by
   adding new suspend/resume methods.  The previous code was deeply
   broken, and would generate error messages from the genirq framework.

 - Bugfix the (shared) RTC driver to handle the rtc_wkalrm.enable flag
   properly, reporting it when the alarm is read and setting it as
   requested when the alarm is set.

 - Add a missing MODULE_ALIAS so this driver can hotplug; "rtc-sa1100.c"
   would normally hold a driver named "rtc-sa1100", not "sa1100-rtc".

Compile-tested.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 arch/arm/mach-pxa/generic.c    |    2 ++
 arch/arm/mach-pxa/irq.c        |   16 ++++++++++++++++
 arch/arm/mach-sa1100/generic.c |    2 ++
 drivers/rtc/rtc-sa1100.c       |   31 ++++++++++++++++++++++++++-----
 4 files changed, 46 insertions(+), 5 deletions(-)
 
Index: at91/arch/arm/mach-pxa/irq.c
===================================================================
--- at91.orig/arch/arm/mach-pxa/irq.c	2006-12-07 21:22:59.000000000 -0800
+++ at91/arch/arm/mach-pxa/irq.c	2006-12-19 00:33:06.000000000 -0800
@@ -39,11 +39,27 @@ static void pxa_unmask_low_irq(unsigned 
 	ICMR |= (1 << (irq + PXA_IRQ_SKIP));
 }
 
+/*
+ * Apart from GPIOs 0-15, only the RTC alarm can be a wakeup event.
+ */
+static int pxa_set_wake(unsigned int irq, unsigned int on)
+{
+	if (irq == IRQ_RTCAlrm) {
+		if (on)
+			PWER |= PWER_RTC;
+		else
+			PWER &= ~PWER_RTC;
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static struct irq_chip pxa_internal_chip_low = {
 	.name		= "SC",
 	.ack		= pxa_mask_low_irq,
 	.mask		= pxa_mask_low_irq,
 	.unmask		= pxa_unmask_low_irq,
+	.set_wake	= pxa_set_wake,
 };
 
 #if PXA_INTERNAL_IRQS > 32
Index: at91/arch/arm/mach-pxa/generic.c
===================================================================
--- at91.orig/arch/arm/mach-pxa/generic.c	2006-12-07 21:22:59.000000000 -0800
+++ at91/arch/arm/mach-pxa/generic.c	2006-12-19 00:34:21.000000000 -0800
@@ -398,6 +398,8 @@ static int __init pxa_init(void)
 {
 	int cpuid, ret;
 
+	device_init_wakeup(&pxartc_device.dev, 1);
+
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret)
 		return ret;
Index: at91/arch/arm/mach-sa1100/generic.c
===================================================================
--- at91.orig/arch/arm/mach-sa1100/generic.c	2006-12-07 21:23:00.000000000 -0800
+++ at91/arch/arm/mach-sa1100/generic.c	2006-12-19 00:25:21.000000000 -0800
@@ -354,6 +354,8 @@ static int __init sa1100_init(void)
 	if (sa11x0ir_device.dev.platform_data)
 		platform_device_register(&sa11x0ir_device);
 
+	device_init_wakeup(&sa11x0rtc_device.dev, 1);
+
 	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
 }
 
Index: at91/drivers/rtc/rtc-sa1100.c
===================================================================
--- at91.orig/drivers/rtc/rtc-sa1100.c	2006-12-18 23:32:22.000000000 -0800
+++ at91/drivers/rtc/rtc-sa1100.c	2006-12-19 00:09:46.000000000 -0800
@@ -263,8 +263,12 @@ static int sa1100_rtc_set_time(struct de
 
 static int sa1100_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
+	u32 rtsr;
+
 	memcpy(&alrm->time, &rtc_alarm, sizeof(struct rtc_time));
-	alrm->pending = RTSR & RTSR_AL ? 1 : 0;
+	rtsr = RTSR;
+	alrm->enabled = (rtsr & RTSR_ALE) ? 1 : 0;
+	alrm->pending = (rtsr & RTSR_AL) ? 1 : 0;
 	return 0;
 }
 
@@ -275,12 +279,10 @@ static int sa1100_rtc_set_alarm(struct d
 	spin_lock_irq(&sa1100_rtc_lock);
 	ret = rtc_update_alarm(&alrm->time);
 	if (ret == 0) {
-		memcpy(&rtc_alarm, &alrm->time, sizeof(struct rtc_time));
-
 		if (alrm->enabled)
-			enable_irq_wake(IRQ_RTCAlrm);
+			RTSR |= RTSR_ALE;
 		else
-			disable_irq_wake(IRQ_RTCAlrm);
+			RTSR &= ~RTSR_ALE;
 	}
 	spin_unlock_irq(&sa1100_rtc_lock);
 
@@ -350,9 +352,28 @@ static int sa1100_rtc_remove(struct plat
 	return 0;
 }
 
+static int sa1100_rtc_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(IRQ_RTCAlrm);
+	return 0;
+}
+
+static int sa1100_rtc_resume(struct platform_device *pdev)
+{
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(IRQ_RTCAlrm);
+	return 0;
+}
+
+/* alias needed so hotplug behaves ("modprobe $MODALIAS") */
+MODULE_ALIAS("sa1100-rtc");
+
 static struct platform_driver sa1100_rtc_driver = {
 	.probe		= sa1100_rtc_probe,
 	.remove		= sa1100_rtc_remove,
+	.suspend	= sa1100_rtc_suspend,
+	.resume		= sa1100_rtc_resume,
 	.driver		= {
 		.name		= "sa1100-rtc",
 	},
