Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319261AbSIFRRv>; Fri, 6 Sep 2002 13:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319262AbSIFRRu>; Fri, 6 Sep 2002 13:17:50 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1040 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S319261AbSIFRRt>;
	Fri, 6 Sep 2002 13:17:49 -0400
Message-ID: <3D78E44E.5020107@namesys.com>
Date: Fri, 06 Sep 2002 21:22:22 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: "Stephen C. Tweedie" <sct@redhat.com>, Aaron Lehmann <aaronl@vitelus.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 throughput woes on certain (possibly heavily fragmented)
 files
References: <20020903092419.GA5643@vitelus.com>	<20020906170614.A7946@redhat.com> <15736.57972.202889.872554@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Stephen C. Tweedie writes:
> > Hi,
> > 
> > On Tue, Sep 03, 2002 at 02:24:19AM -0700, Aaron Lehmann wrote:
> > 
> > > [aaronl@vitelus:~]$ time cat mail/debian-legal > /dev/null
> > > cat mail/debian-legal > /dev/null  0.00s user 0.02s system 0% cpu 5.565 total
> > > [aaronl@vitelus:~]$ ls -l mail/debian-legal
> > > -rw-------    1 aaronl   mail      7893525 Sep  3 00:42 mail/debian-legal
> > > [aaronl@vitelus:~]$ time cat /usr/src/linux-2.4.18.tar.bz2 > /dev/null
> > > cat /usr/src/linux-2.4.18.tar.bz2 > /dev/null  0.00s user 0.10s system 16% cpu 0.616 total
> > > [aaronl@vitelus:~]$ ls -l /usr/src/linux-2.4.18.tar.bz2 
> > > -rw-r--r--    1 aaronl   aaronl   24161675 Apr 14 11:53
> > > 
> > > Both files were AFAIK not in any cache, and they are on the same
> > > partition.
> > > 
> > > My current uninformed theory is that this is caused by fragmentation,
> > > since the linux tarball was downloaded all at once but the mailbox I'm
> > > comparing it to has 1695 messages, each of which having been appended
> > > seperately to the file. All of my mailboxes exhibit similarly awful
> > > performance.
> > 
> > Yep, both ext2 and ext3 can get badly fragmented by files which are
> > closed, reopened and appended to frequently like that.
> > 
> > > Do any other filesystems handle this type of thing more gracefully?
> > 
> > There are some ideas from recent FFS changes.  One thing they now do
> > is to defragment things automatically as a file grows by effectively
> > deleting and then reallocating the last 16 blocks of the file.
> > Fragmentation will still occur, but less so, if we do that.
> > 
>
>Another possible solution is to try to "defer" allocation. For example,
>in reiser4 (and XFS, I believe) extents are allocated on the transaction
>commit and as a result, if file was created by several writes, it will
>still be allocated as one extent.
>
> > 
> > Cheers,
> >  Stephen
>
>Nikita.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
The FFS approach has an advantage for the case where the file grows too 
slowly for allocation to be delayed.

I think I prefer that we implement a repacker for reiser4 though, as 
that, combined with delayed allocation, will be a balanced and thorough 
solution.

Hans


