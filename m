Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWHMI6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWHMI6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 04:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWHMI6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 04:58:45 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:40936 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750766AbWHMI6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 04:58:44 -0400
Date: Sun, 13 Aug 2006 04:53:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: oops in close when exiting fsx
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608130455_MC3-1-C7EE-44C7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44DE2EA6.4060809@austin.rr.com>

On Sat, 12 Aug 2006 14:40:22 -0500, Steve French wrote:

> ctl-c exiting fsx after a few hours with 2.6.18-rc4 got the following 
> oops - anyone recognize it?
> Although I didn't see cifs symbols on the call stack it is running on a 
> cifs mount, but it is not
> one I have seen before.

> EIP is at __down+0x56/0xc5

  1a:   8d 43 08                  lea    0x8(%ebx),%eax  <= addr of sema wait queue list_head
  1d:   8b 48 04                  mov    0x4(%eax),%ecx  <= list->prev
  20:   8d 54 24 2c               lea    0x2c(%esp),%edx
  24:   89 50 04                  mov    %edx,0x4(%eax)
  27:   89 44 24 2c               mov    %eax,0x2c(%esp)
   0:   89 11                     mov    %edx,(%ecx)   <===== list->prev->next = new

The semaphore's wait queue head is corrupted: 'prev' is 0.

>  [<c1038908>] mempool_free+0x43/0x46
>  [<c1013678>] default_wake_function+0x0/0xc
>  [<c132ed37>] __down_failed+0x7/0xc
>  [<fa2da685>] .text.lock.file+0x87/0x9a [cifs]      <=====
>  [<c104e807>] __fput+0xab/0x148
>  [<c104c453>] filp_close+0x4e/0x54
>  [<c101773a>] put_files_struct+0x64/0xa6
>  [<c1018581>] do_exit+0x1c7/0x675
>  [<c10052b0>] do_syscall_trace+0x12b/0x172
>  [<c1018a8b>] sys_exit_group+0x0/0xd
>  [<c1002abf>] syscall_call+0x7/0xb

It came from a lock section in the cifs code.  If you disassemble
.text.lock.file in cifs.o, at offset 0x87 (or shortly after) you
will see a jump back to the code that's trying to get the semaphore.

-- 
Chuck

