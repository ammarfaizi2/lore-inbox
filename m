Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269274AbRHWRal>; Thu, 23 Aug 2001 13:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269197AbRHWRad>; Thu, 23 Aug 2001 13:30:33 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:51269 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269223AbRHWRaV>; Thu, 23 Aug 2001 13:30:21 -0400
Message-ID: <3B853DB2.3060704@redhat.com>
Date: Thu, 23 Aug 2001 13:30:26 -0400
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andris Pavenis <pavenis@latnet.lv>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810 audio doesn't work with 2.4.9
In-Reply-To: <E15ZGQv-0008Qb-00@the-village.bc.nu> <200108220848.f7M8mVh00441@hal.astr.lu.lv> <3B850C9A.7080002@redhat.com> <200108231715.f7NHFGx00363@hal.astr.lu.lv>
Content-Type: text/plain; charset=ISO-8859-13; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis wrote:
> On Thursday 23 August 2001 17:00, Doug Ledford wrote:
> 
>>Andris Pavenis wrote:
>>
>>>Got incremental diffs between ac versions since 2.4.5.
>>>Applied all diffs to 2.4.5 version of i810_audio.c except one between
>>>2.4.6-ac1 and 2.4.6-ac2 As result i810 audio seems to work
>>>
>>Can you send me that incremental patch you left out.  I would like to
>>look at it to see what's going on.
>>
>>
> 
> i810_audio.c works for me if all patches except following is aplied (it's a part of update
> from 2.4.6-ac1 to 2.4.6-ac2)

[snip]

OK, now I know what is going on.  The change you reference was added to 
the i810 driver because some software (mpg123) could fall behind to the 
point that they drained the buffer, then when they refilled it 
(according to the value sent by the GETOSPACE ioctl), it would cause the 
LVI == CVI and the i810 chipset would essentially stop playing.  This 
made it so that we would wait for the LVI != CVI before we wrote all the 
data into the buffer.  Unfortunately, because artsd in particular opens 
the file in non-blocking mode, we only write as much data as is allowed 
before we hit the simplistic "always write actual space - fragsize bytes 
to avoid the LVI == CVI lockup" issue.  Therefore, artsd would check the 
GETOSPACE ioctl, try to write that amount of data, the write routine 
doesn't write the full amount because of the workaround, we return less 
than a full write, artsd immediately tries to write more, we get in an 
endless loop that wastes lots of CPU cycles.  I'll improve the free 
space calculation and then implement it in both the write and GETOSPACE 
areas so that the return from GETOSPACE is in fact the amount of data we 
will allow to be written.  That will solve the problem for both the 
artsd and the mpg123 cases. (I'll likewise have to do something similar 
with read and GETISPACE, and I'll have to verify that GETOPTR and 
GETIPTR are going to work properly with the new scheme as well).  Once 
that's done, I'll send a 0.05 version of the driver to Alan.




-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

