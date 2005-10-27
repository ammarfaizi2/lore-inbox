Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVJ0Pkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVJ0Pkj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 11:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVJ0Pki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 11:40:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28817 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750822AbVJ0Pki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 11:40:38 -0400
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [KDUMP] pending interrupts problem
References: <20051027.165027.97297370.noboru.obata.ar@hitachi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 27 Oct 2005 09:40:12 -0600
In-Reply-To: <20051027.165027.97297370.noboru.obata.ar@hitachi.com> (OBATA
 Noboru's message of "Thu, 27 Oct 2005 16:50:27 +0900 (JST)")
Message-ID: <m1y84farz7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being lazy does this patch fix the problem for you?

It looks like this is enough to keep the kernel going
in the face of unexpected IPIs ...

Eric

---

 arch/i386/kernel/smp.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

applies-to: e6a6c8ed12ba1ef7fa376fa3993e3c329e9f294a
195ab3620ba410697ad78957226c5493d55dd2ee
diff --git a/arch/i386/kernel/smp.c b/arch/i386/kernel/smp.c
index 218d725..3d33125 100644
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -560,6 +560,7 @@ int smp_call_function (void (*func) (voi
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
 			cpu_relax();
+	call_data = NULL;
 	spin_unlock(&call_lock);
 
 	return 0;
@@ -609,6 +610,14 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+
+	/* Ignore spurious IPIs */
+	if (!call_data)
+		return;
+
+	func = call_data->func;
+	info = call_data->info;
+	wait = call_data->wait;
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
