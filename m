Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVEWI1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVEWI1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 04:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEWI1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 04:27:46 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:51008 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261855AbVEWI1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 04:27:30 -0400
Message-ID: <4291940E.9060104@sw.ru>
Date: Mon, 23 May 2005 12:27:58 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Heiko Carstens <Heiko.Carstens@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Christian Borntraeger <cborntra@de.ibm.com>,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Running OOM and worse with broken signal handler
References: <OF65FF28C6.9C7B30EE-ONC1257008.0029505D-C1257008.00297392@de.ibm.com>
In-Reply-To: <OF65FF28C6.9C7B30EE-ONC1257008.0029505D-C1257008.00297392@de.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040708050503020905010100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040708050503020905010100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew, here is the patch with the comment for the problem described below.

Patch comment:
If SIGKILL does not have priority, we cannot instantly kill task
before it makes some unexpected job. It can be critical, but we
were unable to reproduce this easily until Heiko Carstens 
<Heiko.Carstens@de.ibm.com> reported this problem on LKML.

Signed-Off-By: Kirill Korotaev <dev@sw.ru>
Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

Kirill


> Hi Kirill,
> 
> your patch fixes this issue. Thanks!
> Andrew, any chances to get this merged?
> 
> Heiko
> 
> 
>>Can you test this patch, please?
>>
>>Alexey Kuznetsov discovered long ago that SIGKILL is low priority than 
>>signalls 1-8, so it can be delivered very long... But we didn't 
>>succedded to reproduce this in real life, looks like you did it :)
>>
>>Kirill
>>
>>
>>>Hi all,
>>>
>>>we experienced some interesting behaviour with an out of
>>>memory condition caused by signal handling (on s390x).
>>>The following program ran our system in an OOM situation
>>>and couldn't be killed because the SIGKILL signal couldn't
>>>be delivered.
>>>Necessary for this to happen is that the stack size limit
>>>is set to unlimited.
>>>
>>>sig_handler(int sig)
>>>{
>>>  asm volatile(".long 0\n");
>>>}
>>>
>>>int main (int argc, char **argv)
>>>{
>>>  struct sigaction act;
>>>
>>>  act.sa_handler = &sig_handler;
>>>  act.sa_restorer = 0;
>>>  act.sa_flags = SA_NOMASK | SA_RESTART;
>>>
>>>  sigaction(SIGILL, &act, 0);
>>>  sigaction(SIGSEGV, &act, 0);
>>>
>>>  asm volatile(".long 0\n");
>>>}
>>>
>>>The instruction in the asm block is suppossed to be an
>>>illegal opcode which enforces a SIGILL.
>>>When executed the following happens:
>>>The illegal instruction causes a SIGILL to be delivered to
>>>the process. Since the signal handler itself contains an
>>>illegal instruction this causes another SIGILL to
>>>be delivered, thus causing the stack to grow unlimited.
>>>When we are finally out of memory the OOM killer selects
>>>our process and sends it a SIGKILL.
>>>Only problem in this scenario is that the SIGKILL never
>>>will be sent to our process simply because there is
>>>always a SIGILL pending too, which will be handled before
>>>the SIGKILL because of its lower number (see next_signal()
>>>in kernel/signal.c).
>>>The only possibly way this signal would be handled would
>>>be that the process is running in userspace while trying
>>>to handle the delivered SIGILL, where it would be interrupted
>>>by an interrupt and upon return to userspace do_signal()
>>>would be called again. This is unfortunately very unlikely
>>>if you are running a nearly timer interrupt free kernel
>>>like we do on s390/s390x.
>>>Since the OOM killer set the TIF_MEMDIE flag for our
>>>process it now is allowed to eat up all the memory left
>>>and our system is more or less dead until you're lucky
>>>and an interrupt hits at the right time and finally
>>>causing the process to be terminated...
>>>
>>>Maybe the OOM killer or signal handling would need
>>>a change to fix this?
>>>
>>>Thanks,
>>>Heiko
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe 
> 
> linux-kernel" in
> 
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>diff -ur orig/linux-2.6.8.1/kernel/signal.c 
> 
> linux-2.6.8.1/kernel/signal.c
> 
>>--- orig/linux-2.6.8.1/kernel/signal.c   2005-05-12 02:44:12.000000000 
> 
> +0400
> 
>>+++ linux-2.6.8.1/kernel/signal.c   2005-05-13 12:07:04.000000000 +0400
>>@@ -519,7 +520,16 @@
>> {
>>    int sig = 0;
>>
>>-   sig = next_signal(pending, mask);
>>+   /* SIGKILL must have priority, otherwise it is quite easy
>>+    * to create an unkillable process, sending sig < SIGKILL
>>+    * to self */
>>+   if (unlikely(sigismember(&pending->signal, SIGKILL))) {
>>+      if (!sigismember(mask, SIGKILL))
>>+         sig = SIGKILL;
>>+   }
>>+
>>+   if (likely(!sig))
>>+      sig = next_signal(pending, mask);
>>    if (sig) {
>>       if (current->notifier) {
>>          if (sigismember(current->notifier_mask, sig)) {
> 
> 
> 


--------------040708050503020905010100
Content-Type: text/plain;
 name="diff-mainstream-sigkillprio-20050513"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-mainstream-sigkillprio-20050513"

diff -ur orig/linux-2.6.8.1/kernel/signal.c linux-2.6.8.1/kernel/signal.c
--- orig/linux-2.6.8.1/kernel/signal.c	2005-05-12 02:44:12.000000000 +0400
+++ linux-2.6.8.1/kernel/signal.c	2005-05-13 12:07:04.000000000 +0400
@@ -519,7 +520,16 @@
 {
 	int sig = 0;
 
-	sig = next_signal(pending, mask);
+	/* SIGKILL must have priority, otherwise it is quite easy
+	 * to create an unkillable process, sending sig < SIGKILL
+	 * to self */
+	if (unlikely(sigismember(&pending->signal, SIGKILL))) {
+		if (!sigismember(mask, SIGKILL))
+			sig = SIGKILL;
+	}
+
+	if (likely(!sig))
+		sig = next_signal(pending, mask);
 	if (sig) {
 		if (current->notifier) {
 			if (sigismember(current->notifier_mask, sig)) {

--------------040708050503020905010100--

