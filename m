Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUGQCJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUGQCJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 22:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUGQCJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 22:09:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:53164 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266683AbUGQCJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 22:09:46 -0400
Message-ID: <40F88A69.4080003@acm.org>
Date: Fri, 16 Jul 2004 21:09:45 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Khalid Aziz <khalid_aziz@hp.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipmi_msghandler module load failure
References: <1089995643.5015.47.camel@lyra.fc.hp.com>
In-Reply-To: <1089995643.5015.47.camel@lyra.fc.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So they've added enforcement so that non-init code cannot call init 
code.  The call as it was is actually safe, there is a variable that 
will  only cause it to be called if it has not been called yet (there 
are possible reasons to do this when the driver is compiled into the 
kernel) and it always gets called at init time. The the enforcement is 
probably a good thing, though.  The patch looks ok.

-Corey

Khalid Aziz wrote:

>Corey,
>
>On a 2.6.7 kernel, when I try to modprobe ipmi_msghandler, it fails to
>load with following message:
>
>FATAL: Error inserting ipmi_msghandler (/lib/modules/2.6.7/kernel/drivers/char/ipmi/ipmi_msghandler.ko): Invalid module format
>
>And there is an error message in dmesg:
>
>ipmi_msghandler: init symbol 0xa000000200058080 used in module code at a000000200031b32
>
>What I have been able to determine is that ipmi_msghandler.c defines
>ipmi_init_msghandler() as the module_init() routine and then it also
>calls ipmi_init_msghandler() diretcly from couple of other places. This
>does not seem to be okay in 2.6.7 kernel. I was able to fix this by
>defining a new module_init routine which in turn calls
>ipmi_init_msghandler(). I also removed __init from
>ipmi_init_msghandler() since it gets called from ipmi_open() on an open
>of the ipmi device file. So I would think we want to keep
>ipmi_init_msghandler() around even after initialization. Here is the
>patch. Please apply if it looks good:
>
>--- linux-2.6.7/drivers/char/ipmi/ipmi_msghandler.c	2004-06-15 23:19:36.000000000 -0600
>+++ linux-2.6.7.new/drivers/char/ipmi/ipmi_msghandler.c	2004-07-16 10:28:52.000000000 -0600
>@@ -3072,7 +3072,7 @@
> 	200   /* priority: INT_MAX >= x >= 0 */
> };
> 
>-static __init int ipmi_init_msghandler(void)
>+static int ipmi_init_msghandler(void)
> {
> 	int i;
> 
>@@ -3107,6 +3107,11 @@
> 	return 0;
> }
> 
>+static __init int ipmi_init_msghandler_mod(void)
>+{
>+	ipmi_init_msghandler();
>+}
>+
> static __exit void cleanup_ipmi(void)
> {
> 	int count;
>@@ -3143,7 +3148,7 @@
> }
> module_exit(cleanup_ipmi);
> 
>-module_init(ipmi_init_msghandler);
>+module_init(ipmi_init_msghandler_mod);
> MODULE_LICENSE("GPL");
> 
> EXPORT_SYMBOL(ipmi_alloc_recv_msg);
>
>  
>


