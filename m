Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbTKSPH6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 10:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbTKSPH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 10:07:58 -0500
Received: from ns.suse.de ([195.135.220.2]:7641 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264106AbTKSPHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 10:07:55 -0500
Message-ID: <3FBB8748.8020503@suse.de>
Date: Wed, 19 Nov 2003 16:07:52 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB90A6A.4050505@nortelnetworks.com> <20031117180312.GZ24159@parcelfarce.linux.theplanet.co.uk> <200311172133.59839.arvidjaar@mail.ru> <20031117191513.GA24159@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031117191513.GA24159@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Nov 17, 2003 at 09:33:59PM +0300, Andrey Borzenkov wrote:
> 
>>On Monday 17 November 2003 21:03, viro@parcelfarce.linux.theplanet.co.uk 
>>wrote:
>>
>>>On Mon, Nov 17, 2003 at 12:50:34PM -0500, Chris Friesen wrote:
>>>
>>>>viro@parcelfarce.linux.theplanet.co.uk wrote:
>>>>
>>>>>On Mon, Nov 17, 2003 at 11:06:48AM -0500, Chris Friesen wrote:
>>>>>
>>>>>>Anyone know why it overmounts rather than pivots?
>>>>>
>>>>>Because amount of extra code you lose that way takes more memory than
>>>>>empty roots takes.
>>>>>
>>>>>Remove whatever files you don't need and be done with that.
>>>>
>>>>How do you remove files from the old rootfs after the new one has been
>>>>mounted on top of it?
>>>
>>>You do that before ;-)
>>
>>would the following work?
>>
>>pivot_root . /initramfs
>>cd /initramfs && rm -rf *
> 
> 
> No.  pivot_root() will not move the absolute root of tree elsewhere.
> 
> 
>>?? doing it before is rather hard ... you apparently still need something to 
>>execute your mounts :)
> 
> 
> You do, but you can trivially call unlink() on the executable itself.  It
> will be freed after it does exec() of final /sbin/init...
> 
> Alternatively, you could
> mkdir /root
> mount final root on /root
> 
> chdir("/root");
> mount("/", "initramfs", NULL, MS_BIND, NULL);
> mount(".", "/", NULL, MS_MOVE, NULL);
> chroot(".");
> execve("/sbin/init", ...)
> 
Nope. initramfs shares the superblock with 'rootfs', which has the 
MS_NOUSER flags set. Hence graft_tree() (which is the worker function 
for MS_BIND) refuses to work.
Can't we just remove the MS_NOUSER flags if initramfs is active?
Probably not the correct way, but certainly the quickest :-)
The correct way would probably be to clone the superblock of initramfs, 
set the filesystem-type of initramfs to 'ramfs' so that initramfs 
appears to be a chroot()ed filesystem like initrd. Then we could do a 
pivot_root and we have the contents of initramfs still available.
But needs someone with deeper fs-knowledge than myself to do it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Deutschherrnstr. 15-19			+49 911 74053 688
90429 Nürnberg				http://www.suse.de

