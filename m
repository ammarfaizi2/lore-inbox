Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWJMMOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWJMMOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWJMMOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:14:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12444 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751643AbWJMMOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:14:36 -0400
Message-ID: <452F8364.9050803@in.ibm.com>
Date: Fri, 13 Oct 2006 17:45:32 +0530
From: Chandru <chandru@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 Red Hat/1.0.5-0.1.el4 SeaMonkey/1.0.5
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC]: Possible race condition on an SMP between proc_lookupfd
 and tasks on other cpus
References: <452CB67A.4070702@in.ibm.com> <m1hcy9ib95.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1hcy9ib95.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> You certain seem to be in one of the proc stress conditions so this
> may not be a unique bug.
>
> Digging through the disassembly and figuring out which access you died
> on would be interesting, so we could know with precision which part
> of tid_fd_revalidate we are dying in.  My ppc64 isn't good enough 
> especially without the matching binaries to figure that out though.
> All I know is that you are about 25 instructions into
> tid_fd_revalidate.
>   
 From the disassembly in xmon, the code that failed while running was in 
fcheck_files() called from tid_fd_revalidate()

f:mon> di c0000000001351e0
c0000000001351e0  800b0000      lwz     r0,0(r11)    <<<<<------ PC
c0000000001351e4  7f804840      cmplw   cr7,r0,r9
c0000000001351e8  409d00e0      ble     cr7,c0000000001352c8    #
.tid_fd_revalidate+0x14c/0x220
c0000000001351ec  e96b0008      ld      r11,8(r11)
c0000000001351f0  79291f24      rldicr  r9,r9,3,60
c0000000001351f4  7c09582a      ldx     r0,r9,r11
c0000000001351f8  2fa00000      cmpdi   cr7,r0,0
c0000000001351fc  419e00cc      beq     cr7,c0000000001352c8    #


r11 gets loaded with 'fdt'  as in  struct fdtable *fdt = 
files_fdtable(files);

include/linux/file.h:97
             b3c:       e9 6a 00 08     ld      r11,8(r10)

Following are the register contents...

f:mon> r
R00 = c0000000001351cc   R16 = 00000000fae9f35a
R01 = c0000000eaa1b710   R17 = 0000000010020000
R02 = c00000000056cd20   R18 = 00000000fae9f15a
R03 = c00000018b5f89a0   R19 = 00000000fae9e966
R04 = c0000001e172cb80   R20 = 00000000fae9e95a
R05 = c0000001349e88f8   R21 = 0000000010030000
R06 = c00000018b5f8ca0   R22 = 00000000fae9e968
R07 = 000000007fffffff   R23 = c0000000105e3920
R08 = 0000000000135075   R24 = c0000001349e88a8
R09 = 000000000000028c   R25 = c00000023dca8628
R10 = c00000018b5f89a0   R26 = c0000001e172ca30
R11 = 6b6b6b6b6b6b6b6b   R27 = c00000023dca8628
R12 = d0000000001bb3f8   R28 = 000000000000028c
R13 = c000000000456300   R29 = c0000001e172ca30
R14 = 00000000ffffffff   R30 = c0000000004a9250
R15 = 0000000000000000   R31 = c0000001349e88c8
pc  = c0000000001351e0 .tid_fd_revalidate+0x64/0x220
lr  = c0000000001351cc .tid_fd_revalidate+0x50/0x220
msr = 8000000000009032   cr  = 84000482
ctr = c00000000016a770   xer = 0000000000000000   trap =  300
dar = 6b6b6b6b6b6b6b6b   dsisr = 40000000


Now r11=6b6b6b6b6b6b6b6b = 'fdt'
and an attempt is made to access fdt->max_fds as in 'if (fd < fdt->max_fds)'  which fails

include/linux/file.h:99
             b44:       80 0b 00 00     lwz     r0,0(r11)   <<<<<<------PC 
             b48:       7f 80 48 40     cmplw   cr7,r0,r9

Further the contents of 'struct files_struct *files' were all filled 
with '0x6b's.  I tried to look in to for which task the lookup was being 
done and the task seemed to be 'execve04'.  Also noticed that another 
cpu ( cpu #1)  was running on an execve code path ( do not have the 
state of the system right now to copy it's backtrace  :(  ).

Thanks,
Chandru

