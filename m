Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVAGSSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVAGSSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 13:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVAGSRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 13:17:49 -0500
Received: from mail.tyan.com ([66.122.195.4]:1037 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261371AbVAGSPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 13:15:38 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291311@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: YhLu <YhLu@tyan.com>, Andi Kleen <ak@muc.de>
Cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jamesclv@us.ibm.com, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 10:27:05 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also in arch/x86_64/kernel/setup.c  init_amd


        if (c->cpuid_level >= 0x80000008) {

---->

        n = cpuid_eax(0x80000000);

        if (n >= 0x80000008) {

for c->cupid_level is get cupid_eax(0) and it always =1

YH

-----Original Message-----
From: YhLu 
Sent: Friday, January 07, 2005 10:08 AM
To: 'Andi Kleen'
Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
jamesclv@us.ibm.com; suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64

Hard_smp_processor_id is CPU physical apicid.
Boot_cpu_id is boot_cpu_physical_apicid.

There is two configuration that we need to enable APIC_EXT_ID.
1. 8 way + dual core --- 8*2 + 2 +1 = 19, the cpu will use 0-15, and ioapic
need to use 16 above.
2. 4 way + 7 amd 8131 + 1 8111 --- 4+7*2+1=19

After enabling APIC_EXT_ID, the K8 can use 256 apicid. But the io apic
device (amd 8131 and 8111) still need to use 0-15. So We need to use 16
above for cpu apic id.

The BIOS or LinuxBIOS will set the apic id of CPU to 16 later. Or that's to
say
Apicid = initial apic id + apicid_offset.

When dual core is used and nb_cfg_54 is set, node 0 will use initial apicid
0/1 for core0 and core1. after setting apicid_offset. Apicid will be 16/17.

Without subtract boot_cpu_id, phys_pkg_id will return 8.
With that, It will return 0.

The c->x86_apicid is initial apic id and it is by cupid(0x1).

I guess for one core old cpu
nb_cfg_54 can not be set, and node 0 will use initial apidid 0. After
setting apicid_offset. Apicid will be 16.

Without subtract boot_cpu_id, phys_pkg_id will return 16.
With that, It will return 0.

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Friday, January 07, 2005 4:25 AM
To: YhLu
Cc: Matt Domsch; linux-kernel@vger.kernel.org; discuss@x86-64.org;
jamesclv@us.ibm.com; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Thu, Jan 06, 2005 at 06:53:11PM -0800, YhLu wrote:
> static unsigned int phys_pkg_id(int index_msb)
> {
>         return hard_smp_processor_id() >> index_msb;
> }
> 
> In arch/x86_64/kernel/genapic_cluster.c
> 
> Should be changed to 
> 
> static unsigned int phys_pkg_id(int index_msb)
> {
>         /* physical apicid, so we need to substract offset */
>         return (hard_smp_processor_id() - boot_cpu_id) >> index_msb;
> }

Why? 

If you want a patch merged you need to supply some more explanation
please.

Also cc Suresh & James for comment.

-Andi
