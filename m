Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUDVBSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUDVBSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 21:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUDVBSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 21:18:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:12198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263761AbUDVBSt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 21:18:49 -0400
Date: Wed, 21 Apr 2004 18:18:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter =?ISO-8859-1?B?V+RjaHRsZXI=?= <pwaechtler@mac.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] coredump - as root not only if euid switched
Message-Id: <20040421181827.5c2b5405.akpm@osdl.org>
In-Reply-To: <1082575247.3052.21.camel@picklock.adams.family>
References: <1082575247.3052.21.camel@picklock.adams.family>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler <pwaechtler@mac.com> wrote:
>
> While it's more secure to not dump core at all if the program has
>  switched euid, it's also very unpractical. Since only programs 
>  started from root, being setuid root or have CAP_SETUID it's far 
>  more practical to dump as root.root mode 600. This is the bahavior 
>  of Solaris.
> 
>  The current implementation does not ensure that an existing core
>  file is only readable as root, i.e. after dumping the ownership 
>  and mode is unchanged.
> 
>  Besides mm->dumpable to avoid recursive core dumps, on setuid files 
>  the dumpable flag still prevents a core dump while seteuid & co will
>  result in a core only readable as root.

It's a bit sad to add another function call level to sys_unlink() simply
because the core dumping code needs it.

Is it not possible to call sys_unlink() directly from there?  Something like

long kernel_unlink(const char *name)
{
	mm_segment_t old_fs = get_fs();
	long ret;

	set_fs(KERNEL_DS);
	ret = sys_unlink(name);
	set_fs(old_fs);
	return ret;
}	
