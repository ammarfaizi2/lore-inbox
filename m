Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbUKHO2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUKHO2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUKHO2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:28:52 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:65017 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261780AbUKHO2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:28:38 -0500
Message-ID: <418F826C.2060500@in.ibm.com>
Date: Mon, 08 Nov 2004 19:57:56 +0530
From: Sripathi Kodi <sripathik@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       dino@in.ibm.com
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 11:17:44AM -0800, Linus Torvalds wrote:

>> I think the real fix is to notice when we have dropped the tasklist_lock 
>> inside the loop, and _not_ re-schedule in that case, but just repeat the 
>> loop from the top.
>> 
>> And that's easy enough to do: set current->state to TASK_RUNNING in the
>> cases where we might have raced with somebody else. That will cause the
>> schedule() to be a no-op.
>> 
>> We could also choose to just wake up all our siblings "child_wait" lists
>> when we reap a child ourselves. They likely got woken up _anyway_ when the
>> child died in the first place, after all. For extra bonus points, make the
>> child_wait thing use the self-removing waitqueue entries, ie use
>> "prepare_to_wait()" instead of add_wait_queue(), and move it after the
>> "repeat:" thing.
>> 
>> 		Linus
>  
>

Linus,

Thanks for your suggestions. I have attached the re-done patch. I have 
implemented your first suggestion because it was much easier. I hope it 
looks better now.

Thanks and regards,
Sripathi Kodi.

Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>

--- linux-2.6.10-rc1/kernel/exit.c	2004-11-08 23:38:17.358375128 +0530
+++ /home/sripathi/12013/patch/take2/exit.c	2004-11-08 23:33:44.973783880 +0530
@@ -1345,8 +1345,10 @@ repeat:
 				break;
 			default:
 			// case EXIT_DEAD:
-				if (p->exit_state == EXIT_DEAD)
-					continue;
+				if (p->exit_state == EXIT_DEAD) {
+					current->state = TASK_RUNNING;
+					break;
+				}
 			// case EXIT_ZOMBIE:
 				if (p->exit_state == EXIT_ZOMBIE) {
 					/*
@@ -1363,6 +1365,7 @@ repeat:
 					/* He released the lock.  */
 					if (retval != 0)
 						goto end;
+					current->state = TASK_RUNNING;
 					break;
 				}
 check_continued:


