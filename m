Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWEXTe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWEXTe5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 15:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWEXTe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 15:34:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751180AbWEXTe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 15:34:56 -0400
Date: Wed, 24 May 2006 12:37:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, tytso@mit.edu,
       mita@miraclelinux.com
Subject: Re: [PATCH] loop: online resize support
Message-Id: <20060524123715.77051ac0.akpm@osdl.org>
In-Reply-To: <20060523073129.GA6507@miraclelinux.com>
References: <20060523073129.GA6507@miraclelinux.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:
>
> This patch introduces new ioctl command LOOP_UPDATE_SIZE
> which enables to resize online mounted loop device.
> 
> EXAMPLE
> =======
> # Make 10MB disk image
> # dd if=/dev/zero of=image bs=1k count=10k
> # mkfs.ext3 -j -F image
> 
> # Mount
> # mkdir loop
> # mount -o loop=/dev/loop/0,debug -t ext3 image loop
> 
> # Check disk size
> # df -h loop
> Filesystem            Size  Used Avail Use% Mounted on
> /home/mita/looback-test/image
>                       9.7M  1.1M  8.2M  12% /home/mita/looback-test/loop
> 
> # Extend disk image to 20MB
> # dd if=/dev/zero of=appendix bs=1k count=10k
> # cat appendix >> image
> 
> # Resize
> # gcc -o loop-update loop-update.c
> # ./loop-update /dev/loop/0
> # ext2online -d -v image
> 
> # Check disk size again
> # df -h loop
> Filesystem            Size  Used Avail Use% Mounted on
> /home/mita/looback-test/image
>                        20M  1.1M   18M   6% /home/mita/looback-test/loop

<tries to remember how loop works>

> +static int loop_update_size(struct loop_device *lo)
> +{
> +	int err = figure_loop_size(lo);
> +
> +	if (!err)
> +		i_size_write(lo->lo_device->bd_inode,
> +			     (loff_t) get_capacity(disks[lo->lo_number]) << 9);
> +
> +	return err;
> +}
> +
>  static int lo_ioctl(struct inode * inode, struct file * file,
>  	unsigned int cmd, unsigned long arg)
>  {
> @@ -1169,6 +1182,9 @@ static int lo_ioctl(struct inode * inode
>  	case LOOP_GET_STATUS64:
>  		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
>  		break;
> +	case LOOP_UPDATE_SIZE:
> +		err = loop_update_size(lo);
> +		break;
>  	default:
>  		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
>  	}

I don't immediately see any show-stoppers here.

Note that this interface will allow the loop "device" to be larger than the
backing file (in fact that's already the case).  Just ftruncate the backing
file to a shorter size.  Everything should still work after that has
happened - the VFS will just extend the file again once the loop driver
writes to it outside i_size.

Given that, and given that your code is a bit racy anyway, I don't think
the interface should be "resize the device to match the backing file's
size".  I think the interface should be "resize the loop device to this
loff_t".  That's a superset of what you have there, and it permits the
device size to be larger than or smaller than the backing file.

Also, one really should take i_mutex when altering an i_size.  Probably it
doesn't make much difference here, but that's the rule.

Please ensure that the loop driver is well tested with a device size which
is both smaller than and larger than the backing file, and that it's tested
for both do_lo_send_aops()-based and do_lo_send_write()-based backing
filesystems, thanks.

