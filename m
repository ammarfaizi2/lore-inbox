Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293146AbSBWPge>; Sat, 23 Feb 2002 10:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293147AbSBWPgZ>; Sat, 23 Feb 2002 10:36:25 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28947 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293146AbSBWPgN>; Sat, 23 Feb 2002 10:36:13 -0500
Message-ID: <3C77B6C9.50009@evision-ventures.com>
Date: Sat, 23 Feb 2002 16:35:37 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.5 IDE cleanup 12
In-Reply-To: <20020222200750.GE9558@kroah.com> <Pine.LNX.4.10.10202221204400.2519-100000@master.linux-ide.org> <20020223004436.B9809@suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does the following:

1. Add some notes to Documentation/driver-model.txt about how and
    and where to mount the driverfs.

2. Reorganize and prepare the PCI scanning code for proper device
dependant splitup. Basically tedious cleanup of macro games.

3. Use struct pci_dev name field as the name of PCI host dapaters 
instead of invention ambigious IDE special names. This makes
the kernel bootup messages look a bit shifted, since those names are bit
longer, but makes up for consistance and should allow one later
to rearage things to fit into the generic PCI device initialization
mechanisms provided by the kernel.

4. Set 3. Allowed us to make the host chip specific
pci_init_xxx class functions have the proper signature of
module initializers. This will make it possible to make true
modules out of them later.

5. Make some functions in cmd64x.c static which where not used
elsewhere.

6. rename ide_special_settings to trust_pci_irq - this is reflecting
it's functionality better. And make it match the pci device vendor
as well as the device ID. It was a BUG to match only the device id!.

7. Make the chanell setup more tollerant for BIOS-es which don't
report IO and MEM bases properly. The code found previously there
tryed but was inconsistant.

8. Start to use proper terminology in ide-pci.c: host chip, channel, 
drive instead of hwif, port, drive...

9. Enlarge the name field from ide_hwif_t to 64 bytes. It was only 6
previously and there where custom names there which where exceeding
this!!! But since we use the proper pci devce name there now instead,
we had to extend the size of this field anyway.

10. Add some explanatory comments and fix misguiding comments here and
there.

11. Kill the proc_ide_write_config and proc_ide_read_config brain
damage! Those where backdoors to the pci configuration registers on PCI
devices and IO registers on directly connected ISA ATA controllers.
They didn't discrement between them!

Access to both of them *simply* doesn't belong into an operating system,
which is supposed to abstract out the access to hardware! Did I mention
that access to both can be done from user land without an IDE special 
interface! Any program which was using them (I hardly beleve there is
one) just deserves to loose. The programmer responsible for it
deserves to be fired immediately.

12. Move ide_map_xx and ide_unmap_xx tinny bio level wrappers away
from the "global" ide.h to where those are actually used and kill
trivial wrappers for otherwise generic bio_ routines. Just fighting
code obfuscation. The "rq->bio is used or is not there" brain
damage in ide-taskfile.c has to be fixed later. Possibly by killing
ide-taskfile.c alltogether, becouse this should be a driver for
users and not a driver for ATA disk disaster recovery companys...

13. Kill hwif->pci_devid and hwif->pci_venid. Just use the already 
present hwif->pci_dev field instead.

14. Kill unused big switch ide_reinit_drive function. This silly
functon was switching upon every possible device driver cathegory
and calling the correspondng reinit function directly. This
idiocy was fortunately not used.

That's all... Most will be clear if one starts looking at the changes
in ide.h of course...

In contrast to the previous patches this one is actually fixing two
serious bugs.


The next direct step will be to kill the sigle place global PCI device
type recognition list from ide-pci.c by pushing the entries to where
they belong -> the host chips setup modules.

