Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUJIGJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUJIGJc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUJIGHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:07:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37547 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266543AbUJIFwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:52:05 -0400
Message-ID: <4166AF3D.9080808@sgi.com>
Date: Fri, 08 Oct 2004 10:16:13 -0500
From: Colin Ngam <cngam@sgi.com>
Reply-To: cngam@sgi.com
Organization: SSO
User-Agent: Mozilla/5.0 (X11; U; IRIX64 IP35; en-US; rv:1.4.1) Gecko/20040105
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>, Grant Grundler <iod00d@hp.com>,
       "Luck, Tony" <tony.luck@intel.com>
CC: Colin Ngam <cngam@sgi.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C989@scsmsx401.amr.corp.intel.com> <41644301.9EC028B3@sgi.com> <20041006195424.GF25773@cup.hp.com> <200410061327.28572.jbarnes@engr.sgi.com> <20041006204832.GB26459@cup.hp.com> <20041006210525.GI16153@parcelfarce.linux.theplanet.co.uk> <41645BDE.E9732310@sgi.com>
In-Reply-To: <41645BDE.E9732310@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ngam wrote:

Gentlemen,

I need you to say yes or no on this issue so that Tony can proceed with 
his decision on the next step towards this patch.  Tony believes that 
this is still an outstanding issue.  Basically, it does not matter which 
way we go.

In the current patch, because pci_root_ops is static, we define 
sn_pci_root_ops.  sn_pci_root_ops ends up calling raw_pci_ops - which is 
exactly what we need.

Now, if we can remove the static from pci_root_ops, I can use it in 
io_init.c, that would be cleanest and that was what we started with.  
This is what the patch would look like ontop of the 002_add* patch:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/07 11:53:49-05:00 cngam@attica.americas.sgi.com
#   pci.h:
#     Add prototype for pci_root_ops.
#   io_init.c:
#     Use pci_root_ops.
#   pci.c:
#     Remove static so that pci_root_ops can be externed.
#
# include/asm-ia64/pci.h
#   2004/10/07 11:53:02-05:00 cngam@attica.americas.sgi.com +2 -0
#   Add prototype for pci_root_ops.
#
# arch/ia64/sn/kernel/io_init.c
#   2004/10/07 11:52:49-05:00 cngam@attica.americas.sgi.com +4 -27
#   Use pci_root_ops.
#
# arch/ia64/pci/pci.c
#   2004/10/07 11:52:30-05:00 cngam@attica.americas.sgi.com +1 -1
#   Remove static so that pci_root_ops can be externed.
#
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c       2004-10-07 11:54:17 -05:00
+++ b/arch/ia64/pci/pci.c       2004-10-07 11:54:17 -05:00
@@ -124,7 +124,7 @@
                                  devfn, where, size, value);
 }

-static struct pci_ops pci_root_ops = {
+struct pci_ops pci_root_ops = {
        .read = pci_read,
        .write = pci_write,
 };
diff -Nru a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
--- a/arch/ia64/sn/kernel/io_init.c     2004-10-07 11:54:17 -05:00
+++ b/arch/ia64/sn/kernel/io_init.c     2004-10-07 11:54:17 -05:00
@@ -33,29 +33,6 @@

 int sn_ioif_inited = 0;                /* SN I/O infrastructure 
initialized? */

-static int
-sn_pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size,
-         u32 * value)
-{
-       return raw_pci_ops->read(pci_domain_nr(bus), bus->number,
-                                 devfn, where, size, value);
-}
-
-static int
-sn_pci_write(struct pci_bus *bus, unsigned int devfn, int where, int size,
-          u32 value)
-{
-
-       return raw_pci_ops->write(pci_domain_nr(bus), bus->number,
-                                  devfn, where, size, value);
-}
-
-struct pci_ops sn_pci_root_ops = {
-       .read = sn_pci_read,
-       .write = sn_pci_write,
-};
-
-
 /*
  * Retrieve the DMA Flush List given nasid.  This list is needed
  * to implement the WAR - Flush DMA data on PIO Reads.
@@ -281,10 +258,10 @@
 }

 /*
- * sn_pci_fixup_bus() - This routine sets up a bus's resources
+ * sn_pci_controller_fixup() - This routine sets up a bus's resources
  * consistent with the Linux PCI abstraction layer.
  */
