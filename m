Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWHRLkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWHRLkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWHRLkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:40:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38874 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030207AbWHRLkf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:40:35 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [RFC][PATCH 4/7] UBC: syscalls (user interface)
Date: Fri, 18 Aug 2006 13:40:30 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
References: <44E33893.6020700@sw.ru> <44E33C3F.3010509@sw.ru>
In-Reply-To: <44E33C3F.3010509@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608181340.31773.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 17:39, Kirill Korotaev wrote:
> --- ./include/asm-powerpc/systbl.h.arsys        2006-07-10 12:39:19.000000000 +0400
> +++ ./include/asm-powerpc/systbl.h      2006-08-10 17:05:53.000000000 +0400
> @@ -304,3 +304,6 @@ SYSCALL_SPU(fchmodat)
>  SYSCALL_SPU(faccessat)
>  COMPAT_SYS_SPU(get_robust_list)
>  COMPAT_SYS_SPU(set_robust_list)
> +SYSCALL(sys_getluid)
> +SYSCALL(sys_setluid)
> +SYSCALL(sys_setublimit)
...
> --- ./include/asm-x86_64/unistd.h.ubsys 2006-07-10 12:39:19.000000000 +0400
> +++ ./include/asm-x86_64/unistd.h       2006-07-31 16:00:01.000000000 +0400
> @@ -619,10 +619,16 @@ __SYSCALL(__NR_sync_file_range, sys_sync
>  __SYSCALL(__NR_vmsplice, sys_vmsplice)
>  #define __NR_move_pages                279
>  __SYSCALL(__NR_move_pages, sys_move_pages)
> +#define __NR_getluid           280
> +__SYSCALL(__NR_getluid, sys_getluid)
> +#define __NR_setluid           281
> +__SYSCALL(__NR_setluid, sys_setluid)
> +#define __NR_setublimit                282
> +__SYSCALL(__NR_setublimit, sys_setublimit)
>  
...
> +/*
> + *     The setbeanlimit syscall
> + */
> +asmlinkage long sys_setublimit(uid_t uid, unsigned long resource,
> +               unsigned long *limits)

While I don't yet understand what this call does, it looks to me that
the way it's implemented breaks in 32 bit emulation mode on x86_64 and
powerpc.

You either need to pass a pointer a something that is the same on 32 and
64 bit (e.g. __u64 __user *limits), or need to provide a different
entry point for 32 bit applications:

long compat_sys_setublimit(compat_uid_t uid, compat_ulong_t resource,
				compat_ulong_t __user *limits);

You should also add the prototypes to include/linux/syscalls.h.

	Arnd <><
