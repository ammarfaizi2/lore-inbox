Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbULAF5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbULAF5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbULAF5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:57:25 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:56262 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261238AbULAF5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:57:20 -0500
Date: Wed, 01 Dec 2004 14:57:24 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [lkdump-develop] Re: [ANNOUNCE 0/7] Diskdump 1.0 Release
Cc: linux-kernel@vger.kernel.org, Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <1101810405.14413.329.camel@wks126533wss.in.ibm.com>
References: <20041130083116.3D92.ODA@valinux.co.jp> <1101810405.14413.329.camel@wks126533wss.in.ibm.com>
Message-Id: <20041201141427.3DA7.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30 Nov 2004 15:56:45 +0530
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> 
> Now kexec based dump is in -mm tree. Could you please have a look at the
> code and point out if any problems you see.

(I looked 2.6.10-rc1-mm3.)

At first crash_machine_kexec() should be called before bust_spinlock(0)
in the panic() function :-)

In disable_IO_APIC() (this is called from crash_dump_stop_cpus())
spin_lock_irqsave(&ioapic_lock, flags) is required. It may be cause
a deadlock. (The other CPU may be stoped with this lock hold.)

It seems no lock required except the point mentioned above from
crash_machine_kexec called to jumping the new kernel. I feel it is
fine.

(BTW. The disconnect_bsp_APIC() in the crash_dump_stop_cpus() 
 is called twice if both CONFIG_X86_IO_APIC and CONFIG_X86_LOCAL_APIC
 are set. The code is beter as follows.
#if defined(CONFIG_X86_IO_APIC)
        disable_IO_APIC();
#elif defined(CONFIG_X86_LOCAL_APIC)
        disconnect_bsp_APIC();
#endif
)

Thank you.
-- 
Itsuro ODA <oda@valinux.co.jp>

