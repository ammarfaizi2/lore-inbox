Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266436AbUGOWl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266436AbUGOWl6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUGOWl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:41:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35032 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266436AbUGOWlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:41:52 -0400
Date: Fri, 16 Jul 2004 00:41:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: yokota@netlab.is.tsukuba.ac.jp, gotom@debian.or.jp
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI nsp32.c: remove inlines
Message-ID: <20040715224143.GP25633@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/scsi/nsp32.c in 2.6.8-rc1-mm1 using gcc 3.4 
results in compile errors starting with the following:

<--  snip  -->

...
  CC      drivers/scsi/nsp32.o
drivers/scsi/nsp32.c: In function `nsp32_prom_start':
drivers/scsi/nsp32.c:270: sorry, unimplemented: inlining failed in call 
to 'nsp32_prom_set': function body not available
drivers/scsi/nsp32.c:3348: sorry, unimplemented: called from here
drivers/scsi/nsp32.c:270: sorry, unimplemented: inlining failed in call 
to 'nsp32_prom_set': function body not available
drivers/scsi/nsp32.c:3349: sorry, unimplemented: called from here
drivers/scsi/nsp32.c:270: sorry, unimplemented: inlining failed in call 
to 'nsp32_prom_set': function body not available
drivers/scsi/nsp32.c:3350: sorry, unimplemented: called from here
drivers/scsi/nsp32.c:270: sorry, unimplemented: inlining failed in call 
to 'nsp32_prom_set': function body not available
drivers/scsi/nsp32.c:3351: sorry, unimplemented: called from here
drivers/scsi/nsp32.c:270: sorry, unimplemented: inlining failed in call 
to 'nsp32_prom_set': function body not available
drivers/scsi/nsp32.c:3353: sorry, unimplemented: called from here
make[2]: *** [drivers/scsi/nsp32.o] Error 1


<--  snip  -->


The patch below removes the inlines from nsp32_prom_{get,set}.

An alternative approach would be to move the functions above the place  
where they are called the first time.


diffstat output:
 drivers/scsi/nsp32.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full-3.4/drivers/scsi/nsp32.c.old	2004-07-16 00:34:49.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full-3.4/drivers/scsi/nsp32.c	2004-07-16 00:37:26.000000000 +0200
@@ -267,8 +267,8 @@
 static        int  nsp32_prom_read     (nsp32_hw_data *, int);
 static        int  nsp32_prom_read_bit (nsp32_hw_data *);
 static        void nsp32_prom_write_bit(nsp32_hw_data *, int);
-static inline void nsp32_prom_set      (nsp32_hw_data *, int, int);
-static inline int  nsp32_prom_get      (nsp32_hw_data *, int);
+static        void nsp32_prom_set      (nsp32_hw_data *, int, int);
+static        int  nsp32_prom_get      (nsp32_hw_data *, int);
 
 /* debug/warning/info message */
 static void nsp32_message (const char *, int, char *, char *, ...);
@@ -3387,7 +3387,7 @@
 	return val;
 }
 
-static inline void nsp32_prom_set(nsp32_hw_data *data, int bit, int val)
+static void nsp32_prom_set(nsp32_hw_data *data, int bit, int val)
 {
 	int base = data->BaseAddress;
 	int tmp;
@@ -3405,7 +3405,7 @@
 	udelay(10);
 }
 
-static inline int nsp32_prom_get(nsp32_hw_data *data, int bit)
+static int nsp32_prom_get(nsp32_hw_data *data, int bit)
 {
 	int base = data->BaseAddress;
 	int tmp, ret;

