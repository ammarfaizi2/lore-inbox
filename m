Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSJXAgC>; Wed, 23 Oct 2002 20:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265272AbSJXAgC>; Wed, 23 Oct 2002 20:36:02 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:33552 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264732AbSJXAfz>; Wed, 23 Oct 2002 20:35:55 -0400
Date: Thu, 24 Oct 2002 01:42:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, alan@lxorquk.ukuu.org.uk,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
Message-ID: <20021024014204.A31345@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
	greg@kroah.com, alan@lxorquk.ukuu.org.uk,
	linux-scsi@vger.kernel.org
References: <3DB7304A.3030903@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB7304A.3030903@mvista.com>; from sdake@mvista.com on Wed, Oct 23, 2002 at 04:27:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 04:27:06PM -0700, Steven Dake wrote:
> lkml,
> 
> Attached is an update of the Advanced TCA disk hotswap driver to provide 
> disk hotswap
> support for the Linux Kernel 2.5.43.  Hotswap targets include both SCSI 
> and FibreChannel.
> Note this support is generic in that it will work in a typical PC system 
> with SCSI or
> FibreChannel disks.

Thanks a lot for doing the work.  There are still some issues to sort
out, but I guess we'll be able to finish getting it integrated into
the tree.

Btw, please Cc linux-scsi@vger.kernel.org for scsi-related patches.

> linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c
> --- linux-2.5.44-qla/drivers/scsi/hosts.c    Fri Oct 18 21:01:09 2002
> +++ linux-2.5.44-scsi-hotswap/drivers/scsi/hosts.c    Wed Oct 23 
> 15:35:30 2002
> @@ -371,6 +371,7 @@
>     scsi_hosts_registered++;
> 
>     spin_lock_init(&shost->default_lock);
> +    spin_lock_init(&shost->host_queue_lock);
>     scsi_assign_lock(shost, &shost->default_lock);
>     atomic_set(&shost->host_active,0);

I think your mailer mangles the patch a bit, I'm pretty sure that
code uses one tab indentation.  Please make sure that you use
that indentation in new code (if you editor gets it wrong all
the time just run the source through unexpand(1))

>     int (* bios_param)(Disk *, struct block_device *, int []);
> 
> +#ifdef CONFIG_SCSIFCHOTSWAP
> +    /*
> +     * Used to determine the id to send the inquiry command to during
> +     * hot additions of FibreChannel targets
> +     */
> +    int (*get_scsi_info_from_wwn)(int mode, unsigned long long wwn, int 
> *host, int *channel, int *lun, int *id);
> +#endif

Please make this method unconditional - even if we don't call it without
your option set, the drivers are cluttered up much less this way.

> @@ -0,0 +1,1334 @@
> +/*
> + * hotswap.c
> + *
> + * SCSI/FibreChannel Hotswap kernel implementaton
> + * + * Author: MontaVista Software, Inc.

Is this + * intentional or a cut & paste error? :)

> *buf)
> +{
> +    buf->f_type = SCSI_HOTSWAP_MAGIC;
> +    buf->f_bsize = PAGE_CACHE_SIZE;
> +    buf->f_namelen = 255;
> +    return (0);
> +}

Please take a look at fs/libfs.c.  For most of your filesystem
methods you can just use the simple_* functions there.

> +static int scsi_hotswap_mkdir (struct inode *dir, struct dentry *dentry,
> +    int mode)
> +{
> +    return (scsi_hotswap_mknod (dir, dentry, mode | S_IFDIR, 0));

Small codingstyle issue, this should be:

	return scsi_hotswap_mknod(dir, dentry, mode | S_IFDIR, 0);

Btw, have you read Documentation/CodingStyle in the kernel tree?

> +
> +static ssize_t default_read_file (struct file *file, char *buf, size_t 
> count,
> +    loff_t *ppos)
> +{
> +    return (0);
> +}
> +
> +static ssize_t default_write_file (struct file *file, const char *buf,
> +    size_t count, loff_t *ppos)
> +{
> +    return (count);
> +}

If you don't need read/write just don't set those methods in
the operation vector - the kernel can cope with that.

> +
> +static loff_t default_file_lseek (struct file *file, loff_t offset, int 
> orig)
> +{
> +    loff_t retval = -EINVAL;
> +
> +    switch(orig) {
> +    case 0:
> +        if (offset > 0) {
> +            file->f_pos = offset;
> +            retval = file->f_pos;
> +        }
> +        break;
> +    case 1:
> +        if ((offset + file->f_pos) > 0) {
> +            file->f_pos += offset;
> +            retval = file->f_pos;
> +        }
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return (retval);
> +}

This isn't different from default_llseek (except of missing locking),
just don't implement ->llseek, the VFS will take care of you.

> +
> +static int default_open (struct inode *inode, struct file *filp)
> +{
> +    if (inode->u.generic_ip) {
> +        filp->private_data = inode->u.generic_ip;
> +    }
> +    return (0);
> +}

You don't seem to actually use file->private_data.  Unless I'm
wrong you don't have to implement ->open at all.

> +
> +static int default_sync_file (struct file *file, struct dentry *dentry,
> +    int datasync)
> +{
> +    return (0);
> +}

Again, no need to implement a noop ->fsync, VFS deals with it not beeing
implemented.

> +static struct file_operations default_file_operations = {
> +    read:        default_read_file,
> +    write:         default_write_file,
> +    open:        default_open,
> +    llseek:        default_file_lseek,
> +    fsync:         default_sync_file,
> +    mmap:         generic_file_mmap,
> +};

Please use C99 struct-initializers, i.e.

static struct file_operations default_file_operations = {
	.mmap = 	generic_file_mmap,
};

> + * scsi_hotswap_insert_by_scsi_id file operations structure
> + */
> +static ssize_t scsi_hotswap_insert_by_scsi_id_read_file (struct file 
> *file,
> +    char *buf, size_t count, loff_t *offset);
> +static ssize_t scsi_hotswap_insert_by_scsi_id_write_file (struct file 
> *file,
> +    const char *buf, size_t count, loff_t *ppos);

