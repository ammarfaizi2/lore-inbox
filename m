Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTEVWLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTEVWLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:11:46 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:47840 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S263355AbTEVWLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:11:44 -0400
Date: Thu, 22 May 2003 23:24:48 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: IDE 2.5.69 possible bogosity...
Message-Id: <20030522232448.21d7ee2f.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Im wondering if this is correct. is the test for initializing in the
second for loop correct?

Im building an IDE driver into my kernel that calls ide_register_hw()
twice to register its primary and secondary ports, but only the
secondary port is recognised. the first fails, since the test in the
first for loop fails and so does the second, so it then 'unregisters'
it, despite never having been registered. somehow, this puts my drive
INTO the hwif array, so the secondary interface registers OK, passing
the other tests.

a hack that allowed the primary interface to register was to register it
twice, but that sucks.

int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
{
        int index, retry = 1;
        ide_hwif_t *hwif;

        do {
                for (index = 0; index < MAX_HWIFS; ++index) {
                        hwif = &ide_hwifs[index];
                        if (hwif->hw.io_ports[IDE_DATA_OFFSET] ==
hw->io_ports[IDE_DATA_OFFSET])
                                goto found;
                }
                for (index = 0; index < MAX_HWIFS; ++index) {
                        hwif = &ide_hwifs[index];

*** is the test for initialising (not the !initialising one) here ok?
***

                    if ((!hwif->present && !hwif->mate && !initializing)
||
                        (!hwif->hw.io_ports[IDE_DATA_OFFSET] &&
initializing))
                                goto found;
                }
                for (index = 0; index < MAX_HWIFS; index++)
                        ide_unregister(index);
        } while (retry--);
