Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264774AbUGZBVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbUGZBVi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264781AbUGZBVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:21:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:52380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264774AbUGZBVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:21:36 -0400
Date: Sun, 25 Jul 2004 18:20:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Limit number of concurrent hotplug processes
Message-Id: <20040725182006.6c6a36df.akpm@osdl.org>
In-Reply-To: <40FD23A8.6090409@suse.de>
References: <40FD23A8.6090409@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannes Reinecke <hare@suse.de> wrote:
>
> the attached patch limits the number of concurrent hotplug processes.
>  Main idea behind it is that currently each call to call_usermodehelper 
>  will result in an execve() of "/sbin/hotplug", without any check whether 
>  enough resources are available for successful execution. This leads to 
>  hotplug being stuck and in worst cases to machines being unable to boot.
> 
>  This check cannot be implemented in userspace as the resources are 
>  already taken by the time any resource check can be done; for the same 
>  reason any 'slim' programs as /sbin/hotplug will only delay the problem.

hm, it's a bit sad that this happens.  Are you able to tell us more about
what is causing such an explosion of module probes?

>  Any comments/suggestions welcome; otherwise please apply.

I suggest you just use a semaphore, initialised to a suitable value:


static struct semaphore foo = __SEMAPHORE_INITIALIZER(foo, 50);


{
	...
	down(&foo);
	...
	up(&foo);
	...
}

