Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVAEOih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVAEOih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVAEOih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:38:37 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39818 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262453AbVAEOiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:38:00 -0500
Date: Wed, 5 Jan 2005 10:04:23 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bryan Fulton <bryan@coverity.com>
Cc: linux-kernel@vger.kernel.org, jaharkes@cs.cmu.edu,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       acme@conectiva.com.br, davem@redhat.com, kas@fi.muni.cz,
       nathans@sgi.com
Subject: Re: [Coverity] Untrusted user data in kernel
Message-ID: <20050105120423.GA13662@logos.cnet>
References: <1103247211.3071.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1103247211.3071.74.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Bryan,

First of all, thanks very much for this effort.

Davem: Please check the networking ones, there are several.

On Thu, Dec 16, 2004 at 05:33:32PM -0800, Bryan Fulton wrote:
> Hi, recently we ran a security checker over linux and discovered some 
> flaws in the Linux 2.6.9 kernel. I've inserted into this post a few
> examples of what we found.  These functions copy in user data
> (copy_from_user) and use it as an array index, loop bound or memory
> function argument without proper bounds checking.  
> 
> This posting just involves bugs in /fs, /net and /drivers/net. There
> will be more postings for similar flaws in the drivers, as well as
> network exploitable bugs and bugs in system calls.  

We're anxious to see those.

> Some can be viewed as minor as they might involve directly passing an
> unsigned tainted scalar to kmalloc. I was under the impression that
> kmalloc has an implicit bounds check as it returns null if attempting to
> allocate >64kb (or at least it used to). Can someone confirm/disconfirm
> that? 

On v2.6 the kmalloc limit is 128k for most machines.

!CONFIG_MMU allows up to 1Mb and CONFIG_LARGE_ALLOCS allows up to 32Mb, so better
not rely on kmalloc checking. ;)

> Suggestions for other security properties to check are welcome.  We
> appreciate your feedback as a method to improve and expand our
> security checkers.

Please run the checker on v2.4.29-pre3.

Would be really nice if you could do it periodically say on each new kernel release (v2.6
and v2.4) or a monthly basis.

> Thanks,
> .:Bryan Fulton and Ted Unangst of Coverity, Inc.
> 
> Quick location summary:
> 
> /fs/coda/pioctl.c::coda_pioctl
> /fs/xfs/linux-2.6/xfs_ioctl.c::xfs_attrmulti_by_handle
> /net/ipv6/netfilter/ip6_tables.c::do_replace
> /net/bridge/br_ioctl.c::old_deviceless
> /net/rose/rose_route.c::rose_rt_ioctl
> /drivers/net/wan/sdla.c::sdla_xfer
> 
> /////////////////////////////////////////////////////
> // 1:  /fs/coda/pioctl.c::coda_pioctl              //
> /////////////////////////////////////////////////////
> - tainted scalars (signed shorts) data->vi.in_size and data->vi.out_size
> are used to copy memory from and to user space
> - neither are properly upper/lower bounds checked (in_size only
> upper-bound checked, out_size only lower-bound checked)

<snip>

