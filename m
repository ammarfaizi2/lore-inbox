Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbTADTVr>; Sat, 4 Jan 2003 14:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTADTVr>; Sat, 4 Jan 2003 14:21:47 -0500
Received: from arava.co.il ([212.179.127.3]:30944 "HELO arava.co.il")
	by vger.kernel.org with SMTP id <S261322AbTADTVp>;
	Sat, 4 Jan 2003 14:21:45 -0500
Date: Sat, 4 Jan 2003 21:31:38 +0200 (IST)
From: Matan Ziv-Av <matan@svgalib.org>
To: Andrew McGregor <andrew@indranet.co.nz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
In-Reply-To: <133840000.1041674500@localhost.localdomain>
Message-ID: <Pine.LNX.4.21_heb2.09.0301042115010.5981-100000@matan.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2003, Andrew McGregor wrote:

> Or else find that the NV3x has some stonking quick CPU embedded, and apps
> talk GLX to it...
> 
> Strange how noone objects to APM BIOS calls or ACPI.

Actually, I object to this. 
On my via 686a, the advice on this list for getting the power saving was
to use ACPI (after setting some bits in PCI config space). But lvcool
program showed how to do this without proprietary programs, and I
adapted it to bit of kernel code:

static void via686_idle(void) {
        if (!current->need_resched)
                inb(Reg_PL2);
}
static int __init init_lvcool(void)
{
        nb = pci_find_device(PCI_VENDOR_ID_VIA,
             PCI_DEVICE_ID_VIA_8363_0, nb);
        smb = pci_find_device(PCI_VENDOR_ID_VIA,
             PCI_DEVICE_ID_VIA_82C686_4, smb);
        if(nb==NULL)pci_find_device(PCI_VENDOR_ID_VIA,
             PCI_DEVICE_ID_VIA_8371_0, nb);
        if(!Reg_PL2) {
                u32 t;
                pci_read_config_dword(smb, 0x48, &t);
                Reg_PL2 = (t&0xff80) + 0x14;
                printk(KERN_DEBUG "Reg_PL2 = %08x\n", Reg_PL2);
        }

        old_idle = pm_idle;
        pm_idle = via686_idle;

    return 0;
}


And I don't need to run any proprietary code during normal system run. I
still need to use BIOS to boot and to poweroff the system, but
that will be solved as well.


-- 
Matan Ziv-Av.                         matan@svgalib.org


