Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSJXTzS>; Thu, 24 Oct 2002 15:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265630AbSJXTzS>; Thu, 24 Oct 2002 15:55:18 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:49661 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S265626AbSJXTzB>; Thu, 24 Oct 2002 15:55:01 -0400
Message-ID: <3DB85239.60407@mvista.com>
Date: Thu, 24 Oct 2002 13:04:09 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
References: <3DB7304A.3030903@mvista.com> <20021024014204.A31345@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph

Thanks for the comments some responses below.

Christoph Hellwig wrote:

>On Wed, Oct 23, 2002 at 04:27:06PM -0700, Steven Dake wrote:
>  
>
>>lkml,
>>
>>Attached is an update of the Advanced TCA disk hotswap driver to provide 
>>disk hotswap
>>support for the Linux Kernel 2.5.43.  Hotswap targets include both SCSI 
>>and FibreChannel.
>>Note this support is generic in that it will work in a typical PC system 
>>with SCSI or
>>FibreChannel disks.
>>    
>>
>
>Thanks a lot for doing the work.  There are still some issues to sort
>out, but I guess we'll be able to finish getting it integrated into
>the tree.
>
>Btw, please Cc linux-scsi@vger.kernel.org for scsi-related patches.
>
>  
>
>>linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c
>>--- linux-2.5.44-qla/drivers/scsi/hosts.c    Fri Oct 18 21:01:09 2002
>>+++ linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c    Wed Oct 23 
>>15:35:30 2002
>>@@ -371,6 +371,7 @@
>>    scsi_hosts_registered++;
>>
>>    spin_lock_init(&shost->default_lock);
>>+    spin_lock_init(&shost->host_queue_lock);
>>    scsi_assign_lock(shost, &shost->default_lock);
>>    atomic_set(&shost->host_active,0);
>>    
>>
>
>I think your mailer mangles the patch a bit, I'm pretty sure that
>code uses one tab indentation.  Please make sure that you use
>that indentation in new code (if you editor gets it wrong all
>the time just run the source through unexpand(1))
>  
>
I used tabs.  My mozilla mailer won't let me include patches inline so I 
guess I can just
attach them in the future.

>  
>
>>    int (* bios_param)(Disk *, struct block_device *, int []);
>>
>>+#ifdef CONFIG_SCSIFCHOTSWAP
>>+    /*
>>+     * Used to determine the id to send the inquiry command to during
>>+     * hot additions of FibreChannel targets
>>+     */
>>+    int (*get_scsi_info_from_wwn)(int mode, unsigned long long wwn, int 
>>*host, int *channel, int *lun, int *id);
>>+#endif
>>    
>>
>
>Please make this method unconditional - even if we don't call it without
>your option set, the drivers are cluttered up much less this way.
>  
>
I see your point.  Will do.

>  
>
>>@@ -0,0 +1,1334 @@
>>+/*
>>+ * hotswap.c
>>+ *
>>+ * SCSI/FibreChannel Hotswap kernel implementaton
>>+ * + * Author: MontaVista Software, Inc.
>>    
>>
>
>Is this + * intentional or a cut & paste error? :)
>  
>
must be a cut and paste error

>  
>
>>*buf)
>>+{
>>+    buf->f_type = SCSI_HOTSWAP_MAGIC;
>>+    buf->f_bsize = PAGE_CACHE_SIZE;
>>+    buf->f_namelen = 255;
>>+    return (0);
>>+}
>>    
>>
>
>Please take a look at fs/libfs.c.  For most of your filesystem
>methods you can just use the simple_* functions there.
>  
>
I'm going to move the driver to driverfs for the 2.5 patch so most of 
the comments should fall
out.  Thanks for looking at the code though!

[SNIP]

>  
>
>  
>
>>+static struct file_operations default_file_operations = {
>>+    read:        default_read_file,
>>+    write:         default_write_file,
>>+    open:        default_open,
>>+    llseek:        default_file_lseek,
>>+    fsync:         default_sync_file,
>>+    mmap:         generic_file_mmap,
>>+};
>>    
>>
>
>Please use C99 struct-initializers, i.e.
>
>static struct file_operations default_file_operations = {
>	.mmap = 	generic_file_mmap,
>};
>
>  
>
Thanks will do.

>>+ * scsi_hotswap_insert_by_scsi_id file operations structure
>>+ */
>>+static ssize_t scsi_hotswap_insert_by_scsi_id_read_file (struct file 
>>*file,
>>+    char *buf, size_t count, loff_t *offset);
>>+static ssize_t scsi_hotswap_insert_by_scsi_id_write_file (struct file 
>>*file,
>>+    const char *buf, size_t count, loff_t *ppos);
>>    
>>
>
>Looks like this wants a bit nicer line-wrapping (or shorter function
>names :))
>
><lots of file_operations snipped)
>
>Mayb you can put a switch into ->read/->write instead of having
>many different file operations?
>  
>
Good idea.