> TAINTED variable "((data)->vi).in_size" passed to tainted data sink
> "copy_from_user"
> 
> 572    if ( copy_from_user((char*)inp + (long)inp->coda_ioctl.data,
> 573                         data->vi.in, data->vi.in_size) ) {
> 574            error = -EINVAL;
> 575            goto exit;
> 576    }
> 
> ... 
> 
> Checked lower bounds of signed scalar "((data)->vi).out_size" by 
>                             "((outp)->coda_ioctl).len >
> ((data)->vi).out_size"
> 
> 588             if (outp->coda_ioctl.len > data->vi.out_size) {
> 589                     error = -EINVAL;
> 590             } else {
> 
> TAINTED variable "((data)->vi).out_size" passed to tainted data sink
> "copy_to_user"
> 
> 591                     if (copy_to_user(data->vi.out, 
> 592                                      (char *)outp +
> (long)outp->coda_ioctl.data, 
> 593                                      data->vi.out_size)) {
> 594                             error = -EFAULT;
> 595                             goto exit;
> 596                     }


Correct, fix for both v2.4 and v2.6 attached. Adds bound checking:

Jan Harkes, please check correctness so we can apply it.

--- linux-2.6.10-rc3/fs/coda/upcall.c.orig	2005-01-05 10:30:24.575445152 -0200
+++ linux-2.6.10-rc3/fs/coda/upcall.c	2005-01-05 10:30:26.623133856 -0200
@@ -550,10 +550,15 @@
 	UPARG(CODA_IOCTL);
 
         /* build packet for Venus */
-        if (data->vi.in_size > VC_MAXDATASIZE) {
+        if (data->vi.in_size > VC_MAXDATASIZE || data->vi.in_size < 0) {
 		error = -EINVAL;
 		goto exit;
-        }
+        } 
+
+	if (data->vi.out_size > VC_MAXDATASIZE || data->vi.out_size < 0) {
+		error = -EINVAL;
+		goto exit;
+	}
 
         inp->coda_ioctl.VFid = *fid;
     
> ////////////////////////////////////////////////////////////////////
> // 2:  /fs/xfs/linux-2.6/xfs_ioctl.c::xfs_attrmulti_by_handle     //
> ////////////////////////////////////////////////////////////////////

XFS people, can you take care of this one please. Not a security threat,
protected under ADMIN caps.

> ////////////////////////////////////////////////////////
> // 3:   /net/ipv6/netfilter/ip6_tables.c::do_replace  //
> ////////////////////////////////////////////////////////

This one lacks bound checking as people discussed, but is not
a security threat since region is protected under NET_ADMIN caps.

> //////////////////////////////////////////////////
> // 4:  /net/bridge/br_ioctl.c::old_deviceless   //
> //////////////////////////////////////////////////

Lacks bound checking but is not a security threat since region 
is protectedunder NET_ADMIN caps.

Something similar to this should do it. Not sure if "65535" is a
sane value, though.

--- br_ioctl.c.orig     2005-01-05 11:02:28.301994264 -0200
+++ br_ioctl.c  2005-01-05 11:02:30.552652112 -0200
@@ -324,6 +324,9 @@
                int *indices;
                int ret = 0;
 
+               if (args[2] > 65535)
+                       return -EFAULT;
+
                indices = kmalloc(args[2]*sizeof(int), GFP_KERNEL);
                if (indices == NULL)
                        return -ENOMEM;

> ////////////////////////////////////////////////// 
> // 5:   /net/rose/rose_route.c::rose_rt_ioctl   //
> //////////////////////////////////////////////////

Not a security threat because requires NET_ADMIN caps. 

Alan, Arnaldo, proper bound checking is required nevertheless. 
Can you take a look at this please?

> //////////////////////////////////////////////
> // 6:   /drivers/net/wan/sdla.c::sdla_xfer  //
> //////////////////////////////////////////////
> 
> - tainted signed scalar mem.len passed to kmalloc and memset (1206 and
> 1211, or 1220 and 1223). Possibly minor because of kmalloc's
> implicit size check

Protected by NET_ADMIN caps, but definately needs some bound checking.

Jan, I think SDLA_MAX_DATA is the correct bound to check for here, can 
you confirm please?

--- linux-2.4.28.orig/drivers/net/wan/sdla.c	2004-12-31 15:21:16.000000000 -0200
+++ linux-2.4.28/drivers/net/wan/sdla.c	2005-01-05 11:23:15.089453760 -0200
@@ -1195,6 +1195,9 @@
 
 	if(copy_from_user(&mem, info, sizeof(mem)))
 		return -EFAULT;
+
+	if (mem.len > SDLA_MAX_DATA || mem.len < 0)
+		return -EFAULT;
 		
 	if (read)
 	{	

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="24_coda.patch"

--- linux-2.4.28/fs/coda/upcall.c.orig	2005-01-05 10:33:55.427390784 -0200
+++ linux-2.4.28/fs/coda/upcall.c	2005-01-05 10:33:58.739887208 -0200
@@ -538,11 +538,16 @@
 	UPARG(CODA_IOCTL);
 
         /* build packet for Venus */
-        if (data->vi.in_size > VC_MAXDATASIZE) {
+        if (data->vi.in_size > VC_MAXDATASIZE || data->vi.in_size < 0) {
 		error = -EINVAL;
 		goto exit;
         }
 
+	if (data->vi.out_size > VC_MAXDATASIZE || data->vi.out_size < 0) {
+		error = -EINVAL;
+		goto exit;
+	}
+
         inp->coda_ioctl.VFid = *fid;
     
         /* the cmd field was mutated by increasing its size field to

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="26_coda.patch"

--- linux-2.6.10-rc3/fs/coda/upcall.c.orig	2005-01-05 10:30:24.575445152 -0200
+++ linux-2.6.10-rc3/fs/coda/upcall.c	2005-01-05 10:30:26.623133856 -0200
@@ -550,10 +550,15 @@
 	UPARG(CODA_IOCTL);
 
         /* build packet for Venus */
-        if (data->vi.in_size > VC_MAXDATASIZE) {
+        if (data->vi.in_size > VC_MAXDATASIZE || data->vi.in_size < 0) {
 		error = -EINVAL;
 		goto exit;
-        }
+        } 
+
+	if (data->vi.out_size > VC_MAXDATASIZE || data->vi.out_size < 0) {
+		error = -EINVAL;
+		goto exit;
+	}
 
         inp->coda_ioctl.VFid = *fid;
     

--WIyZ46R2i8wDzkSu--
