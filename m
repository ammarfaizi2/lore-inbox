Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313455AbSDPBlX>; Mon, 15 Apr 2002 21:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313457AbSDPBlW>; Mon, 15 Apr 2002 21:41:22 -0400
Received: from unthought.net ([212.97.129.24]:39335 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S313455AbSDPBlV>;
	Mon, 15 Apr 2002 21:41:21 -0400
Date: Tue, 16 Apr 2002 03:41:20 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: davem@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
Message-ID: <20020416034120.R18116@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Hirokazu Takahashi <taka@valinux.co.jp>, davem@redhat.com,
	ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020412.143934.33012005.davem@redhat.com> <20020415.103013.62679757.taka@valinux.co.jp> <20020414.212308.33849971.davem@redhat.com> <20020416.100302.129343787.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 10:03:02AM +0900, Hirokazu Takahashi wrote:
> Hi, David
> 
...
> 
> Yes, it seems to be the most general way.
> OK, I'll do this way first of all.
> 
> In the kernel, probaboly I'd impelement as following:
> 
> 	put a RPC header and a NFS header on "bufferA";
> 	down(semaphore);
> 	sendmsg(bufferA, MSG_MORE);
> 	for (eache pages of fileC)
> 		sock->opt->sendpage(page, islastpage ? 0 : MSG_MORE)
> 	up(semaphore);
> 
> the semaphore is required to serialize sending data as many knfsd kthreads
> use the same socket.

Won't this serialize too much ?  I mean, consider the situation where we
have file-A and file-B completely in cache, while file-C needs to be
read from the physical disk.

Three different clients (A, B and C) request file-A, file-B and file-C
respectively. The send of file-C is started first, and the sends of files
A and B (which could commence immediately and complete at near wire-speed)
will now have to wait (leaving the NIC idle) until file-C is read from
the disks.

Even if it's not the entire file but only a single NFS request (probably 8kB),
one disk seek (7ms) is still around 85 kB, or 10 8kB NFS requests (at 100Mbit).

Or am I misunderstanding ?   Will your UDP sendpage() queue the requests ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
