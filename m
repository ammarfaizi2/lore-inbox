Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWGON0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWGON0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 09:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWGON0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 09:26:21 -0400
Received: from smtpout.mac.com ([17.250.248.172]:38135 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964791AbWGON0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 09:26:20 -0400
In-Reply-To: <m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
References: <m1mzbd1if1.fsf@ebiederm.dsl.xmission.com> <1152815391.7650.58.camel@localhost.localdomain> <m1wtahz5u2.fsf@ebiederm.dsl.xmission.com> <1152821011.24925.7.camel@localhost.localdomain> <m17j2gzw5u.fsf@ebiederm.dsl.xmission.com> <1152887287.24925.22.camel@localhost.localdomain> <m17j2gw76o.fsf@ebiederm.dsl.xmission.com> <20060714162935.GA25303@sergelap.austin.ibm.com> <m18xmwuo5r.fsf@ebiederm.dsl.xmission.com> <1152896138.24925.74.camel@localhost.localdomain> <20060714170814.GE25303@sergelap.austin.ibm.com> <1152897579.24925.80.camel@localhost.localdomain> <m17j2gt7fo.fsf@ebiederm.dsl.xmission.com> <1152900911.5729.30.camel@lade.trondhjem.org> <m1hd1krpx6.fsf@ebiederm.dsl.xmission.com> <1152911079.5729.70.camel@lade.trondhjem.org> <m1psg7qzjl.fsf@ebiederm.dsl.xmission.com> <4DBD2EBA-9AE2-4598-A9E5-FE7ADCA60B44@mac.com> <m1d5c7qc55.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <50EA0F5E-5C46-4395-A4AE-01702B82C51C@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Dave Hansen <haveblue@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Date: Sat, 15 Jul 2006 09:25:39 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 15, 2006, at 08:35:18, Eric W. Biederman wrote:
> Kyle Moffett <mrmacman_g4@mac.com> writes:
>> With NFS and the proposed superblock-sharing patches (necessary  
>> for  efficiency and other reasons I don't entirely understand),  
>> the  situation is worse:  A mount of server:/foo/bar on / in the  
>> bar virtual machine may get its superblock merged with a mount of  
>> server:/ foo/baz on / in the baz virtual machine.  If it's  
>> efficient to merge  those superblocks we should, and once again  
>> it's necessary to tie the  UID namespace to the vfsmount, not the  
>> superblock.
>
> I completely agree that pushing nameidata down into  
> generic_permission where we can use per mount properties in our  
> permission checks is ideal.  The benefit I see is just a small  
> increase in flexibility. So I don't really care either way.
>
> Currently there are several additional flags that could benefit  
> from a per vfsmount interpretation as well:  nosuid, noexec, nodev,  
> and readonly, how do we handle those?
>
> noexec is on the vfsmount.
> nosuid is on the vfsmount
> nodev  is on the vfsmount
> readonly is not on the vfsmount.
>
> The existing precedent is clearly in favor of putting this kind of  
> information on the vfsmount.  The read-only attribute seems to be  
> the only hold out.  If readonly has deep implications like no  
> journal replay it makes sense to keep it per mount.  Which  
> indicates we could nose a nowrite option to express the per  
> vfsmount property.

Well, speaking of that; there's been another thread recently that's  
splitting the properties of read-only between vfsmount and  
superblock.  So a read-only superblock implies read-only vfsmounts,  
but the following can create a read-only vfsmount for a writable  
superblock:

   mount --bind / /mnt/read-only-root
   mount -o ro,remount /mnt/read-only-root

So the readonly special case will go away.

> I hope the confusion has passed for Trond.  My impression was he  
> figured this was per process data so it didn't make sense any where  
> near a filesystem, and the superblock was the last place it should be.

One of the things I said earlier in this thread is that "Both  
filesystems _and_ processes should be first-class objects in any UID  
namespace".  In order to have sufficient access controls in the  
presence of _only_ a UID-namespace (as opposed to with full container  
isolation), you need to check against an object *and* the namespace  
in which it is located.  In some cases, the object is a file, which  
means that the inode, vfsmount, or superblock need a UID namespace  
reference.  Theoretically a you could implement per-file UID  
namespace pointers, but that would probably be incredibly  
inefficient.  IMHO, per-vfsmount gives the best flexibility and  
efficiency of the three.

In fact, it's strange to think about this in context with the rest of  
the namespaces that are being designed, but processes would  
ordinarily *not* have primary presence in a UID namespace if they  
weren't the target of UID-verified operations in and of themselves  
(EX: kill, ptrace, etc).  Otherwise they would just have a set of  
(namespace,UID,cap_flags) pairs to give them access to filesystems in  
specific uid namespaces.

Cheers,
Kyle Moffett

