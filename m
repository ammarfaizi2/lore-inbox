Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVDJNUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVDJNUX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVDJNUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:20:23 -0400
Received: from mail.aknet.ru ([217.67.122.194]:25605 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261494AbVDJNUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:20:14 -0400
Message-ID: <42592813.5020005@aknet.ru>
Date: Sun, 10 Apr 2005 17:20:19 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru> <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru> <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru> <20050407080004.GA27252@elte.hu> <42555BBF.6090704@aknet.ru> <Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org> <425563D6.30108@aknet.ru> <Pine.LNX.4.58.0504070951570.28951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504070951570.28951@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090304070509030301000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090304070509030301000509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Linus Torvalds wrote:
>> 2. How can one be sure there are no more
>> of the like places where the stack is left
>> empty?
> That's a good argument, and may be the strongest reason for _not_ doing 
> the speculation. However, I don't think it really can happen anywhere 
> else. 
OK, so how do you feel about the attached
patch? I understand that from some point
of view it may look like a hack, but at
the same time it:
1. Allows to preserve the valueable optimization
2. Works for NMIs
3. Doesn't care whether or not there are more
of the like instances where the stack is left
empty.
4. Seems to work for me without the crashes:) 


--------------090304070509030301000509
Content-Type: text/x-patch;
 name="esp0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="esp0.diff"

--- linux/arch/i386/kernel/process.c.old	2005-03-20 14:12:18.000000000 +0300
+++ linux/arch/i386/kernel/process.c	2005-04-10 16:54:39.000000000 +0400
@@ -394,7 +394,7 @@
 	childregs->esp = esp;
 
 	p->thread.esp = (unsigned long) childregs;
-	p->thread.esp0 = (unsigned long) (childregs+1);
+	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 


--------------090304070509030301000509--
