Return-Path: <linux-kernel-owner+w=401wt.eu-S1422650AbXAES0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbXAES0N (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbXAES0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:26:13 -0500
Received: from mx0.karneval.cz ([81.27.192.122]:7412 "EHLO av2.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422650AbXAES0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:26:13 -0500
X-Greylist: delayed 1289 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 13:26:12 EST
From: Pavel Pisa <ppisa4lists@pikron.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: ARM i.MX serial: fix tx buffer overflows
Date: Fri, 5 Jan 2007 19:01:52 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org,
       Konstantin Kletschke <kletschke@synertronixx.de>
References: <20070105155144.GD5838@localhost.localdomain>
In-Reply-To: <20070105155144.GD5838@localhost.localdomain>
Organization: PiKRON Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051901.52486.ppisa4lists@pikron.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 16:51, Sascha Hauer wrote:
> This patch fixes occasional tx buffer overflows in the i.MX serial
> driver which came from the fact that space in the buffer was checked
> after sending the first byte. Also, fifosize is 32 bytes, not 8.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Hello Sascha,

I have tested your change on 2.6.19-rt14 kernel
which I have on hand there. It is only very short
test, but I have not noticed any problems.

In the fact, I think, that it is possible, that
I have noticed some mentioned problem during
my CPU-Freq testing on RT kernels before.
I have noticed some problems sometimes with BusyBox
shell history editing during frequency throttling.
May it be, that RT+changed frequency invoked the problem.

I have some other small fix for i.MX uart there.
Can you add it into patch, or should I send it
as separate one-liner?

If RTS interrupt is caused by RTS senzing logic inside
i.MX UART module the IRQ type cannot be set.

It applies only for interrupts going through GPIO layer.
The problem has been noticed by Konstantin Kletschke
some time ago.

  No IRQF_TRIGGER set_type function for IRQ 26 (MPU)

I would not change type to fixed 0, because it could
be possible to use different GPIO MX1 pin for RTS
in the theory. On the other hand it is only for documentation
purposes now, because RTS read code would have to be adjusted
in such case.

Health and success wishes
in year 2007 from

                     Pavel Pisa

---

 drivers/serial/imx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.19-rt/drivers/serial/imx.c
===================================================================
--- linux-2.6.19-rt.orig/drivers/serial/imx.c
+++ linux-2.6.19-rt/drivers/serial/imx.c
@@ -403,7 +403,8 @@ static int imx_startup(struct uart_port 
 	if (retval) goto error_out2;
 
 	retval = request_irq(sport->rtsirq, imx_rtsint,
-			     IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+			     (sport->rtsirq < IMX_IRQS) ? 0 :
+			       IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			     DRIVER_NAME, sport);
 	if (retval) goto error_out3;
 




