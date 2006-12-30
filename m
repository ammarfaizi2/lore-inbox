Return-Path: <linux-kernel-owner+w=401wt.eu-S1030327AbWL3T6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWL3T6q (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 14:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWL3T6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 14:58:46 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:39904 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030327AbWL3T6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 14:58:45 -0500
Date: Sat, 30 Dec 2006 20:58:43 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2.6.20-rc2-git1] kernelparams: detect if and which parameter parsing enabled irq's
Message-ID: <20061230195843.GU912@telegraafnet.nl>
References: <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org> <20061229125108.GK912@telegraafnet.nl> <20061229132759.GL912@telegraafnet.nl> <20061229141058.GM912@telegraafnet.nl> <20061229150132.GN912@telegraafnet.nl> <20061229154251.GR912@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229154251.GR912@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The parsing of some kernel parameters seem to enable irq's at a
stage that irq's are not supposed to be enabled (Particularly the
ide kernel parameters).  Having irq's enabled before the irq
controller is initialized might lead to a kernel panic.
This patch only detects this behaviour and warns about wich
parameter caused it.

Signed-off-by: Ard van Breemen <ard@telegraafnet.nl>

--- linux-2.6.19.vanilla/kernel/params.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19.ok/kernel/params.c	2006-12-29 15:14:26.000000000 +0000
@@ -143,9 +143,14 @@ int parse_args(const char *name,
 
 	while (*args) {
 		int ret;
+		int irq_was_disabled;
 
 		args = next_arg(args, &param, &val);
+		irq_was_disabled=irqs_disabled();
 		ret = parse_one(param, val, params, num, unknown);
+		if(irq_was_disabled && !irqs_disabled()) {
+			printk(KERN_WARNING "parse_args(): option '%s' enabled irq's!\n",param);
+		}
 		switch (ret) {
 		case -ENOENT:
 			printk(KERN_ERR "%s: Unknown parameter `%s'\n",
