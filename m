Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318926AbSHEXfR>; Mon, 5 Aug 2002 19:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSHEXfR>; Mon, 5 Aug 2002 19:35:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29153 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318926AbSHEXfQ>;
	Mon, 5 Aug 2002 19:35:16 -0400
Date: Mon, 5 Aug 2002 16:38:39 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs API Updates
Message-ID: <20020805163839.A13073@eng2.beaverton.ibm.com>
References: <Pine.LNX.4.44.0208051216090.1241-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.44.0208051216090.1241-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Mon, Aug 05, 2002 at 12:17:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat -

On Mon, Aug 05, 2002 at 12:17:13PM -0700, Patrick Mochel wrote:

> I've also created a macro[1] for defining device attributes, that goes
> like this:
> 
> DEVICE_ATTR(name,"strname",mode,show,store);

Do you any plans to simplify the show or store interfaces? 

We have the same interface and problem with /proc read and write.

Right now, to do it correctly (for short read buffers, seeks, or long strings
being output) using sprintf() is very painful, see sg.c for example, and its
proc read interfaces. It took me forever to realize that the code is 
re-writing the same data into a buffer.

Passing a single page or two (4k to 8k buffer), with no offset, and letting
the driverfs_read_file fill buf might be OK, but breaks seeks (and short
buffer usage), but at least the show/restore functions would be less likely
to be broken. Limiting the offset to a fit in a page might help.

If the show and store interfaces could return a pointer, lengths, and
a specifier ("%s", "%d", etc.), that might be pretty simple, and would
allow for correct offset and overflow checks.

Most of the current show interfaces are broken for a short buffer or seek,
and they are being copied to create new interfaces, example usage:

[patman@elm3a50 linux-2.5.29-p1]$ cat /devices/root/pci0/00:0f.2/name
PCI device 1166:0220
[patman@elm3a50 linux-2.5.29-p1]$ dd if=/devices/root/pci0/00:0f.2/name of=/tmp/xx bs=1 count=10 ; cat /tmp/xx ; echo 
1+0 records in
1+0 records out
P

I changed the scsi_scan.c scsi_device_type_read(), and got it working
OK, it does not check for overflows (snprintf does not work, since we
do not pass an offset; maybe if a snoffprintf existed it might help),
but this does work for seeks (or short reads):

static ssize_t scsi_device_type_read(struct device *driverfs_dev, char *page,
        size_t count, loff_t off)
{
        struct scsi_device *sdev = to_scsi_device(driverfs_dev);
        ssize_t size;

        if ((sdev->type > MAX_SCSI_DEVICE_CODE) ||
            (scsi_device_types[(int)sdev->type] == NULL))
                size = sprintf(page, "Unknown\n");
        else
                size = sprintf(page, "%s\n",
                               scsi_device_types[(int)sdev->type]);
        if (off >= size)
                /*
                 * Assumed complete.
                 */
                return 0;
        return size;
}

For the above to function I also had to change:

===== fs/driverfs/inode.c 1.20 vs edited =====
--- 1.20/fs/driverfs/inode.c	Fri Jul 26 12:58:50 2002
+++ edited/fs/driverfs/inode.c	Tue Jul 30 14:01:46 2002
@@ -311,7 +311,7 @@
 		} else if (len > count)
 			len = count;
 
-		if (copy_to_user(buf,page,len)) {
+		if (copy_to_user(buf,page+*ppos,len)) {
 			retval = -EFAULT;
 			break;
 		}

-- Patrick Mansfield
