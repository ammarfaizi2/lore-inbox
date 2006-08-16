Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWHPM63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWHPM63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWHPM63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:58:29 -0400
Received: from ihug-mail.icp-qv1-irony4.iinet.net.au ([203.59.1.198]:44205
	"EHLO mail-ihug.icp-qv1-irony4.iinet.net.au") by vger.kernel.org
	with ESMTP id S1751040AbWHPM62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:58:28 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.08,132,1154880000"; 
   d="scan'208"; a="855270844:sNHT70629588"
Subject: Re: 2.6.18-rc4-mm1
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <6237.1155731027@warthog.cambridge.redhat.com>
References: <30157.1155722439@warthog.cambridge.redhat.com>
	 <29660.1155720852@warthog.cambridge.redhat.com>
	 <20060815114912.d8fa1512.akpm@osdl.org>
	 <20060815104813.7e3a0f98.akpm@osdl.org>
	 <20060815065035.648be867.akpm@osdl.org>
	 <20060814143110.f62bfb01.akpm@osdl.org>
	 <20060813133935.b0c728ec.akpm@osdl.org>
	 <20060813012454.f1d52189.akpm@osdl.org>
	 <10791.1155580339@warthog.cambridge.redhat.com>
	 <918.1155635513@warthog.cambridge.redhat.com>
	 <29717.1155662998@warthog.cambridge.redhat.com>
	 <6241.1155666920@warthog.cambridge.redhat.com>
	 <6237.1155731027@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 20:58:28 +0800
Message-Id: <1155733108.22077.8.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 13:23 +0100, David Howells wrote:

> And saw the following appear in the kernel log around the problem bit for
> trash:/usr:
> 
> | ...
> | SELinux: initialized (dev 0:18, type nfs), uses genfs_contexts
> | audit(1155729189.533:468): avc:  denied  { read } for  pid=6472 comm="automount" name="cambridge-temp.redhat.com.2" dev=hda2 ino=688243 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:var_yp_t:s0 tclass=file
> | audit(1155729189.557:469): avc:  denied  { name_bind } for  pid=6472 comm="automount" src=716 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:reserved_port_t:s0 tclass=udp_socket
> 
> Not sure what's going on here.  The automounter tried to do bind a socket to a
> reserved port perhaps and was denied.

Possibly an RPC ping.
That's about the only thing I do that does net connects.

> 
> | NFS: nfs_update_inode(0:18/2 ct=1 info=0x6)
> | NFS: permission(0:18/2), mask=0x1, res=0
> 
> sys_mkdirat() calls do_path_lookup(), which checks MAY_EXEC on the dir.
> 
> | NFS: permission(0:18/2), mask=0x1, res=0
> 
> lookup_create() is called.  This calls __lookup_hash(), which checks MAY_EXEC
> on the dir.
> 
> | -->nfs_lookup(,usr,{200,80,44e3069a})
> 
> __lookup_hash() then looks up the new dentry with intent to create:
> 
> 	VARIABLE			VALUE
> 	===============================	===============================
> 	nd->flags			LOOKUP_CREATE
> 	nd->intent.open.flags		O_EXCL
> 	nd->intent.open.create_mode	weird value, even in octal

I'm fairly sure there's a race in autofs for the create case. I've tried
to work a solution in the past but haven't been successful yet. In any
case autofs should not allow anyone else besides the daemon to do
anything in the autofs fs. It's been a while but I think this case leads
to a deadlock.

> 
> This means that nfs_lookup() considers this to be "an exclusive create" of
> this node, and dispenses with the LOOKUP RPC call to the server.
> 
> | NFS: lookup(/usr)
> | exlusive_create
> 
> Just to confirm that the lookup is skipped.
> 
> | <--nfs_lookup() = 00000000
> 
> We return the dentry we were given, but don't return an error.  The dentry we
> were given is left negative (on the assumption it's about to be created), but
> does get attached to the directory.
> 
> | NFS: permission(0:18/2), mask=0x3, res=0
> 
> vfs_mkdir() calls may_create() which checks that the directory has MAY_WRITE
> and MAY_EXEC permissions.  This firstly calls nfs_permission, which grants
> permission.
> 
> | audit(1155729189.605:470): avc:  denied  { write } for  pid=6472 comm="automount" name="" dev=0:18 ino=2 scontext=root:system_r:automount_t:s0 tcontext=system_u:object_r:nfs_t:s0 tclass=dir
> 
> And secondly calls security_inode_permission() though which SELinux which
> _denies_ permission.
> 
> | NFS: dentry_delete(/usr, 0)
> 
> vfs_mkdir() returns -ENOACCES to sys_mkdirat() which releases its hold on the
> dentry, but leaves the negative dentry attached to the directory.
> 
> 
> The negative dentry wouldn't normally be a problem, even though it's attached
> to its parent directory... except for the small matter that it's subsequently
> listed in a directory read operation.

Surely this dentry should also be unhashed at some point.
Wouldn't that be a sensible result of the failed operation?
It wouldn't then show up in a listing and the fs should normally be able
to deal with these.

Ian

