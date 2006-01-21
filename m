Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWAUHZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWAUHZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 02:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWAUHZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 02:25:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751033AbWAUHZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 02:25:18 -0500
Date: Fri, 20 Jan 2006 23:25:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tvec_bases too large for per-cpu data
Message-Id: <20060120232500.07f0803a.akpm@osdl.org>
In-Reply-To: <43CE4C98.76F0.0078.0@novell.com>
References: <43CE4C98.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> The biggest arch-independent consumer is tvec_bases (over 4k on 32-bit
>  archs,
>  over 8k on 64-bit ones), which now gets converted to use dynamically
>  allocated
>  memory instead.

ho hum, another pointer hop.

Did you consider using alloc_percpu()?


The patch does trickery in init_timers_cpu() which, from my reading, defers
the actual per-cpu allocation until the second CPU comes online. 
Presumably because of some ordering issue which you discovered.  Readers of
the code need to know what that issue was.

And boot_tvec_bases will always be used for the BP, and hence one slot in
the per-cpu array will forever be unused.  Until the BP is taken down and
brought back up, in which case it will suddenly start to use a dynamically
allocated structure.

But all of this modification was unchangelogged and is uncommented, so I'm
somewhat guessing here.  Please always ensure that tricksy things like this
have complete covering comments.

Also, the new code would appear to leak one tvec_base_t per cpu-unplugging?
