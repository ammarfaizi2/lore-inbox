Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUK2L4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUK2L4Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbUK2L4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:56:25 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:972 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261685AbUK2L4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:56:16 -0500
Message-ID: <41AB0DA5.5030906@xeon2.local.here>
Date: Mon, 29 Nov 2004 12:53:09 +0100
From: kladit@t-online.de (Klaus Dittrich)
User-Agent: Mozilla Thunderbird 0.9+ (X11/20041126)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Sripathi Kodi <sripathik@in.ibm.com>, Klaus Dittrich <kladit@t-online.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: do_wait fix for 2.6.10-rc1
References: <20041120132403.GA2062@xeon2.local.here> <41A0738B.1070100@in.ibm.com> <41A1AD33.8080108@xeon2.local.here> <41A58B51.7060600@in.ibm.com> <41A763A1.6090806@xeon2.local.here> <41AA9F21.9060408@in.ibm.com>
In-Reply-To: <41AA9F21.9060408@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040106070704060702050000"
X-ID: bVqCpmZY8e+UBTbmZt9xPZKA+QuC3xAP-dGVHJQWpouzEiwk-byQ8b
X-TOI-MSGID: ceb96671-2c7c-4f76-bdc9-009bb8965ef0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040106070704060702050000
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Sripathi Kodi wrote:

> Can you test this patch please?
>
>> -- 
>> Regards Klaus
>
>
> Hi Klaus,
>
> I have tested your patch against my testcase and it seems to be alright.
>
> My testcase is right here in my first post on LKML about this: 
> http://lkml.org/lkml/2004/11/5/34! The essence of the testcase is two 
> threads racing in waitpid to collect the exit status of a child. 
> Sometimes the thread that loses this race gets stuck in waitpid 
> forever unless manually interrupted. I had been able to recreate this 
> problem only on a multiprocessor machine. The essence of the fix was 
> to make the thread that loses this race not to set 'flag =1'. The 
> patch you sent me does not alter this behavior, so it works alright.
>
> Thanks and regards,
> Sripathi.

I encountered a bug in waitpid after Sripathi's patch
was applied.
See lkml
"kernel reports kill too late? Thu Nov 18 2004 - 07:36:48 EST"

Attached is a patch for do_wait() that may fix both problems.

--
Regards Klaus

--------------040106070704060702050000
Content-Type: text/plain;
 name="2patch-exit.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2patch-exit.c"

--- kernel/exit.ORIG.c	2004-11-24 17:20:32.000000000 +0100
+++ kernel/exit.c	2004-11-26 17:38:36.000000000 +0100
@@ -1316,6 +1316,9 @@ static long do_wait(pid_t pid, int optio
 	DECLARE_WAITQUEUE(wait, current);
 	struct task_struct *tsk;
 	int flag, retval;
+	struct task_struct *p;
+	struct list_head *_p;
+	int ret;
 
 	add_wait_queue(&current->wait_chldexit,&wait);
 repeat:
@@ -1324,9 +1327,6 @@ repeat:
 	read_lock(&tasklist_lock);
 	tsk = current;
 	do {
-		struct task_struct *p;
-		struct list_head *_p;
-		int ret;
 
 		list_for_each(_p,&tsk->children) {
 			p = list_entry(_p,struct task_struct,sibling);
@@ -1377,10 +1377,11 @@ repeat:
 						goto end;
 					break;
 				}
-				flag = 1;
 check_continued:
-				if (!unlikely(options & WCONTINUED))
+				if (!unlikely(options & WCONTINUED)) {
+					flag = 1;
 					continue;
+				}
 				retval = wait_task_continued(
 					p, (options & WNOWAIT),
 					infop, stat_addr, ru);

--------------040106070704060702050000--
