Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUIXLxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUIXLxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUIXLxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:53:04 -0400
Received: from fmr12.intel.com ([134.134.136.15]:40881 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S268699AbUIXLw7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:52:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Fri, 24 Sep 2004 19:52:51 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057534510B@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSiELBoEO4gWXuhTTa/Eul+85D6gQAGqccw
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>
Cc: "Zhu, Yi" <yi.zhu@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Sep 2004 11:52:53.0872 (UTC) FILETIME=[06742700:01C4A22D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> We talked about this in Ottawa a few months ago, and I think this is
the
>> right approach. Note though, that I think it needs to be more
complete:
>>
>> - There needs to be restore_state() to be symmetic.
>> - There needs to be the proper failure recovery
>>   If save_state() or suspend() fails, every device that has had their
>>   state saved needs to be restored.
>> - It needs to be called for all power management requests.
>> - The PCI implementation should call pci_save_state() in it, instead
of
>in
>>   ->suspend().
>>
>> It would be great if you could add these things. Otherwise, I'll add
it
>to
>> my TODO list..
>
>Additionally, for devices like the above that need either to rely on
>userland for firmware download or to allocate large amounts of memory
>for firmware backup/restore, I think we need to revive the pre-suspend
>and post-resume notifiers ... Of course, if a device that needs
userland
>to reload a firmware is on the swap patch, then we have a chicken & egg
>problem, but there is no easy solution for that one, unless the driver
>uses the pre-suspend callback to pre-load the firmware that it will
need
>for resume
I somewhat think choice 2 is better. The pre-load can be invoked in any
order instead of in the device tree hierarchy order. And currently only
few devices need it, is it worth adding it in the device core?
In addition, the notifiers have better flexibility. We can easily add
more notifier types if needed, such as adding a callback between the
sysdev resume and regular devices resume. To tell the truth, we actually
have the case. An ACPI link device must resume before regular devices
but must be with IRQ enabled. I'm considering add a call back between
sysdev and regular devices resume for the issue. I guess the MTRR driver
in SMP has the same requirement. Anyway, notifier solution sounds like
easier to extend, but we can't extend device core casually.

Thanks,
Shaohua
