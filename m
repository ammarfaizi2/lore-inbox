Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWGYNDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWGYNDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 09:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGYNDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 09:03:16 -0400
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:41681 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S932093AbWGYNDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 09:03:15 -0400
Subject: PROBLEM: PCI (?) trouble on Toshiba M400 notebook
From: Elias Holman <eholman@holtones.com>
Reply-To: eholman@holtones.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 25 Jul 2006 08:03:23 -0500
Message-Id: <1153832603.3141.29.camel@parachute.holtones.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Toshiba Portege M400 tablet notebook that will not boot due to
a null pointer dereference.  This problem appears to have been
introduced between 2.6.17-rc1 and rc2.  I have tried many kernels since
then with no better luck, up to 2.6.18-rc2.  I apologize if this issue
has been addressed via a patch or otherwise and I have not seen it, but
a search of the mailing list archives turned up nothing except that this
problem was informally reported on June 21st by Herbert Rosmanith, but
he chose not to submit a full report for whatever reason.  From his
email:

"I just had to examine
a notebook which had problems with our software: a
"toshiba portege m400". 2.4 seems to work so far, as does 2.6.16.
I also tried 2.6.17, but get a strange problem: it simply hangs
after writing "PCI: probing hardware" (or similar). A closer look
reveals that it hangs in drivers/pci/probe.c, in pci_read_bases. What's
exactly going on, I don't know..."

I have more or less confirmed that it stops in pci_read_bases by putting
printk statements at different points in the code (I am really not a
kernel hacker and so it was the only thing I knew to do).  It appears
that the problem is in this block:

for(pos=0; pos<howmany; pos = next) {
.
.
.
pci_read_config_dword(dev, reg, &l);
pci_write_config_dword(dev, reg, ~0);
pci_read_config_dword(dev, reg, &sz);
pci_write_config_dword(dev, reg, l);

It stops somewhere in the reading and writing block, although I haven't
narrowed it down further.  It appears that the value of howmany is 6, so
I assume this is being called from inside of pci_setup_device in the
PCI_HEADER_TYPE_NORMAL case, where a call to pci_read_bases has a
constant 6 passed in.  It appears to hang on the 3rd time through the
loop, i.e. device number 2.  I don't really know how the output of lspci
relates to that device number, but I am happy to provide the full
verbose lspci output for an interested party.  It also appears to be the
second call to pci_read_bases, with it being called from inside the
PCI_HEADER_TYPE_BRIDGE case with no issue (I am basing this again on the
value of howmany, which is 2 in that case).

I can get further into the boot process by specifying pci=off, although
then acpi has trouble.  If I specify pci=off and acpi=off, then it gets
even further, but eventually has trouble mounting the root filesystem.

I am currently running what appears to be a stable configuration on
2.6.17-rc1 with no issue.  I am happy to provide any more debugging
information that someone might need.
-- 
Eli


