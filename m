Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSJPURT>; Wed, 16 Oct 2002 16:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSJPURT>; Wed, 16 Oct 2002 16:17:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:11415 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261365AbSJPURR>; Wed, 16 Oct 2002 16:17:17 -0400
Date: Wed, 16 Oct 2002 13:22:55 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Adam Radford <aradford@3WARE.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'torvalds@transmeta.com'" <torvalds@transmeta.com>
Subject: Re: 2.5.43 aic7xxx segfault sd_synchronize_cache() called after SHT-> release()
Message-ID: <20021016132255.A4170@eng2.beaverton.ibm.com>
Mail-Followup-To: Adam Radford <aradford@3WARE.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'torvalds@transmeta.com'" <torvalds@transmeta.com>
References: <A1964EDB64C8094DA12D2271C04B812672C79B@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <A1964EDB64C8094DA12D2271C04B812672C79B@tabby>; from aradford@3WARE.com on Wed, Oct 16, 2002 at 12:41:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 12:41:14PM -0700, Adam Radford wrote:
> I think sd_synchronize_cache() is getting called after SHT->release()
> function,
> which couldn't possibly be right.  This causes adaptec, 3ware, etc, to
> segfault
> on rmmod.
> 
> See below for adaptec segfault output:
> 
> aic7xxx
> CPU:    1
> EIP:    0060:[<c025918b>]    Not tainted
> EFLAGS: 00010202
> EIP is at put_device+0x7b/0xa0
> eax: 00000000   ebx: c8997028   ecx: 00000001   edx: c0465470
> esi: c12f4174   edi: c8997000   ebp: 00000000   esp: c5b81ee4
> ds: 0068   es: 0068   ss: 0068
> Process rmmod (pid: 1085, threadinfo=c5b80000 task=c5d4a800)
> Stack: c8997028 c0481e20 c02d0f3a c8997028 c8997028 c0481f3c c8997028
> c0481f4c
>        00000000 c66fe1e8 00000286 c798aa00 c0481e20 c12f4000 c13b5000
> c02be9aa
>        c12f4000 c5b81f30 00000002 00030002 00000002 08072009 c042399f
> 08071fff
> Call Trace:
>  [<c02d0f3a>] sg_detach+0x20a/0x240
>  [<c02be9aa>] scsi_unregister_host+0x26a/0x5f0
>  [<c01418d8>] __alloc_pages+0x88/0x270
>  [<c892f12a>] exit_this_scsi_driver+0xa/0xc [aic7xxx]
>  [<c893a740>] driver_template+0x0/0x70 [aic7xxx]
>  [<c012029e>] free_module+0x1e/0x140
>  [<c011f3db>] sys_delete_module+0x1db/0x4c0
>  [<c010787f>] syscall_call+0x7/0xb
> 
> Code: 0f 0b 0d 01 86 69 3d c0 8b 83 d4 00 00 00 85 c0 74 04 53 ff

Are you sure it is not a BUG? This looks just like what Badari reported
yesterday:

kernel BUG at drivers/base/core.c:251!
invalid operand: 0000
qla2200
CPU:    0
EIP:    0060:[<c023eb24>]    Not tainted
EFLAGS: 00010202
EIP is at put_device+0x64/0x90
eax: 00000000   ebx: f8a08028   ecx: f8a080c4   edx: 00000001
esi: c3aded54   edi: f8a08000   ebp: 00000003   esp: cb007ee4
ds: 0068   es: 0068   ss: 0068
Process rmmod (pid: 4803, threadinfo=cb006000 task=f62c98c0)
Stack: f8a08028 c0477a40 c02ce533 f8a08028 f8a08028 c0477b5c f8a08028 c0477b6c
       00000000 40153f6d 00000286 f68fc000 c0477a40 c3adec00 f4df0000 c02a7a9a
       c3adec00 cb007f30 00000002 00030002 00000001 08071002 c041685c 08070ffd  
Call Trace:
 [<c02ce533>] sg_detach+0x1e3/0x210
 [<c02a7a9a>] scsi_unregister_host+0x26a/0x5d0
 [<c01f4736>] __generic_copy_to_user+0x56/0x80
 [<c013e4e8>] __alloc_pages+0x98/0x270
 [<f89e7cba>] exit_this_scsi_driver+0xa/0x10 [qla2200]
 [<f8a00360>] driver_template+0x0/0x74 [qla2200]
 [<c011ea0e>] free_module+0x1e/0x130
 [<c011dc94>] sys_delete_module+0x1b4/0x410
 [<c01075e3>] syscall_call+0x7/0xb

I posted a patch to change the put_device() calls to device_unregister(),
st.c got fixed in 2.5.43, these are still not fixed in 2.5.43:

--- linux-2.5.43/drivers/scsi/scsi.c	Tue Oct 15 20:28:22 2002
+++ linux-2.5.43-unreg/drivers/scsi/scsi.c	Wed Oct 16 12:50:08 2002
@@ -2248,7 +2248,7 @@
 			if (shpnt->hostt->slave_detach)
 				(*shpnt->hostt->slave_detach) (SDpnt);
 			devfs_unregister (SDpnt->de);
-			put_device(&SDpnt->sdev_driverfs_dev);
+			device_unregister(&SDpnt->sdev_driverfs_dev);
 		}
 	}
 
@@ -2299,7 +2299,7 @@
 		/* Remove the /proc/scsi directory entry */
 		sprintf(name,"%d",shpnt->host_no);
 		remove_proc_entry(name, tpnt->proc_dir);
-		put_device(&shpnt->host_driverfs_dev);
+		device_unregister(&shpnt->host_driverfs_dev);
 		if (tpnt->release)
 			(*tpnt->release) (shpnt);
 		else {
--- linux-2.5.43/drivers/scsi/sg.c	Tue Oct 15 20:27:57 2002
+++ linux-2.5.43-unreg/drivers/scsi/sg.c	Wed Oct 16 12:50:25 2002
@@ -1611,7 +1611,7 @@
 		sdp->de = NULL;
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
-		put_device(&sdp->sg_driverfs_dev);
+		device_unregister(&sdp->sg_driverfs_dev);
 		if (NULL == sdp->headfp)
 			vfree((char *) sdp);
 	}
