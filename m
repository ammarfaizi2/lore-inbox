Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUIOUtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUIOUtj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUIOUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:48:34 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:26775 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S267385AbUIOUpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:45:39 -0400
Message-ID: <4148AA34.3000003@246tNt.com>
Date: Wed, 15 Sep 2004 22:46:44 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 10/9] Small updates for Freescale MPC52xx - Late one ...
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Sorry for this late one, I just got it and it belongs with the others.
I've added it to the bk tree I sent earlier ( 
bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending )
so please pull from that tree.

The unified diff along with the patch description is below.

Thanks,

    Sylvain



# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/15 22:03:38+02:00 tnt@246tNt.com
#   ppc: Fix output of low-level serial debug on Freescale MPC52xx
#  
#   Thanks to Roger Blofeld for pointing that out.
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/syslib/mpc52xx_setup.c
#   2004/09/15 22:02:23+02:00 tnt@246tNt.com +14 -10
#   ppc: Fix output of low-level serial debug on Freescale MPC52xx
#
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c 
b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c   2004-09-15 22:36:07 +02:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c   2004-09-15 22:36:07 +02:00
@@ -100,24 +100,28 @@
 #error "mpc52xx PSC for console not selected"
 #endif

+static void
+mpc52xx_psc_putc(struct mpc52xx_psc * psc, unsigned char c)
+{
+       while (!(in_be16(&psc->mpc52xx_psc_status) &
+                MPC52xx_PSC_SR_TXRDY));
+       out_8(&psc->mpc52xx_psc_buffer_8, c);
+}
+
 void
 mpc52xx_progress(char *s, unsigned short hex)
 {
        struct mpc52xx_psc *psc = (struct mpc52xx_psc *)MPC52xx_CONSOLE;
        char c;

-               /* Don't we need to disable serial interrupts ? */
-      
        while ((c = *s++) != 0) {
-               if (c == '\n') {
-                       while (!(in_be16(&psc->mpc52xx_psc_status) &
-                                MPC52xx_PSC_SR_TXRDY)) ;
-                       out_8(&psc->mpc52xx_psc_buffer_8, '\r');
-               }
-               while (!(in_be16(&psc->mpc52xx_psc_status) &
-                        MPC52xx_PSC_SR_TXRDY)) ;
-               out_8(&psc->mpc52xx_psc_buffer_8, c);
+               if (c == '\n')
+                       mpc52xx_psc_putc(psc, '\r');
+               mpc52xx_psc_putc(psc, c);
        }
+
+       mpc52xx_psc_putc(psc, '\r');
+       mpc52xx_psc_putc(psc, '\n');
 }

 #endif  /* CONFIG_SERIAL_TEXT_DEBUG */

