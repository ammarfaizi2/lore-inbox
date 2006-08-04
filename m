Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWHDNgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWHDNgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 09:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWHDNgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 09:36:01 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:34024 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161169AbWHDNgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 09:36:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JWzc8dUuuKA8MNgZPvmUaV6J9+WpgxRBmta2Dd5Q5bD5JMFx7RZ/z2uKRCqIUTnA8IwSmBcQFB4U5o1mbye5/QNUjlDOCK0MJJl1rAe52q4fKa8co7OD01HUotUwyC+Moee4DhlBMplJEVlH5ZLPSfxo/w+ylTO2KeLiFUSgqhU=
Subject: [SOLUTION/HACK/PUZZLED] pcmcia modem only works with cardmgr in
	recent 2.6.15 kernel.
From: Romano Giannetti <romano.giannetti@gmail.com>
To: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: sklein@cpcug.org
Content-Type: text/plain
Date: Fri, 04 Aug 2006 15:35:52 +0200
Message-Id: <1154698553.7617.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SHORT: if your modem on a double function pcmcia card stop working with
newer kernels, get rid of *.cis file, start (deprecated) cardmgr modem,
and the card will work again.

LONG: Hi, this is a sort-of "solution" (although hack is a better word)
to my problem reported here:

http://lists.infradead.org/pipermail/linux-pcmcia/2006-July/003772.html

and maybe to

http://lists.infradead.org/pipermail/linux-pcmcia/2006-July/003776.html

Moreover, I have a bug open on:

https://launchpad.net/distros/ubuntu/+source/pcmciautils/+bug/52510


Now, the thing is a bit complex, so let me explain. The problem is that
just the first function of my pcmcia ethernet/modem card is detected. My
system is an uptodate Ubuntu dapper. 

