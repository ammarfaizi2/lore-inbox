Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262739AbVGKWPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbVGKWPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVGKWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:13:42 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:27298 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262788AbVGKWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:11:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=cTsVE8QeRYfbLjeZgdU1CBju8nWHaQu7oy+jFwsiPHPJ70XDaaKNSdXmLAg1aop0cFyfKGUmi7+VDUgh7GczOCIpFHiAMOBX0mj0GxXqVUSV/pRUiK/cT/YFcq5Mq4XnTji7kCckKvSdKLCUF5mAgOiZQ03NjrdUZXYtr4cTAnc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: CONFIG_REGPARM - prevent_tail_call doubts (context: SKAS3 bug in detail)
Date: Tue, 12 Jul 2005 00:18:50 +0200
User-Agent: KMail/1.8.1
Cc: Jeff Dike <jdike@addtoit.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507120018.51436.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just diagnosed (and announced) a big bug affecting the SKAS3 patch: namely, 
syscall parameter values stored in registers may be corrupted for some 
syscalls on return, when called through int 0x80, and when CONFIG_REGPARM is 
enabled.

Ok, the diagnosys of the SKAS3 bug I just noticed is that simply, this 
construct:

int do_foo(params...) {
}

asmlinkage int sys_foo(params...) {
	return do_foo(a_new_param, params...);
}

does not work, because sys_foo() is optimized to reorder parameters on the 
stack and to tail-call do_foo. The corrupted parameters on the stack will 
then be restored (when calling with int $0x80) inside the userspace 
registers. From entry.S, especially from this comment:

	/* if something modifies registers it must also disable sysexit */

it's clear that when using SYSENTER registers are not restored (even verified 
through sys_iopl() code, which touched EFLAGS).

I've used prevent_tail_call to fix this, and it works (verified with tests and 
assembly inspection). I even think I've understood why it works... it's clear 
why it disallows tail call, but I thought that GCC could create a normal call 
reusing some space from the stack frame of sys_foo, to create the stack frame 
of do_foo... it's just that it wouldn't improve speed.

This construct is used for four syscalls (sys_mmap2, old_mmap, sys_mprotect, 
sys_modify_ldt) and I verified the bug for all sys_mmap2 and sys_mprotect, 
and I'm sure about modify_ldt because the compiled code is identical to 
sys_mprotect().

I initially noticed this with the errno-vs-NPTL fix I and Al Viro discussed 
some time ago: it used indeed mmap2() and triggered the bug.

Luckily, strace reads the correct data (since syscall params are read before 
the syscall is done) so I couldn't do anything else than understand something 
bad was happening.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
