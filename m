Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266160AbSLCIRI>; Tue, 3 Dec 2002 03:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266144AbSLCIRI>; Tue, 3 Dec 2002 03:17:08 -0500
Received: from [213.213.74.131] ([213.213.74.131]:6041 "EHLO percy.comedia.it")
	by vger.kernel.org with ESMTP id <S266135AbSLCIRF>;
	Tue, 3 Dec 2002 03:17:05 -0500
Date: Tue, 3 Dec 2002 09:24:33 +0100
From: Luca Berra <bluca@comedia.it>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021203082432.GB11862@percy.comedia.it>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com> <20021122101301.GB1508@reti> <15851.53969.794768.513642@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <15851.53969.794768.513642@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 08:38:25AM +1100, Neil Brown wrote:
>> 1) Building a mirror is essentially just copying large amounts of data
>>    around, exactly what is needed to implement move functionality for
>>    arbitrarily remapping volumes.  (see
>>    http://people.sistina.com/~thornber/pvmove_outline.txt).
>
>Building a mirror may be just moving data around. But the interesting
>issues in raid1 are more about maintaining a mirror:  read balancing,
>retry on error, hot spares, etc.

true, that's why LVM (dm) should use md for the raid work.

>> 
>> 2) Extending raid 5 volumes becomes very simple if they are dm targets
>>    since you just add another segment, this new segment could even
>>    have different numbers of stripes.  eg,
>> 
>But is this something that you would *want* to do???
>
>To my mind, the raid1/raid5 almost always lives below any LVM or
>partitioning scheme.  You use raid1/raid5 to combine drives (real,
>physical drives) into virtual drives that are more reliable, and then
>you partition them or whatever you want to do.  raid1 and raid5 on top
>of LVM bits just doesn't make sense to me.
well to me does:
- you might want to split a mirror of a portion of data for backup
  purposes (when snapshots won't do) or for safety before attempting a
  risky operation.
- you might also want to have different raid strategies for different
  data. Think a medium sized storage with oracle, you might want to do
  a fast mirror for online redo logs(1) and raid5 for datafiles.(2)
- you might want to add mirroring after having put data on your disks
  and the current way to do it with MD on partitions is complex, with
  LVM over MD is really hard to do right.
- stackable devices are harder to maintain, a single interface to deal
  with mirroring and volume management would be easier.
- we wont have any more problems with 'switching cache buffer size' :))))

(1) yes i know they are mirrored by oracle, but having a fs unavailable
due to disk failure is a pita anyway
(2) a dba will tell you to use different disks, but i never found
anyone willing to use 4 73Gb disks for redo logs
  

>[[ I just had this really sick idea of creating a raid level that did
>data duplication (aka mirroring) for the first N stripes, and
I had another sick idea of teaching lilo how to do raid5, but it won't
fit in 512b. anyway for the normal MD on partitions case creating one
n-way raid1 for /boot and raid5 for the rest

>I really think the raid1/raid5 parts of MD are distinctly different
>from DM, and they should remain separate.  However I am quite happy to
>improve the interfaces so that seamless connections can be presented
>by user-space tools.

reading this it looks like that the only way dm could get raid is
reimplementing or duplicating code from existing md, thus duplicating
code in the kernel.

>To summarise:  If you want tigher integration between MD and DM, do it
>by defining useful interfaces, not by trying to tie them both together
>into one big lump.

we can think of md split in those major areas
1 the superblock interface, which i believe we all agree should go to
  user mode for all the array setup function, and should keep the
  portion for updating superblock in kernel space.
2 the raid logic code
3 the interface to lower block device layer
4 the interface to upper block device layer
(in md these 3 are thightly coupled)

some of these areas overlap with dm and it could be possible to merge
the duplicated functionality.

having said that and having looked 'briefly' at the code i believe that
doing something like this would mean reworking completely the logic
behind md, and adding some major parts to dm, or better to a separate
module.

in my idea we will have
a core that handles request mapping
metadata plugins for both md superblock format and lvm metadata (those
        would deal with keeping the metadata current with the array
        current status)
layout plugins for raid?, striping, linear, multipath (does this belong
        here or at a different level?)

L.

-- 
Luca Berra -- bluca@comedia.it
        Communication Media & Services S.r.l.
 /"\
 \ /     ASCII RIBBON CAMPAIGN
  X        AGAINST HTML MAIL
 / \
