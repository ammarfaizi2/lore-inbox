Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284765AbRLKBCB>; Mon, 10 Dec 2001 20:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284766AbRLKBBu>; Mon, 10 Dec 2001 20:01:50 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:35853 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S284765AbRLKBBg>; Mon, 10 Dec 2001 20:01:36 -0500
Date: Mon, 10 Dec 2001 20:01:25 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@marabou.research.att.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] 2.4.17-pre7: fdomain_16x0_release undeclared
In-Reply-To: <E16DY8J-0003Z7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112101950320.8097-100000@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan!

> > > I wonder if the patches that introduce warnings should be allowed in the 
> > > stable branch?  Anyway, comparing with other SCSI drivers I see that 0 
> > > should be returned and scsi_unregister(shpnt) should be called before 
> > > that.
> 
> All the drivers I looked at return 1 and don't call scsi_unregister(shpnt).

Strange.  That's what I see:

advansys.c:5777    scsi_unregister, return 0
eata.c:2069        scsi_unregister, return FALSE (i.e. 0)
inia100.c:790      no scsi_unregister, return 0
aha152x.c:1409     scsi_unregister, return 0
gdth.c:4373        scsi_unregister, return 0
ibmmca.c:1851      no scsi_unregister, return 0
53c7,8xx.c:6431    no scsi_unregister, return 1
eata_dma.c:146     no scsi_unregister, return 1

> Inspecting the core code shows that 
> 
> 	1.	The return code is ignored (see I did test it worked 8))
> 	2.	scsi_unregister() is done by the core code for us

Anyway, if it doesn't matter then let's not waste time on it.

> So I believe it simply needs a 
> 
> 	return 1 
> 
> on the end

Fine.  That's the updated patch:

======================================
--- linux.orig/drivers/scsi/fdomain.c
+++ linux/drivers/scsi/fdomain.c
@@ -2042,6 +2042,7 @@ int fdomain_16x0_release(struct Scsi_Hos
 	if (shpnt->io_port && shpnt->n_io_port)
 		release_region(shpnt->io_port, shpnt->n_io_port);
 
+	return 1;
 }
 
 MODULE_LICENSE("GPL");
--- linux.orig/drivers/scsi/fdomain.h
+++ linux/drivers/scsi/fdomain.h
@@ -34,6 +34,7 @@
 int        fdomain_16x0_biosparam( Disk *, kdev_t, int * );
 int        fdomain_16x0_proc_info( char *buffer, char **start, off_t offset,
 				   int length, int hostno, int inout );
+int        fdomain_16x0_release(struct Scsi_Host *shpnt);
 
 #define FDOMAIN_16X0 { proc_info:      fdomain_16x0_proc_info,           \
 		       detect:         fdomain_16x0_detect,              \
======================================

-- 
Regards,
Pavel Roskin

