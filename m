Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSJNOBP>; Mon, 14 Oct 2002 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSJNOBO>; Mon, 14 Oct 2002 10:01:14 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:9645 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261660AbSJNOBO>; Mon, 14 Oct 2002 10:01:14 -0400
Message-ID: <003401c2738b$ccfe2010$2b060e09@beavis>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: <neilb@cse.unsw.edu.au>, "Hirokazu Takahashi" <taka@valinux.co.jp>
Cc: <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
       <nfs@lists.sourceforge.net>
References: <20020918.171431.24608688.taka@valinux.co.jp><15786.23306.84580.323313@notabene.cse.unsw.edu.au> <20021014.210144.74732842.taka@valinux.co.jp>
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
Date: Mon, 14 Oct 2002 09:12:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello, Neil
>
> > > I ported the zerocopy NFS patches against linux-2.5.36.
> >
> > hi,
> >  I finally got around to looking at this.
> >  It looks good.
>
> Thanks!
>
> >  However it really needs the MSG_MORE support for udp_sendmsg to be
> >  accepted before there is any point merging the rpc/nfsd bits.
> >
> >  Would you like to see if davem is happy with that bit first and get
> >  it in?  Then I will be happy to forward the nfsd specific bit.
>
> Yes.
>
> >  I'm bit I'm not very sure about is the 'shadowsock' patch for having
> >  several xmit sockets, one per CPU.  What sort of speedup do you get
> >  from this?  How important is it really?
>
> It's not so important.
>
> davem> Personally, it seems rather essential for scalability on SMP.
>
> Yes.
> It will be effective on large scale SMP machines as all kNFSd shares
> one NFS port. A udp socket can't send data on each CPU at the same
> time while MSG_MORE/UDP_CORK options are set.
> The UDP socket have to block any other requests during making a UDP frame.

I experienced this exact problem a few months ago.  I had a test where
several clients read a file or files cached on a linux server.  TCP was just
fine, I could get 100% CPU on all CPUs on the server.  TCP zerocopy was even
better, by about 50% throughput.  UDP could not get better than 33% CPU, one
CPU working on those UDP requests and I assume a portion of another CPU
handling some inturrupt stuff.  Essentially 2P and 4P throughput was only as
good as UP throughput.  It is essential to get scaling on UDP.  That
combined with the UDP zerocopy, we will have one extremely fast NFS server.

Andrew Theurer
IBM LTC

