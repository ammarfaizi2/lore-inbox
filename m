Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbULWJCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbULWJCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 04:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbULWJCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 04:02:44 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60174 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261180AbULWJCd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 04:02:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: mingo@redhat.com
Subject: Re: 2.6.x BUGs at boot time (APIC related)
Date: Thu, 23 Dec 2004 11:02:09 +0000
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com
References: <200412221731.20105.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200412221731.20105.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200412231102.10171.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 December 2004 17:31, Denis Vlasenko wrote:
> This is happening on a "HP Compaq dc7100 CMT"
> (I believe it is a model number - taken from the label on the box).
>
> Both 2.6.9 and 2.6.10-rc3 are dying this way:
>
> [top of visible screen]
> I/O APIC #1 Version 17 at 0xFEC00000
> Enabled APIC mode: Flat. Using 1 I/O APICs
> ...
> [unrelated stuff (dentry cache size etc...)]
> ...
> Enabling fast FPU save & restore ...done
> Enabling unmasked SIMD FPU exception support ...done
> Checking 'hlt' instruction ..OK
> ------------------------
> kernel BUG at arch/i386/kernel/apic.c:388! [:366! for 2.6.9]
>
>
> Code:
> ....
> void __init setup_local_APIC (void)
> {
>         ...
>         /*
>          * Double-check whether this APIC is really registered.
>          */
>         if (!apic_id_registered())
>                 BUG();   <=========================

Tested with noapic nolapic boot params. Still happens.

Call chain is init() -> APIC_init_uniprocessor() ->
->  setup_local_APIC(). I am a bit suspicious why
APIC_init_uniprocessor() does not bail out
if enable_local_apic<0 (i.e. if I boot with "nolapic"):

int __init APIC_init_uniprocessor (void)
{
        if (enable_local_apic < 0)
                clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
		<===== missing "return -1"?

        if (!smp_found_config && !cpu_has_apic)
                return -1;
...
        verify_local_APIC();

        connect_bsp_APIC();

        phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);

        setup_local_APIC();  <=== will die there

--
vda
