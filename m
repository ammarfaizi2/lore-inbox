Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbWDMXWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWDMXWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWDMXWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:22:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965037AbWDMXWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:22:23 -0400
Date: Thu, 13 Apr 2006 16:24:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: [PATCH 2/2] mm: fix mm_struct reference counting bugs in
 mm/oom_kill.c
Message-Id: <20060413162432.41892d3a.akpm@osdl.org>
In-Reply-To: <200604131452.08292.dsp@llnl.gov>
References: <200604131452.08292.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
> The patch below fixes some mm_struct reference counting bugs in
> badness().

hm, OK, afaict the code _is_ racy.

But you're now calling mmput() inside read_lock(&tasklist_lock), and
mmput() can sleep in exit_aio() or in exit_mmap()->unmap_vmas().  So
sterner stuff will be needed.

I'll put a might_sleep() into mmput - it's a bit unexpected.
