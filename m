Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWDJXET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWDJXET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWDJXET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:04:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932169AbWDJXES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:04:18 -0400
Date: Mon, 10 Apr 2006 15:03:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
       leendert@us.ibm.com
Subject: Re: [PATCH 7/7] tpm: Driver for next generation TPM chips
Message-Id: <20060410150324.4dd55994.akpm@osdl.org>
In-Reply-To: <1144679848.4917.15.camel@localhost.localdomain>
References: <1144679848.4917.15.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall <kjhall@us.ibm.com> wrote:
>
> This patch contains the driver for the next generation of TPM chips
> version 1.2 including support for interrupts.  The Trusted Computing
> Group has written the TPM Interface Specification (TIS) which defines a
> common interface for all manufacturer's 1.2 TPM's thus the name
> tpm_tis.
> 
> This updated version of the patch uses the new sysfs files that came
> about from the comments and changes in patch 6/7.  It replaces the 7/7
> patch from the original set.
> 
> Signed-off-by: Leendert van Doorn <leendert@watson.ibm.com>
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>

I've assumed that Leendert is the author of this driver.  If incorrect,
please let me know.  If correct then the way in which we indicate that is
to put a From: line right at the top of the changelog.

> +		interruptible_sleep_on_timeout(&chip->vendor.int_queue,
> +					       HZ *
> +					       chip->vendor.timeout_a /
> +					       1000);
>
> ...
>
> +		interruptible_sleep_on_timeout(queue, HZ * timeout / 1000);

Please don't use the sleep_on functions.  They are racy unless (iirc) both
the waker and wakee are holding lock_kernel().  If the race hits, we miss a
wakeup.

These should be converted to the not-racy wait_event_interruptible().
