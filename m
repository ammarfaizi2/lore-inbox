Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265751AbTFSJxa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 05:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbTFSJxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 05:53:30 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:24798 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S265751AbTFSJx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 05:53:26 -0400
Subject: matroxfb console oops in 2.4.2x
From: David Woodhouse <dwmw2@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Content-Type: text/plain
Organization: 
Message-Id: <1056017187.27851.154.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Thu, 19 Jun 2003 11:06:28 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have matroxfb with acceleration enabled but no other console, and
set console=tty0 on the command line, it dies because its putcs
functions are called before matroxfb_init_putc() is called.

Below is a workaround which lets the machine boot. It's obviously not a
fix.

--- drivers/video/matrox/matroxfb_accel.c~	Wed Jun 18 17:16:40 2003
+++ drivers/video/matrox/matroxfb_accel.c	Thu Jun 19 10:57:54 2003
@@ -487,6 +487,9 @@
 
 	DBG_HEAVY("matroxfb_cfb8_putc");
 
+	if (!ACCESS_FBINFO(curr.putc))
+		return;
+
 	fgx = attr_fgcol(p, c);
 	bgx = attr_bgcol(p, c);
 	fgx |= (fgx << 8);
@@ -504,6 +507,9 @@
 
 	DBG_HEAVY("matroxfb_cfb16_putc");
 
+	if (!ACCESS_FBINFO(curr.putc))
+		return;
+
 	fgx = ((u_int16_t*)p->dispsw_data)[attr_fgcol(p, c)];
 	bgx = ((u_int16_t*)p->dispsw_data)[attr_bgcol(p, c)];
 	fgx |= (fgx << 16);
@@ -519,6 +525,9 @@
 
 	DBG_HEAVY("matroxfb_cfb32_putc");
 
+	if (!ACCESS_FBINFO(curr.putc))
+		return;
+
 	fgx = ((u_int32_t*)p->dispsw_data)[attr_fgcol(p, c)];
 	bgx = ((u_int32_t*)p->dispsw_data)[attr_bgcol(p, c)];
 	ACCESS_FBINFO(curr.putc)(fgx, bgx, p, c, yy, xx);
@@ -662,6 +671,9 @@
 
 	DBG_HEAVY("matroxfb_cfb8_putcs");
 
+	if (!ACCESS_FBINFO(curr.putcs))
+		return;
+
 	c = scr_readw(s);
 	fgx = attr_fgcol(p, c);
 	bgx = attr_bgcol(p, c);
@@ -681,6 +693,9 @@
 
 	DBG_HEAVY("matroxfb_cfb16_putcs");
 
+	if (!ACCESS_FBINFO(curr.putcs))
+		return;
+
 	c = scr_readw(s);
 	fgx = ((u_int16_t*)p->dispsw_data)[attr_fgcol(p, c)];
 	bgx = ((u_int16_t*)p->dispsw_data)[attr_bgcol(p, c)];
@@ -697,6 +712,9 @@
 	MINFO_FROM_DISP(p);
 
 	DBG_HEAVY("matroxfb_cfb32_putcs");
+
+	if (!ACCESS_FBINFO(curr.putcs))
+		return;
 
 	c = scr_readw(s);
 	fgx = ((u_int32_t*)p->dispsw_data)[attr_fgcol(p, c)];





-- 
dwmw2

