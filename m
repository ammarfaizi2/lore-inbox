Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWCQJ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWCQJ67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWCQJ67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:58:59 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:37530 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751212AbWCQJ67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:58:59 -0500
Date: Fri, 17 Mar 2006 15:28:58 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Balbir Singh <balbir@in.ibm.com>
Cc: emist emist <emistz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops-jprobe
Message-ID: <20060317095858.GA855@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060317025519.GA32497@in.ibm.com> <661de9470603170131j7580d8ccr9927a600a7184ef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661de9470603170131j7580d8ccr9927a600a7184ef3@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >DEVPATH=/module/sysensor SUBSYSTEM=module[17192146.124000] Unable to
> > >handle kernel paging request at virtual address 080c9566
> 
> The address looks like a user space address. Since sys_open() passes
> user space arguments - in this case a pointer to the filename. Are you
> derefencing the pointer correctly?
> 
> I think the handler should first copy_from_user().

User must not call copy_from_user() in the handler, since preemption is
disabled and the copy_from_user might cause a page fault that might
sleep if the user page is not in the memory. Although the latest patch
posted on lkml tries to fixup the exception, it may some
times not succeed and the data collected might be incorrect.

> 
> Moreover your stack is
> [17192146.124000] Call Trace:
> [17192146.124000]  [<c01c6384>] vscnprintf+0x17/0x24
> [17192146.124000]  [<c0116c7d>] vprintk+0x62/0x22a
> [17192146.124000]  [<c02a8682>] int3+0x1e/0x24
> [17192146.124000]  [<c0116c18>] printk+0xe/0x11
> [17192146.124000]  [<e05610ac>] jsys_open+0x1d/0x28 [sysensor]
> [17192146.124000]  [<c0102cef>] sysenter_past_esp+0x54/0x75
> [17192146.124000] Code: 77 03 c6 03 20 4d 43 85 ed 7f f1 e9 9e 01 00
> 00 89 f0 89 fa 83 c6 04 8b 08 b8 19 14 2d c0 81 f9 ff 0f 00 00 0f 46
> c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10
> 89 c7 75
> 
> and in the code posted, there is no printk in jsys_open(). Have you
> sent a revised version of your probe module?

Also from the above stack trace, looks like you had a int3 elsewhere(in printk)
also when jsys_open() was executed.

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
