Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWI1BiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWI1BiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWI1BiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:38:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965176AbWI1BiV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:38:21 -0400
Date: Wed, 27 Sep 2006 18:35:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
Message-Id: <20060927183507.5ef244f3.akpm@osdl.org>
In-Reply-To: <20060928005830.GA25694@havoc.gtf.org>
References: <20060928005830.GA25694@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 20:58:30 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> The following patch (DO NOT APPLY) illustrates why
> device_for_each_child() should not be marked with __must_check.
> 
> The function returns the return value of the actor function, and ceases
> iteration upon error.
> 
> However, _every_ case in drivers/scsi has a hardcoded return value,
> illustrating how it is quite valid to not check the return value of this
> function.
> 

What does "has a hardcoded return value" mean?

AFICT the problem here is that (for example) (going up the call stack in
the callee->caller direction):

scsi_internal_device_block() returns an error code

but device_block() drops that on the floor

so target_block() drops it on the floor too

so scsi_target_block() drops it on the floor too


It's a small matter of (correct kernel) programming to correctly propagate
the scsi_internal_device_block() error code all the way back out of
scsi_target_block().

It all looks rather sloppy?
