Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTEOCSy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTEOCSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:18:54 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:62407 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263680AbTEOCSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:18:49 -0400
Date: Wed, 14 May 2003 19:33:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
Message-Id: <20030514193300.58645206.akpm@digeo.com>
In-Reply-To: <1052965395.758.3.camel@teapot.felipe-alfaro.com>
References: <1052965395.758.3.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 02:31:33.0029 (UTC) FILETIME=[1963DD50:01C31A8A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> Hi again, Andrew,
> 
> Besides the "make_KOBJ_NAME-match_BUS_ID_SIZE.patch" causing "pccard"
> oopses, I've also found that, with 2.5.69-mm5 compiled with ACPI
> support, my laptop is unable to power off. The kernel invokes
> "acpi_power_off" and stays there forever.
> 
> I've found that reverting the "i8259-shutdown.patch" fixes the problem
> and my laptop is able to shutdown properly (init 0) when using ACPI.
> 
> A hardware bug? A kernel bug?

And thanks again, again.

That's the below patch.  It looks pretty innocuous.  I'd be assuming that
there's something in the shutdown sequence which needs 8259 functionality
after the thing has been turned off.

This could well depend upon .config contents and linkage order.

Eric, maybe we need to turn it off by hand at the right time rather than
relying on driver model shutdown ordering?


 arch/i386/kernel/i8259.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

diff -puN arch/i386/kernel/i8259.c~i8259-shutdown arch/i386/kernel/i8259.c
--- 25/arch/i386/kernel/i8259.c~i8259-shutdown	2003-05-11 18:48:58.000000000 -0700
+++ 25-akpm/arch/i386/kernel/i8259.c	2003-05-11 18:48:58.000000000 -0700
@@ -245,10 +245,21 @@ static int i8259A_resume(struct device *
 	return 0;
 }
 
+static void i8259A_shutdown(struct device *dev)
+{   
+	/* Put the i8259A into a quiescent state that
+	 * the kernel initialization code can get it
+	 * out of.
+	 */
+	outb(0xff, 0x21);	/* mask all of 8259A-1 */
+	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
+}
+
 static struct device_driver i8259A_driver = {
 	.name		= "pic",
 	.bus		= &system_bus_type,
 	.resume		= i8259A_resume,
+	.shutdown	= i8259A_shutdown,
 };
 
 static struct sys_device device_i8259A = {

_

