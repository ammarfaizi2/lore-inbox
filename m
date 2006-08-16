Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWHPCUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWHPCUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWHPCUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:20:32 -0400
Received: from smtpout.mac.com ([17.250.248.177]:32974 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750742AbWHPCUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:20:31 -0400
In-Reply-To: <787b0d920608131308se2376f3ua2a775533d99f58e@mail.gmail.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com> <20060724182000.2ab0364a.akpm@osdl.org> <20060724184847.3ff6be7d.pj@sgi.com> <20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com> <20060724193318.d57983c1.akpm@osdl.org> <20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com> <20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com> <m1mza8wqdc.fsf@ebiederm.dsl.xmission.com> <787b0d920608131308se2376f3ua2a775533d99f58e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <06D0393F-8EB3-4A9C-96B2-829E935100C3@mac.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, akpm@osdl.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] ps command race fix
Date: Tue, 15 Aug 2006 22:20:16 -0400
To: Albert Cahalan <acahalan@gmail.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2006, at 16:08:20, Albert Cahalan wrote:
> In general, process namespaces are useful for:
>
> 1. silly marketing (see Sun and FreeBSD)
>
> 2. the very obscure case of "root" account providers who are too  
> clueless to use SE Linux or Xen

3. Kernel developers who need to test their kernel changes on  
multiple distributions can install those distributions unmodified in  
containers (requires process namespaces)

4. Server admins who want an absolutely unbreakable way (well, as  
close as one can get) to isolate virtual servers from each other and  
from the hardware.  This also doesn't have the overhead of running 2  
stacked memory allocators (Xen allocator and kernel allocator) as  
well as multiple copies of each kernel.

> I don't think either case justifies the complexity.  I am not  
> looking forward to the demands that I support this mess in procps.  
> I suspect I am not alone; soon people will be asking for support in  
> pstools, gdb, fuser, killall... until every app which interacts  
> with other processes will need hacks.

IMHO support for PID namespaces should/would/will be done without  
changing the existing /proc entries or underlying layout.  For  
example, one compatible solution would be to add a new "pidspace="  
mount option to procfs which specifies which pidspace will be  
represented.  Another method (also compatible with the pidspace=  
mount option and enabling hierarchical pid spaces would be to  
represent child pidspaces in their parent pidspace as a single  
process, such that sending signals to said process will send signals  
to the "init" process in the child pidspace as though they came from  
the kernel (IE: They aren't blocked-by-default), then add a  
"pidspace" subdirectory that contains all of the proc entries for  
processes in that space.  Example:

# mount -t proc proc /proc
# create_new_pidspace /bin/sleep 100000 &
[1] 1234
# ls /proc
...
...
1234
...
...
# ls /proc/1234/pidspace
1

There are obviously still problems with this scenario (what numbering  
schemes do pidspaces use and how is the pidspace= mount option  
interpreted?), but it's an example of a few ways to preserve ABI  
compatibility with existing userspace.  I think the idea behind all  
of this is to make it possible to run 6 different unmodified distros  
on a single system (but you need a few extra tools in the parent  
"boot" namespace).

> If the cost were only an #ifdef in the kernel, there would be no  
> problem. Unfortunately, this is quite a hack in the kernel and it  
> has far-reaching consequenses in user space.

I believe it's been stated that rule #1 for this stuff is preserving  
backwards compatibility and kernel<=>userspace ABI with every  
change.  We might add new APIs (which then have to remain the same in  
future versions, barring outright showstopper bugs), but existing  
APIs will still work correctly.

Cheers,
Kyle Moffett

