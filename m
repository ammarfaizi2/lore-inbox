Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWBJPNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWBJPNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWBJPNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:13:33 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:29467 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751282AbWBJPNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:13:32 -0500
Message-ID: <43ECAD5B.9070308@cfl.rr.com>
Date: Fri, 10 Feb 2006 10:12:27 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>, dm-devel@redhat.com,
       Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support HDIO_GETGEO on device-mapper volumes
References: <43EBEDD0.60608@us.ibm.com> <20060210145348.GA12173@agk.surrey.redhat.com>
In-Reply-To: <20060210145348.GA12173@agk.surrey.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2006 15:14:25.0749 (UTC) FILETIME=[ADF82850:01C62E54]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14259.000
X-TM-AS-Result: No--25.100000-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon wrote:
> On Thu, Feb 09, 2006 at 05:35:12PM -0800, Darrick J. Wong wrote:
>   
>> Since dm doesn't implement the HDIO_GETGEO ioctl,
>>     
>
> Why should it?  Device-mapper constructs a virtual device and
> I think it's completely wrong for it to 'fake' a geometry.
>
> Of course dm could recognise the ioctl - but the default response
> should be the one that indicates the geometry is unknown.
>
>   

That is what it did before.  By failing the ioctl, that indicates that 
the geometry is unknown, and that causes problems for grub. 

>> grub assumes that the CHS
>> geometry is 620/128/63, which makes it impossible to configure it to
>> boot a filesystem that lives beyond the 2GB mark, even if the system
>> BIOS supports that.
>>     
>
> Surely a problem in grub, not the kernel?
>
>   

Yes, I think this could also be fixed on grub's end.  It seems that 
fdisk assumes usable default values for the geometry but grub has 
different defaults that cause it problems.  I think that the defaults 
could be modified in grub so that it will work when HDIO_GETGEO fails. 

>> The attached patch implements a simple ioctl handler that supplies a
>> compatible geometry when HDIO_GETGEO is called against a device-mapper
>> device.  Its behavior is somewhat similar to what sd_mod does if the
>> scsi controller doesn't provide its own geometry. 
>>     
>
> What if the dm device is a linear mapping to an sd device that *does*
> provide a different geometry?  Then the 'fake' geometry dm would return
> with this patch would be wrong!
>
>   

There is no 'right' or 'wrong' geometry; it is all made up anyhow. 

>> this seems to be a better option than having each program make
>> up its own potentially different geometry, or making an arbitrary guess.
>>     
>
> I disagree - either dm should work out the *correct* geometry to
> return for those mappings where a geometry is known and it's sensible
> to return one (e.g. linear mapping to the start of certain scsi
> devices), or else it should leave it to userspace to decide how to
> handle the situation.  (And there's nothing currently stopping
> userspace seeing that a dm device is constructed out of a scsi device
> and choosing to use the geometry of that underlying device.)

Except that most user space tools are not aware of dm and shouldn't need 
to be.

In this case, I think the correct solution is to patch grub so that if 
there is already a valid MBR on the disk, it should take the geometry 
from there.  If it is creating a brand new MBR, then it should use the 
geometry from HDIO_GETGEO and if that fails, make up sensible defaults 
like fdisk does. 


