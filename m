Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSBDMt2>; Mon, 4 Feb 2002 07:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSBDMtS>; Mon, 4 Feb 2002 07:49:18 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:59660 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288953AbSBDMtB>; Mon, 4 Feb 2002 07:49:01 -0500
Message-Id: <200202041247.g14ClUt12479@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Steven Walter <srwalter@hapablap.dyn.dhs.org>
Subject: Re: VIA Northing workaround /causing/ problems
Date: Mon, 4 Feb 2002 14:47:31 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020202224032.A8010@hapablap.dyn.dhs.org>
In-Reply-To: <20020202224032.A8010@hapablap.dyn.dhs.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 February 2002 02:40, Steven Walter wrote:
> I recently upgraded my kernel from 2.4.10-pre6 to 2.4.18-pre2.  After
> doing so, X acted extremely weird; whenever just about anything
> happened, lines would appear across the screen, almost like static.
>
> After playing around with a few config options that I'd changed, with no
> results, I noticed the message about the VIA northbridge bug in dmesg.
> I commented out the line listing this chipset in pci-pc.c, recompiled,
> and sure enough that fixed the problem!
>
> This board is based on the KT33 chipset.  If anyone would like more
> information, email me.

Can you play with it a bit more?
Go to that file, uncomment it back, fiddle with
pci_fixup_via_northbridge_bug(): try to clear only bit 7,
then only 7 and 6 and see which cause it...
Make it print reg#, old, new contents:
...
printk("Trying to stomp on VIA Northbridge bug: [%02x] %02x->%02x\n", where, v, v & 0x1f);
...
etc.
Original function for your reference:

static void __init pci_fixup_via_northbridge_bug(struct pci_dev *d)
{
        u8 v;
        int where = 0x55;
        if (d->device == PCI_DEVICE_ID_VIA_8367_0) {
                where = 0x95; /* the memory write queue timer register is
                                 different for the kt266x's: 0x95 not 0x55 */
        }
        pci_read_config_byte(d, where, &v);
        if (v & 0xe0) {
                printk("Trying to stomp on VIA Northbridge bug...\n");
                v &= 0x1f; /* clear bits 5, 6, 7 */
                pci_write_config_byte(d, where, v);
        }
}
--
vda
