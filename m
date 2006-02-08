Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbWBHPbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWBHPbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWBHPbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:31:13 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:50900 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030430AbWBHPbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:31:12 -0500
Subject: Re: [SCSI] fix wrong context bugs in SCSI
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060208085629.GE4338@suse.de>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
	 <1139342922.6065.12.camel@mulgrave.il.steeleye.com>
	 <20060208085629.GE4338@suse.de>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 09:31:02 -0600
Message-Id: <1139412662.3003.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 09:56 +0100, Jens Axboe wrote:
> Hmm, this (and further up) could fail, yet you don't check.

By and large, you have process context, so this isn't going to be a
problem.

> I don't think this API is very nice to be honest, there's no good way to
> handle failures - you can't just sleep and loop retry the execute if you
> are in_interrupt(). I'd prefer passing in a work_queue_work (with a
> better name :-) that has been allocated at a reliable time during
> initialization.

Yes, I agree ... however, the failure is less prevalent in the new code
than the old.  The problem is that we may need to execute multiple puts
for a single target from irq contex, so under this scheme you need a wqw
(potentially) for every get.

I could solve this by binding the API more tightly into the device
model, so the generic device contains the wqw and it is told that the
release function of the final put must be called in process context, but
that's an awful lot of code changes.

James