>  
>
>>+/*
>>+ * Core file read/write operations interfaces
>>+ */
>>+static char scsi_hotswap_insert_by_scsi_id_usage[] = {
>>+    "Usage: echo \"[host] [channel] [lun] [id]\" > insert_by_scsi_id\n"
>>+};
>>    
>>
>
>I don't think the kernel should supply usage information.
>  
>
I've gotten mixed feedback on this one.  One thing that annoys me about 
some of the proc read/write routines
to control the kernel is without looking at the code, there is no way to 
understand how to use them.

The user should be able to read the file and see "how to use" the method 
exported by the filesystem
without looking at the code (imho).  This is a big advantage of having a 
read() method.

>  
>
>>+/*
>>+ * Core Interface Implementation
>>+ * Note these are exported to the global symbol table for
>>+ * other subsystems to use such as a scsi processor or 1394
>>+ */
>>+int scsi_hotswap_insert_by_scsi_id (unsigned int host, unsigned int 
>>channel,
>>+    unsigned int lun, unsigned int id)
>>+{
>>+    struct Scsi_Host *scsi_host;
>>+    Scsi_Device *scsi_device;
>>+
>>+    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
>>+        scsi_host = scsi_host_get_next (scsi_host)) {
>>+        if (scsi_host->host_no == host) {
>>+            break;
>>+        }
>>+    }
>>+    if (scsi_host == 0) {
>>+        return (-ENXIO);
>>+    }
>>+
>>+    spin_lock (&scsi_host->host_queue_lock);
>>+
>>+    /*
>>+     * Determine if device already attached
>>+     */
>>+    for (scsi_device = scsi_host->host_queue; scsi_device; scsi_device 
>>= scsi_device->next) {
>>+        if ((scsi_device->channel == channel
>>+             && scsi_device->id == id
>>+             && scsi_device->lun == lun)) {
>>+            break;
>>+        }
>>+    }
>>+   
>>+    spin_unlock (&scsi_host->host_queue_lock);
>>+
>>+    /*
>>+     * If scsi_device found in host queue, then device already attached
>>+     */
>>+    if (scsi_device) {
>>+        return (-EEXIST);
>>+    }
>>+
>>+    scan_scsis(scsi_host, 1, channel, id, lun);
>>+
>>+    return (0);
>>+}
>>    
>>
>
>This seems to be largely copied from proc_scsi_gen_write().  What about
>factoring out a common support function? (dito for many of the functions
>below)
>  
>
I'll replace proc_scsi_gen_writes() routine with this routine instead. 
 The point of this
routine is to be a generic call for other kernel functions to call like 
proc_scsi_gen_write.

I do think hotswap functionality should be removed from 
proc_scsi_gen_write but that might
confuse some folks that rely on that functionality.

>  
>
>>diff -uNr linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c 
>>linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c
>>--- linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c    Wed Oct 23 
>>    
>>
>
>Doesn't seem to exist in my tree..
>  
>
This is in my private tree only and is the QLogic 6.1 driver integrated 
into 2.5.44.  This is
needed to support FibreChannel hotswap only.  The generic kernel can 
live without this patch
until the QLogic driver is integrated...

>  
>
>>diff -uNr linux-2.5.44-qla/include/linux/scsi_hotswap.h 
>>linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h
>>--- linux-2.5.44-qla/include/linux/scsi_hotswap.h    Wed Dec 31 17:00:00 
>>1969
>>+++ linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h    Wed Oct 23 
>>    
>>
>
>I think this one should go to include/scsi/ instead, that's where
>the other scsi headers live.
>
>  
>
This is in include/linux so that other kernel functions may call the 
hotswap operations and
have the function prototypes defined.  An example here is 1394.  We 
don't want 1394 having
to include "../../drivers/scsi/scsi_hotswap.h" I don't think :)

I'll make some of the changes you have suggested and post a new patch.

Thanks for the comments!
-steve

