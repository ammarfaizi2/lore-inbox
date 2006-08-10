Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWHJSCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWHJSCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422675AbWHJSCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:02:44 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:60819 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422672AbWHJSCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:02:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pG/xW3UFIu0KrEq64o73P3VUhm3DKCReMRwANsfu+fUCTz7xM8D5XblPaeihr1hxH5oVwHkP+FFfuiuv1Ta7MpRqc9XDY43jOTYtwfm45V3W8U+Qtzyjk6AjxUl6w4y6ncLjaZ9a60bNSSm9VHXeC9wcdrV04OP7/TzEYaSOpB4=
Message-ID: <4ae3c140608101102j3ec28dccob94d407b9879aa86@mail.gmail.com>
Date: Thu, 10 Aug 2006 14:02:39 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: Urgent help needed on an NFS question, please help!!!
Cc: "Matthew Wilcox" <matthew@wil.cx>, "Neil Brown" <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1155230922.10547.61.camel@localhost>
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
	 <1155230922.10547.61.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Trond.

The device is subject to change when server reboot? I don't quite
understand. If the backing device at the server side is not changed,
how come server reboot will cause device ID change?

One possibilty that can cause device ID to change is exported device
change AFTER server reboots. But this can be detected by adding a
server generation number or device generation number. So maybe we can
say:  "In a single machine, inode+dev
ID+i_generation+server_generation can uniquely identify a file". Is
this true?

About your comment on the second conclusion, I already explained in
one of my previous email. We assume that both server and clients are
under our control. That is, we don't consider too much about
interoperability.  The file handle format will be static even the NFS
server is changed. Actually, in our inter-VM inode sharing scheme, we
don't even care about the normal file handle contents. Instead, we
only check our extended fields, which include: server-side inode
address, ino, dev info, i_generation and server_generation. An NFS
client first uses the server-side inode address to locate the inode
object in the server inode cache (we dynamically remapped the inode
cache into the client, in order to expedite metadata retrieval and
bypass inter-VM communication). After getting the inode object, the
NFS client has to validate this inode object corresponds to the file
handle so that it can read the right file attributes stored in the
inode. There are many possibilities that can cause a located inode
stores false information: the inode has been released because someone
on the server remove the file, the inode was filled by another file's
inode (other possibilities?).  So we must validate the inode before
using the file attributes retrieved from the mapped inode.

That's why we bring up this question.

Also, does someone compare NFS v4's delegation mechanism with the
speculative execution mechanism proposed in SOSP 2005
http://www.cs.cmu.edu/~dga/15-849/papers/speculator-sosp2005.pdf?

What are the pros and cons of these two mechanisms?

I put the content of my previous email below.
----My previous email ---
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


On 8/10/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Thu, 2006-08-10 at 12:23 -0400, Xin Zhao wrote:
> > That makes sense.
> >
> > Can we make the following two conclusions?
> > 1. In a single machine, inode+dev ID+i_generation can uniquely identify a file
>
> Not really. The device id is frequently subject to change on server
> reboot or device disconnect/reconnect.
>
> > 2. Given a stored file handle and an inode object received from the
> > server,  an NFS client can safely determine whether this inode
> > corresponds to the file handle by checking the inode+dev+i_generation.
>
> No! The file handle is an opaque bag of bytes as far as clients are
> concerned. If you change the server, then the filehandle format can and
> will change. On linux, even changing the setting of the subtree_checking
> export option will suffice to change the filehandle.
>
> Cheers,
>    Trond
>
>
