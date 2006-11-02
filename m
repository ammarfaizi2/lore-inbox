Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752608AbWKBNJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbWKBNJO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbWKBNJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:09:14 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:40458 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1752608AbWKBNJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:09:13 -0500
Message-ID: <4549ECF8.2070508@openvz.org>
Date: Thu, 02 Nov 2006 16:04:56 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>, vatsa@in.ibm.com, balbir@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, Paul Menage <menage@google.com>,
       dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
References: <20061030103356.GA16833@in.ibm.com>	 <45486925.4000201@openvz.org>	 <20061101181236.GC22976@in.ibm.com>	 <1162419565.12419.154.camel@localhost.localdomain>	 <6599ad830611011550m69876b1ase3579167903a7cd7@mail.gmail.com>	 <4549B5A3.2010908@openvz.org> <1162466807.12419.194.camel@localhost.localdomain>
In-Reply-To: <1162466807.12419.194.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Thu, 2006-11-02 at 12:08 +0300, Pavel Emelianov wrote:
>> [snip]
>>
>>> I think that having a "tasks" file and a "threads" file in each
>>> container directory would be a clean way to handle it:
>>>
>>> "tasks" : read/write complete process members
>>> "threads" : read/write individual thread members
>> I've just thought of it.
>>
>> Beancounter may have more than 409 tasks, while configfs
>> doesn't allow attributes to store more than PAGE_SIZE bytes
>> on read. So how would you fill so many tasks in one page?
> 
> 	To be clear that's a limitation of configfs as an interface. In the
> Resource Groups code, for example, there is no hard limitation on length
> of the underlying list. This is why we're talking about a filesystem
> interface and not necessarily a configfs interface.

David Rientjes persuaded me that writing our own file system is
reimplementing the existing thing. If we've agreed with file system
interface then configfs may be used. But the limitations I've
pointed out must be discussed.

Let me remind:
1. limitation of size of data written out of configfs;
2. when configfs is a module user won't be able to
   use beancounters.

and one new
3. now in beancounters we have /proc/user_beancounters
   file that shows the complete statistics on BC. This
   includes all then beancounters in the system with all
   resources' held/maxheld/failcounters/etc. This is very
   handy and "vividly": a simple 'cat' shows you all you
   need. With configfs we lack this very handy feature.

>> I like the idea of writing pids/tids to these files, but
>> printing them back is not that easy.
> 
> 	That depends on how you do it. For instance, if you don't have an
> explicit list of tasks in the group (rough cost: 1 list head per task)
> then yes, it could be difficult.

I propose not to have the list of tasks associated with beancounter
(what for?) but to extend /proc/<pid>/status with 'bcid: <id>' field.
/configfs/beancounters/<id>/(tasks|threads) file should be write-only
then.

What do you think?
