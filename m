Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265244AbUGCWT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUGCWT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 18:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUGCWT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 18:19:58 -0400
Received: from nef.ens.fr ([129.199.96.32]:60426 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S265244AbUGCWT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 18:19:56 -0400
Date: Sun, 4 Jul 2004 00:19:51 +0200 (MEST)
From: David Monniaux <David.Monniaux@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: bug in moxa.c driver (+ patch, please apply)
Message-ID: <Pine.GSO.4.03.10407032354510.4300-100000@basilic.ens.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Sun, 04 Jul 2004 00:19:55 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SYMPTOMS:
The current Moxa Intellio driver (moxa.c) panics when using > 1 board.

BACKGROUND:
The Moxa board needs a firmware download (see
http://www.moxa.com/drivers/C320T/Linux/v5.4/MXDRV.TGZ, command
moxaload -y) prior to usage.

Unfortunately, the current Linux kernel code fails during this download if
more than one board are installed.

EXPLANATION AND FIX:
The MoxaDriverPoll function does:
[...]
        for (card = 0; card < MAX_BOARDS; card++) {
                if ((ports = moxa_boards[card].numPorts) == 0)
                        continue;
                if (readb(moxaIntPend[card]) == 0xff) {
[...]

Unfortunately, with multiple boards, there exists a point where
MoxaDriverPoll() will be called when moxa_boards[card].numPorts != 0 but
moxaIntPend[card] is still NULL. Result: kernel panic.

Fix: use instead
                if ((ports = moxa_boards[card].numPorts) == 0
                    || moxaIntPend[card] == 0)
                        continue;

If someone who understands the code better than me proposes a better
patch, I'd be delighted. [For the little story, the above patch was
written after finding the bug in a remote location without internet access
using a serial console for getting the panic trace...]

David Monniaux            http://www.di.ens.fr/~monniaux
Laboratoire d'informatique de l'École Normale Supérieure,
Paris, France

