Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVBRHuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVBRHuh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 02:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBRHuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 02:50:37 -0500
Received: from main.gmane.org ([80.91.229.2]:35015 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261305AbVBRHuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 02:50:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Kernel hangs on PCI config register access ???
Date: Fri, 18 Feb 2005 08:49:58 +0100
Organization: {M:U} IT-Consulting
Message-ID: <pan.2005.02.18.07.49.57.620452@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4E   G?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have a bunch of systems which semi-reproducibly (chance of 1:1000) hang
when a PCMCIA card is removed from its PCI->PCMCIA interface via "cardctl
eject". Right *here*, in fact:

static int pci_conf1_read (int seg, int bus, int devfn, int reg, int
len, + u32 *value) {
    [...]
    case 2:
        debug("you see me \n");
        *value = inw(0xCFC + (reg & 2));
        debug("but you don't get here \n");
        break;
    [...]

Does anybody have *any* idea what could possibly be the cause of this?
Using pci=bios still hangs; pci=conf2 doesn't work.

FWIW, the call sequence is:

shutdown_socket
yenta_sock_init
yenta_clear_maps
yenta_set_socket
pci_bus_read_config_word
pci_conf1_read

The systems in question are wildly different (VIA vs. Intel CPUs, standard
mainboard vs. PCI backplane, Ricoh vs. ENE cardbus bridges), so I'm
inclined to rule out hardware problems. The NMI monitor doesn't trigger
(yes I tested it), kgdb is unresponsive -- the system hangs hard at that
point, as far as I can determine.

Kernel: tested with various 2.6.1? plus -rc* and/or -mm*, no change.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


