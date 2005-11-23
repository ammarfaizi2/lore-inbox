Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVKWPY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVKWPY5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVKWPY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:24:57 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:29120 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750968AbVKWPY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:24:56 -0500
Subject: kobject_register needs return value checks (was: What protection
	does sysfs_readdir have with SMP/Preemption?)
From: Steven Rostedt <rostedt@goodmis.org>
To: maneesh@in.ibm.com
Cc: Thibaut VARENE <varenet@parisc-linux.org>, linux-scsi@vger.kernel.org,
       linuxraid@amcc.com, Matt Tolentino <matthew.e.tolentino@intel.com>,
       len.brown@intel.com, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <1132755654.13395.37.camel@localhost.localdomain>
References: <1132695202.13395.15.camel@localhost.localdomain>
	 <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com>
	 <Pine.LNX.4.58.0511230748000.23751@gandalf.stny.rr.com>
	 <20051123135847.GF22714@in.ibm.com>
	 <1132755344.13395.32.camel@localhost.localdomain>
	 <1132755654.13395.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 10:24:32 -0500
Message-Id: <1132759472.13395.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing some tests to see what happens on a failure of setting up
something in the sysfs, and I've discovered a few areas that don't test
the return value of kobject_register. The test was due to a memory
problem in a custom kernel that showed that sysfs didn't quite handle
the error cases well.

I did the following command:

find .  -name "*.c" ! -type d  | xargs grep  "kobject_register"

I found 27 hits. Of these:

14 - checked the return value.
1 - reference in .mod.c file /* ignore it */
3 - in comments /* ignore it */
1 - declaration of actual function /* ignore it */
1 - EXPORT_SYMBOL /* ignore it */
1 - inside a printk quote. /* ignore it */

and ...

6 - calls without checking return values.

Here are the culprits:

./drivers/acpi/scan.c:  kobject_register(&device->kobj);
./drivers/firmware/efivars.c:   kobject_register(&new_efivar->kobj);
./drivers/md/md.c:      kobject_register(&mddev->kobj);
./drivers/parisc/pdc_stable.c:          kobject_register(&entry->kobj);
./fs/partitions/check.c:        kobject_register(&p->kobj);
./kernel/params.c:      kobject_register(&mk->kobj);


Normally, these would not return errors, but in case they do, the kernel
should be robust enough to handle it.

I tried to CC all the maintainers of the above files.

-- Steve


