Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269672AbUJMKvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbUJMKvr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 06:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269673AbUJMKvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 06:51:46 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:28884 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S269672AbUJMKvo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 06:51:44 -0400
In-Reply-To: <20041013102955.GB30851@infradead.org>
Subject: Re: __put_task_struct unresolved when being used in modules
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF59CA9171.69619345-ONC1256F2C.003A7BE2-C1256F2C.003B7F4C@de.ibm.com>
From: Thomas Spatzier <thomas.spatzier@de.ibm.com>
Date: Wed, 13 Oct 2004 12:49:52 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 13/10/2004 12:51:36
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Christoph Hellwig <hch@infradead.org> wrote on 13.10.2004 12:29:55:
>
> In general module shouldn't deal with task reference counts.  If we
decide
> you have a legitimate reason for doing this from a module after a review
here
> on lkml we could add an EXPORT_SYMBOL_GPL at the same time your module
gets
> merged.
>
The module is actually already in the kernel (drivers/s390/net/qeth.ko).
We have a userspace daemon that registers with the kernel module and we
need to send a signal to that daemon, whenever the device driver detects
some
change in its managed devices. This is done in qeth_notify_processes (just
in
case you want to take a look ;-) ).
For this purpose, we store a pointer to the daemon's task_struct, so we can
send a signal to that task. However, if the daemon crashes for some reason,
we have an invalid task_struct pointer. If we had a counted reference, we
could check the state of the task before signaling. In case of the task
being gone, we would release our reference.
We had another idea for solving the problem: is there a possibility that
our module gets notified when the task dies, i.e. is there a notifier_chain
defined for task states? In that case we could do the cleanup of our
notifier list when we receive the notification.

Thomas

