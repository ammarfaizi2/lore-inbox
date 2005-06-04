Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVFDIIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVFDIIc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 04:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFDIIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 04:08:32 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:21664 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261286AbVFDIIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 04:08:30 -0400
Message-ID: <000701c568e3$fb67dcc0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
Subject: NPX init bugs in x86 head.S ???
Date: Sat, 4 Jun 2005 05:01:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the code snip that checks for a hardware NPX - which it does OK.

But, how can enabling a 287 ever work in a paged environment?  A 287 NPX
only has internal registers capable of handling 16:16 segmented protected
mode addresses.  Once paging is enabled and 16:32 addresses start getting
generated I should think everything falls apart.  At a minimum, if nothing
else died first, any reported exception CS:IP's would certainly be bogus
having only 16 bits of IP coming back to the 386 from the NPX.

Am I missing something here?

 Tony

------------------CUT-------------------

/*
 * We depend on ET to be correct. This checks for 287/387.
 */
check_x87:
        movb $0,X86_HARD_MATH
        clts
        fninit
        fstsw %ax
        cmpb $0,%al
        je 1f
        movl %cr0,%eax          /* no coprocessor: have to set bits */
        xorl $4,%eax            /* set EM */
        movl %eax,%cr0
        ret
        ALIGN
1:      movb $1,X86_HARD_MATH
        .byte 0xDB,0xE4         /* fsetpm for 287, ignored by 387 */
        ret

