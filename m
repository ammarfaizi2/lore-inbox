Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVHTB1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVHTB1I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVHTB1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:27:07 -0400
Received: from tornado.reub.net ([202.89.145.182]:52913 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932619AbVHTB1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:27:07 -0400
Message-ID: <430686EA.3000901@reub.net>
Date: Sat, 20 Aug 2005 13:27:06 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20050819)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
References: <20050819043331.7bc1f9a9.akpm@osdl.org>	<4305DCC6.70906@reub.net> <20050819103435.2c88a9f2.akpm@osdl.org>
In-Reply-To: <20050819103435.2c88a9f2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On 20/08/2005 5:34 a.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:

>> A few new problems cropped up with this kernel..
>>
>> 1. NFS seems to be unstable, oopsing when shutting down:
> 
> --- devel/fs/nfsd/nfssvc.c~ingo-nfs-stuff-fix	2005-08-19 10:29:15.000000000 -0700
> +++ devel-akpm/fs/nfsd/nfssvc.c	2005-08-19 10:30:03.000000000 -0700
> @@ -286,7 +286,6 @@ out:
>  	/* Release the thread */
>  	svc_exit_thread(rqstp);
>  
> -	unlock_kernel();
>  	/* Release module */
>  	unlock_kernel();
>  	module_put_and_exit(0);
> _

That fixed it, thanks.


>> Aug 20 12:26:10 tornado kernel: Device  not ready.
>>
>> 2.  That message on the third line of the trace above: "kernel: Device  not 
>> ready." is being logged every few mins or so, I believe it is my SCSI CDROM 
>> that is causing it.  It also logs something similar after the SCSI driver has 
>> probed the device on boot:
>>
>> Aug 20 12:24:36 tornado kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA 
>> DRIVER, Rev 7.0
>> Aug 20 12:24:36 tornado kernel:         <Adaptec 2940 Ultra SCSI adapter>
>> Aug 20 12:24:36 tornado kernel:         aic7880: Ultra Wide Channel A, SCSI 
>> Id=7, 16/253 SCBs
>> Aug 20 12:24:36 tornado kernel:
>> Aug 20 12:24:36 tornado kernel:   Vendor: SONY      Model: CD-RW  CRX145S 
>> Rev: 1.0b
>> Aug 20 12:24:36 tornado kernel:   Type:   CD-ROM 
>> ANSI SCSI revision: 04
>> Aug 20 12:24:36 tornado kernel:  target0:0:6: Beginning Domain Validation
>> Aug 20 12:24:36 tornado kernel:  target0:0:6: Domain Validation skipping write 
>> tests
>> Aug 20 12:24:36 tornado kernel:  target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 
>> ns, offset 15)
>> Aug 20 12:24:36 tornado kernel:  target0:0:6: Ending Domain Validation
>> Aug 20 12:24:36 tornado kernel: Device  not ready.
>>
>> This has been a problem for quite a few weeks now, albeit I believe, only a 
>> cosmetic one.
> 
> Is some application trying to poll the device?

I wonder if hald knows something about this and is polling.. however that 
message above about "Device  not ready" occurs when the kernel is booting, 
before any userspace stuff has started up.  Maybe hald is just being a bit 
aggressive in re-probing the drive after userspace launches.  B all accounts 
after a week of uptime the drive certainly ought to be ready, it seems to work 
ok ;-)

Note the extra space after 'Device' and 'not' which implies possibly some text 
is missing (which would have made it more clear which device is not exactly 
ready).  The case sensitive strings "Device" and "not ready" appears together 
in scsi_lib.c and very few other places.

> Is the device actually "not ready", or is it in reality ready and working? 
> ie: what happens if you stick a CD in it?

The CD can be read, and the error messages go away.  They stay away even after 
the CD has been ejected.

>> 4. PAM is complaining about "PAM audit_open() failed: Protocol not suppor
>> ted" and I can't log in as any user including root.  I would have picked this 
>> was a userspace problem, but it doesn't break with -rc5-mm1, yet reproduceably 
>> breaks with -rc6-mm1.  Weird.
> 
> hm.  How come you're able to use the machine then?

Machine was booting up ok, and things were being written to syslog.  Rebooted 
into -rc5-mm1 to investigate, and of course could boot into rc6-mm1 in single 
user mode, test and bring services up one by one from there.  Having two boxes 
helped too.

> Is it possible to get an strace of this failure somehow?

Not sure if this is needed anymore, as I found that the problem goes away when 
I compile in kernel auditing.  This not required for -rc5-mm1.  Is that change 
intended?

reuben
