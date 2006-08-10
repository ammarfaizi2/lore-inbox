Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWHJRfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWHJRfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWHJRfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:35:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57321 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422644AbWHJRfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:35:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Seokmann Ju <sju@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi : megaraid_{mm, mbox} : irq data type fix
References: <1155228887.6698.7.camel@dhcp-65-957.se.lsil.com>
Date: Thu, 10 Aug 2006 11:34:40 -0600
In-Reply-To: <1155228887.6698.7.camel@dhcp-65-957.se.lsil.com> (Seokmann Ju's
	message of "Thu, 10 Aug 2006 12:54:47 -0400")
Message-ID: <m1vep01olr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seokmann Ju <sju@lsil.com> writes:

> This patch fixes incorrect irq data type in the driver which led driver
> initialization failure in some cases.
> The problem was reported by Eric @. Biederman <ebiederm@xmission.com>.

We have a race going on, I read your first message then this one pops up.
But I will reply again for wider distribution.

Nacked-by: Eric Biederman.

The problem is that struct mcontroller is exported to user space
and is a packed structure so it has no free bytes.

Therefore you will break user space when you add bytes in the
middle of your structure.  We can't do that.  You either need
to add an extra field at the end (while keeping the structure size the
same) or you need to add a new ioctl that gets this information correct,
or you need to give up entirely on the idea of exporting the irq
number to user space this way.

What you need not to do is break the kernel<->user space ABI.  That
is just confusing and couples the kernel and user space in unpleasant
ways.

I believe struct mraid_hba_info has the same problem but I could not
see where it was exported to user space.

Eric
