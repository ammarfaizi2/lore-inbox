Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSFKXer>; Tue, 11 Jun 2002 19:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317256AbSFKXeq>; Tue, 11 Jun 2002 19:34:46 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:18958 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317253AbSFKXep>;
	Tue, 11 Jun 2002 19:34:45 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Athanasius <Athanasius@miggy.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: request_module[net-pf-10]: fork failed, errno 11 
In-Reply-To: Your message of "Tue, 11 Jun 2002 14:42:25 +0100."
             <20020611134225.GD13726@miggy.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jun 2002 09:34:34 +1000
Message-ID: <15923.1023838474@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 14:42:25 +0100, 
Athanasius <Athanasius@miggy.org.uk> wrote:
>  Ok, a little more investigation:
>
>root@bowl:/sbin# cat modprobe-logging 
>#!/bin/sh
>
>echo "`date` `ps axh | wc -l`: $@" >> /var/log/modprobe.log
>exec /sbin/modprobe $@
>root@bowl:/sbin# cat /proc/sys/kernel/modprobe 
>/sbin/modprobe-logging

You do not need a special modprobe.log script.  Just mkdir
/var/log/ksymoops and you will get module logging automatically.  man
insmod, look for ksymoops.

>In /var/log/kern.log:
>Jun 11 14:36:58 bowl kernel: request_module[net-pf-10]: fork failed, errno 11
>
>And in /var/log/modprobe.log:
>
>Tue Jun 11 14:36:41 BST 2002     229: -s -k -- net-pf-10
>Tue Jun 11 14:36:58 BST 2002     228: -s -k -- net-pf-10
>Tue Jun 11 14:36:58 BST 2002     227: -s -k -- net-pf-10
>Tue Jun 11 14:37:02 BST 2002     227: -s -k -- net-pf-10

>/proc/sys/kernel/threads-max is 4095.
>  Note that ulimit -u is 256, but that's per login instance normally and
>I'd not have thought a kernel thread goes through PAM anyway...

This is weird.  'fork failed' is issued when kernel_thread() fails.
This means that the fork() syscall for kernel threads is failing,
before the application has even been started.  The fact that you see
other modprobes working only shows that multiple requests for net-pf-10
were issued and some of them got as far as running modprobe but others
failed.

