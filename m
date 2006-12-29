Return-Path: <linux-kernel-owner+w=401wt.eu-S1754917AbWL2PZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754917AbWL2PZP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754927AbWL2PZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:25:15 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:55730 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbWL2PZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:25:10 -0500
Date: Fri, 29 Dec 2006 16:24:26 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061229152426.GQ912@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org> <20061229125108.GK912@telegraafnet.nl> <20061229132759.GL912@telegraafnet.nl> <20061229141058.GM912@telegraafnet.nl> <20061229150132.GN912@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20061229150132.GN912@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 29, 2006 at 04:01:32PM +0100, Ard -kwaak- van Breemen wrote:
> > - parse-one detection of Yanmin
> It doesn't flag it. I am working on that.
As said: it was doing a callback to obsolete_...
This replaces the patch into not being bloated and still gives
enough info. It won't check voor callbacks or whatever, just
which parameter b0rked it.

Output of dmesg without the pci-patch applied:
ard@supergirl:~$ dmesg|grep -B5 -A1 'interrupts were enabled'
Kernel command line: console=tty0 console=ttyS0,115200 hdb=noprobe hdc=noprobe hdd=noprobe root=/dev/md0 ro panic=30 earlyprintk=serial,ttyS0,115200 
ide_setup: hdb=noprobe
parse_args(): option 'hdb=noprobe' enabled irq's!
ide_setup: hdc=noprobe
ide_setup: hdd=noprobe
start_kernel(): bug: interrupts were enabled *very* early, fixing it
Initializing CPU#0

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.

--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="param-parse-irq-enable-detection.patch"

--- linux-2.6.19.vanilla/kernel/params.c	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19/kernel/params.c	2006-12-29 15:14:26.000000000 +0000
@@ -143,9 +143,14 @@
 
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

--ZInfyf7laFu/Kiw7--
