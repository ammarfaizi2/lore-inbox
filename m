Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVFJGmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVFJGmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 02:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVFJGmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 02:42:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262414AbVFJGmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 02:42:53 -0400
Date: Thu, 9 Jun 2005 23:42:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: axboe@suse.de, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Real-time problem due to IO congestion.
Message-Id: <20050609234231.42a10763.akpm@osdl.org>
In-Reply-To: <42A91D36.8090506@lab.ntt.co.jp>
References: <42A91D36.8090506@lab.ntt.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp> wrote:
>
> There are 2 type processes in test environment.
>  1. The real-time needed process (run on with high static priority)
>      The process wake up every 10ms, and wake up, write some log (the
>  test case is current CPU clock via tsc) to the file.
> 
>  2. The process which make IO load
>      The process have large memory size, and kill the process with dumping.
>      The process's memory area exceeds 70% of whole physical
>  RAM.(Actually 1.5GB memory area while whole RAM is 2GB)
> 
>  Whenever during dumping, the real-time needed process sometimes stop for
>  long time during write system call. (sometimes exceeds 1000ms)

The writeback code does attempt to give some preference to realtime tasks
(in get_dirty_limits()), but it can only work up to a point.

Frankly, your application is poorly designed.  If you want sub-10ms
responsiveness you shouldn't be doing disk I/O.  The realtime task should
hand the data off to a non-realtime task for writeout, with suitable
amounts of buffering in between.
