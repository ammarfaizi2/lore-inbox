Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSGHW6j>; Mon, 8 Jul 2002 18:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSGHW6i>; Mon, 8 Jul 2002 18:58:38 -0400
Received: from 216-174-224-194.atgi.net ([216.174.224.194]:53765 "HELO
	interceptor.mahinetworks.com") by vger.kernel.org with SMTP
	id <S317253AbSGHW6h>; Mon, 8 Jul 2002 18:58:37 -0400
Message-ID: <9D6D37E97A57D411BB7C00508BAE29C902D24056@main.mahinetworks.com>
From: Dave Richards <drichards@mahinetworks.com>
To: "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: arch/i386/kernel/traps.c
Date: Mon, 8 Jul 2002 16:01:08 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While diagnosing an MMX/FPU problem I found a minor problem in the code
which diagnoses and generates signals for FPU exceptions.  On x86 Stack
Fault Exception are a subclass of Invalid Operation.  Thus, the FPU status
register will have both the SF and IF bits set when a stack fault occurs.
The code which turns FPU exceptions into signals was assuming IF would be
clear:

*** linux/arch/i386/kernel/traps.c  Sun Sep 30 19:26:08 2001
--- linux-2.4.18/arch/i386/kernel/traps.c   Tue Jul  2 15:59:33 2002
***************
*** 578,587 ****
--- 578,595 ----
    switch (((~cwd) & swd & 0x3f) | (swd & 0x240)) {
        case 0x000:
        default:
            break;
        case 0x001: /* Invalid Op */
+ #ifdef CONFIG_MAHI_NMP
+       case 0x041: /* Stack Fault */
+       case 0x241: /* Stack Fault | Direction */
+ #else
        case 0x040: /* Stack Fault */
        case 0x240: /* Stack Fault | Direction */
+ #endif
            info.si_code = FPE_FLTINV;
            break;
        case 0x002: /* Denormalize */

Dave Richards
Mahi Networks, Inc.
1039 N. McDowell Blvd.
Petaluma, CA 94954
(707) 283-1139 (voice)
(707) 283-1299 (fax)


