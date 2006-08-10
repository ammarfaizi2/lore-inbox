Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWHJW2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWHJW2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 18:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWHJW2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 18:28:34 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:4817 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751491AbWHJW2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 18:28:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UswGwin50wB3zzok/5t19Z5qC31517BYyfz/6wD+w2p4Y1419BnoJhNLR/bNOPbI5LcEhljJTqRYti7nd0jzpxuj2i85SMkPeGfGBT8J+0oCqfw+Qk9kOHJ0ojK+9iy7ia6c8dOI7cwwWuR7bW+qv+m8AgHuebDla6rbY+r53qs=
Message-ID: <4ae3c140608101528s69c50e2do554e0b908c2a1cf1@mail.gmail.com>
Date: Thu, 10 Aug 2006 18:28:31 -0400
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

Also, delegations are about caching. That's true. It improve NFS
performance because a client with a lease does not need to worry about
server change and can manipulate files using local cache.  But if
speculative execution can achieve the same goal without incurring the
cost of lease renewal and revoke, delegation becomes less useful.

So my question is essentially: if speculative execution is there, why
do we still need delegation? Can delegation do anything better?

Xin

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
