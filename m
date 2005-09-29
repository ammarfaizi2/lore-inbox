Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbVI2Vca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbVI2Vca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVI2Vca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:32:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22185 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751334AbVI2Vca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:32:30 -0400
Date: Thu, 29 Sep 2005 23:32:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sourceforge.net,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with CF bluetooth
Message-ID: <20050929213219.GA2180@elf.ucw.cz>
References: <20050929134802.GA6042@elf.ucw.cz> <1128008752.5123.28.camel@localhost.localdomain> <20050929155602.GA1990@elf.ucw.cz> <1128011355.30743.14.camel@localhost.localdomain> <20050929175420.GN1990@elf.ucw.cz> <1128016693.6052.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <1128016693.6052.2.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > I believe it would happen with any other CF card, too. Can you
> > hciattach it, unplug, hciattach again?
> 
> actually I don't have any of them with me and I don't saw a problem with
> my Casira of a serial port.

Following patch seems to work around it. And yes, printk() triggers
twice after 

root@amd:~# ~pavel/bin/billionton_start
hciattach: no process killed
hci0:   Type: UART
        BD Address: 00:10:60:AB:25:9A ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:201 acl:0 sco:0 events:9 errors:0
        TX bytes:168 acl:0 sco:0 commands:8 errors:0

root@amd:~# ~pavel/bin/billionton_start
no state->info
no state->info
hci0:   Type: UART
        BD Address: 00:10:60:AB:25:9A ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:201 acl:0 sco:0 events:9 errors:0
        TX bytes:168 acl:0 sco:0 commands:8 errors:0

root@amd:~#

									Pavel

Workaround billionton eject problem.

---
commit 81a2889a21eb2bfdf8b242f2cc2cc1d6ad424ea2
tree 35187ac07854fda50f07e9de3eb1c46db2cdd0a7
parent 5fb2493e110ff081e4463e7ab65eff487a3a14f6
author <pavel@amd.(none)> Thu, 29 Sep 2005 23:21:18 +0200
committer <pavel@amd.(none)> Thu, 29 Sep 2005 23:21:18 +0200

 drivers/serial/serial_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -521,7 +521,9 @@ static void uart_flush_buffer(struct tty
 	DPRINTK("uart_flush_buffer(%d) called\n", tty->index);
 
 	spin_lock_irqsave(&port->lock, flags);
-	uart_circ_clear(&state->info->xmit);
+	if (!state->info)
+		printk(KERN_CRIT "no state->info\n");
+	else uart_circ_clear(&state->info->xmit);
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_wakeup(tty);
 }


-- 
if you have sharp zaurus hardware you don't need... you know my address

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=billionton_start

# Take 2.6.12-rc3-mm3
# 
# PCMCIA config:
# card "Cyber-blue Compact Flash Card"
#   manfid 0x0279, 0x950b
#   bind "serial_cs"
#

killall hciattach
sleep .1
setserial /dev/ttyBT baud_base 921600
hciattach -s 921600 /dev/ttyBT bcsp
hciconfig hci0 up
hciconfig

--GvXjxJ+pjyke8COw--
