Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWDUWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWDUWVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWDUWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:21:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:5181 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S932487AbWDUWVM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:21:12 -0400
X-IronPort-AV: i="4.04,146,1144047600"; 
   d="scan'208"; a="27090316:sNHT209908286"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Fri, 21 Apr 2006 15:20:22 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D9D3ED3@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZljJYQOuX13VveSAyJCkeHiiArEwAAHPVw
From: "Gross, Mark" <mark.gross@intel.com>
To: "Doug Thompson" <dthompson@lnxi.com>
Cc: "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2006 22:21:10.0960 (UTC) FILETIME=[E4C7CB00:01C66591]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Doug Thompson [mailto:dthompson@lnxi.com]
>Sent: Friday, April 21, 2006 2:43 PM
>To: Gross, Mark
>Cc: Ong, Soo Keong; Carbonari, Steven; Wang, Zhenyu Z; bluesmoke-
>devel@lists.sourceforge.net; Doug Thompson;
linux-kernel@vger.kernel.org
>Subject: RE: Problems with EDAC coexisting with BIOS
>
>On Fri, 2006-04-21 at 21:32 +0000, "Gross, Mark"  wrote:
>>
>> >-----Original Message-----
>> >From: Doug Thompson [mailto:dthompson@lnxi.com]
>> >Sent: Friday, April 21, 2006 1:57 PM
>> >To: Gross, Mark
>> >Cc: Ong, Soo Keong; Carbonari, Steven; Wang, Zhenyu Z; bluesmoke-
>> >devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
>> >Subject: Re: Problems with EDAC coexisting with BIOS
>> >
>> >Mark thanks for the informaton on this.
>> >
>> >Now the e752x_edac.c driver contains no direct calls to panic within
>> >itself. The edac_mc.c 'core' piece does, but only calls that if an
UE
>> >error is found and panic on UE is enabled. (The other is a PCI
parity
>> >panic, but doesn't effect this path). It might be possible that
since
>> >the hidden register was now hidden, the retrieval function returns
some
>> >garbage which falsely triggers the panic by the core.
>>
>> The problem is that once the BIOS SMI re-hides the device reading
from
>> the chipset error registers returns 0xFFFFFFFF.
>
>Ok so the panic is caused by the driver because the UE bit is a one
>(somewhere in the 32-bit field), and then informs the CORE driver of
the
>false positive UE event, which does the panic trigger. I follow the
>logic now.
>
>The question then comes up: how to determine if the system has the
>hidden register feature.

For the E752x chipsets, if the Dev0:Fun1 is hidden after the BIOS hands
control to the OS, I think the driver should simply honor this and not
un-hide it.

The test is to check if bit 5 of the DEVPRES1 resister is set.  If set
the device is available, otherwise its hidden.  (see section 3.5.41 of
e7520 specification
ftp://download.intel.com/design/chipsets/datashts/30300602.pdf )

>
>You mentioned that the probe should be refactored to look for this all
>ones return value as such an indicator, is that correct?

Yes, basically we should consider removing the un-hide code in
e752x_probe1, and handle the case where the dev0:fun1 is left hidden by
the BIOS as an error condition at driver probe time.

>
>But there is a window that the register is unhidden, the probe runs,
>detects the hardware it is looking at and registers itself. Then later
>the window closes, the register is hidden again and the panic can
>reoccurr as above. Thus, a check needs to be made in the poll operation
>for the all ones return value, notify the log of this situtation,
>shutdown future polling of this hardware and basicly become a no-op
poll
>operation.

You can never predict when a SMI will bubble through the system.  Even
if you handle case where the BIOS re-hides Dev0:Fun1 and not panic how
do you deal with the race between the BIOS SMI based handling and the
driver?  Who will end up reading (and clearing) the error registers
first?  There is no good way to share today.


>
>Does that fix cover the issue as you have discovered it? Or is there
>more, or another fix you see?

No, you should return an error from e752x_probe1 if bit5 is cleared
already.  To do anything else you are assuming that you are privileged
to have more knowledge about what the BIOS is doing than you should.

I'll send the patch to e752x_edac.c this weekend.

--mgross

>
>doug t
>
>
>
>>
>> >
>> >I would like to see the panic output and stack trace to see where
that
>> >panic came from. It might have come from the PCI device access
subsytem
>> >when it was trying to access the now hidden register.
>> >
>> >can you post that panice information?
>>
>> Yes, but the edac_mc.c call to panic doesn't drop any data to the
>> console.
>> The following is the output from an instrumentation we did to the
EDAC
>> that went into RHEL4-U3 :
>>
>> INIT: version 2.85 booting
>>                 Welcome to Red Hat Enterprise Linux AS
>>                 Press 'I' to enter interactive startup.
>> Starting udev:  [  OK  ]
>> Initializing hardware...  storage network audioIn probe1, before
write
>> E752X_DEVPRES1 = 0x10
>> In probe1, after write
>> E752X_DEVPRES1 = 0x30
>>
>> Snip .....
>>
>> Configuring kernel parameters:  [  OK  ]
>> Setting clock  (localtime): Sun Mar 12 00:52:17 PST 2006 [  OK  ]
>> Setting hostname localhost.localdomain:  [  OK  ]
>> Checking root filesystem
>> [/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda1
>> /: clean, 365954/8830976 files, 2357630/17657443 blocks
>> [  OK  ]
>> Remounting root filesystem in read-write mode:  [  OK  ]
>> No devices found
>> No Software RAID disks
>> Setting up Logical Volume ManageE752X_DEVPRES1 = 0x10
>> ment: E752X_DEVPRES1 = 0x10
>> Kernel panic - not syncing: MC0: Uncorrected Error
>>
>> that's all you get, no stack trace.
>>
>> The EX752C_DEVPRES1 = ... debug statements came from sprinkling call
to
>> the following debug function we instrumented into the EDAC driver
code.
>>
>> static void print_error_info(struct pci_dev *pdev)
>> {
>>   u8 stat8;
>>   pci_read_config_byte(pdev, E752X_DEVPRES1, &stat8);
>>   printk(KERN_EMERG "E752X_DEVPRES1 = 0x%02X\n", stat8);
>> }
>>
