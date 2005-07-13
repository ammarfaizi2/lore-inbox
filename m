Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVGMBSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVGMBSm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVGMBSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:18:42 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:33520
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262525AbVGMBSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:18:41 -0400
Subject: System call registration mess?
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Jul 2005 03:18:32 +0200
Message-Id: <1121217512.17472.93.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to register a new system call and notice that on several
architectures there is some inconsistency between the system call table
and unistd.h, e.g. (2.6.13-rc2):

in arch/arm/kernel/calls.S:
...
/* 310 */       .long   sys_request_key
                .long   sys_keyctl
                .long   sys_semtimedop
__syscall_end:
...

and in include/asm-arm/unistd.h:
...
#define __NR_request_key                (__NR_SYSCALL_BASE+310)
#define __NR_keyctl                     (__NR_SYSCALL_BASE+311)

#if 0 /* reserved for un-muxing ipc */
#define __NR_semtimedop                 (__NR_SYSCALL_BASE+312)
#endif

#define __NR_vserver                    (__NR_SYSCALL_BASE+313)

/*
 * The following SWIs are ARM private.
 */
#define __ARM_NR_BASE                   (__NR_SYSCALL_BASE+0x0f0000)
...


So it seems that sys_vserver is not declared in the system call table.
Is there any reason for this inconsistency or is this a bug and should
be fixed? If second, should there be something like
.long       sys_ni_syscall           /* reserved for vserver */
 or
.long       sys_vserver
in the syscall table?

Similar inconsistencies can be found in other architecture subtrees,
e.g. in arm26:

arch/arm26/kernel/calls.S:
...
/* 235 */       .long   sys_removexattr
                .long   sys_lremovexattr
                .long   sys_fremovexattr
                .long   sys_tkill
__syscall_end:
...

in include/asm-arm26/unistd.h there is a whole bunch of calls that are
not registered in the system call table:

#define __NR_tkill                      (__NR_SYSCALL_BASE+238)
#define __NR_sendfile64                 (__NR_SYSCALL_BASE+239)
#define __NR_futex                      (__NR_SYSCALL_BASE+240)
...
#define __NR_mq_notify                  (__NR_SYSCALL_BASE+278)
#define __NR_mq_getsetattr              (__NR_SYSCALL_BASE+279)
#define __NR_waitid                     (__NR_SYSCALL_BASE+280)

Should they all get filled up with sys_ni_syscall definitions or with 
their corresponding entries so I can enter my own syscall at the bottom
with correct numbering or what is the proper way to register a new 
syscall in these cases?

Thanks,
Wieland

