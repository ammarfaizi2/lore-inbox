Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWCEDHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWCEDHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 22:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWCEDHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 22:07:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932333AbWCEDHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 22:07:20 -0500
Date: Sat, 4 Mar 2006 19:05:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: jimd@starshine.org (Jim Dennis)
Cc: linux-kernel@vger.kernel.org
Subject: Re: SEEK_HOLE and SEEK_DATA support?
Message-Id: <20060304190538.0a94b4a0.akpm@osdl.org>
In-Reply-To: <20060302214929.GA16523@starshine.org>
References: <20060302214929.GA16523@starshine.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jimd@starshine.org (Jim Dennis) wrote:
>
> 
>  All,
> 
>  Has there been any thought about adding SEEK_HOLE and SEEK_DATA (*)
>  support to Linux?  
> 
>  I ask primarily because of the interplay between 64-bit systems and
>  things like /var/log/lastlog (which appears as a 1.2TiB file due to
>  the nfsnobody UID of 4294967294).
> 
>  (I'm realize that adding support for these additional seek() flags
>  wouldn't solve the problem ... archiving tools would still have to
>  implement it.  And I can also hear the argument that Red Hat and other
>  distributions should re-implement lastlog handling to use a more modern
>  and efficient hashing/index format and perhaps that they should set
>  nfsnobody to "-1" ... I'd be curious if those details are driven by
>  some published standard or if they are artifacts of porting.  I'd also
>  be curious what's happened with other 64-bit UNIX ports and whether
>  this issue ever came up in Linux ports to the Alpha or other 64-bit
>  processors).
> 
>  As a stray data point I just did a quick experiment and just doing
>  a time cat /var/log/lastlog > /dev/null took about:
> 
>  36.33user 2453.99system 41:35.90elapsed 99%CPU 
>     (0avgtext+0avgdata 0maxresident)k
>     0inputs+0outputs (133major+15minor)pagefaults 0swaps
> 
> 
>  On an otherwise idle 2GHz dual Opteron (yes, of course the extra
>  CPU is wasted for this job), reading SCSI disk hanging off a Fusion MPT 
>  controller.
> 
>  From what I hear our Networker processes pore over these NULs for about
>  two hours any time someone fails to exclude /var/log/lastlog from their
>  backup list.

This can already be solved in userspace (and I'm sure it already has been
in some backup programs).  Use the FIBMAP ioctl() against the fd to find
out whether a particular block in the file is actually instantiated.

Not all filesystems necessarily implement FIBMAP, so one would need to fall
back to sucky mode if FIBMAP failed.

