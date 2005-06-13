Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVFNAGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVFNAGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 20:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVFNAFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 20:05:20 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:7101 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261493AbVFNACO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 20:02:14 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <42AE1D4A.3030504@namesys.com>
Date: Mon, 13 Jun 2005 16:56:58 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: fs <fs@ercist.iscas.ac.cn>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com>
In-Reply-To: <20050613201315.GC19319@moraine.clusterfs.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>On Jun 13, 2005  10:59 -0700, Hans Reiser wrote:
>  
>
>>If you write a patch to implement 1a and 3a for reiserfs and reiser4 I
>>will accept them.  2a is too vague for me to support --- I can only
>>answer the question of whether error conditions are fs independent when
>>it is regarding specified error conditions.  I suspect there are times
>>when it needs to be fs dependent, but only a comprehensive review could
>>answer to that.
>>    
>>
>
>Hans, it would probably be preferrable to get ext2-like behaviour where
>action is configurable (see below),
>

> I personally would be annoyed if my
>workstation rebooted if there is a read error from the disk.
>  
>
My concern is that real users don't read their logs and won't notice
that a disk is going bad, and there is no effective method for the
kernel notifying userspace of an error requiring user attention.

However given the existence of USB drives and CDROMs with scratches I
concede the point.

>Better to mark filesystem read-only on error and continue to allow
>users to read from rest of filesystem than to just reboot the node.
>That is my experience in any case.  For those systems where there is
>e.g. an HA server with dual-channel disk it might be better to reboot
>and failover to another server, but even that isn't clear as a real
>media error will just cause both nodes to reboot endlessly instead of
>providing the best service they can.
>
>  
>
>>fs wrote:
>>    
>>
>>>Dear Linus, Andrew Morton, and all FS maintainers,
>>>1) When I/O failure occurs(e.g.: unrecoverable media failure - USB
>>>unplug), FS should
>>>  a. shutdown the FS right now(XFS does this)
>>>  b. try to make the media serve as long as possible(EXT3 remounts 
>>>     read-only, cache is still valid for read)
>>>  c. do not care, just print some kernel debugging info(EXT2 JFS 
>>>     ReiserFS)
>>>      
>>>
>
>Actually, 1b is just the default behaviour for ext3 (because of journal
>errors).  It is also possible to mount the filesystem with error=panic,
>which will implement 1a, and it is also possible to mount ext2 with
>error=remount-ro (which is default on Debian for ext2) which implements
>1b.  I don't think it is possible to get 1c behaviour for journal
>errors on ext3.
>
>  
>
>>>2) When I/O failure occurs, FS should
>>>  a. give a unified error
>>>  b. give errors according to the FS type
>>>      
>>>
>
>What is "unified error"?  Does this mean "-EIO" for all cases?  I also
>don't understand why this is so important to your application...  If
>you get an error back from the filesystem that isn't expected, that is
>generally a problem regardless of what the error is...
>
>  
>
>>>3) the returned errno should be
>>>  a. real cause of failure, e.g. USB unplug returns EIO
>>>  b. cause from FS, e.g. USB unplug made FS remount read-only,
>>>     so open(O_RDONLY) returns ENOENT while open(O_RDWR) returns
>>>     EROFS
>>>  c. errno means nothing, you already get -1, that's enough
>>>      
>>>
>
>This doesn't make sense.  If the "real cause of failure" is that the
>journal code detected an inconsistency (it might not be an IO error at
>the time, just some structure that is not what it should be, maybe the
>user tried to format their partition while in use ;-) then the real
>error is that the journal turned the filesystem read-only.  In any case,
>you can't expect to get more information that "EIO", regardless of the
>root cause (e.g. ENOMEM causes async buffer read to not complete, caller
>checks buffer_uptodate() and it isn't uptodate, returns EIO).
>  
>
Well, maybe we should fix this. Or at least be open to his writing a
patch to fix it.

EIO is simply not enough information, don't you agree? i mean, if the
USB drive got unplugged, for us to say IO error rather than "hey you,
where'd the USB drive go? Plug it back in, or I can't do nothing!" and
to distinguish it from some other complex error due to software bugs in
the filesystem is to fail to understand the information needs of the
seven year old using the laptop. The seven year old probably can't cope
with debugging the filesystem's software error, but plugging the USB
drive back in he can do....

>Cheers, Andreas
>--
>Andreas Dilger
>Principal Software Engineer
>Cluster File Systems, Inc.
>
>
>
>  
>

