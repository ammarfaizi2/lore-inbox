Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWBVBps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWBVBps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWBVBps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:45:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932507AbWBVBpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:45:47 -0500
Date: Tue, 21 Feb 2006 17:44:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: 2.6.16-rc4-mm1 (bugs and lockups)
Message-Id: <20060221174400.4542ccbf.akpm@osdl.org>
In-Reply-To: <43FB5317.60501@aknet.ru>
References: <43FB5317.60501@aknet.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> main.c: moved smp_prepare_boot_cpu() call earlier. This
>  was necessary because otherwise printk() can't print
>  It checks cpu_online(), which returns false. This change
>  is consistent with the UP case, where's the boot CPU is
>  "online" from the very beginning, AFAICS. But again, I am
>  not entirely sure whether this is safe.
> 

Yeah, this is scary.  Early boot is fragile and complex and architectures
might not expect to run smp_prepare_boot_cpu() before setup_arch().

umm, actually it's wrong.  i386's smp_prepare_boot_cpu() diddles with
per-cpu memory, and that's not initialised at that stage.  See the call to
setup_per_cpu_areas() a few lines later.

So I'll drop that hunk.  How important is it in practice?

If it's purely to make printk print something then perhaps we can do
something expedient like:

#ifdef CONFIG_SMP
	cpu_set(smp_processor_id(), cpu_online_map);	/* comment */
#endif

right there in start_kernel()?

(That assumes that smp_processor_id() works at that stage.  Surely that's
true).
