Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265083AbSJRMxQ>; Fri, 18 Oct 2002 08:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265089AbSJRMxQ>; Fri, 18 Oct 2002 08:53:16 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:59616 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP
	id <S265083AbSJRMxP>; Fri, 18 Oct 2002 08:53:15 -0400
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: block allocators and LVMs
Message-ID: <1034946264.3db006d87c82c@imp.free.fr>
Date: Fri, 18 Oct 2002 15:04:24 +0200 (CEST)
From: christophe.varoqui@free.fr
Cc: linux-kernel@vger.kernel.org
References: <3DA24B4A0064C333@mel-rta8.wanadoo.fr> <20021018112617.GA1942@fib011235813.fsnet.co.uk>
In-Reply-To: <20021018112617.GA1942@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 171.16.0.177
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

En réponse à Joe Thornber <joe@fib011235813.fsnet.co.uk>: 
 
> Christophe, 
> > the role of intelligent block allocators and/or online FS 
> > defragmentation could be replaced by a block remapper in the 
> > LVM subsystem. 
>  
> Crazy idea :) 
>  
> I think this is best left to the fs to handle, mainly because the 
> blocks that the fs deals with are so small.  You would end up with 
> *huge* remapping tables.  Also you would need to spend a lot of time 
> collecting the information neccessary calculate the remapping, to do 
> it properly you'd need to record an ordering of data acccesses not 
> just io counts (ie. so you could build a Markov chain). 
>  
 
I realize I didn't pick the right words (from my poor English 
dictionnary) : I meant an extend remapper rather than a block remapper. 
 
As far as I can see, this task can be done entirely from userland : 
 
o per-extend IO counters exported from kernel-space can be turned into 
  a list of extends sorted by activity 
 
o lvdisplay-like tool gives the mapping extend<->physical blocks 
 
o a scheduled job in user-space should be able to massage this info to 
  decide where to move low-access-rate-extends to the border of the 
  platter and pack high-access-rate-extends together ... all in one run 
  that can be scheduled at low activity period (cron defrag way) 
 
The algorithm could be something along the line of : 
 
while top_user_queue_not_empty 
do 
  extend = dequeue_lowest_user_extend 
  if extend_in_good_spot 
  then 
    move_extend_to_corner_destination 
    find_highest_user_extend_in_bad_spot 
    move_this_extend_to_freed_good_spot 
  fi 
done 
 
 
This sort of extend reordering is done in some big Storage Arrays like 
StorageWorks EVA110 (as far as I know : they are very secretive on the 
subject). 
