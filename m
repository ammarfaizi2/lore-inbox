Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVDETR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVDETR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVDETOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:14:48 -0400
Received: from mail.aknet.ru ([217.67.122.194]:49170 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261898AbVDETLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:11:05 -0400
Message-ID: <4252E2C9.9040809@aknet.ru>
Date: Tue, 05 Apr 2005 23:11:05 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu>
In-Reply-To: <20050405065544.GA21360@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------020709040801030903080105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020709040801030903080105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ingo et all.

Ingo Molnar wrote:
> the crashes below happen when PAGEALLOC is enabled. It's this 
> instruction:
>  movb OLDSS(%esp), %ah
I am really sorry about that screwup :(
I can't do too much right now as I am
reading the mail in a batch mode, and
the next time I'll be reading it will
be 24 hours from now.

Attached is a quick fix, which I'll be
testing to death tomorrow at work.
I had DEBUG_PAGEALLOC disabled, so I
haven't noticed that stupid bug while
optimizing my checks...
Let me know how it goes. 


--------------020709040801030903080105
Content-Type: text/x-patch;
 name="entry.S.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="entry.S.diff"

--- entry.S.old	2005-04-05 20:08:07.000000000 +0400
+++ entry.S	2005-04-05 22:54:43.000000000 +0400
@@ -244,11 +244,12 @@
 	jne syscall_exit_work
 
 restore_all:
-	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
-	movb OLDSS(%esp), %ah
-	movb CS(%esp), %al
-	andl $(VM_MASK | (4 << 8) | 3), %eax
-	cmpl $((4 << 8) | 3), %eax
+	testl $3, CS(%esp)
+	jz restore_nocheck		# return to kernel or v86
+	movl EFLAGS(%esp), %eax		# mix EFLAGS and SS
+	movb OLDSS(%esp), %al
+	andl $(VM_MASK | 4), %eax
+	cmpl $4, %eax
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
 	RESTORE_REGS


--------------020709040801030903080105--
