Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbUCJWJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUCJWJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:09:23 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:15510 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262854AbUCJWJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:09:19 -0500
Message-ID: <404F8FDE.3050305@acm.org>
Date: Wed, 10 Mar 2004 15:59:58 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible race in signal handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hoping I am wrong, but I think I have found a race in signal 
handling.  I believe this can only happen in an SMP system or a system 
with preempt on.  I'll use 2.6 for the example, but I think it applies 
to 2.4, too.

In arch/i386/signal.c, in the do_signal() function, it calls 
get_signal_to_deliver() which returns the signal number to deliver 
(along with siginfo).  get_signal_to_deliver() grabs and releases the 
lock, so the signal handler lock is not held in do_signal().  Then the 
do_signal() calls handle_signal(), which uses the signal number to 
extract the sa_handler, etc.

Since no lock is held, it seems like another thread with the same signal 
handler set can come in and call sigaction(), it can change sa_handler 
between the call to get_signal_to_deliver() and fetching the value of 
sa_handler.  If the sigaction() call set it to SIG_IGN, SIG_DFL, or some 
other fundamental change, that bad things can happen.

Am I correct here, or am I missing something?

-Corey

