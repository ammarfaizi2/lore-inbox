Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUISX0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUISX0s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 19:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUISX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 19:26:47 -0400
Received: from pop.gmx.net ([213.165.64.20]:42157 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264917AbUISX0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 19:26:43 -0400
X-Authenticated: #24390674
From: Hans-Frieder Vogt <hfvogt@gmx.net>
Reply-To: hfvogt@gmx.net
To: felipe.alfaro@linuxmail.org
Subject: Re: 2.6.9-rc2-mm1: i8042.c: Can't read CTR while initializing i8042
Date: Mon, 20 Sep 2004 01:25:57 +0200
User-Agent: KMail/1.7
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409200125.57953.hfvogt@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> My keyboard has suddenly stopped working with 2.6.9-rc2-mm1-VP-S1 and 
2.6.9-rc2-mm1. This is part of the output of dmesg:
>
> i8042: ACPI [P2KI] at I/O 0x0, 0x0, irq 1
> i8042: ACPI [P2MI] at irq 12
> i8042.c: Can't read CTR while initializing i8042.
>
> This does happen on 2.6.9-rc2-mm1-VP-S1 and 2.6.9-rc2-mm1 on a NEC Chrom@ 
laptop, with a 440BX motherboard, Pentium III Mobile and integrated PS/2 
keyboard and mouse. It doesn't happen in 2.6.8.1, not does it happen on my 
Pentium 4 machine, however.
>
> Any ideas?

I had the same problem on my AMD64 system (MSI K8T Neo board). The reason, why 
the ioports are not recognised on this board (i.e., why they show up as 0x0, 
0x0) is, that the ACPI defines these ports as FixedIO () and not as IO () as 
expected by the current linux code. FixedIO is perfectly fine and in line 
with the ACPI standard. So the DSDT table is NOT bad but linux is currently 
simply not flexible enough to cope with all possible (and allowable) 
combinations.

With the small attached patch the i8042 IO-ports were recognised on my board 
(only tested with keyboard).

Voytech, could you include this patch into your next patch set?

--- linux-2.6.9-rc1-mm5.orig/drivers/input/serio/i8042-x86ia64io.h 2004-09-13 
15:39:39.061522663 +0200
+++ linux-2.6.9-rc1-mm5/drivers/input/serio/i8042-x86ia64io.h 2004-09-20 
01:10:32.124593201 +0200
@@ -105,6 +105,7 @@ static acpi_status i8042_acpi_parse_reso
 {
  struct i8042_acpi_resources *i8042_res = data;
  struct acpi_resource_io *io;
+ struct acpi_resource_fixed_io *fixed_io;
  struct acpi_resource_irq *irq;
  struct acpi_resource_ext_irq *ext_irq;
 
@@ -119,6 +120,16 @@ static acpi_status i8042_acpi_parse_reso
    }
    break;
 
+  case ACPI_RSTYPE_FIXED_IO:
+   fixed_io = &res->data.fixed_io;
+   if (fixed_io->range_length) {
+    if (!i8042_res->port1)
+     i8042_res->port1 = fixed_io->base_address;
+    else
+     i8042_res->port2 = fixed_io->base_address;
+   }
+   break;
+
   case ACPI_RSTYPE_IRQ:
    irq = &res->data.irq;
    if (irq->number_of_interrupts > 0)

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net
