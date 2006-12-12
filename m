Return-Path: <linux-kernel-owner+w=401wt.eu-S932316AbWLLR5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWLLR5G (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWLLR5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:57:05 -0500
Received: from smtpout.mac.com ([17.250.248.175]:64677 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932316AbWLLR5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:57:03 -0500
In-Reply-To: <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com> <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mach-O binary format support and Darwin syscall personality [Was: uts banner changes]
Date: Tue, 12 Dec 2006 12:56:51 -0500
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-12_04:2006-12-12,2006-12-10,2006-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0612050001 definitions=main-0612120016
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: If at all possible I'd like to keep the userspace stuff is set  
in stone; I want to just load some Mach-O binaries, libraries and  
dynamic linker onto the Linux system, "chroot /darwin" and go.  There  
may very well be huge game-over show-stoppers, but I might as well  
try, dammit! :-D

On Dec 12, 2006, at 11:23:58, Linus Torvalds wrote:
> On Tue, 12 Dec 2006, Kyle Moffett wrote:
>> So now I have to figure out how to set up a new syscall  
>> personality with a bunch of wrapper syscalls which reorder  
>> arguments and translate constant values before calling into the  
>> rest of the Linux code.  I'm fairly sure it's possible because you  
>> can run some Solaris binaries under Linux if you turn on the  
>> appropriate BINFMT_* config option(s), but I'm totally unsure as  
>> to _how_.
>
> What system call interface do Mach-O binaries use? Is it the old  
> stupid  "lcall 7,0" thing, or does it use "sysenter" or something  
> like that?
>
> If it's sysenter, it's going to be "interesting". That code  
> currently doesn't support any kind of emulation, and the whole  
> "sysenter" interface is pretty grotty at a CPU level (it doesn't  
> even save EIP etc). So you'd need to delve into x86 asm and arch/ 
> i386/kernel/entry.S (or the x86-64 equivalent).

Virtually all of my easily accessible computers right now are PowerPC  
and all of my assembly experience is PPC and MIPS, so as far as the  
x86-syscall support I have no clue whatsoever.  I hadn't even really  
considered it till you mentioned it.  I might get around to X86  
support at some point in the future assuming I get the PPC side to  
work, or I might just leave that for some enterprising person with a  
hell of a lot better understanding of X86 assembly fundamentals.

PPC seems to be a lot more straightforward and constrained than  
the... umm... "eccentric" privilege rings that x86 has (which I only  
minimally grasp).  I've only really studied RISC architectures in any  
detail.

With a little bit of Google and a lot of greping darwin sources I've  
been able to puzzle out that they don't use slow call gates and that  
they probably use sysenter/sysexit (Or possibly syscall/sysret if  
it's available?  I'm way over my head as far as x86 assembly and  
architecture goes)

The PPC syscall stuff on the other hand is fairly straightforward.   
The code loads the argument registers (which I _think_ follow the  
same syscall ABI on Linux and Darwin due to somebody having a flash  
of inspiration and putting that recommendation in the PPC spec  
documents) and runs the sc instruction.  Kernel code takes over,  
saves some state, loads some state, bumbles around with the argument  
registers a bit and looks up the syscall function in the syscall  
table (marked "asmlinkage"? what does that do?) and wanders off into  
the per-syscall handling code.

 From what I understand (for PPC at least), from the "sc" instruction  
till we actually call the in-kernel syscall-specific handler function  
the code is effectively the same.  We save the same state, set up  
similar kernel state, etc, so that the customary kernel services are  
available as soon as our syscall-handler-function starts.

So I guess all I have to do is:
   (A)  Write a bunch of new syscall handlers taking arguments of the  
same types as the Darwin syscall handlers,
   (B)  Figure out how to switch tables depending on the "syscall  
personality" of "current"
   (C)  Figure out how to set the "syscall personality" of "current"  
from my Mach-O binary format module.

(A) seems fairly straightforward, if unusually tedious and error- 
prone, but I'm totally in the dark for (B) and (C).  Any help would  
be much appreciated.

Cheers,
Kyle Moffett

