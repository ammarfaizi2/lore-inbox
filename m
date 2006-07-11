Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030384AbWGKGGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbWGKGGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 02:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWGKGGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 02:06:10 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:55429 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1030189AbWGKGGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 02:06:08 -0400
Subject: [PATCH 4/4] stack overflow safe kdump (2.6.18-rc1-i386) -
	safe_smp_send_nmi_allbutself
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: vgoyal@in.ibm.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org, ak@suse.de,
       James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Tue, 11 Jul 2006 15:06:06 +0900
Message-Id: <1152597966.2414.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-implement smp_send_nmi_allbutself so that calls to smp_processor_id
(through send_IPI_allbutself) can be replaced with safe_smp_processor_id
without affecting other parts of the kernel (as suggested by Eric Biederman).

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc1/arch/i386/kernel/crash.c linux-2.6.18-rc1-sof/arch/i386/kernel/crash.c
--- linux-2.6.18-rc1/arch/i386/kernel/crash.c	2006-07-11 14:14:04.000000000 +0900
+++ linux-2.6.18-rc1-sof/arch/i386/kernel/crash.c	2006-07-11 14:15:49.000000000 +0900
@@ -122,7 +122,10 @@ static int crash_nmi_callback(struct pt_
 
 static void smp_send_nmi_allbutself(void)
 {
-	send_IPI_allbutself(NMI_VECTOR);
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(safe_smp_processor_id(), mask);
+	if (!cpus_empty(mask))
+		send_IPI_mask(mask, NMI_VECTOR);
 }
 
 static void nmi_shootdown_cpus(void)


