Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWDUVdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWDUVdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWDUVdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:33:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:21674 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S964794AbWDUVdc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:33:32 -0400
X-IronPort-AV: i="4.04,146,1144047600"; 
   d="scan'208"; a="27071472:sNHT53334785"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Problems with EDAC coexisting with BIOS
Date: Fri, 21 Apr 2006 14:32:16 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D9D3D67@orsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with EDAC coexisting with BIOS
Thread-Index: AcZlhjaRUtWn4hXbQHecUg6JfW+qoQAAR5Lw
From: "Gross, Mark" <mark.gross@intel.com>
To: "Doug Thompson" <dthompson@lnxi.com>
Cc: "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2006 21:33:30.0626 (UTC) FILETIME=[3BE37620:01C6658B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Doug Thompson [mailto:dthompson@lnxi.com]
>Sent: Friday, April 21, 2006 1:57 PM
>To: Gross, Mark
>Cc: Ong, Soo Keong; Carbonari, Steven; Wang, Zhenyu Z; bluesmoke-
>devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
>Subject: Re: Problems with EDAC coexisting with BIOS
>
>Mark thanks for the informaton on this.
>
>Now the e752x_edac.c driver contains no direct calls to panic within
>itself. The edac_mc.c 'core' piece does, but only calls that if an UE
>error is found and panic on UE is enabled. (The other is a PCI parity
>panic, but doesn't effect this path). It might be possible that since
>the hidden register was now hidden, the retrieval function returns some
>garbage which falsely triggers the panic by the core.

The problem is that once the BIOS SMI re-hides the device reading from
the chipset error registers returns 0xFFFFFFFF.

>
>I would like to see the panic output and stack trace to see where that
>panic came from. It might have come from the PCI device access subsytem
>when it was trying to access the now hidden register.
>
>can you post that panice information?

Yes, but the edac_mc.c call to panic doesn't drop any data to the
console.
The following is the output from an instrumentation we did to the EDAC
that went into RHEL4-U3 :

INIT: version 2.85 booting
                Welcome to Red Hat Enterprise Linux AS
                Press 'I' to enter interactive startup.
Starting udev:  [  OK  ]
Initializing hardware...  storage network audioIn probe1, before write
E752X_DEVPRES1 = 0x10
In probe1, after write
E752X_DEVPRES1 = 0x30

Snip .....

Configuring kernel parameters:  [  OK  ]
Setting clock  (localtime): Sun Mar 12 00:52:17 PST 2006 [  OK  ]
Setting hostname localhost.localdomain:  [  OK  ]
Checking root filesystem
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/sda1
/: clean, 365954/8830976 files, 2357630/17657443 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
No devices found
No Software RAID disks
Setting up Logical Volume ManageE752X_DEVPRES1 = 0x10
ment: E752X_DEVPRES1 = 0x10
Kernel panic - not syncing: MC0: Uncorrected Error

that's all you get, no stack trace.

The EX752C_DEVPRES1 = ... debug statements came from sprinkling call to
the following debug function we instrumented into the EDAC driver code.

static void print_error_info(struct pci_dev *pdev) 
{
  u8 stat8;
  pci_read_config_byte(pdev, E752X_DEVPRES1, &stat8);
  printk(KERN_EMERG "E752X_DEVPRES1 = 0x%02X\n", stat8);
}

--mgross
>
>thanks
>
>doug thompson
>
>
>On Fri, 2006-04-21 at 16:01 +0000, "Gross, Mark"  wrote:
>> I'm sorry to have to bring up these issues after a fare amount of
good
>> work, and I don't know how this problem managed to get by for as long
as
>> it has, but there are some issues with the EDAC and the BIOS for
managed
>> computer systems.
>>
>> Managed computers are systems with automatic ECC logging to a System
>> Event Log or SEL.  They typically have an out of band Board
Management
>> Controller aka BMC or IPMC that runs out of band WRT the OS payload.
>>
>> The issues found with the EDAC driver are:
>> 1) The default AMI BIOS behavior on SMI is to check the chipset error
>> registers (Dev0:Fun1) and re-hide them.
>> 2) If you are lucky enough to have BIOS code that doesn't re-hide
>> Dev0:Fun1; then when EDAC is loaded there is a race condition between
>> the platform BIOS and the driver to gain access to these registers.
>> 3) If the platform BIOS does the ECC logging out of band WRT the
payload
>> OS, there is no good way for the driver to know at load time.
>>
>> We discovered these problems when testing with one of the later
RHEL4-U3
>> RC's.  The EDAC driver called panic when the device 0 Function 1 of
the
>> E7250 was re-hidden by the legacy USB SMI that when off between the
load
>> of the EDAC driver and the USB host driver.  Loading the EDAC driver
for
>> many AMI bios's is a panic land mine waiting go off.  Unless the OS
>> knows that it can trust the BIOS to not re-hide those chipset
registers
>> using this driver is not a safe thing to do.
>>
>> Basically if device 0 : function 1 is hidden by the platform at boot
>> time un-hiding and using the device and function is a risky thing to
do,
>> as there is likely a good reason for it to have been hidden in the
first
>> place.  If the BIOS thinks that it owns some registers then the OS
>> should not use them without great care.
>>
>> It is possible that the driver could be modified to check for
re-hiding
>> of the DEV0:FUN1, but this will be racey WRT SMI processing.  At
least
>> it shouldn't panic.
>>
>> The driver should never get loaded by default or automatically.  If
the
>> user knows enough about there BIOS to trust that the SMI behavior
will
>> coexist with the driver then its OK to load otherwise using this
driver
>> is not a safe thing to do.
>>
>> I think the best thing to do is to have the driver error out in its
init
>> or probe code if the dev0:fun1 is hidden at boot time.
>>
>> Comments?
>>
>> Next steps?
>>
>> Do you want me to send a patch implementing graceful error handling
at
>> driver init time so it doesn't load if DEV0:FUN1 is hidden?
>>
>> --mgross
>> Intel Open Source Technology Center
>> (503) 677-4628
>> (503)-712-6227
>> ms: JF1-235
>> 2111 NW 25th Ave
>> Hillsboro, OR 97124
>>
>>
>>
>> -------------------------------------------------------
>> Using Tomcat but need to do more? Need to support web services,
security?
>> Get stuff done quickly with pre-integrated technology to make your
job
>easier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache
>Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid0709&bid&3057&dat1642
>> _______________________________________________
>> bluesmoke-devel mailing list
>> bluesmoke-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluesmoke-devel
