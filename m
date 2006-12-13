Return-Path: <linux-kernel-owner+w=401wt.eu-S1751071AbWLMVYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWLMVYT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWLMVYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:24:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43579 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbWLMVYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:24:17 -0500
Date: Wed, 13 Dec 2006 13:23:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
Message-Id: <20061213132358.ddcaaaf4.akpm@osdl.org>
In-Reply-To: <457FA840.5000107@hitachi.com>
References: <457FA840.5000107@hitachi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 16:14:08 +0900
"Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com> wrote:

> This patch provides a feature which enables you to specify the memory
> segment types you don't want to dump into a core file. You can specify
> them per process via /proc/<pid>/coremask file. This file represents
> the bitmask of memory segment types which are not written out when the
> <pid> process is dumped. Currently, bit 0 is only available. This
> means anonymous shared memory, which includes IPC shared memory and
> some of mmap(2)'ed memory.
> 
> This patch can be applied against 2.6.19-rc6-mm2, and tested on i386,
> x86_64, and ia64 platforms.
> 
> Here is the background. Some software programs share huge memory among
> hundreds of processes. If a failure occurs on one of these processes,
> they can be signaled by a monitoring process to generate core files
> and restart the service. However, it can develop into a system-wide
> failure such as system slow down for a long time and disk space
> shortage because the total size of the core files is very huge!
> 
> To avoid the above situation we can limit the core file size by
> setrlimit(2) or ulimit(1). But this method can lose important data
> such as stack because core dumping is done from lower address to
> higher address and terminated halfway.
> So I suggest keeping shared memory segments from being dumped for
> particular processes. Because the shared memory attached to processes
> is common in them, we don't need to dump the shared memory every time.
> 
> If you don't want to dump all shared memory segments attached to
> pid 1234, set the bit 0 of the process's coremask to 1:
> 
>   $ echo 1 > /proc/1234/coremask
> 
> Additionally, you can check its hexadecimal value by reading the file:
> 
>   $ cat /proc/1234/coremask
>   00000001
> 
> When a new process is created, the process inherits the coremask
> setting from its parent. It is useful to set the coremask before
> the program runs. For example:
> 
>   $ echo 1 > /proc/self/coremask
>   $ ./some_program

The requirement makes sense, I guess.

Regarding the implementation: if we add

	unsigned char coredump_omit_anon_memory:1;

into the mm_struct right next to `dumpable' then we avoid increasing the
size of the mm_struct, and the code gets neater.


Modification of this field is racy, and we don't have a suitable lock in
mm_struct to fix that.  I don't think we care about that a lot, but it'd be
best to find some way of fixing it.


Really we should convert binfmt_aout.c and any other coredumpers too.


Does this feature have any security implications?  For example, there might
be system administration programs which force a coredump on a "bad"
process, and leave the core somewhere for the administrator to look at. 
With this change, we permit hiding of that corefile's anon memory from the
administrator.  OK, lame example, but perhaps there are better ones.
