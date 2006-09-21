Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWIUNV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWIUNV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 09:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWIUNV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 09:21:29 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:390 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751213AbWIUNV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 09:21:28 -0400
Message-ID: <451291D3.10401@fr.ibm.com>
Date: Thu, 21 Sep 2006 15:21:23 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC][PATCH -mm] replace cad_pid by a struct pid
References: <45110C1B.7020304@fr.ibm.com> <20060920143028.fd446145.akpm@osdl.org>
In-Reply-To: <20060920143028.fd446145.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew Morton wrote:
> On Wed, 20 Sep 2006 11:38:35 +0200
> Cedric Le Goater <clg@fr.ibm.com> wrote:
> 
>> There are a few places in the kernel where the init task is
>> signaled. The ctrl+alt+del sequence is one them. It kills a task,
>> usually init, using a cached pid (cad_pid).
>>
>> This patch replaces the pid_t by a struct pid to avoid pid wrap around
>> problem. The struct pid is initialized at boot time in init() and can
>> be modified through systctl with
>>
>> 	/proc/sys/kernel/cad_pid
> 
> hm.  Is there any sane scenario in which C-A-D would be directed to any
> other process?

I don't know. I really looked hard to see where this was used and i didn't
find any distro using it. 
 
> What happens if/when the process which is identifier by
> /proc/sys/kernel/cad_pid exits?  User error, I guess...

kill_pid() fails.

>> +extern struct pid* cad_pid;
> 
> Whitespace violation detected!
> 
>> -	if (shuting_down || kill_proc(1, SIGINT, 1)) {
>> +	if (shuting_down || kill_cad_pid(SIGINT, 1)) {
> 
> So your patch actually makes functional changes: lots of random
> init-signallers gain extra functionality: the process which they signal can
> now be configured via /proc/sys/kernel/cad_pid.  But by default, things
> remain unchanged.  Fair enough.

yes.

>> --- 2.6.18-rc7-mm1.orig/drivers/char/nwbutton.c
>> +++ 2.6.18-rc7-mm1/drivers/char/nwbutton.c
> 
> This driver can be compiled as a module.  I shall add the missing export...

oops thanks,

> (And I'll fix the parisc build too)

the only parisc i have still runs its native hpux 11. 

do we still need /proc/sys/kernel/cad_pid ? If it is obsolete, i'd send a 
different patch to disable this feature with some warning in dmesg and the
kill_proc(1) would stay as they are.

but may be some small distros for embedded linux use it.  

thanks,

C.
