Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUIVSjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUIVSjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUIVSjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:39:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28078 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266616AbUIVSjG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:39:06 -0400
Date: Wed, 22 Sep 2004 19:39:05 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: Re: The new PCI fixup code ate my IDE controller
Message-ID: <20040922183905.GQ16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922174929.GP16153@parcelfarce.linux.theplanet.co.uk> <1095877177.17821.1535.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095877177.17821.1535.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 07:19:37PM +0100, David Woodhouse wrote:
> Hmm. We already have two passes through the fixup stuff. Add a third?
> But sorting PCI_ANY_ID to go last seems like a reasonable first stab at
> an answer, if that's sufficient for your purposes.

I don't think we need to go that far.  Something like the following
should work ... (untested, uncompiled, whitespace-damaged)

Index: drivers/pci/quirks.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/quirks.c,v
retrieving revision 1.16
diff -u -p -r1.16 quirks.c
--- drivers/pci/quirks.c        13 Sep 2004 15:23:21 -0000      1.16
+++ drivers/pci/quirks.c        22 Sep 2004 18:37:53 -0000
@@ -661,7 +661,7 @@ static void __devinit quirk_ide_bases(st
        printk(KERN_INFO "PCI: Ignoring BAR%d-%d of IDE controller %s\n",
               first_bar, last_bar, pci_name(dev));
 }
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,             PCI_ANY_ID,                   
  quirk_ide_bases );
+DECLARE_PCI_FIXUP_HEADER_ALL(quirk_ide_bases);
 
 /*
  *     Ensure C0 rev restreaming is off. This is normally done by
Index: include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/pci.h,v
retrieving revision 1.18
diff -u -p -r1.18 pci.h
--- include/linux/pci.h 13 Sep 2004 15:24:12 -0000      1.18
+++ include/linux/pci.h 22 Sep 2004 18:37:54 -0000
@@ -1016,6 +1016,11 @@ enum pci_fixup_pass {
        __attribute__((__section__(".pci_fixup_header"))) = {                   
        \
                vendor, device, hook };
 
+#define DECLARE_PCI_FIXUP_HEADER_ALL(hook) \
+       static struct pci_fixup __pci_fixup_PCI_ANY_IDPCI_ANY_ID##hook __attribu
te_used__ \
+       __attribute__((__section__(".pci_fixup_header_all"))) = {
+               PCI_ANY_ID, PCI_ANY_ID, hook };
+
 #define DECLARE_PCI_FIXUP_FINAL(vendor, device, hook)                          
\
        static struct pci_fixup __pci_fixup_##vendor##device##hook __attribute_u
sed__   \
        __attribute__((__section__(".pci_fixup_final"))) = {                    
        \
Index: include/asm-generic/vmlinux.lds.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/asm-generic/vmlinux.lds.h,v
retrieving revision 1.4
diff -u -p -r1.4 vmlinux.lds.h
--- include/asm-generic/vmlinux.lds.h   13 Sep 2004 15:24:02 -0000      1.4
+++ include/asm-generic/vmlinux.lds.h   22 Sep 2004 18:37:54 -0000
@@ -20,6 +20,7 @@
        .pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {        \
                VMLINUX_SYMBOL(__start_pci_fixups_header) = .;          \
                *(.pci_fixup_header)                                    \
+               *(.pci_fixup_header_all)                                \
                VMLINUX_SYMBOL(__end_pci_fixups_header) = .;            \
                VMLINUX_SYMBOL(__start_pci_fixups_final) = .;           \
                *(.pci_fixup_final)                                     \

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
