Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWGOEgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWGOEgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWGOEgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:36:32 -0400
Received: from smtpout.mac.com ([17.250.248.177]:24520 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750775AbWGOEgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:36:32 -0400
In-Reply-To: <m1psg7qzjl.fsf@ebiederm.dsl.xmission.com>
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com> <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com> <1152821011.24925.7.camel@localhost.localdomain> <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com> <1152887287.24925.22.camel@localhost.localdomain> <m17j2gw76o.fsf@ebiederm.dsl.xmission.com> <20060714162935.GA25303@sergelap.austin.ibm.com> <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com> <1152896138.24925.74.camel@localhost.localdomain> <20060714170814.GE25303@sergelap.austin.ibm.com> <1152897579.24925.80.camel@localhost.localdomain> <m17j2gt7fo.fsf@ebiederm.dsl.xmission.com> <1152900911.5729.30.camel@lade.trondhjem.org> <m1hd1krpx6.fsf@ebiederm.dsl.xmission.com> <1152911079.5729.70.camel@lade.trondhjem.org> <m1psg7qzjl.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4DBD2EBA-9AE2-4598-A9E5-FE7ADCA60B44@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Date: Sat, 15 Jul 2006 00:35:34 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 15, 2006, at 00:09:50, Eric W. Biederman wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
>> NFS is the least of your problems. You can only have one  
>> superblock for most local filesystems too and with good reason:  
>> imagine, for instance, the effect of having 2 different block  
>> allocators working on the same device.
>
> Let me try to explain the idea again.
>
> Currently there is a global context in which we interpret uids.   
> But different machines can have different global contexts.
>
> Each filesystem to be sane needs to store uids from only one such  
> context.  For network filesystems typicall the context is extended  
> to multiple machines so that everyone who mounts a filesystem will  
> interpret a uid with the same meaning.
>
> The idea of creating multiple a user id namespaces on a single  
> machine creates multiple contexts for the interpretation of uid  
> values on the same machine.  Allowing a single id to refer to  
> different users depending on the context in which it is interpreted.
>
> I can think of no circumstance in which a single filesystem will  
> have multiple contexts in which user id's will be interpreted. Nor  
> can I think of a sane scenario in which that would occur.
>
> Given the fact that we are referring to a global property of a  
> filesystem why is it fundamentally a problem to put it in the  
> superblock?

Here's a possible example:

I have one disk which I want to share between multiple virtualized  
instances for root filesystems.  I bind-mount /onedisk/foo as the foo  
virtual machine's root and /onedisk/bar as the bar virtual machine's  
root.  There should (must) be two interpretations of the linear UID  
space on that disk, one for the foo virtual machine, and one for the  
bar virtual machine.  By allowing the administrator to determine UID  
namespace per-vfsmount, you make such an arrangement possible where  
it otherwise would not be.

With NFS and the proposed superblock-sharing patches (necessary for  
efficiency and other reasons I don't entirely understand), the  
situation is worse:  A mount of server:/foo/bar on / in the bar  
virtual machine may get its superblock merged with a mount of server:/ 
foo/baz on / in the baz virtual machine.  If it's efficient to merge  
those superblocks we should, and once again it's necessary to tie the  
UID namespace to the vfsmount, not the superblock.

Cheers,
Kyle Moffett

