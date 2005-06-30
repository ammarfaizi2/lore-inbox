Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVF3Q7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVF3Q7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbVF3Q5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:57:50 -0400
Received: from siaag1aa.compuserve.com ([149.174.40.3]:39570 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263017AbVF3Q4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:56:55 -0400
Date: Thu, 30 Jun 2005 12:53:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Handle kernel page faults using task gate
To: Ingo Molnar <mingo@elte.hu>
Cc: eliad lubovsky <eliadl@013.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200506301256_MC3-1-A31A-142@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2005 at 09:11:01 +0200, Ingo Molnar wrote:

> * eliad lubovsky <eliadl@013.net> wrote:
> 
> > How do I clear the 'busy' bit?
> > I set my TSS descriptor with
> > __set_tss_desc(cpu, GDT_ENTRY_PAGE_FAULT_TSS, &pagefault_tss);
> 
> i suspect you have to clear the busy bit in the pagefault handler 
> itself. The CPU marks it as busy upon fault. I guess it would be OK to 
> just do the above __set_tss_desc() for _every_ pagefault, that too will 
> clear the busy bit, but you are probably better off just clearing that 
> bit manually:
> 
>     cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;


  Tasks are not reentrant.  Clearing the busy bit could let a second
instance of the handler overwrite the stack of the current one.

  Since recursive page faults should never occur, this should be OK.
Each CPU needs its own TSS for concurrent fault handling on SMP, though.


--
Chuck
