Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312982AbSDEPZx>; Fri, 5 Apr 2002 10:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDEPZn>; Fri, 5 Apr 2002 10:25:43 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:15083 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S312982AbSDEPZa>;
	Fri, 5 Apr 2002 10:25:30 -0500
Message-ID: <3CADC0AD.4080601@sgi.com>
Date: Fri, 05 Apr 2002 09:20:13 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
CC: linux-kernel@vger.kernel.org, linux-xfs@thebarn.com, mkp@mkp.net
Subject: Re: REPOST : linux-2.5.5-xfs-dj1 - 2.5.7-dj2  (raid0_make_request bug)
In-Reply-To: <3CAD8B9D.8070902@st-peter.stw.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

svetljo wrote:

> Hi
> i'd like to ask you to CC me because i'm not subscribed to the lists
>
> i'm having some interesting troubles
> i have lvm over soft RAID-0 with LV's formated with XFS and JFS
> i can work with the JFS LV's,
>   but i can not with the XFS one's, i can not mount them ( no troubles
> with XFS normal partitions)
>
> so
> i'd like to ask is this problem with XFS or with raid or lvm
> and is there a way to fix it
>
> thanks for your help
>
> here is what i found in dmesg
>
>
> XFS mounting filesystem lvm(58,2)
> raid0_make_request bug: can't convert block across chunks or bigger than
> 16k 8323317 64
> raid0_make_request bug: can't convert block across chunks or bigger than
> 16k 8323445 64
> I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block
> 0x601f7d
>         ("xlog_bread") error 5 buf count 131072
> raid0_make_request bug: can't convert block across chunks or bigger than
> 16k 8324829 29
> I/O error in filesystem ("lvm(58,2)") meta-data dev 0xc0223a02 block
> 0x602565
>         ("xlog_bread") error 5 buf count 30208
>

This is your problem, in the 2.5 code base, the bio infrastructure and the
raid code do not work well together. It is being worked on - slowly.

If you want to dumb down xfs to make it function then I suspect you
can do it by editing

    fs/xfs/pagebuf/page_buf.c

looking for the line which uses BIO_MAX_SECTORS and replace

    nr_pages = BIO_MAX_SECTORS >> (PAGE_SHIFT - 9);

with

    nr_pages = 1;

And for extra bonus points, only do it when pb->pb_dev is on the
MD_MAJOR device.

This will make xfs send smaller bio structures down to the block
layer and hopefully avoid the problem.

I have not tested this - don't have any time right now, on a plane
in 6 hours and way too much to do.

Steve


