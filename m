Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSEVNQH>; Wed, 22 May 2002 09:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSEVNQG>; Wed, 22 May 2002 09:16:06 -0400
Received: from daimi.au.dk ([130.225.16.1]:56071 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S313201AbSEVNQG>;
	Wed, 22 May 2002 09:16:06 -0400
Message-ID: <3CEB9A12.FB4C346B@daimi.au.dk>
Date: Wed, 22 May 2002 15:16:02 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] handle_vm86_fault
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently some changes were made to arch/i386/kernel/vm86.c in order to
prevent some Oopses. Currently handle_vm86_fault returns VM86_UNKNOWN
in those cases. But that is a little broken, rather than returning
this value, it should send a SIGSEGV to usermode.

That is however not trivial, there is a problem with the si_addr field
in the siginfo_t struct. The do_page_fault function in
arch/i386/mm/fault.c will fill this field in such a struct with the
local variable address. But that only happens if the trap comes from
usermode, in this case the trap comes from kernelmode. That means that
do_page_fault just finds the fixup address and returns loosing the
value of the local variable address.

How can I pass that variable back from do_page_fault to
handle_vm86_fault? There might also be a problem with the si_code
field, I'm not sure exactly from where I should get that value.
Perhaps it will turn out to be some known constant.

Would it be safe to fill the address in tsk->thread.cr2 like the
usermode case?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
