Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUDPUsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbUDPUsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:48:06 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:65450 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263806AbUDPUqx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:46:53 -0400
Date: Fri, 16 Apr 2004 13:46:51 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make stack executable on demand?
Message-ID: <20040416204651.GA24194@lucon.org>
References: <20040416170915.GA20260@lucon.org> <1082145778.9600.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1082145778.9600.6.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:02:58PM +0200, Arjan van de Ven wrote:
> >  But it will either fail if
> > kernel is set with non-executable stack,
> 
> eh no. mprotect with prot_exec is still supposed to work. The stacks
> still have MAY_EXEC attribute, just not the actual EXEC attribute

Ok. It looks like a bug in Red Hat EL 3 kernel. In fs/exec.c, there
are

                if (executable_stack)
                        mpnt->vm_flags = VM_STACK_FLAGS | VM_MAYEXEC | VM_EXEC;
		else
                        mpnt->vm_flags = VM_STACK_FLAGS & ~(VM_MAYEXEC|VM_EXEC); 

That is if an executabl is not marked with executable stack, the
VM_MAYEXEC bit is turned off. But 2.6.5-mm6 has

                if (unlikely(executable_stack == EXSTACK_ENABLE_X))
                        mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
                else if (executable_stack == EXSTACK_DISABLE_X)
                        mpnt->vm_flags = VM_STACK_FLAGS & ~VM_EXEC;
                else
                        mpnt->vm_flags = VM_STACK_FLAGS;
  
The VM_MAYEXEC bit is untouched. Now the question is if it is a good
idea for user to change stack permission.


H.J.
