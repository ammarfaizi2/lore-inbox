Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936680AbWLCIqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936680AbWLCIqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 03:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936682AbWLCIqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 03:46:37 -0500
Received: from il.qumranet.com ([62.219.232.206]:13986 "EHLO il.qumranet.com")
	by vger.kernel.org with ESMTP id S936680AbWLCIqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 03:46:36 -0500
Message-ID: <45728EE9.1060208@qumranet.com>
Date: Sun, 03 Dec 2006 10:46:33 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Thomas Tuttle <thinkinginbinary@gmail.com>
CC: Avi Kivity <avi@qumranet.com>, Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Yaniv Kamay <yaniv@qumranet.com>
Subject: Re: 2.6.19-rc6-mm2
References: <20061128020246.47e481eb.akpm@osdl.org>	<20061129002411.GA1178@lion> <20061128165328.fd17d085.akpm@osdl.org> <456D1807.1000603@qumranet.com>
In-Reply-To: <456D1807.1000603@qumranet.com>
Content-Type: multipart/mixed;
 boundary="------------000409020409090608040006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409020409090608040006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Avi Kivity wrote:
> Andrew Morton wrote:
>> On Tue, 28 Nov 2006 19:24:45 -0500
>> Thomas Tuttle <thinkinginbinary@gmail.com> wrote:
>>
>>  
>>> I've found a couple of bugs so far...
>>>
>>> 1. I did `modprobe kvm' and then tried running a version of the KVM 
>>> Qemu
>>> compiled for a different kernel.  My mistake.  But I got an oops:
>>>
>>> BUG: unable to handle kernel NULL pointer dereference at virtual 
>>> address 00000008
>>> Code: 14 0f 87 77 02 00 00 8b 0c b5 00 15 20 f9 85 c9 0f 84 68 02 00 
>>> 00 89 ea 89 f8 ff d1 85 c0 0f 84 4c 02 00 00 89 f8 e8 31 e9 ff ff 
>>> <65> a1 08 00 00 00 8b 40 04 8b 40 08 a8 04 0f 85 ae 02 00 00 e8 
>>> EIP: [<f91f9c3f>] kvm_vmx_return+0xef/0x4d0 [kvm] SS:ESP 0068:e5a4fd54
>>>
>>>     
>
> 65 a1 08 00 00 00       mov    %gs:0x8,%eax
>
> kvm isn't restoring gs properly.
>
> I'll look into it.

This comes from the pda patches.

Does the attached patch fix it?


-- 
error compiling committee.c: too many arguments to function


--------------000409020409090608040006
Content-Type: text/x-patch;
 name="kvm-load-i386-segment-bases.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-load-i386-segment-bases.patch"

diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/kvm_main.c /home/avi/kvm-release/kernel/kvm_main.c
--- linux-2.6/drivers/kvm/kvm_main.c	2006-12-03 10:43:09.000000000 +0200
+++ linux-2.6/drivers/kvm/kvm_main.c	2006-12-03 10:42:36.000000000 +0200
@@ -90,6 +90,9 @@
 	typedef unsigned long ul;
 	unsigned long v;
 
+	if (selector == 0)
+	    return 0;
+
 	asm ("sgdt %0" : "=m"(gdt));
 	table_base = gdt.base;
 
diff -X /home/avi/kvm/linux-2.6/Documentation/dontdiff --exclude=Makefile -ru /home/avi/kvm/linux-2.6/drivers/kvm/vmx.c /home/avi/kvm-release/kernel/vmx.c
--- linux-2.6/drivers/kvm/vmx.c	2006-12-03 10:43:09.000000000 +0200
+++ linux-2.6/drivers/kvm/vmx.c	2006-12-03 10:41:44.000000000 +0200
@@ -1702,6 +1702,9 @@
 #ifdef __x86_64__
 	vmcs_writel(HOST_FS_BASE, read_msr(MSR_FS_BASE));
 	vmcs_writel(HOST_GS_BASE, read_msr(MSR_GS_BASE));
+#else
+	vmcs_writel(HOST_FS_BASE, segment_base(fs_sel));
+	vmcs_writel(HOST_GS_BASE, segment_base(gs_sel));
 #endif
 
 	if (vcpu->irq_summary &&

--------------000409020409090608040006--
