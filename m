Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265162AbTLCUTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbTLCUTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:19:41 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:45733 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265162AbTLCUTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:19:39 -0500
Message-ID: <3FCE453D.9080701@colorfullife.com>
Date: Wed, 03 Dec 2003 21:19:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Raj <raju@mailandnews.com>, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: kernel BUG at kernel/exit.c:792!
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com> <20031203182319.D14999@in.ibm.com> <Pine.LNX.4.58.0312032059040.4438@earth> <Pine.LNX.4.58.0312031203430.7406@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312031203430.7406@home.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>So as far as I can tell, the patch from Ingo and Srivatsa just paper over
>the _real_ bug. And the real fix is to get rid of the debugging helper
>completely, since it no longer serves any purpose, and it is WRONG!
>
>So tell me why it isn't wrong?
>  
>
It's wrong, because next_thread() relies on

    task->pids[PIDTYPE_TGID].pid_chain.next

That pointer is not valid after detach_pid(task, PIDTYPE_TGID), and 
that's called within __unhash_process.  Thus next_thread() fails if it's 
called on a dead task. Srivatsa's second patch is the right change: If 
pid_alive() is wrong, then break from the loop without calling 
next_thread().

--
    Manfred

