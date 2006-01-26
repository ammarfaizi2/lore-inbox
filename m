Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbWAZPML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbWAZPML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 10:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWAZPML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 10:12:11 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:37166 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932345AbWAZPMJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 10:12:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nF1cxe+dJMnaA02fB3bmemCRtDyqUnM9ZoyTZOg/mFFj7Efqv3fNZfI3I5nBu1Zu2NJwu8LyB5WR2larnnhl2GAOXJYunHaLjRnlxmLnkaHWrt76+UEbDqxmNCc7bB48+b7ubDQd1SocCPjf+BuWIeQsJgg6wf2Rl/xEoegoCLg=
Message-ID: <401b11ae0601260712w7cfe88abm638dc7a459b3bb3a@mail.gmail.com>
Date: Thu, 26 Jan 2006 15:12:08 +0000
From: Daniel fernandez <ergot86@gmail.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386 - sys_clone from vsyscall
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200601252247_MC3-1-B6BF-F209@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601252247_MC3-1-B6BF-F209@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your work on the patch

> Your patch almost works but it copies the stack into the parent's address space.
> Using access_process_vm() fixes it.  However, that still leaves unfixed the case
> where vsyscall-int80 is used.

I copy the stack into the parent's address space becuase in this case
the memory is shared, but  access_process_vm() is more elegant :).
About vsyscall-int80, I don't know how to test that case in my
computer but I think a solution could be:

add a INT80H_RETURN symbol:

 .LSTART_vsyscall:
          int $0x80
 .globl INT80H_RETURN
 INT80H_RETURN:
          ret
  .LEND_vsyscall:

and then in process.c:

  int size = 0 ;
  childregs->eax = 0;

    if ((void *)regs->eip == SYSENTER_RETURN)
                size = sizeof(vsyscall_stack) ;
    if ((void *)regs->eip == INT80H_RETURN)
                size = sizeof(unsigned long) ;

       if (regs->esp != esp && size) {
               if (copy_from_user(vsyscall_stack, (void *)regs->esp, size))
                       return -EFAULT;
               if (access_process_vm(p, esp - size, vsyscall_stack,
size, 1) != size)
                       return -EFAULT;
               esp -= size;
       }
       childregs->esp = esp;

I hope somebody can test if it works that way.
Regards
