Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTEJGRX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 02:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTEJGRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 02:17:23 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:40922 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263665AbTEJGRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 02:17:22 -0400
Message-ID: <3EBC9C62.5010507@nortelnetworks.com>
Date: Sat, 10 May 2003 02:29:54 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC]  new syscall to allow notification when arbitrary pids die
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to get some comments on a new syscall that I am planning on 
implementing.  This syscall would allow a process to register to be notified 
when another process dies.  The calling process would specify the pid of the 
process in which it is interested and the signal which it wants to be sent when 
the process with the specified pid dies.  The api would be:

int sigexit(pid_t pid, int signum)

The implementation would add a new linked list to the task struct which would 
store pid/signal tuples for each process requesting notification.  On process 
death, in do_notify_parent we walk the list and send the specified signals to 
all the listeners.

I see two immediate uses for this.  One would be to enable a "watcher" process 
which can do useful things on the death of processes which registered with it 
(logging, respawning, notifying other processes, etc).  The watcher could keep a 
persistant list of what its monitoring and what for in a file, and if it ever 
died, the new watcher could scan the list and register to watch them all again. 
The second would be to enable mutual suicide pacts between processes. (I'm not 
sure when I would use this, but it sounds kind of fun.)

Anyone have any opinions on this?  There is a comment in exit_notify about not 
sending signals to arbitrary processes using the thread signals, but I'm not 
sure if that objection was to the idea or to the implementation.

Thanks,

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

