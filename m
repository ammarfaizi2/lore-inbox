Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVL3LpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVL3LpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 06:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVL3LpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 06:45:20 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:6019 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751104AbVL3LpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 06:45:18 -0500
Date: Fri, 30 Dec 2005 17:14:53 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>, Andi Kleen <ak@muc.de>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 write apic id fix
Message-ID: <20051230114453.GF11470@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051229082709.GB1626@in.ibm.com> <43B40757.7040706@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43B40757.7040706@kolumbus.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:57:11PM +0200, Mika Penttilä wrote:
> Vivek Goyal wrote:
> 
> >o Apic id is in most significant 8 bits of APIC_ID register. Current code
> > is trying to write apic id to least significant 8 bits. This patch fixes
> > it.
> >
> >o This fix enables booting uni kdump capture kernel on a cpu with non-zero
> > apic id.
> >
> >Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> >---
> >
> > 
> >
> What difference does it make in the first place? In 
> APIC_init_uniprocessor() you write back the apic id read before from 
> processor, not from mp table (because you wouldn't be in 
> APIC_init_uniprocessor() otherwise).
> 

In this case APIC_init_uniprocessor() is being called from smp_init() as
I have compiled this as a uni kernel. And smp_found_config is 1. So this
can not be guaranteed that boot_cpu_id has been read from APIC.

But at the same time I see two functions (detect_init_APIC() and
init_apic_mappings()) which overwrite the boot_cpu_id unconditionally. Former
sets it to zero by default and later always reads it from APIC. This 
basically means that we just don't trust the MP tables in all the cases.

For kdump case, this becomes further tricky, as we boot into a second
kernel without going through the BIOS and we might be booting on a cpu
with non-zero apic id. But ACPI and MP tables will continue to report
boot cpu id as 0 and that's not correct. 

To come back to your question, I have just fixed one problem and that is
if you are writing boot_cpu_id to APIC_ID register, write it in a proper
manner. Otherwise what happens in this case is that boot_cpu_id is 1 and
if I use apic_write_around(apic, boot_cpu_id) then it writes 0 to APIC_ID
register instead of 1 and definitely that's not the requirement.

Thanks
Vivek