If I copy the correct (for what it's worth) CIS file in /lib/firmware,
and then use pccardctl to load it:

root@rukbat:/lib/firmware# pccardctl insert 1

SYS: Aug  4 15:21:42 localhost kernel: [ 3098.044000] pccard: PCMCIA
card inserted into slot 1
SYS: Aug  4 15:21:42 localhost kernel: [ 3098.044000] pcmcia:
registering new device pcmcia1.0
SYS: Aug  4 15:21:42 localhost kernel: [ 3098.104000] eth1: 3Com 3c589,
io 0x300, irq 3, hw_addr 00:00:86:1A:4E:A8
SYS: Aug  4 15:21:42 localhost kernel: [ 3098.108000]   8K FIFO split
5:3 Rx:Tx, auto xcvr

just the first function (ethernet is detected). 

If I eject it and use the cardmgr daemon (should have been obsoleted,
no?) I have this:

root@rukbat:/lib/firmware# cardmgr
cardmgr[8613]: could not adjust resource: IO ports 0xc00-0xcff: Function
not implemented
cardmgr[8613]: could not adjust resource: IO ports 0x100-0x4ff: Function
not implemented
cardmgr[8613]: could not adjust resource: memory 0xc0000-0xfffff:
Function not implemented
cardmgr[8613]: could not adjust resource: memory 0x60000000-0x60ffffff:
Function not implemented
cardmgr[8613]: could not adjust resource: memory 0xa0000000-0xa0ffffff:
Function not implemented
cardmgr[8613]: could not adjust resource: IO ports 0xa00-0xaff: Function
not implemented

root@rukbat:/lib/firmware# cardctl insert 1

SYS: Aug  4 15:23:37 localhost kernel: [ 3212.900000] pcmcia:
registering new device pcmcia1.0
SYS: Aug  4 15:23:37 localhost kernel: [ 3212.952000] eth1: 3Com 3c589,
io 0x300, irq 3, hw_addr 00:00:86:1A:4E:A8
SYS: Aug  4 15:23:37 localhost kernel: [ 3212.952000]   8K FIFO split
5:3 Rx:Tx, auto xcvr
SYS: Aug  4 15:23:37 localhost cardmgr[8614]: socket 1: Anonymous Memory
SYS: Aug  4 15:23:37 localhost cardmgr[8614]: executing: 'modprobe
memory_cs 2>&1'
SYS: Aug  4 15:23:37 localhost cardmgr[8614]: + FATAL: Module memory_cs
not found.
SYS: Aug  4 15:23:37 localhost cardmgr[8614]: modprobe exited with
status 1
SYS: Aug  4 15:23:37 localhost cardmgr[8614]:
module /lib/modules/2.6.15-26-386/pcmcia/memory_cs.o not available
SYS: Aug  4 15:23:37 localhost cardmgr[8614]: bind 'memory_cs' to socket
1 failed: Invalid argument

Ok, no joy. But if I rename away the cis file:

root@rukbat:/lib/firmware# cardctl eject 1
root@rukbat:/lib/firmware# cardctl insert 1

YS: Aug  4 15:26:04 localhost kernel: [ 3360.212000] pccard: PCMCIA card
inserted into slot 1
SYS: Aug  4 15:26:04 localhost kernel: [ 3360.212000] pcmcia:
registering new device pcmcia1.0
SYS: Aug  4 15:26:04 localhost firmware_helper[8741]: main: error
loading '/lib/firmware/3CXEM556.cis' for device '/class/firmware/1.0'
with driver '(unknown)'
SYS: Aug  4 15:26:04 localhost cardmgr[8614]: socket 1: 3Com/Megahertz
3CXEM556 Ethernet/Modem
SYS: Aug  4 15:26:04 localhost kernel: [ 3360.504000] eth1: 3Com 3c589,
io 0x300, irq 3, hw_addr 00:00:86:1A:4E:A8
SYS: Aug  4 15:26:04 localhost kernel: [ 3360.504000]   8K FIFO split
5:3 Rx:Tx, auto xcvr
SYS: Aug  4 15:26:04 localhost kernel: [ 3360.504000] pcmcia:
registering new device pcmcia1.1
SYS: Aug  4 15:26:04 localhost kernel: [ 3360.552000] 1.1: ttyS1 at I/O
0x2f8 (irq = 3) is a 16550A
SYS: Aug  4 15:26:04 localhost firmware_helper[8747]: main: error
loading '/lib/firmware/3CXEM556.cis' for device '/class/firmware/1.0'
with driver '(unknown)'
SYS: Aug  4 15:26:05 localhost cardmgr[8614]: executing: './network
start eth1 2>&1'
SYS: Aug  4 15:26:05 localhost cardmgr[8614]: +
cat: /var/lib/misc/pcmcia-scheme: No such file or directory
SYS: Aug  4 15:26:05 localhost cardmgr[8614]: executing: './serial start
ttyS1 2>&1'

and voila, MY MODEM WORKS.

So, maybe the CIS file is busted. I tried 
root@rukbat:/lib/firmware# dump_cis
[...]
Socket 1:
  dev_info
    NULL 0ns, 512b
  vers_1 5.0, "3Com", "Megahertz 3CXEM556", "LAN + 56k Modem", ""
  manfid 0x0101, 0x0035
  funcid multi_function
  mfc {
    funcid network_adapter
    config base 0x0800 mask 0x0063 last_index 0x07
    cftable_entry 0x07
      Vcc Vnom 5V
      io 0x0000-0x000f [lines=4] [8bit] [16bit]
      irq mask 0xffff [level]
  }, {
    funcid serial_port
    config base 0x0900 mask 0x0063 last_index 0x27
    cftable_entry 0x27
      Vcc Vnom 5V
      io 0x0000-0x0007 [lines=3] [8bit]
      irq mask 0xffff [level]
  }

and if I try the file:

root@rukbat:/lib/firmware# dump_cis -i 3CXEM556.cis.orig
dev_info
  NULL 0ns, 512b
vers_1 5.0, "3Com", "Megahertz 3CXEM556", "LAN + 56k Modem", ""
manfid 0x0101, 0x0035
funcid multi_function
mfc {
}

ok, something is wrong. 

But if I try to feed the dump_cis to pack_cis, I have exactly the same
file as before. No go without cardmgr. 

So... my modem works and I'm happy. But I think something is really
busted here. 

Hope this helps someone, 

	Romano 


