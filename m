Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUGOE66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUGOE66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 00:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUGOE66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 00:58:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:33774 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263448AbUGOE65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 00:58:57 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] was: [RFC] removal of sync in panic
Date: Thu, 15 Jul 2004 06:58:54 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, lmb@suse.de
References: <200407141745.47107.linux-kernel@borntraeger.net> <200407141939.52316.linux-kernel@borntraeger.net> <20040714143112.1d8d1892.akpm@osdl.org>
In-Reply-To: <20040714143112.1d8d1892.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407150658.54925.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I agree with the patch in principle, but I'd be interested in what
> observed problem motivated it?

see the first posting.

-----------snip--------------
I have seen panic failing two times lately on an SMP system. The box 
panic'ed but was running happily on the other cpus. The culprit of this 
failure is the fact, that these panics have been caused by a block device 
or a filesystem (e.g. using errors=panic). In these cases the  likelihood 
of a failure/hang of  sys_sync() is high. This is exactly what happened in 
both cases I have seen. Meanwhile the other cpus are happily continuing  
destroying data as the kernel has a severe problem but its not aware of 
that as smp_send_stop happens after sys_sync.

I can imagine several changes but I am not sure if this is a problem which 
must be fixed and which fix is the best.
Here are my alternatives:

1. remove sys_sync completely: syslogd and klogd use fsync. No need to help 
them. Furthermore we have a severe problem which is worth a panic, so we 
better dont do any I/O.
2. move smp_send_stop before sys_sync. This at least prevents other cpus of 
doing harm if sys_sync hangs. Here I am not sure if this is really working.
3. Add an 
        if (doing_io())
                printk(KERN_EMERG "In I/O routine - not syncing\n");
check like in_interrupt check. Unfortunately I have no clue how this can be 
achieved and it looks quite ugly.
---------------------
