Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUHQIVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUHQIVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268182AbUHQIUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:20:16 -0400
Received: from mailhub2.uq.edu.au ([130.102.149.128]:60173 "EHLO
	mailhub2.uq.edu.au") by vger.kernel.org with ESMTP id S268165AbUHQITl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:19:41 -0400
Message-ID: <412185B0.4080105@torque.net>
Date: Tue, 17 Aug 2004 14:12:32 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Greg KH <greg@kroah.com>, martins@au.ibm.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: VPD in sysfs
References: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040814182932.GT12936@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> I've been sent a patch that reads some VPD from the Symbios NVRAM and
> displays it in sysfs.  I'm not sure whether the way the author chose
> to present it is the best.  They put it in 0000:80:01.0/host0/vpd_name
> which seems a bit too scsi-specific and insufficiently forward-looking
> (I bet we want to expose more VPD data than that in the future, so we
> should probably use a directory).
> 
> I actually have a feeling (and please don't kill me for saying this), that
> we should add a struct vpd * to the struct device.  Then we need something
> like the drivers/base/power/sysfs.c file (probably drivers/base/vpd.c)
> that takes care of adding vpd to each device that wants it.
> 
> Thoughts?  Since there's at least four and probably more ways of getting
> at VPD, we either need to fill in some VPD structs at initialisation or
> have some kind of vpd_ops that a driver can fill in so the core can get
> at the data.

Vital Product Data (VPD) seems to be an ever increasing
area for all sorts of data. Here is a list (from sg_inq
in sg3_utils) of existing and proposed VPD pages for SCSI
targets and LUs:

struct vpd_name {
     int number;
     int peri_type;
     char * name;
};

static struct vpd_name vpd_name_arr[] = {
     {0x0, 0, "Supported VPD pages"},
     {0x80, 0, "Unit serial number"},
     {0x82, 0, "ASCII implemented operating definition"},
     {0x83, 0, "Device identification"},
     {0x84, 0, "Software interface identification"},
     {0x85, 0, "Management network addresses"},
     {0x86, 0, "Extended INQUIRY data"},
     {0x87, 0, "Mode page policy"},
     {0x88, 0, "SCSI ports"},
     {0x89, 0, "ATA information"},
     {0xb0, 0, "Block limits (sbc2)"},
     {0xb0, 0x1, "SSC device capabilities (ssc3)"},
     {0xb0, 0x11, "OSD information (osd)"},
     {0xb1, 0x11, "Security token (osd)"},
};

The most interesting one in the above list is the
"Device identification" VPD page (0x83) which may contain
multiple descriptors each identifying either a:
   - SCSI port (of a target)
   - SCSI target
   - SCSI logical unit

And here is a selection of possible identifier formats:
    - naa (2,5 or 6)
    - eui-64
    - t10 vendor
    - SCSI name string (iSCSI here)
    - MD5 logical unit identifier
    - vendor specific
amongst others.

["The great thing about standards is that there are so many
to choose from."]

And your patch is about attaching VPD data to a SCSI HBA (host)
via sysfs.
"struct vpd" should be interesting ...

Doug Gilbert



