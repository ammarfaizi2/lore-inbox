Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263853AbTICRei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTICRdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:33:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22770 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264146AbTICRcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:32:47 -0400
Message-ID: <3F5625BC.3C347696@mvista.com>
Date: Wed, 03 Sep 2003 11:32:44 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PATCH:2.4:2.6:compile hermes.h fails with outw_p() in :?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

build errors:
  hermes.h: In function `hermes_set_irqmask':
  hermes.h:337: parse error before "do"
  hermes.h:337: parse error before ';' token
  hermes.h: In function `hermes_write_words':

In mips, outw_p() is a #define do...while(0) which, in the
case of ?:, results in a statement being used where an
expression is required. 

Here are my proposed (identical) patches for 2.4 and 2.6.



--- linux-2.4.23-pre2/drivers/net/wireless/hermes.h     Mon Aug 25 05:44:42 2003
+++ linux-2.4.23-pre2.hermes/drivers/net/wireless/hermes.h      Wed Sep  3 11:05:05 2003
@@ -302,12 +302,14 @@
 #define hermes_read_reg(hw, off) ((hw)->io_space ? \
        inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
        readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
-#define hermes_write_reg(hw, off, val) ((hw)->io_space ? \
-       outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
-       writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )))
-
-#define hermes_read_regn(hw, name) (hermes_read_reg((hw), HERMES_##name))
-#define hermes_write_regn(hw, name, val) (hermes_write_reg((hw), HERMES_##name, (val)))
+#define hermes_write_reg(hw, off, val) do { \
+       if ( (hw)->io_space ) \
+               outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       else \
+               writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       } while (0)
+#define hermes_read_regn(hw, name) hermes_read_reg((hw), HERMES_##name)
+#define hermes_write_regn(hw, name, val) hermes_write_reg((hw), HERMES_##name, (val))
 
 /* Function prototypes */
 void hermes_struct_init(hermes_t *hw, ulong address, int io_space, int reg_spacing);




--- linux-2.6.00-test4/drivers/net/wireless/hermes.h    Fri Aug 22 17:51:39 2003
+++ linux-2.6.00-test4.hermes/drivers/net/wireless/hermes.h     Wed Sep  3 11:05:09 2003
@@ -302,12 +302,14 @@
 #define hermes_read_reg(hw, off) ((hw)->io_space ? \
        inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
        readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
-#define hermes_write_reg(hw, off, val) ((hw)->io_space ? \
-       outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
-       writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )))
-
-#define hermes_read_regn(hw, name) (hermes_read_reg((hw), HERMES_##name))
-#define hermes_write_regn(hw, name, val) (hermes_write_reg((hw), HERMES_##name, (val)))
+#define hermes_write_reg(hw, off, val) do { \
+       if ( (hw)->io_space ) \
+               outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       else \
+               writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       } while (0)
+#define hermes_read_regn(hw, name) hermes_read_reg((hw), HERMES_##name)
+#define hermes_write_regn(hw, name, val) hermes_write_reg((hw), HERMES_##name, (val))
 
 /* Function prototypes */
 void hermes_struct_init(hermes_t *hw, ulong address, int io_space, int reg_spacing);
