Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269811AbUJMUzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269811AbUJMUzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 16:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269842AbUJMUzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 16:55:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:49111 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269811AbUJMUy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 16:54:56 -0400
Date: Wed, 13 Oct 2004 13:52:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: __put_task_struct unresolved when being used in modules
Message-Id: <20041013135257.11d65704.akpm@osdl.org>
In-Reply-To: <OF59CA9171.69619345-ONC1256F2C.003A7BE2-C1256F2C.003B7F4C@de.ibm.com>
References: <20041013102955.GB30851@infradead.org>
	<OF59CA9171.69619345-ONC1256F2C.003A7BE2-C1256F2C.003B7F4C@de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Spatzier <thomas.spatzier@de.ibm.com> wrote:
>
> Christoph Hellwig <hch@infradead.org> wrote on 13.10.2004 12:29:55:
>  >
>  > In general module shouldn't deal with task reference counts.  If we
>  decide
>  > you have a legitimate reason for doing this from a module after a review
>  here
>  > on lkml we could add an EXPORT_SYMBOL_GPL at the same time your module
>  gets
>  > merged.
>  >
>  The module is actually already in the kernel (drivers/s390/net/qeth.ko).
>  We have a userspace daemon that registers with the kernel module and we
>  need to send a signal to that daemon, whenever the device driver detects
>  some
>  change in its managed devices. This is done in qeth_notify_processes (just
>  in
>  case you want to take a look ;-) ).
>  For this purpose, we store a pointer to the daemon's task_struct, so we can
>  send a signal to that task. However, if the daemon crashes for some reason,
>  we have an invalid task_struct pointer.

Drivers should not be holding references to userspace processes.  Your
daemons should instead be holding references to resources within the
driver.

IOW: the daemon should be holding an open file descriptor and should be
blocked in read() or select/poll waiting for activity on that fd.
