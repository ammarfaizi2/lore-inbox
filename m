Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWB1AwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWB1AwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWB1AwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:52:23 -0500
Received: from NS8.Sony.CO.JP ([137.153.0.33]:43651 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S1750952AbWB1AwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:52:23 -0500
Message-ID: <44039EBE.4040401@sm.sony.co.jp>
Date: Tue, 28 Feb 2006 09:52:14 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: col-pepper@piments.com
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: o_sync in vfat driver
References: <op.s5lrw0hrj68xd1@mail.piments.com> <20060226165114.e87fe056.akpm@osdl.org> <op.s5nkafhpj68xd1@mail.piments.com>
In-Reply-To: <op.s5nkafhpj68xd1@mail.piments.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Andrew suggested, Ogawa Hirofumi, FAT maintainer post
following patch. I may help you. Please check it.

Message-Id: <87wthrznsv.fsf@devron.myhome.or.jp>
Subject: Re: [EXPERIMENT] Add new "flush" option


	This adds new "flush" option for hotplug devices.

	Current implementation of "flush" option does,

	- synchronizing data pages at ->release() (last close(2))
	- if user's work seems to be done (fs is not active), all
	  metadata syncs by pdflush()

	This option would provide kind of sane progress, and dirty buffers is
	flushed more frequently (if fs is not active).  This option doesn't
	provide any robustness (robustness is provided by other options), but
	probably the option is proper for hotplug devices.

	(Please don't assume that dirty buffers is synchronized at any point.
	This implementation will be changed easily.)


col-pepper@piments.com wrote:
> Thanks for the reply.
> 
> 
> On Mon, 27 Feb 2006 01:51:14 +0100, Andrew Morton <akpm@osdl.org> wrote:
> 
>> col-pepper@piments.com wrote:
>>
>>>
>>> There is nothing in the spec of vfat that suggests the FAT will be  
>>> written
>>> 10.000 during the writing of one large file. Indeed it is hard to  
>>> imagine
>>> that any other implementation on any other OS or any previous linux  
>>> kernel
>>> behaves like that.
>>
>>
>> We sync the file metadata once per write() syscall.  If your app writes a
>> large file in lots of little bits, it'll do a lot of syncs.  Other
>> implementations of fatfs will (must) do the same thing.
> 
> 
> That would not seem to be the case at least on MS systems. I had a 
> freind  do some timings copying a large group of files to a 128M usb 
> flash device.
> There was an arbitary mix of files including many small files and some  
> larger files, one in excess of 50MB.
> 
> suse10 default 4m10
> win2k 2m30
> suse w/o sync 30s
> 
> The suse test was drag and drop in konqueror , the other dnd in windows  
> explorer.
> 
>>
>>> It would seem that the first step could be to revert to the 2.6.11
>>> behaviour which was more appropriate and probably safer even from 
>>> the  data
>>> point of view.
>>
>>
>> fatfs used to be buggy - it didn't implement `-o sync'.  Now it does, and
>> what we're seeing is the fallout from the late fixing of that bug.
>>
> 
> I just tested on my 2.6.11 kernel which would predate the change and 
> there  is a clear difference between mounting my usb device with and 
> without sync  option.
> 
> ls -ail /tmpd/mail*
> 239151 -rw-r--r-- 1 root root 8169540 2006-02-27 19:04  
> /tmpd/mail-bak.2006-02-28.bz2
> bash-3.1#time cp !$ /mnt/usb
> time cp /tmpd/mail* /mnt/usb
> 
> real    0m0.227s
> user    0m0.001s
> sys     0m0.070s
> 
> It returns immediately with no disk activity. About 30s later there was  
> disk activity. Presumably some periodic flushing of IO buffers.
> 
> bash-3.1#umount /mnt/usb
> bash-3.1#mount -o sync !$
> 
> bash-3.1#time cp /tmpd/mail* /mnt/usb
> 
> real    0m5.440s
> user    0m0.000s
> sys     0m0.143s
> 
> So the older model did seem to have some sync functionality , tho'  
> presumably not the agressive one-for-one sync that is now being used.
> 
> Please correct me if my interpretation is flawed here:
> 
> flash has to be cleared before being written. If metadata is written 
> with  every block output with write(), the risk of erasing the FAT is 
> now many  times higher than with the old sync policy.
> 
> So the newer sync policy drastically _reduces_ the data security in the  
> case of untimely disconnection despite the speed penalty and possible  
> hardware damage it incurs.
> 
> A less rigourous sync policy may in fact be more appropriate than the  
> current model.
> 
> Thanks again.
> 
> 
> [Note: I am not subscribed to LKML, if you wish me to recieve any follow
> ups please BCC: col-pepper at piments point com . thx]
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Hiroyuki Machida		machida@sm.sony.co.jp		
SSW Dept. HENC, Sony Corp.
