Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTFOOxl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTFOOxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:53:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2314 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262267AbTFOOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:53:40 -0400
Date: Sun, 15 Jun 2003 16:07:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Subject: bad: scheduling while atomic! (Part Deux)
Message-ID: <20030615160729.A5417@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sigh.  Another MTD deadlock, and cause of scheduling badness on UP preempt.

David, I think MTD needs an audit to ensure that no further cases exist.

static void cfi_intelext_sync (struct mtd_info *mtd)
{
        for (i=0; !ret && i<cfi->numchips; i++) {
                chip = &cfi->chips[i];

                spin_lock(chip->mutex);
                ret = get_chip(map, chip, chip->start, FL_SYNCING);
...
        }

        /* Unlock the chips again */

        for (i--; i >=0; i--) {
                chip = &cfi->chips[i];

                spin_lock(chip->mutex);
...
                spin_unlock(chip->mutex);
        }
}

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

