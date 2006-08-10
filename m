Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWHJWZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWHJWZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWHJWZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:25:29 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:31430 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751228AbWHJWZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:25:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pprIr0SdJa9n7UapeD4vtUjXVArVlcD9akqK5x4PYLFgOcZAM6DvW2RzYEDIur5LdDyqqiT2Otl6i6mJonS6NXPcvUWTumhkqlDwDT4bMeBTcRESqyc3RFtSHn8cWxZT0v3Aj25ddkE6L2Dnh4W7QOIV10zSiwq2ziIwNcVGaf4=
Message-ID: <4ae3c140608101525u7b6eeaebjca351ba850173544@mail.gmail.com>
Date: Thu, 10 Aug 2006 18:25:25 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: Urgent help needed on an NFS question, please help!!!
Cc: "Matthew Wilcox" <matthew@wil.cx>, "Neil Brown" <neilb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1155239982.5826.24.camel@localhost>
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
	 <4ae3c140608101102j3ec28dccob94d407b9879aa86@mail.gmail.com>
	 <1155239982.5826.24.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The inter-VM inode helps reduce communication cost used to retrieve
file attributes in a VM environment. In a network environment, it is
possible for a client to direct see the inode caches of the server.
But in the virtual server environment, where both client and server
running on the same physical host, this would be possible.

If clients have read-only access to server's inode cache, they can
directly retrieve file attributes without incurring expensive
getattr() rpc call. Of couse the delegation is able to allow a client
to trust local cached file attributes without worry about server
change. But this only works when file is not shared by multiple
clients. Right? Does NFS4 has some other mechanisms that can further
improve performance on metadata access?

Thanks,
-x

On 8/10/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> On Thu, 2006-08-10 at 14:02 -0400, Xin Zhao wrote:
> > Thanks. Trond.
> >
> > The device is subject to change when server reboot? I don't quite
> > understand. If the backing device at the server side is not changed,
> > how come server reboot will cause device ID change?
>
> Things like USB, firewire, and fibre channel allocate their device ids
> on the fly. There is no such thing as a fixed device id in those cases.
>
> > About your comment on the second conclusion, I already explained in
> > one of my previous email. We assume that both server and clients are
> > under our control. That is, we don't consider too much about
> > interoperability.  The file handle format will be static even the NFS
> > server is changed. Actually, in our inter-VM inode sharing scheme, we
> > don't even care about the normal file handle contents. Instead, we
> > only check our extended fields, which include: server-side inode
> > address, ino, dev info, i_generation and server_generation. An NFS
> > client first uses the server-side inode address to locate the inode
> > object in the server inode cache (we dynamically remapped the inode
> > cache into the client, in order to expedite metadata retrieval and
> > bypass inter-VM communication). After getting the inode object, the
> > NFS client has to validate this inode object corresponds to the file
> > handle so that it can read the right file attributes stored in the
> > inode. There are many possibilities that can cause a located inode
> > stores false information: the inode has been released because someone
> > on the server remove the file, the inode was filled by another file's
> > inode (other possibilities?).  So we must validate the inode before
> > using the file attributes retrieved from the mapped inode.
> >
> > That's why we bring up this question.
>
> Why do this, when people are working on standards and implementations
> for doing precisely the above within the NFSv4 protocol?
>
> > Also, does someone compare NFS v4's delegation mechanism with the
> > speculative execution mechanism proposed in SOSP 2005
> > http://www.cs.cmu.edu/~dga/15-849/papers/speculator-sosp2005.pdf?
> >
> > What are the pros and cons of these two mechanisms?
>
> Delegations are all about caching. This paper appears to be about
> getting round the bottlenecks due to synchronous operations. How are the
> two issues related?
>
> Cheers,
>   Trond
>
>
