Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbUJXIvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUJXIvd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 04:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbUJXIvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 04:51:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:8625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261393AbUJXIv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 04:51:29 -0400
Date: Sun, 24 Oct 2004 01:49:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com, rddunlap@osdl.org
Subject: Re: 2.6.9-mm1
Message-Id: <20041024014929.1f303eb8.akpm@osdl.org>
In-Reply-To: <1098522510.626.47.camel@boxen>
References: <20041022032039.730eb226.akpm@osdl.org>
	<1098522510.626.47.camel@boxen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
> >   - kexec and crashdump: this all allegedly works, but I want to *see* it
> >     work first.
> 
> - sys_reboot() calls device_shutdown() which naturally makes my disks go
> to sleep and immediatly after spin up when the disk initialization code
> comes in. Is there some specific reason why this is needed? Appears to
> work for me just removing the function call.

There's special-case code in the IDE driver to prevent this.  The kexec
code manages to defeat it.  This should fix:

--- 25/kernel/sys.c~kexec-ide-spindown-fix	2004-10-24 01:46:52.028277048 -0700
+++ 25-akpm/kernel/sys.c	2004-10-24 01:47:20.911886072 -0700
@@ -531,8 +531,9 @@ asmlinkage long sys_reboot(int magic1, i
 			return -EINVAL;
 		}
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
-		system_state = SYSTEM_BOOTING;
+		system_state = SYSTEM_RESTART;
 		device_shutdown();
+		system_state = SYSTEM_BOOTING;
 		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
 		machine_kexec(image);
_

> - 3c59x driver together with my 3c509C-TX card hits:
> "ff:ff:ff:ff:ff:ff<3>*** EEPROM MAC address invalid"
> after doing a kexec-reboot. I tried reseting it at bootup but I couldn't
> get it kicking. I couldn't find any specs nor maintainer for this one...
> 

3c59x power management is a bit flakey.  I'll have a poke at this when I
get onto playing with kexec.

