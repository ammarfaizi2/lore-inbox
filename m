Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbTJJDzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 23:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTJJDzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 23:55:16 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:62724 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262429AbTJJDzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 23:55:11 -0400
Date: Fri, 10 Oct 2003 01:03:14 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in init_i82365 wrt sysfs
Message-ID: <20031010040314.GB9668@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Russell King <rmk@arm.linux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031010035940.GA9668@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010035940.GA9668@conectiva.com.br>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 10, 2003 at 12:59:40AM -0300, Arnaldo C. Melo escreveu:
> Unable to handle kernel NULL pointer dereference at virtual address 00000010
>  printing eip:
> c0192fc9
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    1
> EIP:    0060:[<c0192fc9>]    Not tainted
> EFLAGS: 00010282
> EIP is at sysfs_add_file+0x9/0xa0
> eax: 00000000   ebx: 0000023c   ecx: 00000001   edx: c2817ff0
> esi: 00000001   edi: 00000000   ebp: c0d89f70   esp: c0d89f64
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 481, threadinfo=c0d88000 task=c0e759b0)
> Stack: 0000023c 00000001 c2817fe8 c0d89f80 c01dbf4c 00000000 c2817154 c0d89fa0
>        c2805188 c2817fe8 c2817154 00000000 c029e8b8 c0d88000 c28172e0 c0d89fbc
>        c0139cff 0804e738 0804e738 0804e738 0804e0e0 00000000 c0d88000 c0109897
> Call Trace:
>  [<c01dbf4c>] class_device_create_file+0x1c/0x30
>  [<c2805188>] init_i82365+0xe8/0x1e8 [i82365]
>  [<c0139cff>] sys_init_module+0x15f/0x2f0
>  [<c0109897>] syscall_call+0x7/0xb
> 
> Code: 8b 77 10 6a 77 68 ab 88 27 c0 e8 e8 a2 f8 ff 8d 5e 70 58 89

Sorry, hit the send key too fast, here is what I researched:

We should use the same approach net/core/net-sysfs.c is using, i.e:

static struct class net_class = {
        .name = "net",
        .release = netdev_release,
#ifdef CONFIG_HOTPLUG
        .hotplug = netdev_hotplug,
#endif
};

.
.
.

        class_dev->class = &net_class;
        class_dev->class_data = net;

Adjusted to pcmcia, of course, its late here, going to bed, tomorrow I'll
try to fix this one, if nobody beats me to it, I'll be happy to test patches
done while I'm asleep 8)

- Arnaldo
