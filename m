Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751922AbWFUBoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWFUBoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbWFUBoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:44:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22994 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750728AbWFUBoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:44:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Mark Maule <maule@sgi.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>,
       Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 6/25] msi: Implement helper functions read_msi_msg and write_msi_msg.
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<11508425183073-git-send-email-ebiederm@xmission.com>
	<11508425191381-git-send-email-ebiederm@xmission.com>
	<11508425192220-git-send-email-ebiederm@xmission.com>
	<11508425191063-git-send-email-ebiederm@xmission.com>
	<1150842520235-git-send-email-ebiederm@xmission.com>
	<11508425201406-git-send-email-ebiederm@xmission.com>
	<20060620180431.C10402@unix-os.sc.intel.com>
Date: Tue, 20 Jun 2006 19:43:08 -0600
In-Reply-To: <20060620180431.C10402@unix-os.sc.intel.com> (Rajesh Shah's
	message of "Tue, 20 Jun 2006 18:04:31 -0700")
Message-ID: <m1ac87b7wz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah <rajesh.shah@intel.com> writes:

> On Tue, Jun 20, 2006 at 04:28:19PM -0600, Eric W. Biederman wrote:
>> In support of this I also add a struct msi_msg that captures
>> the the two address and one data field ina typical msi message,
>> and I remember the pos and if the address is 64bit in
>> struct msi_desc.
>> 
> One thing I found very useful was to kmalloc msi_msg at MSI/MSI-X
> enable time, and stick a pointer to it in the msi_desc structure,
> not just for the CONFIG_PM case. For MSI, there's a single pointer
> to track. This simplified a lot of code and allowed me to avoid
> pci config reads to read the hardware at various places.

Well I think kmalloc is overkill.  If we are going to keep it we
can keep it in msi_desc.  The structure is only 4 bytes longer than
a pointer as it is.

>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>> ---
>> drivers/pci/msi.c | 195 +++++++++++++++++++++++++--------------------------
>>  drivers/pci/msi.h   |    9 +-
>>  include/linux/pci.h |    6 ++
>>  3 files changed, 104 insertions(+), 106 deletions(-)
>> 
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index c1c93f0..e9db6c5 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -94,63 +94,100 @@ static void msi_set_mask_bit(unsigned in
>>  	}
>>  }
>>  
>> -#ifdef CONFIG_SMP
>> -static void set_msi_affinity(unsigned int vector, cpumask_t cpu_mask)
>> +static void read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>>  {
>
> You wouldn't need this if you saved away the msi_msg values
> returned from ->setup().

Sure.

The point of my work was not so much to clean up the code.
But to cleanup up the semantics in how the code worked with
every one else.

The read_msi_msg and write_msi_msg bits were just so I could read
the code enough to clearly tell what was going on.

To a large extent I suspect I have made possible a lot of additional
cleanups all over the place.

Eric

