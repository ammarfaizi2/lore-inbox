Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVDFRs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVDFRs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVDFRs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:48:28 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:38040 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262262AbVDFRsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:48:21 -0400
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050329120311.GO16636@suse.de>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com>
	 <20050329120311.GO16636@suse.de>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 11:27:20 -0500
Message-Id: <1112804840.5476.16.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 14:03 +0200, Jens Axboe wrote:
> It is quite a serious problem, not just for CFQ. SCSI referencing is
> badly broken there.

OK ... I accept that with regard to the queue lock.

However, rather than trying to work out a way to tie all the refcounted
objects together, what about the simpler solution of making the lock
bound to the lifetime of the queue?

As far as SCSI is concerned, we could simply move the lock into the
request_queue structure and everything would work since the device holds
a reference to the queue.  The way it would work is that we'd simply
have a lock in the request_queue structure, but it would be up to the
device to pass it in in blk_init_queue.  Then we'd alter the scsi_device
sdev_lock to be a pointer to the queue lock?  This scheme would also
work for the current users who have a global lock (they simply wouldn't
use the lock int the request_queue).

The only could on the horizon with this scheme is that there may
genuinely be places where we want multiple queues to share a non-global
lock:  situations where we have shared issue queues (like IDE), or
shared tag resources are a possibility.  To cope with those, we'd
probably have to have a separately allocated, reference counted lock.

However, I'm happy to implement the simpler solution (lock in
requuest_queue) if you agree.

James


James


