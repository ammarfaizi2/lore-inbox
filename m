Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUIHRNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUIHRNr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269202AbUIHRNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 13:13:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9724 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269198AbUIHRNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 13:13:37 -0400
Subject: Re: [PATCH 4/4] copyfile: copyfile
From: Steve French <smfltc@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
References: <20040907120908.GB26630@wohnheim.fh-wedel.de>
	 <20040907121118.GA27297@wohnheim.fh-wedel.de>
	 <20040907121235.GB27297@wohnheim.fh-wedel.de>
	 <20040907121520.GC27297@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.58.0409070656150.2299@ppc970.osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1094663397.22419.41.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Sep 2004 12:09:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-07 at 09:06, Linus Torvalds wrote:
> For cifs to be able to use it, the "copyfile()" interface needs to
> basically just be a pathname operation (ie a "dir->i_op->copy()"), not a
> "struct file" operation.  It's more like the VFS "->rename()" or "->link"
> operations, in other words. And it should return -EXDEV the same way
> rename returns EXDEV if the files aren't on the same filesystem.
>
> I think you should be able to copy the "sys_link()" code for almost all of 
> the top-level stuff. The only real difference being
> 
> -	error = dir->i_op->link(old_dentry, dir, new_dentry);
> +	error = dir->i_op->copy(old_dentry, dir, new_dentry);
> 
> answer may be that filesystems that don't support this as a "native op"  
> and can't do it quickly should just return an error, and then users can
> copy their multi-gigabyte files by hand, like they used to.

Yes - the CIFS protocol operation for copy requires syntax similar to
the link or rename examples.  The protocol operation for CIFS copy
requires:
1) a source filename (and a tree identifier - which identifies which
server export ie share the path is relative to)
2) a target filename (and target tree identifier)
3) source and target on the same server - The client filesystem can
enforce the last requirement that the source and target be on the same
server (although some servers also will reject it if the source and
target are not on the same filesystem on the same server) by simply
returning EXDEV to the VFS if the source and target are on different
servers.

Using a similar i_op to the link i_op contains sufficient information
for me to turn on the CIFSSMBCopy function in the fs/cifs code.

There are a couple of obvious copy options which probably could be
mapped onto the cifs network protocol but are not required.
4)Something like a "FAIL_IF_EXISTS" flag (do not copy the file if the
target file exists)
5) a "copy subtree" flag indicating whether the copy is for the
file/directory or for the whole subtree. 

As in link, returning an error when the filesystem can not perform the
operation should be expected by the layers above.

Defining a handle (file struct) based copy operation is not as useful. 

I believe that as a result of the copy request that most CIFS servers
typically would copy file attributes (such as in the case of cifs
servers the dos attributes) and extended attributes (xattrs, and NTFS
alternate data streams if the server supports them) but ACLs for the
existing file would not be copied to the new file.  That seems like
reasonable default common sense semantics. Allowing the client to
interrupt a network file copy that has been submitted to the server will
not always be possible, but it is at least easier to preserve atomicity
in the case of a single copy operation going over the network than it
would be if the copy is broken apart by the client and as individual
open/read/close open/write/close 



