Return-Path: <linux-kernel-owner+w=401wt.eu-S1945903AbWLVEll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945903AbWLVEll (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 23:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945924AbWLVEll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 23:41:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:22723 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945903AbWLVElk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 23:41:40 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,202,1165219200"; 
   d="scan'208"; a="180640805:sNHT21137144"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Date: Fri, 22 Dec 2006 12:41:46 +0800
Message-ID: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Thread-Index: AcclQ8+jlwmLGUIoTd6Ytc5t7iJs/wAPwi2g
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Ard -kwaak- van Breemen" <ard@telegraafnet.nl>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Yinghai Lu" <yinghai.lu@amd.com>, <take@libero.it>, <agalanin@mera.ru>,
       <linux-kernel@vger.kernel.org>, <bugme-daemon@bugzilla.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
X-OriginalArrivalTime: 22 Dec 2006 04:41:39.0093 (UTC) FILETIME=[78337450:01C72583]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Ard -kwaak- van Breemen [mailto:ard@telegraafnet.nl]
>>Sent: 2006Äê12ÔÂ22ÈÕ 5:06
>>To: Zhang, Yanmin
>>Cc: Andrew Morton; Chuck Ebbert; Yinghai Lu; take@libero.it; agalanin@mera.ru; linux-kernel@vger.kernel.org;
>>bugme-daemon@bugzilla.kernel.org; Eric W. Biederman
>>Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
>>
>>On Thu, Dec 21, 2006 at 04:04:04PM +0800, Zhang, Yanmin wrote:
>>> I couldn't reproduce it on my EM64T machine. I instrumented function start_kernel and
>>> didn't find irq was enabled before calling init_IRQ. It'll be better if the reporter could
>>> instrument function start_kernel to capture which function enables irq.
>>
>>Editing init/main.c:
>>        preempt_disable();
>>        if (!irqs_disabled())
>>                printk("start_kernel(): bug: interrupts were enabled early\n");
>>                printk("BLAAT17");
>>        build_all_zonelists();
>>        if (!irqs_disabled())
>>                printk("start_kernel(): bug: interrupts were enabled early\n");
>>                printk("BLAAT18");
>>        page_alloc_init();
>>        if (!irqs_disabled())
>>                printk("start_kernel(): bug: interrupts were enabled early\n");
>>                printk("BLAAT19");
>>        printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
>>        parse_early_param();
>>        if (!irqs_disabled())
>>                printk("start_kernel(): bug: interrupts were enabled early\n");
>>                printk("BLAAT20");
>>        parse_args("Booting kernel", command_line, __start___param,
>>                   __stop___param - __start___param,
>>                   &unknown_bootoption);
>>                printk("BLAAT21");
>>        if (!irqs_disabled())
>>                printk("start_kernel(): bug: interrupts were enabled early\n");
>>        sort_main_extable();
>>        if (!irqs_disabled())
>>                printk("start_kernel(): bug: interrupts were enabled early\n");
>>                printk("BLAAT22");
>>        trap_init();
>>        if (!irqs_disabled())
>>                printk("start_kernel(): bug: interrupts were enabled early\n");
>>                printk("BLAAT23");
>>
>>Results in:
>>^MAllocating PCI resources starting at 88000000 (gap: 80000000:60000000)
>>^MBLAAT12BLAAT13<6>PERCPU: Allocating 32960 bytes of per cpu data
>>^MBLAAT14BLAAT15BLAAT16BLAAT17Built 2 zonelists.  Total pages: 1032635
>>^MBLAAT18BLAAT19<5>Kernel command line: console=tty0 console=ttyS0,115200 hdb=noprobe hdc=noprobe hdd=noprobe root=/dev/md0 ro panic=30
>>earlyprintk=serial,ttyS0,115200
>>^MBLAAT20<6>ide_setup: hdb=noprobe
>>^Mide_setup: hdc=noprobe
>>^Mide_setup: hdd=noprobe
>>^MBLAAT21start_kernel(): bug: interrupts were enabled early
>>^Mstart_kernel(): bug: interrupts were enabled early
>>^MBLAAT22Initializing CPU#0
>>
>>Hmmm, that actually doesn't make sense to me (unless parse_args is able to enable irq's).
I think parse_args enables irq when it calls callbacks.
Could you try below?
1) Test Andrew's patch of sema down_write;
2) Apply below patch and see what the output is when booting. If the output has
"[BUG]..address.", Pls. map the address to function name by System.map.

--- linux-2.6.19/kernel/params.c	2006-12-08 15:32:49.000000000 +0800
+++ linux-2.6.19_work/kernel/params.c	2006-12-22 12:28:38.000000000 +0800
@@ -53,13 +53,22 @@ static int parse_one(char *param,
 		     int (*handle_unknown)(char *param, char *val))
 {
 	unsigned int i;
+	int result;
+	int irq_is_disabled;
 
 	/* Find parameter */
 	for (i = 0; i < num_params; i++) {
 		if (parameq(param, params[i].name)) {
 			DEBUGP("They are equal!  Calling %p\n",
 			       params[i].set);
-			return params[i].set(val, &params[i]);
+			irq_is_disabled = irqs_disabled();
+			result = params[i].set(val, &params[i]);
+			if (irq_is_disabled && !irqs_disabled())
+			{
+				printk("[BUG] parse_one: function %p enabled irq!\n",
+						params[i].set);
+			}
+			return result;
 		}
 	}
 
--- linux-2.6.19/init/main.c	2006-12-08 15:32:49.000000000 +0800
+++ linux-2.6.19_work/init/main.c	2006-12-22 12:28:50.000000000 +0800
@@ -181,6 +181,7 @@ static int __init obsolete_checksetup(ch
 {
 	struct obs_kernel_param *p;
 	int had_early_param = 0;
+	int result, irq_is_disabled;
 
 	p = __setup_start;
 	do {
@@ -197,8 +198,17 @@ static int __init obsolete_checksetup(ch
 				printk(KERN_WARNING "Parameter %s is obsolete,"
 				       " ignored\n", p->str);
 				return 1;
-			} else if (p->setup_func(line + n))
-				return 1;
+			} else {
+				irq_is_disabled = irqs_disabled();
+				result = p->setup_func(line + n);
+				if (irq_is_disabled && !irqs_disabled())
+				{
+					printk("[BUG] obsolete_checksetup: function %p enabled irq!\n",
+							p->setup_func);
+				}
+				if (result)
+					return 1;
+			}
 		}
 		p++;
 	} while (p < __setup_end);
