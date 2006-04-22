Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWDVTxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWDVTxH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWDVTxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:53:07 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:58051 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751106AbWDVTxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:53:04 -0400
Date: Sat, 22 Apr 2006 15:34:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lukasz Stelmach <stlman@poczta.fm>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix socket connection tracking
In-Reply-To: <444A1B86.1060701@poczta.fm>
Message-ID: <Pine.LNX.4.61.0604221531190.18093@yvahk01.tjqt.qr>
References: <44480BD9.5080100@poczta.fm> <Pine.LNX.4.61.0604211452490.23180@yvahk01.tjqt.qr>
 <4448DF94.5030500@poczta.fm> <Pine.LNX.4.61.0604211610500.31515@yvahk01.tjqt.qr>
 <444A1B86.1060701@poczta.fm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> I feel dumb as never so please enlight me. Is ther a way to find out which
>>>>> process is on the other end of a unix socket pointed by a specified fd in a process.
>>>> getpeer*()
>>> getpeername(2) (that is the only man page I've got)
>>>
>> Exactly. And if you do the same on another socket from another process, you 
>> can match up what sockets are connected.
>> You always need to examine more than one process. (Unless the process talks 
>> to itself.)
>
>But how can I examine a file-descriptor (socket) from within other process. Like
>this.
>
>A [fd:4]------[fd:6] B -+
>|                       |
>`---[ptrace] C [ptrace]-'
>

 7315 pts/9    S+     0:00          |               \_ ssh jengelh@lo
 3698 ?        Ss     0:00 /usr/sbin/sshd -o PidFile=/var/run/sshd.init.pid
 7316 ?        Ss     0:00  \_ sshd: jengelh [priv]                            
 7320 ?        S      0:00      \_ sshd: jengelh@pts/10                        
 7321 pts/10   Ss     0:00          \_ -bash

Just look at all processes and logically connect them:

15:32 shanghai:/D/home/jengelh # l /proc/7315/fd
total 7
dr-x------  2 root root  0 Apr 22 15:32 .
dr-xr-xr-x  5 root root  0 Apr 22 15:32 ..
lrwx------  1 root root 64 Apr 22 15:32 0 -> /dev/pts/9
lrwx------  1 root root 64 Apr 22 15:32 1 -> /dev/pts/9
lrwx------  1 root root 64 Apr 22 15:32 2 -> /dev/pts/9
lrwx------  1 root root 64 Apr 22 15:32 3 -> socket:[85928]
lrwx------  1 root root 64 Apr 22 15:32 4 -> /dev/pts/9
lrwx------  1 root root 64 Apr 22 15:32 5 -> /dev/pts/9
lrwx------  1 root root 64 Apr 22 15:32 6 -> /dev/pts/9

15:33 shanghai:/D/home/jengelh # l /proc/7316/fd/
total 6
dr-x------  2 root root  0 Apr 22 15:32 .
dr-xr-xr-x  5 root root  0 Apr 22 15:32 ..
lrwx------  1 root root 64 Apr 22 15:32 0 -> /dev/null
lrwx------  1 root root 64 Apr 22 15:33 1 -> /dev/null
lrwx------  1 root root 64 Apr 22 15:33 2 -> /dev/null
lrwx------  1 root root 64 Apr 22 15:33 3 -> socket:[85929]
lrwx------  1 root root 64 Apr 22 15:33 4 -> /dev/ptmx
lrwx------  1 root root 64 Apr 22 15:33 5 -> socket:[85959]

No need for ptrace. No need for getpeername() either, but it's useful to 
get the real addresses of sockets.


Jan Engelhardt
-- 
