Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTJILLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTJILLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:11:12 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9923 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262095AbTJILLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:11:07 -0400
Date: Thu, 9 Oct 2003 16:46:24 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: 2.6.0-test6-mm4 - oops in __aio_run_iocbs()
Message-ID: <20031009111624.GA11549@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031005013326.3c103538.akpm@osdl.org> <1065655095.1842.34.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065655095.1842.34.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 04:18:15PM -0700, Daniel McNeil wrote:
> I'm been testing AIO on test6-mm4 using a ext3 file system and
> copying a 88MB file to an already existing preallocated file of 88MB.
> I been using my aiocp program to copy the file using i/o sizes of
> 1k to 512k and outstanding aio requests of between 1 and 64 using
> O_DIRECT, O_SYNC and O_DIRECT & O_SYNC.  Everything works as long
> as the file is pre-allocated.  When copying the file to a new file
> (O_CREAT|O_DIRECT), I get the following oops:

What are the i/o sizes and block sizes for which you get the oops ?
Is this only for large i/o sizes ?

__aio_run_iocbs should have been called only for buffered i/o, 
so this sounds like an O_DIRECT fallback to buffered i/o.
Possibly after already submitting some blocks direct to BIO,
the i/o completion path for which ends up calling aio_complete
releasing the iocb. That could explain the use-after-free situation
you see.

But, O_DIRECT write should fallback to buffered i/o only if it 
encounters holes in the middle of the file, not for simple appends 
as in your case. Need to figure out how this could have happened ...

Could you try placing a few printks to find out if this is 
the case or if we need to look elsewhere ?

Regards
Suparna


> 
> 
> Unable to handle kernel paging request at virtual address 6b6b6b6b
>  printing eip:
> c018fa34
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> CPU:    1
> EIP:    0060:[<c018fa34>]    Not tainted VLI
> EFLAGS: 00010002
> EIP is at __aio_run_iocbs+0x19/0xa2
> eax: 00000000   ebx: d443b318   ecx: d4055c78   edx: 6b6b6b6b
> esi: d4055c78   edi: d4055cb0   ebp: dfd6df48   esp: dfd6df34
> ds: 007b   es: 007b   ss: 0068
> Process aio/1 (pid: 16, threadinfo=dfd6c000 task=dfd71340)
> Stack: 00010000 dfd71914 d4055c78 d4055c9c dfd72790 dfd6df68 c018faf6 d4055c78
>        dfd6df54 dfd6df54 dfd6c000 d4055cfc 00000287 dfd6dfec c0138ad8 d4055c78
>        dfd6dfa0 00000000 5a5a5a5a dfd727b8 dfd727a8 d4055c78 c018fabd dfd727a0
> 
> Call Trace:
>  [<c018faf6>] aio_kick_handler+0x39/0x96
>  [<c0138ad8>] worker_thread+0x1e6/0x346
>  [<c018fabd>] aio_kick_handler+0x0/0x96
>  [<c0122041>] default_wake_function+0x0/0x2e
> 
> 
> Daniel
> 

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

