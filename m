Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWBQPRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWBQPRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWBQPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:17:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19634 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751459AbWBQPRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:17:08 -0500
Date: Fri, 17 Feb 2006 15:16:50 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
Message-ID: <20060217151650.GC12173@agk.surrey.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <djwong@us.ibm.com>,
	dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <43F38D83.3040702@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F38D83.3040702@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 12:22:27PM -0800, Darrick J. Wong wrote:
> - Store a hd_geometry structure with each dm_table entry.

> I chose to attach the 
> hd_geometry structure to dm_table because it seemed like a convenient 
> place to attach config data.  

Given the current device-mapper code structure, I don't think
that's a good place to attach it.  Did you consider 'struct
mapped_device' instead?  In your patch, the geometry will
disappear every time the mapped device's table is reloaded.  
Userspace device-mapper applications are free to reload tables
whenever they wish, so this patch is of little value unless every
userspace device-mapper application you use is updated to support
geometries, or you write a userspace daemon to monitor the devices
for reloads and reset your preferred geometry each time...

That said, it might then be an idea for __bind() to clear
the geometry iff a non-zero device size changes.

+static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct mapped_device *md = bdev->bd_disk->private_data;
+
+	return dm_table_get_geometry(md->map, geo);
+}

And if md->map is NULL?
See above and side-step this issue by avoiding dm_table* completely?


+		{DM_DEV_SETGEO_CMD, dev_setgeo}

Naming inconsistency here:

  Currently you have a DM_TABLE_* implementation - the data
  is stored per-table not per-device.  I'm suggesting you leave
  this as DM_DEV_* but fix the implementation to match the name.

Also, every time a new ioctl is added upstream you need to increment 
the minor number (and date):

  #define DM_VERSION_MAJOR        4
- #define DM_VERSION_MINOR        5
+ #define DM_VERSION_MINOR        6
  #define DM_VERSION_PATCHLEVEL   0
- #define DM_VERSION_EXTRA        "-ioctl (2005-10-04)"
+ #define DM_VERSION_EXTRA        "-ioctl (2006-02-17)"

And please document the new ioctl briefly within dm-ioctl.h like the
existing ones.


As for how to pass the binary data, passing it as a string in the
same manner as DM_DEV_RENAME should be OK if you prefer not to
define a new binary structure for it.

+	/*
+	 * Grab our input buffer.
+	 */
+	tmsg = get_result_buffer(param, param_size, &len);

'result' here means *output* not *input*.  Calling that function here
might change the pointer that says where your input data starts 
before you've processed it!


+	if (x != 4)
+		goto out2;

+	if (indata[0] > 65535 || indata[1] > 255
+	    || indata[2] > 255 || indata[3] > ULONG_MAX)
+		goto out2;

Please issue error messages with DMWARN().

+	tbl = dm_get_table(md);
+	r = dm_table_set_geometry(tbl, &dgm);

Most device-mapper ioctls populate the 'status' fields on
return.  In this case, it doesn't make much difference because
the ioctl isn't changing any of them.  Regardless, *every* function
in _ioctls[] must set param->data_size correctly before returning.
(Set to zero in this particular case.)

[I also find it helpful if variable names are consistent between
functions e.g. 'table' rather than 'tbl']

+#define DM_DEV_SETGEO_32    _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, ioctl_struct)

And include/linux/compat_ioctl.h?

Alasdair
-- 
agk@redhat.com
