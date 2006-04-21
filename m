Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWDUWH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWDUWH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWDUWH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:07:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750821AbWDUWH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:07:28 -0400
Date: Fri, 21 Apr 2006 15:09:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: kiran@scalex86.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext3 percpu counter fixes to suppport for more than
 2**31 ext3 free blocks counter
Message-Id: <20060421150943.2fdc5c4a.akpm@osdl.org>
In-Reply-To: <1145631546.4478.10.camel@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	<1145631546.4478.10.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> The following patches are to fix the percpu counter issue support more
> than 2**31 blocks for ext3, i.e. allow the ext3 free block accounting
> works with more than 8TB storage.
> 
> [PATCH 1] - Generic perpcu longlong type counter support: global counter
> type changed from long to long long. The local counter is still remains
> 32 bit (long type), so we could avoid doing 64 bit update in most cases.
> Fixed the percpu_counter_read_positive() to handle the  0 value counter
> correctly;Add support to initialize the global counter to a value that
> are greater than 2**32.

I think it would be saner to explicitly specify the size of the field. 
That means using s32 and s64 throughout this code.

That'll actually save space on 64-bit machines, where we're presently doing
alloc_percpu(long) when all we need is alloc_percpu(s32).

We'd need to review all users of this interface to make sure that they
handle the changed sizes appropriately, too.