Looks like this wants a bit nicer line-wrapping (or shorter function
names :))

<lots of file_operations snipped)

Mayb you can put a switch into ->read/->write instead of having
many different file operations?

> +/*
> + * Core file read/write operations interfaces
> + */
> +static char scsi_hotswap_insert_by_scsi_id_usage[] = {
> +    "Usage: echo \"[host] [channel] [lun] [id]\" > insert_by_scsi_id\n"
> +};

I don't think the kernel should supply usage information.

> +/*
> + * Core Interface Implementation
> + * Note these are exported to the global symbol table for
> + * other subsystems to use such as a scsi processor or 1394
> + */
> +int scsi_hotswap_insert_by_scsi_id (unsigned int host, unsigned int 
> channel,
> +    unsigned int lun, unsigned int id)
> +{
> +    struct Scsi_Host *scsi_host;
> +    Scsi_Device *scsi_device;
> +
> +    for (scsi_host = scsi_host_get_next (NULL); scsi_host;
> +        scsi_host = scsi_host_get_next (scsi_host)) {
> +        if (scsi_host->host_no == host) {
> +            break;
> +        }
> +    }
> +    if (scsi_host == 0) {
> +        return (-ENXIO);
> +    }
> +
> +    spin_lock (&scsi_host->host_queue_lock);
> +
> +    /*
> +     * Determine if device already attached
> +     */
> +    for (scsi_device = scsi_host->host_queue; scsi_device; scsi_device 
> = scsi_device->next) {
> +        if ((scsi_device->channel == channel
> +             && scsi_device->id == id
> +             && scsi_device->lun == lun)) {
> +            break;
> +        }
> +    }
> +   
> +    spin_unlock (&scsi_host->host_queue_lock);
> +
> +    /*
> +     * If scsi_device found in host queue, then device already attached
> +     */
> +    if (scsi_device) {
> +        return (-EEXIST);
> +    }
> +
> +    scan_scsis(scsi_host, 1, channel, id, lun);
> +
> +    return (0);
> +}

This seems to be largely copied from proc_scsi_gen_write().  What about
factoring out a common support function? (dito for many of the functions
below)

> diff -uNr linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c 
> linux-2.5.44-scsi-hotswap/drivers/scsi/qla2xxx/qla2x00.c
> --- linux-2.5.44-qla/drivers/scsi/qla2xxx/qla2x00.c    Wed Oct 23 

Doesn't seem to exist in my tree..

> diff -uNr linux-2.5.44-qla/include/linux/scsi_hotswap.h 
> linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h
> --- linux-2.5.44-qla/include/linux/scsi_hotswap.h    Wed Dec 31 17:00:00 
> 1969
> +++ linux-2.5.44-scsi-hotswap/include/linux/scsi_hotswap.h    Wed Oct 23 

I think this one should go to include/scsi/ instead, that's where
the other scsi headers live.

