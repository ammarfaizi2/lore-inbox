Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUKJWiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUKJWiC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 17:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbUKJWiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 17:38:02 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15749 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262129AbUKJWg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 17:36:56 -0500
Date: Wed, 10 Nov 2004 16:36:29 -0600
From: Maneesh Soni <maneesh@in.ibm.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: /sys/devices/system/timer registered twice
Message-ID: <20041110223629.GA5925@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20041109193043.GA8767@vrfy.org> <20041109193947.GA5758@kroah.com> <20041110022535.GA10011@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110022535.GA10011@vrfy.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 03:25:35AM +0100, Kay Sievers wrote:
> On Tue, Nov 09, 2004 at 11:39:47AM -0800, Greg KH wrote:
> > On Tue, Nov 09, 2004 at 08:30:43PM +0100, Kay Sievers wrote:
> > > Hi,
> > > I got this on a Centrino box with the latest bk:
> > > 
> > >   [kay@pim linux.kay]$ ls -l /sys/devices/system/
> > >   total 0
> > >   drwxr-xr-x  7 root root 0 Nov  8 15:12 .
> > >   drwxr-xr-x  5 root root 0 Nov  8 15:12 ..
> > >   drwxr-xr-x  3 root root 0 Nov  8 15:12 cpu
> > >   drwxr-xr-x  3 root root 0 Nov  8 15:12 i8259
> > >   drwxr-xr-x  2 root root 0 Nov  8 15:12 ioapic
> > >   drwxr-xr-x  3 root root 0 Nov  8 15:12 irqrouter
> > >   ?---------  ? ?    ?    ?            ? timer
> > > 
> > > 
> > > It is caused by registering two devices with the name "timer" from:
> > > 
> > >   arch/i386/kernel/time.c
> > >   arch/i386/kernel/timers/timer_pit.c
> > > 
> > > If I change one of the names, I get two correct looking sysfs entries.
> > > 
> > > Greg, shouldn't the driver core prevent the corruption of the first
> > > device if another one tries to register with the same name?
> > 
> > Yes, we should handle this.  Can you try the patch below?  I just sent
> > it to Linus, as it fixes a bug that was recently introduced.
> > 
> > The second registration should fail, and this patch will make it fail,
> > and recover properly.
> 
> Yes, the registration fails. But it seems that the second call to
> create_dir(kobj) with a kobject with the same name and parent corrupts
> the dentry from the first call.
> 
> To test it, I just called create_dir(kobj) a second time for my video
> driver and the sysfs entry of the successful registered kobject was
> corrupted:
	> 
>   [kay@pim ~]$ ls -la /sys/class/video4linux/
>   total 0
>   drwxr-xr-x   3 root root 0 Nov 10 02:53 .
>   drwxr-xr-x  18 root root 0 Nov 10 02:53 ..
>   ?---------   ? ?    ?    ?            ? video0
> 

Thanks for reporting this bug. I think the problem here is doing d_drop()
for the existing directory dentry in create_dir() for error case. It should
not be done for EEXIST. Could you please try the same test with the following 
patch applied.

Thanks
Maneesh

o Do not release existing directory if the new directory happens to be a
  duplicate directory. Thanks to Kay Sievers for the testcase.

Signed-off-by: <maneesh@in.ibm.com>
---

 linux-2.6.10-rc1-bk20-maneesh/fs/sysfs/dir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/sysfs/dir.c~fix-dropping-existing-dir fs/sysfs/dir.c
--- linux-2.6.10-rc1-bk20/fs/sysfs/dir.c~fix-dropping-existing-dir	2004-11-10 16:26:14.000000000 -0600
+++ linux-2.6.10-rc1-bk20-maneesh/fs/sysfs/dir.c	2004-11-10 16:27:42.000000000 -0600
@@ -111,7 +111,7 @@ static int create_dir(struct kobject * k
 				d_rehash(*d);
 			}
 		}
-		if (error)
+		if (error && (error != -EEXIST))
 			d_drop(*d);
 		dput(*d);
 	} else
_



-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
