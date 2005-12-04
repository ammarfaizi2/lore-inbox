Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVLDWNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVLDWNm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVLDWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:13:42 -0500
Received: from mx1.suse.de ([195.135.220.2]:37044 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932300AbVLDWNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:13:41 -0500
From: Neil Brown <neilb@suse.de>
To: "Larry Bates" <lbates@syscononline.com>
Date: Mon, 5 Dec 2005 09:13:26 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17299.27142.901162.564588@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>, linux-raid@vger.kernel.org
Subject: Re: newbie - mdadm create raid1 mirrors on large drives
In-Reply-To: message from Larry Bates on Saturday December 3
References: <002501c5f835$cb6bec50$1e00a8c0@LABWXP>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday December 3, lbates@syscononline.com wrote:
> I hope this is the correct list for this question.

 linux-raid@vger.kernel.org is possibly better, but linux-kernel is
 probably a suitable catch-all.

> 
> I've just recently begun using mdadm to set up some
> arrays using large drives (300-400Gb).  One of the 
> things I don't understand is this: when you first 
> create a raid1 (mirrored) array from two drives 
> mdadm insists on mirroring the contents of the first
> drive to the second even though the drives are
> entirely blank (e.g. new drives don't have anything
> on them).  

Well... they do have something one them - lots of zeros and ones, or
maybe just zeros, or maybe just ones.  Sure, you may not be interested
in that data, but it is there.


>            In one configuration I have, this takes
> about 16 hours on a 400Gb drive.  When I do 5 of them
> simultaneously this takes 2+ days to complete.  Is 
> there some way to tell mdadm that you want to create 
> a mirrored set but skip this rather long initial 
> mirroring process?  I don't really see that it actually
> accomplishes anything.

No, there is no way to tell mdadm to skip the initial copying
process.  It is not clear to me that you really want to do this(*)
(though on the "enough rope" principle I'm probably going to extend
the "--assume-clean" option to work in --create mode).

I suggest you simply ignore the fact that it is doing the copy.  Just
keep using the array as though it wasn't.  If this seems to be
impacting over-all system performance, tune /proc/sys/dev/raid/speed_*
to slow it down even more.
If you reboot, it should remember where it was up to and restart from
the same place (providing you are using a 2.6 kernel).

If you have 5 of these 400Gb raid1's, then I suspect you really want
to avoid the slow resync that happens after a crash.  You should look
into adding a bitmap write-intent log.  This requires 2.6.14, and
mdadm 2.1, and is as easy as
   mdadm --grow --bitmap=internal /dev/md3
while the array is running.

This should dramatically reduce resync time, at a possible small cost
in write throughput.  Some limited measurements I have done suggest
up-to 10% slowdown, though usually less.  Possibly some tuning can
make it much better.

(*)
A raid array can suffer from sleeping bad blocks.  i.e. blocks that
you cannot read, but normally you never do (because they haven't been
allocated to a file yet).  When a drive fails, and you are
recovering the data onto a spare, hitting that sleeper can kill your
array. 
For this reason it is good to regularly (daily, or weekly, maybe
monthly) read through the entire array making sure everything is OK.
In 2.6.16 (with complete functionality in 2.6.17) you will be able to
trigger a background read-test of the whole array:
  echo check > /sys/block/mdX/md/sync_action

If you were to create an array with --assume-clean, then whenever you
run this it will report lots of errors, though you can fix them with
   echo repair > /sys/block/mdX/md/sync_action

If you are going to be doing that (and I would recommend it) then you
may as well allow the initial sync, especially as you can quite
happily ignore the fact that it is happening.

NeilBrown
