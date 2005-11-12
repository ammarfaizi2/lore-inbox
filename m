Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVKLTuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVKLTuR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 14:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVKLTuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 14:50:17 -0500
Received: from unknown-1-11.windriver.com ([147.11.1.11]:54401 "EHLO
	mail.wrs.com") by vger.kernel.org with ESMTP id S932483AbVKLTuP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 14:50:15 -0500
Message-ID: <43764766.6010009@windriver.com>
Date: Sat, 12 Nov 2005 13:49:58 -0600
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Tom Rini <trini@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: SysFS 'module' params with CONFIG_MODULES=n
References: <20051111153220.GQ3839@smtp.west.cox.net> <20051112043320.GA27472@suse.de>
In-Reply-To: <20051112043320.GA27472@suse.de>
Content-Type: multipart/mixed;
 boundary="------------030907090205070409030906"
X-OriginalArrivalTime: 12 Nov 2005 19:49:58.0555 (UTC) FILETIME=[431CA6B0:01C5E7C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030907090205070409030906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Fri, Nov 11, 2005 at 08:32:20AM -0700, Tom Rini wrote:
>   
>> On 2.6.14, and probably newer, a system where CONFIG_MODULES=n
>> /sys/module/foo/parameters/param fails:
>>
>> # cat /sys/module/tcp_bic/parameters/low_window
>> cat: /sys/module/tcp_bic/parameters/low_window: Permission denied
>>
>> But just changing MODULES to y:
>>
>> # cat /sys/module/tcp_bic/parameters/low_window
>> 14
>>
>> Is this intentional or fixable?  Just an observation right now, thanks.
>>     
>
> Not intentional at all.  Did this work before 2.6.14?
>
> thanks,
>
> greg k-h
>   
I am not sure when it stopped working.

I recommend the attached patch to kernel/params.c All the work was done 
to setup the file and maintain the file handles but the access functions 
were zeroed out due to the #ifdef.  Removing the #ifdef allows full 
access to all the parameters when CONFIG_MODULES=n.

signed off: Jason Wessel <jason.wessel@windriver.com>

Thanks,
Jason.





--------------030907090205070409030906
Content-Type: text/plain;
 name="params_sysfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="params_sysfs.patch"

Index: linux-2.6.14/kernel/params.c
===================================================================
--- linux-2.6.14.orig/kernel/params.c	2005-11-11 08:40:03.456317256 -0800
+++ linux-2.6.14/kernel/params.c	2005-11-12 11:43:00.439765632 -0800
@@ -618,8 +618,6 @@ static void __init param_sysfs_builtin(v
 
 
 /* module-related sysfs stuff */
-#ifdef CONFIG_MODULES
-
 #define to_module_attr(n) container_of(n, struct module_attribute, attr);
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj);
 
@@ -676,13 +674,6 @@ static struct sysfs_ops module_sysfs_ops
 	.store = module_attr_store,
 };
 
-#else
-static struct sysfs_ops module_sysfs_ops = {
-	.show = NULL,
-	.store = NULL,
-};
-#endif
-
 static struct kobj_type module_ktype = {
 	.sysfs_ops =	&module_sysfs_ops,
 };

--------------030907090205070409030906--
