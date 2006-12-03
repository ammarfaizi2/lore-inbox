Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759691AbWLCVGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759691AbWLCVGs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760098AbWLCVGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:06:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759691AbWLCVGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:06:47 -0500
Date: Sun, 3 Dec 2006 13:02:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce put_pid_rcu() to fix unsafe
 put_pid(vc->vt_pid)
Message-Id: <20061203130237.761bb15d.akpm@osdl.org>
In-Reply-To: <20061201234826.GA9511@oleg>
References: <20061201234826.GA9511@oleg>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 02:48:26 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> drivers/char/vt_ioctl.c changes vc->vt_pid doing
> 
> 	put_pid(xchg(&vc->vt_pid, ...));
> 
> This is unsafe, put_pid() can actually free the memory while vc->vt_pid is
> still used by kill_pid(vc->vt_pid).
> 
> Add a new helper, put_pid_rcu(), which frees "struct pid" via rcu callback
> and convert vt_ioctl.c to use it.
> 


I'm a bit reluctant to go adding more tricky infrastructure (especially
100% undocumented infrastructure) on behalf of a single usage site in a
place as creepy as the VT ioctl code.

If we envisage future users of this infrastructure (and if it gets
documented) then OK.  Otherwise I'd rather just stick another bandaid into
the vt code.  Can we add some locking there, or change it to use a
task_struct* or something?
