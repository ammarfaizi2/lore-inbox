Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSFVCmJ>; Fri, 21 Jun 2002 22:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSFVCmI>; Fri, 21 Jun 2002 22:42:08 -0400
Received: from holomorphy.com ([66.224.33.161]:56004 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316755AbSFVCmH>;
	Fri, 21 Jun 2002 22:42:07 -0400
Date: Fri, 21 Jun 2002 19:41:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: smp_call_function() deadlock during boot
Message-ID: <20020622024140.GD25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

smp_call_function() gets called before cpu_online_map is initialized.
In order to tolerate this behavior the following appears to be necessary.
This method of resolving the issue has a precedent in smp_IPI_allbutself().

Cheers,
Bill


===== arch/i386/kernel/smp.c 1.17 vs edited =====
--- 1.17/arch/i386/kernel/smp.c	Mon May 20 10:51:17 2002
+++ edited/arch/i386/kernel/smp.c	Fri Jun 21 19:37:11 2002
@@ -567,9 +567,9 @@
  */
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	int cpus = num_online_cpus();
 
-	if (!cpus)
+	if (cpus <= 1)
 		return 0;
 
 	data.func = func;
@@ -586,11 +586,11 @@
 	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
-	while (atomic_read(&data.started) != cpus)
+	while (atomic_read(&data.started) != cpus - 1)
 		barrier();
 
 	if (wait)
-		while (atomic_read(&data.finished) != cpus)
+		while (atomic_read(&data.finished) != cpus - 1)
 			barrier();
 	spin_unlock(&call_lock);
 