-static void sn_pci_fixup_bus(int segment, int busnum)
+static void sn_pci_controller_fixup(int segment, int busnum)
 {
        int status = 0;
        int nasid, cnode;
@@ -307,7 +284,7 @@
                BUG();
        }

-       bus = pci_scan_bus(busnum, &sn_pci_root_ops, controller);
+       bus = pci_scan_bus(busnum, &pci_root_ops, controller);
        if (bus == NULL) {
                return;         /* error, or bus already scanned */
        }
@@ -379,7 +356,7 @@
 #endif

        for (i = 0; i < PCI_BUSES_TO_SCAN; i++) {
-               sn_pci_fixup_bus(0, i);
+               sn_pci_controller_fixup(0, i);
        }

        /*
diff -Nru a/include/asm-ia64/pci.h b/include/asm-ia64/pci.h
--- a/include/asm-ia64/pci.h    2004-10-07 11:54:17 -05:00
+++ b/include/asm-ia64/pci.h    2004-10-07 11:54:17 -05:00
@@ -105,6 +105,8 @@
 #define PCI_CONTROLLER(busdev) ((struct pci_controller *) busdev->sysdata)
 #define pci_domain_nr(busdev)    (PCI_CONTROLLER(busdev)->segment)

+extern struct pci_ops pci_root_ops;
+
+extern struct pci_ops pci_root_ops;
+
 static inline int pci_name_bus(char *name, struct pci_bus *bus)
 {
        if (pci_domain_nr(bus) == 0) {


Basically, we add an extern for pci_root_ops in asm-ia64/pci.h and 
remove the static for pci_root_ops in ia64/pci/pci.c.

We need a resolution so that Tony can proceed.  Silence is not going to 
help.

Thank you so much for your help.

colin

>Matthew Wilcox wrote:
>
>  
>
>>On Wed, Oct 06, 2004 at 01:48:32PM -0700, Grant Grundler wrote:
>>    
>>
>>>Agreed. I'm not real clear on why drivers/acpi didn't do that.
>>>But apperently ACPI supports many methods to PCI or PCI-Like (can you
>>>guess I'm not clear on this?) config space. raw_pci_ops supports
>>>multiple methods in i386. ia64 only happens to use one so far.
>>>It seems right for SN2 to use this mechanism if it needs a different
>>>method.
>>>
>>>Willy tried to explain this to me yesterday and I thought I understood
>>>most of it...apperently that was a transient moment of clarity. :^/
>>>      
>>>
>>Let's try it again, by email this time.
>>
>>Fundamentally, there is a huge impedence mismatch between how the ACPI
>>interpreter wants to access PCI configuration space, and how Linux wants
>>to access PCI configuration space.  Linux always has at least a pci_bus
>>around, if not a pci_dev.  So we can use dev->bus->ops to abstract the
>>architecture-specific implementation of "how do I get to configuration
>>space for this bus?"
>>
>>ACPI doesn't have a pci_bus.  It just passes around a struct of { domain,
>>bus, dev, function } and expects the OS-specific code to determine what
>>to do with it.  The original hacky code constructed a fake pci_dev on the
>>stack and called the regular methods.  This broke ia64 because we needed
>>something else to be valid (I forget what), so as part of the grand "get
>>ia64 fully merged upstream" effort, I redesigned the OS-specific code.
>>
>>Fortunately, neither i386 nor ia64 actually need the feature Linux has
>>to have a per-bus pci_ops -- it's always the same.  I think powerpc is
>>the only architecture that needs it.  So I introduced a pci_raw_ops that
>>both ACPI and a generic pci_root_ops could call.
>>
>>The part I didn't seem to be able to get across to you yesterday was
>>that pci_root_ops is not just used for the PCI root bridge, it's used
>>for accessing every PCI device underneath that root bridge.
>>    
>>
>
>Hi Guys,
>
>Therefore, would it be perfectly fine if we remove the static from pci_root_ops
>so that we can use it outside of pci/pci.c??  I can include this in a follow-on
>patch.
>
>Thanks.
>
>colin
>
>  
>
>>--
>>"Next the statesmen will invent cheap lies, putting the blame upon
>>the nation that is attacked, and every man will be glad of those
>>conscience-soothing falsities, and will diligently study them, and refuse
>>to examine any refutations of them; and thus he will by and by convince
>>himself that the war is just, and will thank God for the better sleep
>>he enjoys after this process of grotesque self-deception." -- Mark Twain
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


