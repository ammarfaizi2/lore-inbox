Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbUKKRnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbUKKRnD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUKKRiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:38:19 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:37291 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262304AbUKKR0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:26:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=klG2TrXdBaInunaofVd4de7ceEAHZauq911Yfzb7vV+fzo/E1DzNSqNv8HHQ/ZqZQ7Xo7MVc6c0mY9w29BZHyA+h/TDSLpm4JUoOfTVURINGhHgCatp+Z8mbZkJsp1HKXDFn7HOKMX1ao6iMDtt3VRe6lxryrDSN+EnTj31ABck=
Message-ID: <230a243e0411110926225028a7@mail.gmail.com>
Date: Thu, 11 Nov 2004 19:26:31 +0200
From: Alexander Sandler <alexander.sandler@gmail.com>
Reply-To: Alexander Sandler <alexander.sandler@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: exclusive access with bd_claim
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered this when tried to get exclusive access to device with
bd_claim(). Following code, when compiled as loaded as module, does
not prevent from modifying partition table on /dev/sda.

----------------------------------------------
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/blkdev.h>

struct block_device *bdev;

int excl_init( void )
{
        bdev = open_bdev_excl( "/dev/sda", 0, THIS_MODULE );
        if (!bdev)
                printk( "failed to open /dev/sda\n" );

        return 0;
}

void excl_exit( void )
{
        if (bdev)
                close_bdev_excl( bdev );
}

module_init( excl_init );
module_exit( excl_exit );
----------------------------------------------

Same when doing 

bdev = open_by_devnum( MKDEV( 8, 0 ), FMODE_READ | FMODE_WRITE );
if (bdev)
        bd_claim( bdev, THIS_MODULE );

instead of open_bdev_excl(...).

Am I missing something? Any ideas?

system: SLES8 + 2.6.9 on MP machine.

-- 
Sasha.
