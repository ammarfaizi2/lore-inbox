Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161473AbWHJRIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbWHJRIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWHJRIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:08:47 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:8940 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161464AbWHJRIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:08:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bszj7En8rw0BQRdrHY26358hXhqQurlu9gsIK7SzM/KDIYkbyNzIEJ0txk53L75SKlxL8qbaYbjvIr+v22iU+S/NDhu20Xyj1XgqwcFCLZkgUabQkA89lJV3QzNvR9RumC9AdvdnO8QR7kU1yG3JwYuMsGXm5tRTOD2YZnLk/Ww=
Message-ID: <4ae3c140608101008t4e9a4451r8d1a7bd3c49c4f8b@mail.gmail.com>
Date: Thu, 10 Aug 2006 13:08:45 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Matthew Wilcox" <matthew@wil.cx>
Subject: Re: Urgent help needed on an NFS question, please help!!!
Cc: "Neil Brown" <neilb@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060810165431.GD4379@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
	 <17626.49136.384370.284757@cse.unsw.edu.au>
	 <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com>
	 <17626.52269.828274.831029@cse.unsw.edu.au>
	 <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
	 <20060810161107.GC4379@parisc-linux.org>
	 <4ae3c140608100923j1ffb5bb5qa776bff79365874c@mail.gmail.com>
	 <20060810165431.GD4379@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well. For regular NFS, because it needs to consider interoperability,
it cannot use file handle as an opaque object.

However, in our case, we essentially derived a VM based data sharing
infrastructure from NFS. This would allow multiple virtual machines in
a single server to share data efficiently. With some tricks, we are
able to export inode cache from server to client. Also, we modify the
file handle composer to carry the server-side inode address, inode
number, i_gen, dev along with a file handle. Upon receiving a file
handle, a client can directly access the inode object in the exported
inode cache and bypass the inter-VM communication.

So, in our case, we don't need to consider interoperability (at least
for now), and we DO know the inode number, generation, as well as
exported device info.

I think this explains why I want to make sure the conclusion is right:

Conclusion: Given a stored file handle and an inode object received from the
server,  an NFS client can safely determine whether this inode
corresponds to the file handle by checking the inode+dev+i_generation.

Many thanks for this helpful discussion.

Xin

On 8/10/06, Matthew Wilcox <matthew@wil.cx> wrote:
> On Thu, Aug 10, 2006 at 12:23:12PM -0400, Xin Zhao wrote:
> > That makes sense.
> >
> > Can we make the following two conclusions?
> > 1. In a single machine, inode+dev ID+i_generation can uniquely identify a
> > file
>
> sure.
>
> > 2. Given a stored file handle and an inode object received from the
> > server,  an NFS client can safely determine whether this inode
> > corresponds to the file handle by checking the inode+dev+i_generation.
>
> The NFS client makes up its own inode numbers for use on the local
> machine.  It doesn't know the device+inode+generation numbers on the
> server (and indeed, the server may not even have the concepts of
> inodes).  To quote RFC 1813:
>
>    The file handle contains all the information the server needs to
>    distinguish an individual file.  To the client, the file handle is
>    opaque. The client stores file handles for use in a later request
>    and can compare two file handles from the same server for equality by
>    doing a byte-by-byte comparison, but cannot otherwise interpret the
>    contents of file handles. If two file handles from the same server
>    are equal, they must refer to the same file, but if they are not
>    equal, no conclusions can be drawn.  Servers should try to maintain
>    a one-to-one correspondence between file handles and files, but this
>    is not required. Clients should use file handle comparisons only to
>    improve performance, not for correct behavior.
>
