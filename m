Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTKSQPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 11:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTKSQPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 11:15:53 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:27623 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263930AbTKSQPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 11:15:51 -0500
Date: Wed, 19 Nov 2003 16:10:44 +0000
From: Dave Jones <davej@redhat.com>
To: kernel@mikebell.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/mtrr in 2.6
Message-ID: <20031119161044.GA27802@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, kernel@mikebell.org,
	linux-kernel@vger.kernel.org
References: <20031119051233.GB1485@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119051233.GB1485@mikebell.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 18, 2003 at 09:12:34PM -0800, kernel@mikebell.org wrote:
 > In 2.6, having /proc/mtrr support in a kernel run on a system which
 > lacks MTRR support (like my crusoe) results in /proc/mtrr existing, but
 > giving EIO if you try to read it. On 2.4, it is detected as not existing
 > and not created. Is this the new intentional behaviour, or just a bug?

Need something like this perhaps ?

--- 1/arch/i386/kernel/cpu/mtrr/if.c~	2003-11-19 16:00:10.000000000 +0000
+++ 2/arch/i386/kernel/cpu/mtrr/if.c	2003-11-19 16:09:25.000000000 +0000
@@ -352,6 +352,14 @@
 
 static int __init mtrr_if_init(void)
 {
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if ((!cpu_has(c, X86_FEATURE_MTRR)) ||
+	    (!cpu_has(c, X86_FEATURE_K6_MTRR)) ||
+	    (!cpu_has(c, X86_FEATURE_CYRIX_ARR)) ||
+	    (!cpu_has(c, X86_FEATURE_CENTAUR_MCR)))
+		return -ENODEV;
+
 	proc_root_mtrr =
 	    create_proc_entry("mtrr", S_IWUSR | S_IRUGO, &proc_root);
 	if (proc_root_mtrr) {
