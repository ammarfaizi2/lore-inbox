Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276089AbRI1OtI>; Fri, 28 Sep 2001 10:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276088AbRI1Oss>; Fri, 28 Sep 2001 10:48:48 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:8364 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S276087AbRI1Osi>; Fri, 28 Sep 2001 10:48:38 -0400
Date: Fri, 28 Sep 2001 16:48:57 +0200
Message-Id: <200109281448.f8SEmvh08284@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: "Joachim Weller" <JoachimWeller@web.de>
To: "ChristophHellwig" <hch@ns.caldera.de>,
        "Joachim Weller" <joachim_weller@hsgmed.com>
Cc: axboe@suse.de, JoachimWeller@web.de, linux-kernel@vger.kernel.org
Subject: Re: Re: BUG: cat /proc/partitions endless loop
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@ns.caldera.de> schrieb am 28.09.01:
> In article <200109281315.f8SDFpA01669@bmdipc2c.germany.agilent.com> you wrote:
> >  I traced the problem down to drivers/block/genhd.c, 
> > where the function get_partition_list() outer loop does not 
> > terminate due to the last element in the structured list starting 
> > with gendisk_head is not initialized to NULL, by whatever reason.
> > My fix does not cure the pointered endless loop, but prevents
> > from looping when stepping thru the pointered list.
> 
> I think the fix could be simpler.  What about:
[...] 

> + for (gp = gendisk_head; gp != gendisk_head; gp = gp->next) {

This will break your for loop immedeately, because the loop criteria
is already violated by the initialization !

But I tried another solution:
  for (gp = gendisk_head; gp && (gp->next != gendisk_head); gp = gp->next) {

with no success - the cat /proc/partition only printed the heading line.
This proofed to me, that the pointered list is created the wrong way,
in other words, gendisk_head->next is a pointer to itself.
It looks to me, that the "next" field in 
/*static*/ struct gendisk *gendisk_head;
is not initialized (by the compiler ?) correctly to NULL. 




>     if (gp->part[n].nr_sects == 0)
>      continue;
> 
>  


_______________________________________________________________________
1.000.000 DM gewinnen - kostenlos tippen - http://millionenklick.web.de
IhrName@web.de, 8MB Speicher, Verschluesselung - http://freemail.web.de


