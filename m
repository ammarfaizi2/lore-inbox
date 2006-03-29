Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWC2CMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWC2CMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 21:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWC2CMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 21:12:13 -0500
Received: from mail.gmx.de ([213.165.64.20]:40650 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750773AbWC2CMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 21:12:12 -0500
X-Authenticated: #427522
Message-ID: <4429ED2F.10407@gmx.de>
Date: Wed, 29 Mar 2006 04:13:03 +0200
From: Mathis Ahrens <Mathis.Ahrens@gmx.de>
User-Agent: Mail/News 1.5 (X11/20060325)
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrew Morton <akpm@osdl.org>, col-pepper@piments.com,
       linux-kernel@vger.kernel.org
Subject: Re: o_sync in vfat driver
References: <op.s5lrw0hrj68xd1@mail.piments.com> <op.s5nkafhpj68xd1@mail.piments.com> <20060227151230.695de2af.akpm@osdl.org> <200602281347.46169.mason@suse.com>
In-Reply-To: <200602281347.46169.mason@suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Chris Mason wrote:
> On Monday 27 February 2006 18:12, Andrew Morton wrote:
>   
>> We don't know that the same number of same-sized write()s were happening in
>> each case.
>>
>> There's been some talk about implementing fsync()-on-file-close for this
>> problem, and some protopatches.  But nothing final yet.
>>     
>
> Here's the patch I'm using in -suse right now.  What I want to do is make a 
> much more generic -o flush, but it'll still need a few bits in individual 
> filesystem to kick off metadata writes quickly.
>
> The basic goal behind the code is to trigger writes without waiting for both
> data and metadata.  If the user is watching the memory stick, when the 
> little light stops flashing all the data and metadata will be on disk.
>
> It also generally throttles userland a little during file release.  This 
> could be changed to throttle for each page dirtied, but most users I 
> asked liked the current setup better.
>   

I like the idea and would like to see something like this in mainline.

Here is some non-scientific benchmark done with 2.6.16, comparing
default mount and flush mount of a USB2 stick:

/////////////////////////////////////////////////////////////////////
Single File "Test": 43MB
$ time cp Test /media/usbdisk/test/ && time umount /media/usbdisk/
/////////////////////////////////////////////////////////////////////

VANILLA:

real    0m3.770s
user    0m0.004s
sys     0m0.308s

real    0m9.439s
user    0m0.000s
sys     0m0.040s

FLUSH:

real    0m6.000s
user    0m0.012s
sys     0m0.400s

real    0m3.668s
user    0m0.000s
sys     0m0.028s

REAL TIME RATIO (FLUSH/VANILLA):
9.6 / 13.1 = 0.73

/////////////////////////////////////////////////////////////////////
Directory Tree "flushtest": 44MB (8866 files, 1820 dirs)
$ time cp -R flushtest/ /media/usbdisk/ && time umount /media/usbdisk/
/////////////////////////////////////////////////////////////////////

VANILLA:

real    0m0.966s
user    0m0.024s
sys     0m0.860s

real    1m11.962s
user    0m0.004s
sys     0m0.160s

FLUSH:

real    1m41.645s
user    0m0.032s
sys     0m1.112s

real    0m4.660s
user    0m0.004s
sys     0m0.068s

REAL TIME RATIO (FLUSH/VANILLA):
106.3 / 77.9 = 1.36

