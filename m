Return-Path: <linux-kernel-owner+w=401wt.eu-S1759825AbWLJM5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759825AbWLJM5i (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 07:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759760AbWLJM5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 07:57:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56319 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759747AbWLJM5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 07:57:37 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457C042F.3040903@s5r6.in-berlin.de>
Date: Sun, 10 Dec 2006 13:57:19 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
CC: linux1394-devel@lists.sourceforge.net, Kristian H?gsberg <krh@redhat.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Marcel Holtmann <marcel@holtmann.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>	 <20061205160530.GB6043@harddisk-recovery.com>	 <20060712145650.GA4403@ucw.cz> <45798022.2090104@s5r6.in-berlin.de> <59ad55d30612091144s8356d7dw7c68530238ac79e7@mail.gmail.com>
In-Reply-To: <59ad55d30612091144s8356d7dw7c68530238ac79e7@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> On 12/8/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
...
>>>> On Tue, Dec 05, 2006 at 10:13:55AM -0500, Kristian H?gsberg wrote:
>>>>> Marcel Holtmann wrote:
>>>>>> can you please use drivers/firewire/ if you want to start clean or
>>>>>> aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
>>>>>> the directory path is not really helpful.
>>>>>
>>>>> Yes, that's probably a better idea.  Do you see a problem with using fw_*
>>>>> as a prefix in the code though?  I don't see anybody using that prefix, but
>>>>> Stefan pointed out to me that it's often used to abbreviate firmware too.
[...]
> I'm not changing it just yet, but I'm not too attached to fw_
> and I think that ieee1394_ will work better.  The modutil tools
> already use ieee1394 for device_id tables.
[...]

Alas the length of "ieee1394_" gets in the way of readability.


There are currently no exported symbols starting with "fw_":

linux-2.6.19 $ find . -type f -exec grep -e 'EXPORT.*fw_' {} \;
EXPORT_SYMBOL(iop_fw_load_spu);
EXPORT_SYMBOL(iop_fw_load_mpu);
EXPORT_SYMBOL(hostap_check_sta_fw_version);
EXPORT_SYMBOL(mpt_alloc_fw_memory);
EXPORT_SYMBOL(mpt_free_fw_memory);


There are a few names of struct members starting with "fw_" and four
global variables on the MIPS architecture:

linux-2.6.19 $ find include/ -type f -exec grep -e '[ ]fw_' {} \;
        __u64 fw_ver;
            unsigned char fw_mpx_cap; /* forward multiplexing capability */
        unsigned long fw_vendor;        /* physical addr of CHAR16 vendor string */
        u32 fw_revision;
        int             fw_rev[MAX_BOARD];
        char fw_version[2];                /* major = [0], minor = [1] */
        u64 fw_flags;
extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
linux-2.6.19 $ find include/ -type f -exec grep -l '[ ]fw_' {} \;
include/rdma/ib_user_verbs.h
include/linux/atmsap.h
include/linux/efi.h
include/linux/cyclades.h
include/sound/snd_wavefront.h
include/asm-alpha/gct.h
include/asm-mips/bootinfo.h


There are a few constants starting with "FW_":

linux-2.6.19 $ find include/ -type f -exec grep -e '[ ]FW_' {} \;|wc -l
38
linux-2.6.19 $ find include/ -type f -exec grep -l '[ ]FW_' {} \;
include/linux/firmware.h
include/video/radeon.h
include/asm-powerpc/pmac_feature.h
include/asm-powerpc/firmware.h
include/asm-ppc/residual.h


Since cross-subsystem drivers like sbp2 (a SCSI driver) and eth1394 (a
networking driver) live in linux/drivers/ieee1394/, the IEEE 1394 subsystem
does not need to ship header files in linux/include/, except for the minimum
stuff in linux/include/linux/mod_devicetable.h. Therefore the only conflicts
that the IEEE 1394 subsystem code could create would be via its EXPORTs.

I would therefore prefer "fw_" or "hpsb_" over any of the other suggestions
made here:
  - ieee1394_ makes sense in linux/mod_devicetable.h but is too long
    otherwise.
  - fiwi_, frwr_, and fwire_ are artificial abbreviations which come very
    unnatural. (fw_ is an artificial abbreviation too but is not as awkward
    as the others. hpsb_ is not just an abbreviation, it is an established
    acronym of the canonical name of the bus.)

-- 
Stefan Richter
-=====-=-==- ==-- -=-=-
http://arcgraph.de/sr/
