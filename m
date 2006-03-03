Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWCCV0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWCCV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWCCV0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:26:24 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:14778 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1750830AbWCCV0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:26:24 -0500
Message-ID: <04cd01c63f09$a007a930$0200000a@aldipc>
From: "roland" <devzero@web.de>
To: "Kevin Corry" <kevcorry@us.ibm.com>, <linux-kernel@vger.kernel.org>
Cc: "Jeff Dike" <jdike@addtoit.com>, <agk@redhat.com>,
       <jengelh@linux01.gwdg.de>
References: <043101c63e9c$86e9d710$0200000a@aldipc> <200603030828.59567.kevcorry@us.ibm.com>
Subject: Re: is there a COW inside the kernel ?
Date: Fri, 3 Mar 2006 22:29:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello !

thanks to all for providing that information.

i think i will take a closer look on device-mapper, but i'm unsure if it`s 
perfectly suited.

can i only use devices, not files for the cow?
what about merging a cow-dev/file back to the r/o-dev/file ?
cowloop can do this, and because it can use files, i don`t need to provide a 
fixed amount of diskspace for the cow.  you have direct feedback about how 
big you cow grows....
i'm unsure about dm, but i will dig into the details. (wanted to learn more 
about dm anyway)

any chance of cowloop being merged into mainline ?
loop.c is 1343 lines of code, cowloop.c is around 1000 lines more so it`s 
"reasonable" small....and it has a _really_ nice user manual.

regards
roland

ps:
btw - mountlo looks really "freaky" - i like uml very much, but i think i 
need each bit of performance.
will take a look at mountlo just for personal interest, though.




----- Original Message ----- 
From: "Kevin Corry" <kevcorry@us.ibm.com>
To: <linux-kernel@vger.kernel.org>
Cc: "roland" <devzero@web.de>
Sent: Friday, March 03, 2006 3:28 PM
Subject: Re: is there a COW inside the kernel ?


> On Fri March 3 2006 2:29 am, roland wrote:
>> hello !
>>
>> is there an equivalent of something like
>>
>> cowloop ( http://www.atconsultancy.nl/cowloop/total.html ) or md based 
>> cow
>> device ( http://www.cl.cam.ac.uk/users/br260/doc/report.pdf ),
>>
>> i.e. a feature called "Copy On Write Blockdevice" inside the current or 
>> the
>> near-future mainline kernel (besides UserModeLinux Arch)?
>
> Device-Mapper has a snapshot module, which is used by LVM and EVMS. You 
> can
> also use dmsetup if you want lower-level access than provided by the 
> volume
> managers. To do the equivalent of the cowloop driver that you linked to
> above, you could do something like this:
>
> Say you have a read-only block-device (say a cd-rom) at /dev/hdc. And you 
> have
> a small disk partition, /dev/hdb1, that you want to use for your "COW 
> file".
> Run:
>
> cow_size=`blockdev --getsize /dev/hdc`
> chunk_size=64   # Size of each copied-on-write chunk, in 512 byte sectors
> cow_name="my_cow_dev"
> echo "0 $cow_size snapshot /dev/hdc /dev/hdb1 p $chunk_size" | \
>   dmsetup create $cow_name
>
> This will give you a device called /dev/mapper/$cow_name. Presuming 
> /dev/hdc
> has a filesystem on it, you can mount /dev/mapper/$cow_name and get a
> read-write version of the filesystem on /dev/hdc, where updates to the
> filesystem will be stored on /dev/hdb1. The size of /dev/hdb1 can be
> significantly smaller than /dev/hdc, depending on the amount of writes you
> expect to happen on /dev/mapper/$cow_name. While this device is active, 
> don't
> try to mount /dev/hdc read-write (assuming that's possible), or it will
> corrupt the view of /dev/mapper/$cow_name. If you need read-write access 
> to
> both devices simultaneously, you'll probably just want to use LVM or EVMS 
> and
> create snapshot volumes, since manually activating that kind of setup with
> dmsetup is incredibly tricky.
>
> Use "dmsetup remove $cow_name" to deactivate the device.
>
>> i would find this useful for several purpose, but i don`t want to patch 
>> my
>> system with 3rd party drivers or "non-standard" stuff -  or even 
>> recompile
>> the kernel.
>
> This should work with any recent 2.6 kernel. You'll also need to have the
> device-mapper package installed, which should be available with any recent
> Linux distro.
>
> -- 
> Kevin Corry
> kevcorry@us.ibm.com
> http://www.ibm.com/linux/
> http://evms.sourceforge.net/ 

