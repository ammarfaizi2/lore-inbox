Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWB0WTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWB0WTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWB0WTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:19:33 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:19616 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP id S964838AbWB0WTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:19:32 -0500
Date: Mon, 27 Feb 2006 23:19:17 +0100
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: o_sync in vfat driver
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <op.s5lrw0hrj68xd1@mail.piments.com> <20060226165114.e87fe056.akpm@osdl.org>
From: col-pepper@piments.com
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s5nkafhpj68xd1@mail.piments.com>
In-Reply-To: <20060226165114.e87fe056.akpm@osdl.org>
User-Agent: Opera M2/8.52 (Linux, build 1631)
X-Ovh-Remote: 80.170.101.26 (d80-170-101-26.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|0.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply.


On Mon, 27 Feb 2006 01:51:14 +0100, Andrew Morton <akpm@osdl.org> wrote:

> col-pepper@piments.com wrote:
>>
>> There is nothing in the spec of vfat that suggests the FAT will be  
>> written
>> 10.000 during the writing of one large file. Indeed it is hard to  
>> imagine
>> that any other implementation on any other OS or any previous linux  
>> kernel
>> behaves like that.
>
> We sync the file metadata once per write() syscall.  If your app writes a
> large file in lots of little bits, it'll do a lot of syncs.  Other
> implementations of fatfs will (must) do the same thing.

That would not seem to be the case at least on MS systems. I had a freind  
do some timings copying a large group of files to a 128M usb flash device.
There was an arbitary mix of files including many small files and some  
larger files, one in excess of 50MB.

suse10 default 4m10
win2k 2m30
suse w/o sync 30s

The suse test was drag and drop in konqueror , the other dnd in windows  
explorer.

>
>> It would seem that the first step could be to revert to the 2.6.11
>> behaviour which was more appropriate and probably safer even from the  
>> data
>> point of view.
>
> fatfs used to be buggy - it didn't implement `-o sync'.  Now it does, and
> what we're seeing is the fallout from the late fixing of that bug.
>

I just tested on my 2.6.11 kernel which would predate the change and there  
is a clear difference between mounting my usb device with and without sync  
option.

ls -ail /tmpd/mail*
239151 -rw-r--r-- 1 root root 8169540 2006-02-27 19:04  
/tmpd/mail-bak.2006-02-28.bz2
bash-3.1#time cp !$ /mnt/usb
time cp /tmpd/mail* /mnt/usb

real    0m0.227s
user    0m0.001s
sys     0m0.070s

It returns immediately with no disk activity. About 30s later there was  
disk activity. Presumably some periodic flushing of IO buffers.

bash-3.1#umount /mnt/usb
bash-3.1#mount -o sync !$

bash-3.1#time cp /tmpd/mail* /mnt/usb

real    0m5.440s
user    0m0.000s
sys     0m0.143s

So the older model did seem to have some sync functionality , tho'  
presumably not the agressive one-for-one sync that is now being used.

Please correct me if my interpretation is flawed here:

flash has to be cleared before being written. If metadata is written with  
every block output with write(), the risk of erasing the FAT is now many  
times higher than with the old sync policy.

So the newer sync policy drastically _reduces_ the data security in the  
case of untimely disconnection despite the speed penalty and possible  
hardware damage it incurs.

A less rigourous sync policy may in fact be more appropriate than the  
current model.

Thanks again.


[Note: I am not subscribed to LKML, if you wish me to recieve any follow
ups please BCC: col-pepper at piments point com . thx]
