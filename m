Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUDPScs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUDPScs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:32:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:6278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263595AbUDPScm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:32:42 -0400
Date: Fri, 16 Apr 2004 11:32:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ken Ashcraft <ken@coverity.com>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
       achim_leubner@adaptec.com
Subject: Re: [CHECKER] Probable security holes in 2.6.5
Message-ID: <20040416113239.W22989@build.pdx.osdl.net>
References: <1082134916.19301.7.camel@dns.coverity.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082134916.19301.7.camel@dns.coverity.int>; from ken@coverity.com on Fri, Apr 16, 2004 at 10:01:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ken Ashcraft (ken@coverity.com) wrote:
> [BUG] 
> /home/kash/linux/linux-2.6.5/drivers/scsi/gdth.c:5068:ioc_general:
> ERROR:TAINT: 5059:5068:Passing unbounded user value "((gen).data_len +
> (gen).sense_len)" as arg 2 to function "copy_from_user", which uses it
> unsafely in model [SOURCE_MODEL=(lib,copy_from_user,user,taintscalar)]
> [SINK_MODEL=(lib,copy_from_user,user,trustingsink)]    [PATH=
> "((gen).data_len + (gen).sense_len) != 0" on line 5064 is false =>
> "(gen).ionode >= gdth_ctr_count" on line 5059 is false =>
> "copy_from_user != 0" on line 5059 is false] 
> #else
> 	Scsi_Cmnd scp;
> 	Scsi_Device sdev;
> #endif
>         
> Start --->
>         if (copy_from_user(&gen, (char *)arg,
> sizeof(gdth_ioctl_general)) ||
>             gen.ionode >= gdth_ctr_count)
>             return -EFAULT;
>         hanum = gen.ionode; 
>         ha = HADATA(gdth_ctr_tab[hanum]);
>         if (gen.data_len + gen.sense_len != 0) {
>             if (!(buf = gdth_ioctl_alloc(hanum, gen.data_len +
> gen.sense_len, 
>                                          FALSE, &paddr)))
>                 return -EFAULT;
> Error --->
>             if (copy_from_user(buf, (char *)arg +
> sizeof(gdth_ioctl_general),  
>                                gen.data_len + gen.sense_len)) {
>                 gdth_ioctl_free(hanum, gen.data_len+gen.sense_len, buf,
> paddr);
>                 return -EFAULT;

Agreed this looks like it should be limited, but I'm not sure what valid
limits might be.  Seems this will specify size to pci_alloc_consitent(),
and then use that buffer.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
