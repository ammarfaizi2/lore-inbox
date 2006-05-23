Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWEWR0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWEWR0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWEWR0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:26:34 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:36323 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751037AbWEWR0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:26:33 -0400
Message-ID: <4472FFDA.2040005@hp.com>
Date: Tue, 23 May 2006 12:28:10 +0000
From: Patrick Jefferson <patrick.jefferson@hp.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] PCI: fix MMIO addressing collisions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2006 17:26:32.0469 (UTC) FILETIME=[08CC2450:01C67E8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Clearing PCI Command bits fixes machine halts observed during sizing 
seqences using MMIO cycles. Clearing the bits is suggested by an 
implementation note in the PCI spec.

Thanks,
Patrick

Signed-off-by: Patrick Jefferson <patrick.jefferson@hp.com>

  --- a/drivers/pci/probe.c
  +++ b/drivers/pci/probe.c
  @@ -147,7 +147,7 @@ static u32 pci_size(u32 base, u32 maxbas
   static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, 
int rom)
   {
          unsigned int pos, reg, next;
  -       u32 l, sz;
  +       u32 l, sz, cmd;
          struct resource *res;

          for(pos=0; pos<howmany; pos = next) {
  @@ -155,10 +155,14 @@ static void pci_read_bases(struct pci_de
                  res = &dev->resource[pos];
                  res->name = pci_name(dev);
                  reg = PCI_BASE_ADDRESS_0 + (pos << 2);
  +               /* disable Memory & I/O decoders before sizing a BAR */
  +               pci_read_config_dword(dev, PCI_COMMAND, &cmd);
  +               pci_write_config_dword(dev, PCI_COMMAND, cmd & 
~(PCI_COMMAND_IO|PCI_COMMAND_MEMORY));
                  pci_read_config_dword(dev, reg, &l);
                  pci_write_config_dword(dev, reg, ~0);
                  pci_read_config_dword(dev, reg, &sz);
                  pci_write_config_dword(dev, reg, l);
  +               pci_write_config_dword(dev, PCI_COMMAND, cmd);
                  if (!sz || sz == 0xffffffff)
                          continue;
                  if (l == 0xffffffff)



