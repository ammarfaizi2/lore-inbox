Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUL0NLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUL0NLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 08:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUL0NLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 08:11:06 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:23506 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261884AbUL0NKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 08:10:38 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Paul Bijnens <paul.bijnens@xplanation.com>
Subject: Re: amanda oddments of recent occurance
Date: Mon, 27 Dec 2004 08:10:35 -0500
User-Agent: KMail/1.7
Cc: amanda-users@amanda.org, linux-kernel@vger.kernel.org
References: <200412260443.55711.gene.heskett@verizon.net> <41CFC7C1.9090608@xplanation.com>
In-Reply-To: <41CFC7C1.9090608@xplanation.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412270810.35307.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.45.252] at Mon, 27 Dec 2004 07:10:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 December 2004 03:28, Paul Bijnens wrote:
>Gene Heskett wrote:

And I'm Cc:ing this to the lkml too, Paul.  Somebody there needs to 
know we now have an amanda problem with 2.6.10 that I didn't have 
with 2.6.10-rc3-mm1-V0.7.33-04.

>> coyote:/usr/dlds-misc/FC3-i386-disk2.iso           1      637m
>> wait for dumping coyote:/usr/dlds-misc/FC3-i386-rescuecd.iso      
>>  0       76m wait for dumping
>> coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disc1.iso 1      562m
>> wait for dumping
>> coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disk2.iso 0      562m
>> wait for dumping
>> coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disk3.iso 0      562m
>> wait for dumping
>> coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disk4.iso 0      562m
>> wait for dumping coyote:/usr/dlds-misc/FC3/FC3-i386-disc1.iso     
>>  1      617m wait for dumping
>> coyote:/usr/dlds-misc/FC3/FC3-i386-disk3.iso       1      636m
>> wait for dumping coyote:/usr/dlds-misc/FC3/FC3-i386-disk4.iso     
>>  1      386m wait for dumping
>>
>> Looks normal at first glance, but wait, there is more!  Those
>> first 2 iso images are not *in* the /usr/dlds-misc directory as
>> shown but are in fact in the /usr/dlds-misc/FC3 directory as the
>> other 7 images shown correctly.
>
>To be able to back up a single file (the large iso's) you probably
>created special DLE-entries using includes, with "diskname"
> different than "diskdevice".
>
>coyote  /usr/dlds-misc/FC3-i386-disk2.iso /usr/dlds-misc/FC3 {
> comp-user-tar
> include "./FC3-i386-disk2.iso
> }  1
>
>What you see in is the "diskname" (second argument in DLE), which
> you may name anything you like;  it just has to be unique in the
> disklist. And apparently you used a different scheme for the first
> two.
>
>Is this what has happened?
>
Absolutely correct Paul.  Fixed now.

But I've also another problem, amanda barfed again last night, about 
90% done, leaving:
[amanda@coyote root]$ ps -ea|grep amandad
 3126 ?        00:00:00 amandad
 3128 ?        00:00:00 amandad <defunct>

still present, and it missed several of the larger dle's due to data 
timeouts after amandad went on strike.  I can kill them, but even if 
I do, an 'amcheck Daily' returns this:
[amanda@coyote root]$ amcheck Daily
Amanda Tape Server Host Check
-----------------------------
Holding disk /dumps: 26558 MB disk space available, using 26058 MB
amcheck-server: slot 11: date 20041227 label Dailys-11 (active tape)
amcheck-server: slot 12: date 20041213 label Dailys-12 (exact label 
match)
NOTE: skipping tape-writable test
Tape Dailys-12 label ok
Server check took 0.600 seconds

Amanda Backup Client Hosts Check
--------------------------------
WARNING: coyote: selfcheck reply timed out.
Client check: 2 hosts checked in 21.313 seconds, 1 problem found

(brought to you by Amanda 2.4.5b1-20041221)

Now, I had shut down an smb mounted box in the basement about 2:25 am, 
and that got this in the logs:
--------------
Dec 27 02:25:11 coyote mount.smbfs[22699]: [2004/12/27 02:25:11, 0] 
tdb/tdbutil.c:tdb_log(725)
Dec 27 02:25:11 coyote mount.smbfs[22699]:   
tdb(/var/cache/samba/gencache.tdb): tdb_lock failed on list 10 
ltype=0
 (Bad file descriptor)
Dec 27 02:25:11 coyote mount.smbfs[22699]: [2004/12/27 02:25:11, 0] 
tdb/tdbutil.c:tdb_log(725)
Dec 27 02:25:11 coyote mount.smbfs[22699]:   
tdb(/var/cache/samba/gencache.tdb): tdb_lock failed on list 10 
ltype=1
 (Bad file descriptor)
Dec 27 02:25:11 coyote mount.smbfs[22699]: [2004/12/27 02:25:11, 0] 
tdb/tdbutil.c:tdb_log(725)
Dec 27 02:25:11 coyote mount.smbfs[22699]:   
tdb(/var/cache/samba/gencache.tdb): tdb_lock failed on list 10 
ltype=1
 (Bad file descriptor)
Dec 27 02:25:11 coyote mount.smbfs[22699]: [2004/12/27 02:25:11, 0] 
client/smbmount.c:do_connection(156)
Dec 27 02:25:11 coyote mount.smbfs[22699]:   22699: Connection to 
shop.coyote.den failed
Dec 27 02:25:40 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24027] timed out!
Dec 27 02:26:10 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24028] timed out!
Dec 27 02:26:40 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24029] timed out!
Dec 27 02:27:10 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24030] timed out!
Dec 27 02:27:39 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24031] timed out!
Dec 27 02:28:09 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24032] timed out!
Dec 27 02:28:39 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24033] timed out!
Dec 27 02:29:09 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24034] timed out!
Dec 27 02:29:38 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24035] timed out!
Dec 27 02:30:08 coyote kernel: smb_add_request: request [dd0c7ec0, 
mid=24036] timed out!
--------------
and this last message continues for another megabyte or so till now.

And the only way I know how to fix this is to reboot to a good kernel, 
2.6.10 apparently has a problem with amanda and samba that earlier 
kernels don't have.  I had 8 days of uptime with Ingo Molnars last 
realtime patch, so guess what I'll be running till this gets fixed...

I've no idea why samba is mucking with amanda, if indeed thats the 
problem, that machine is not part of amanda's backup configuration in 
any way, shape or form.

And, still booted to 2.6.10, I have a script in my init.d dir just 
like the smb one but it starts & stops my local samba shares.
--------
[root@coyote root]# service asmb restart
Stopping share gene:
Stopping share dlds:
stopping share shop:
umount: /mnt/shop: device is busy
umount: /mnt/shop: device is busy
Starting share gene:
Starting share dlds:
Starting share shop:
Could not resolve mount point /mnt/shop
[root@coyote root]# ls /mnt/shop
ls: /mnt/shop: Input/output error
[root@coyote root]#
-------------
So whatever has been done to the kernels smb code in 2.6.10, has 
managed to break that too.  If I reboot to 2.6.10, it will work 
again, for maybe 24 hours, 28 hours is the longest uptime I've 
managed so far, but problems start popping up at about 20-21 hours.

I did try the CIFS code for one build, but its apparently incompatible 
with an older samba on the other two machines of my local network.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
