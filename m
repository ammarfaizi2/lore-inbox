Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVIKQAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVIKQAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVIKQAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:00:42 -0400
Received: from ns666.com ([203.98.189.71]:21975 "EHLO bear.ns666.com")
	by vger.kernel.org with ESMTP id S964823AbVIKQAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:00:41 -0400
Message-ID: <432454B5.8040307@ns666.com>
Date: Sun, 11 Sep 2005 18:00:53 +0200
From: Trilight <trilight@ns666.com>
User-Agent: The X
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: oops occured by dentry being passed in is NULL
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I justed installed 2.6.13.1 (vanilla) on several laptops and a desktop,
the result is an Oops during boot. This is the information after running
ksymoops on the data:


>>EIP; c01dd9d3 <create_dir+13/1b0>   <=====

>>ebx; f7d7ce8c <__crc_pci_request_region+4b951/14beab>
>>edx; f7d7ce8c <__crc_pci_request_region+4b951/14beab>
>>esi; f7d7ce88 <__crc_pci_request_region+4b94d/14beab>
>>edi; f7c4169c <__crc_netlink_register_notifier+3711f1/3dbb2e>
>>ebp; c195fe3c <__crc_unregister_chrdev+329ab/422fd3>
>>esp; c195fe04 <__crc_unregister_chrdev+32973/422fd3>

Trace; c0170a0e <__kernel_text_address+2e/40>
Trace; c013d56b <show_trace+3b/80>
Trace; c01ddbd9 <sysfs_create_dir+39/80>
Trace; c027065f <create_dir+1f/50>
Trace; c02708a0 <kobject_add+50/d0>
Trace; c02db815 <class_device_add+85/1e0>
Trace; c02dba38 <class_device_create+98/c0>
Trace; c02ba278 <vcs_make_devfs+38/80>
Trace; c02c1313 <con_open+83/b0>
Trace; c02b1d9d <tty_open+25d/300>
Trace; c02b1b40 <tty_open+0/300>
Trace; c01aa6a6 <chrdev_open+c6/180>
Trace; c019fbfa <dentry_open+13a/200>
Trace; c019fab8 <filp_open+68/70>
Trace; c019feaf <sys_open+4f/e0>
Trace; c01393d8 <init+d8/1c0>
Trace; c0139300 <init+0/1c0>
Trace; c013a1cd <kernel_thread_helper+5/18>

Code;  c01dd9d3 <create_dir+13/1b0>
00000000 <_EIP>:
Code;  c01dd9d3 <create_dir+13/1b0>   <=====
   0:   c0 89 88 98 00 00 00      rorb   $0x0,0x9888(%ecx)   <=====
Code;  c01dd9da <create_dir+1a/1b0>
   7:   31 c0                     xor    %eax,%eax
Code;  c01dd9dc <create_dir+1c/1b0>
   9:   c3                        ret
Code;  c01dd9dd <create_dir+1d/1b0>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  c01dd9e4 <create_dir+24/1b0>
  11:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi
Code;  c01dd9eb <create_dir+2b/1b0>
  18:   55                        push   %ebp

 <0>Kernel panic - not syncing: Attempted to kill init!


After a lot of help from spender (grsecurity) it seems that the oops
occurs when a NULL dentry is passed. After adding a line of code to
dir.c , recompile and reboot, a bit more detail is seen:

"create_dir passed NULL dentry!" , kernel BUG at fs/sysfs/file.c:383! ,
invalid operand: 0000 [#1] ...

The line of coded we added in dir.c (line 101) was:

if (p == NULL) { printk(KERN_ALERT "create_dir passed NULL dentry!\n");
return 0; }

This happened on a laptop, dell inspiron 5150, p4 w/ht, and a similar
crash happened on a remote server running 2.6.13.1 but i'll get that
information when i can go to the location.

So it seems it's sysfs, where a dir is being created and some how goes
wrong.

I'm not expert at all in kernel debugging or a programmer but if more
info is needed i'll try to gather it.

Thank you !

Trilight
