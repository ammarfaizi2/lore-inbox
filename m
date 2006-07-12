Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWGLGm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWGLGm5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWGLGm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:42:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29914 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750748AbWGLGm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:42:57 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: David Miller <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: sparse annotation question 
In-reply-to: Your message of "Tue, 11 Jul 2006 23:14:09 MST."
             <20060711.231409.121242621.davem@davemloft.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jul 2006 16:42:44 +1000
Message-ID: <28491.1152686564@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller (on Tue, 11 Jul 2006 23:14:09 -0700 (PDT)) wrote:
>From: Keith Owens <kaos@ocs.com.au>
>Date: Wed, 12 Jul 2006 15:47:03 +1000
>
>> func (long regno, unsigned long *contents)
>> {
>> 	unsigned long i, *bsp;
>> 	mm_segment_t old_fs;
>> 	bsp = <expression involving only kernel variables>;
>> 	old_fs = set_fs(KERNEL_DS);
>> 	for (i = 0; i < (regno - 32); ++i)
>> 		bsp = ia64_rse_skip_regs(bsp, 1);
>> 	put_user(*contents, bsp);
>> 	set_fs(old_fs);
>> }
>> 
>> sparse is complaining that the second parameter to put_user() is not
>> marked as __user.  How do I tell sparse to ignore this case?  Marking
>> bsp as __user does not work, sparse then complains about incorrect type
>> in assignment (different address spaces).
>
>Since, in this case, you "know what you are doing" you can force the
>matter by using the __force keyword as well as __user.

I tried various combinations of __force, but kept getting this:

warning: incorrect type in argument 1 (different address spaces)
   expected unsigned long *addr
   got unsigned long [noderef] [force] *[addressable] bsp<asn:1>

What finally worked was

 	unsigned long i, *bsp, __user *ubsp;
	...
	ubsp = (unsigned long __user *) bsp;
	put_user(*contents, ubsp);

