Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVHDWLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVHDWLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVHDWI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:08:29 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:54725 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262756AbVHDWIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:08:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gmWDRzqk6P/vJnKYn+TnshLXk6MAQsjxr9W12V4hTI+fU1luXGjmzqDjC/TeQgupxkyxoMyypLydXtNAuws7uJyOWE2PjIDK6WNJdpAADRKQMaAxafZWkwAV4Xv6uTZpKzxekwQvjsX4mXnwXSHyLbMD5oDfBqK6Ogt4mMkXt+c=
Date: Fri, 5 Aug 2005 02:16:12 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, axboe@suse.de,
       "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>
Subject: Documentation/ioctl-mess.txt and ida_ioctl() review (was Re: [PATCH 2/3] cpqarray: ioctl support to configure LUNs dynamically)
Message-ID: <20050804221612.GA3446@mipter.zuzino.mipt.ru>
References: <4221C1B21C20854291E185D1243EA8F302623BD9@bgeexc04.asiapacific.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4221C1B21C20854291E185D1243EA8F302623BD9@bgeexc04.asiapacific.cpqcorp.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 10:15:29AM +0530, Saripalli, Venkata Ramanamurthy (STSD) wrote:
> Patch 2 of 3
> This patch adds support for IDAREGNEWDISK, IDADEREGDISK, IDAGETLOGINFO
> ioctls required
> to configure LUNs dynamically on SA4200 controller using ACU.

drivers/block/cpqarray.c:

  1131	static int ida_ioctl(struct inode *inode, struct file *filep, unsigned int cmd, unsigned long arg)
  1132	{
  1133		drv_info_t *drv = get_drv(inode->i_bdev->bd_disk);
  1134		ctlr_info_t *host = get_host(inode->i_bdev->bd_disk);
  1135		int error;
  1136		int diskinfo[4];

Hmm... diskinfo[3] seems to be enough.

  1137		struct hd_geometry __user *geo = (struct hd_geometry __user *)arg;
  1138		ida_ioctl_t __user *io = (ida_ioctl_t __user *)arg;
  1139		ida_ioctl_t *my_io;
  1140
  1141		switch(cmd) {
  1142		case HDIO_GETGEO:
  1143			if (drv->cylinders) {
  1144				diskinfo[0] = drv->heads;
  1145				diskinfo[1] = drv->sectors;
  1146				diskinfo[2] = drv->cylinders;
  1147			} else {
  1148				diskinfo[0] = 0xff;
  1149				diskinfo[1] = 0x3f;
  1150				diskinfo[2] = drv->nr_blks / (0xff*0x3f);
  1151			}
  1152			put_user(diskinfo[0], &geo->heads);
  1153			put_user(diskinfo[1], &geo->sectors);
  1154			put_user(diskinfo[2], &geo->cylinders);
  1155			put_user(get_start_sect(inode->i_bdev), &geo->start);

Mental note: export drv->heads, drv->sectors, drv->cylinders and
inode->i_bdev->bd_part->start_sect to userspace (with possible tweaking).

  1156			return 0;
  1157		case IDAGETDRVINFO:
  1158			if (copy_to_user(&io->c.drv, drv, sizeof(drv_info_t)))

What does drv_info_t contain? From drivers/block/cpqarray.h:

    47	typedef struct {
    48		unsigned blk_size;
    49		unsigned nr_blks;
    50		unsigned cylinders;
    51		unsigned heads;
    52		unsigned sectors;
    53		int usage_count;
    54	} drv_info_t;

Great... Same heads, sectors, cylinders we can already export. Without magic
"if (!drv->cylinders)". With extra crap for free: "usage_count". Why should
userspace know about reference count of drive? <greppery-grep> This is
not even funny...

$ grep usage_count -w -r . | grep cpq
./drivers/block/cpqarray.c:	host->usage_count++;
./drivers/block/cpqarray.c:	host->usage_count--;
./drivers/block/cpqarray.c:	if (host->usage_count > 1) {
./drivers/block/cpqarray.c:			" revalidation (usage=%d)\n", host->usage_count);
./drivers/block/cpqarray.c:	host->usage_count++;
./drivers/block/cpqarray.c:	host->usage_count--;
./drivers/block/cpqarray.h:	int usage_count;
./drivers/block/cpqarray.h:	int	usage_count;

where the type of "host" is "struct ctlr_info", NOT drv_info_t.

  1159				return -EFAULT;
  1160			return 0;
  1161		case IDAPASSTHRU:
  1162			if (!capable(CAP_SYS_RAWIO))
  1163				return -EPERM;
  1164			my_io = kmalloc(sizeof(ida_ioctl_t), GFP_KERNEL);
  1165			if (!my_io)
  1166				return -ENOMEM;
  1167			error = -EFAULT;
  1168			if (copy_from_user(my_io, io, sizeof(*my_io)))
  1169				goto out_passthru;
  1170			error = ida_ctlr_ioctl(host, drv - host->drv, my_io);
  1171			if (error)
  1172				goto out_passthru;
  1173			error = -EFAULT;
  1174			if (copy_to_user(io, my_io, sizeof(*my_io)))
  1175				goto out_passthru;
  1176			error = 0;
  1177	out_passthru:
  1178			kfree(my_io);
  1179			return error;
  1180		case IDAGETCTLRSIG:
  1181			if (!arg) return -EINVAL;
  1182			put_user(host->ctlr_sig, (int __user *)arg);
  1183			return 0;
  1184		case IDAREVALIDATEVOLS:
  1185			if (iminor(inode) != 0)
  1186				return -ENXIO;
  1187			return revalidate_allvol(host);
  1188		case IDADRIVERVERSION:
  1189			if (!arg) return -EINVAL;
  1190			put_user(DRIVER_VERSION, (unsigned long __user *)arg);
  1191			return 0;

Why should userspace know anything about module version?

  1192		case IDAGETPCIINFO:
  1193		{
  1194
  1195			ida_pci_info_struct pciinfo;
  1196
  1197			if (!arg) return -EINVAL;
  1198			pciinfo.bus = host->pci_dev->bus->number;
  1199			pciinfo.dev_fn = host->pci_dev->devfn;
  1200			pciinfo.board_id = host->board_id;

Why should usersp.... Anyone remembers what was merged first: /proc/pci/ or
this crap?

  1201			if(copy_to_user((void __user *) arg, &pciinfo,
  1202				sizeof( ida_pci_info_struct)))
  1203					return -EFAULT;
  1204			return(0);
  1205		}
  1206
  1207		default:
  1208			return -EINVAL;
  1209		}
  1210
  1211	}

Jens, I ask you to drop this patch. $DEITY witness,
it was wordwrapped,
wasn't incremental,
adds function which semi-duplicates already existing one,
contains irrelevant chunks,
contains commented pieces which are not debugging printks,
adds useless casts,
uses silly (in two orthogonal directions, silly) name for newly added struct,
sometimes returns -E, sometimes -1. Where it isn't a rocket science to
guess _right_ error code, it, of course, returns -1.
and generally says [censored] to CodingStyle.

The most important part, of course, is "it adds new ioctls to where there's
enough mess already".

P. S.: Al repeated many times: people, stay the fuck away from *_ioctl()
unless. Being young and idiot, I didn't want to hear the advice of experienced
hacker. Already LARTed myself.

I did "grep -i ioctl -r .". I started to dig through it. From ~10% of the log
I got ~970 ioctls. But now, after ida_ioctl(), I'm definitely going to finish
and submit Documentation/ioctl-mess.txt. I can't estimate how much time it will
take.

But a question in advance: what information about them people want to see?
Name, type of input and output seems obvious, what else?

