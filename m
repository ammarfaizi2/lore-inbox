Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278485AbRJPBdp>; Mon, 15 Oct 2001 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278487AbRJPBdg>; Mon, 15 Oct 2001 21:33:36 -0400
Received: from linux.ee.tku.edu.tw ([163.13.132.68]:32777 "HELO
	linux.ee.tku.edu.tw") by vger.kernel.org with SMTP
	id <S278485AbRJPBdb>; Mon, 15 Oct 2001 21:33:31 -0400
Date: Tue, 16 Oct 2001 17:52:12 +0800 (CST)
From: Gian-Yan Xu <kids@linux.ee.tku.edu.tw>
To: Monty Vanderbilt <mvb@amazon.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: ptrace bug
In-Reply-To: <ALEMKFGKCDJNAGAJHLLLOEEFCEAA.mvb@amazon.com>
Message-ID: <Pine.LNX.4.21.0110161739320.12579-100000@linux.ee.tku.edu.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Monty Vanderbilt wrote:

> I don't think the problem is what you identified.
> arch/i386/kernel/ptrace.c:getreg() takes the extra FS,GS offsets into
> account and performs special handling for them. I suspect this is because
> they are not stable per-thread registers and not saved into the register
> structure on an interrupt or system call.

Before the reply, I dont examin getreg() carefully. But now, I still
believe the bug is exist. see the blow (ptrace.c case PTRACE_GETREGS):

    for ( i = 0; i < FRAME_SIZE*sizeof(long); i += sizeof(long) ) {
            __put_user(getreg(child, i),(unsigned long *) data);
            data += sizeof(long);
    }

when i = FS*sizeof(long), the getreg() return child->thread.fs,
and the value will be copy into *data of user-space, but
*data is point to orig_eax of struct pt_regs.

So, when i = ORIG_EAX*sizeof(long), even getreg() adjust his regno,
that let us get accurate registers, but it copy value into wrong member of
struct pt_regs ( the *data is point to xcs member, not orig_eax member,
because the line: data += sizeof(long); never be adjust)

If we dont modify struct pt_regs, maybe we should fix the ptrace.c?

> 
> ptrace.c:getreg() ...
> 	switch (regno >> 2) {
> 		case FS:
> 			retval = child->thread.fs;
> 			break;
> 		case GS:
> 			retval = child->thread.gs;
> 			break;
> 		case DS:
> 		case ES:
> 		case SS:
> 		case CS:
> 			retval = 0xffff;
> 			/* fall through */
> 		default:
> 			if (regno > GS*4)				// *** Adusts for missing FS,GS fields *** //
> 				regno -= 2*4;
> 			regno = regno - sizeof(struct pt_regs);
> 			retval &= get_stack_long(child, regno);
> 	}
> 

-- 
Best regards,
Gian-Yan Xu.


