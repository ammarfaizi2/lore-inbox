Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWFNLQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWFNLQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 07:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWFNLQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 07:16:00 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:11372 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932324AbWFNLQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 07:16:00 -0400
Message-ID: <448FEFA9.2040705@sw.ru>
Date: Wed, 14 Jun 2006 15:14:49 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       herbert@13thfloor.at, saw@sw.ru, serue@us.ibm.com, sfrench@us.ibm.com,
       sam@vilain.net, haveblue@us.ibm.com
Subject: Re: [PATCH 2/6] IPC namespace - utils
References: <44898BF4.4060509@openvz.org> <44898E39.3080801@openvz.org>	<448D9F96.5030305@fr.ibm.com>	<m1bqsy6ynn.fsf@ebiederm.dsl.xmission.com>	<448DD71E.1020209@fr.ibm.com> <m1slma3v00.fsf@ebiederm.dsl.xmission.com> <448F2B78.5090405@fr.ibm.com>
In-Reply-To: <448F2B78.5090405@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Agreed.  Hmm.  I bet I didn't see this one earlier because it is specific
>>to the unshare case.  In this case I guess we should either deny the unshare
>>or simply undo all of the semaphores.  Because we will never be able to
>>talk to them again.
> 
> So aren't we reaching the unshare() limits ? Shouldn't we be using the
> exec() principle for the sysvipc namespace ? clear it all and start from
> scratch.
there will be more such issues with more complex namespaces. That's why 
I proposed to use containers.
Any way, right now, I don't think this should be urgently fixed as there 
are many other ways to crash the node when you are a root.
The rule is simple - the process changing the namespace should be 
simple, w/o IPCs. For more complex namespaces (e.g. resource management 
namespaces) a fork() can be required after unshare().

>>Thinking about this some more we need to unsharing the semaphore undo semantics
>>when we create a new instances of the sysvipc namespace.  Which means that
>>until that piece is implemented we can't unshare the sysvipc namespace.
> 
> 
> no big issue I think. exit_sem() does it already. it would end up coding
> the yet unsupported unshare_semundo().
do we need really it?
my point is that while with IPCs it maybe quite easy since semundo code 
already exists it can be still very hard for other namespaces which do 
not track its objects associated with the task.

BTW, do we have the same problem with shm? What will happen if the task 
having shm segment will change it's IPC namespace? Besides the possible 
crash/stability bugs there can be more interesting effects, for example:
"user will be able to do operations on existing objects with new 
namespace limitations?"...

Thanks,
Kirill
