Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVE0TLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVE0TLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVE0TLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:11:20 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:231 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262545AbVE0TIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:08:10 -0400
Message-ID: <42976F62.6000701@davyandbeth.com>
Date: Fri, 27 May 2005 14:05:06 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: disowning a process
References: <42975945.7040208@davyandbeth.com> <1117217088.4957.24.camel@localhost.localdomain> <42976D3A.5020200@davyandbeth.com>
In-Reply-To: <42976D3A.5020200@davyandbeth.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davy Durham wrote:

> Cool.. I looked at the daemon function and I might be able to use it..
>
> However, I compiled your code... seems to work.. but where is the 
> wait() done on the middle parrent so that it isn't left defunct?
>
I added "waitpid(pid,NULL,0);" after the outer-most if.. which is where 
the grand parent cleans up the pid of the intermediate parent. 

However, now trying the daemon() function..  which seems to work the 
same way.. it definately leaves a pid around.. so I guess you really 
need to do a wait() in the parent after forking.. however you don't know 
exactly which pid to wait for so you might be reaping some other child 
you've previously spawned.. 

So, for now I'm going to stick with the explicit double fork code.

Thanks!

> Steven Rostedt wrote:
>
>> Try man daemon.
>>
>> The way I use to do it was simply do a double fork. That is
>> (simplified)...
>>
>> if ((pid = fork()) < 0) {
>>     perror("fork");
>> } else if (!pid) {
>>     /* child */
>>     if ((pid = fork()) < 0) {
>>         perror("child fork");
>>         exit(-1);
>>     } if (pid) {
>>         /* child parent */
>>         /* Here we detach from the child */
>>         exit(0);
>>     }
>>     /* Now this code is a child running almost as a daemon
>>         with init as the parent. */
>>     setsid();
>>     /* Now the child is completely detached from the original
>>        parent */
>>     /* ... daemon code here ... */
>>     exit(0);
>> }
>>
>> /* parent code here */
>>
>> -- Steve
>>
>>  
>>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



