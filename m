Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265560AbSJSIr7>; Sat, 19 Oct 2002 04:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265561AbSJSIr7>; Sat, 19 Oct 2002 04:47:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23430 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265560AbSJSIr6>;
	Sat, 19 Oct 2002 04:47:58 -0400
Date: Sat, 19 Oct 2002 04:53:59 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andres Salomon <dilinger@mp3revolution.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44 Fix uninitialized device struct w/ add_disk()
In-Reply-To: <20021019081101.GA5149@chunk.voxel.net>
Message-ID: <Pine.GSO.4.21.0210190452150.24102-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Oct 2002, Andres Salomon wrote:

> This occurs w/ 2.5 device-mapper; add_disk() is called (w/ a possibly
> invalid gendisk).  add_disk() calls register_disk(), which constructs
> the device struct (gendisk::disk_dev).  First, the bus_id field is
> initialized, and then device_add() is called.  However, device_add()
> does no initialization of the device struct.  So, since the
> gendisk::disk_dev::parent list is NULL, the gendisk::disk_dev::node
> field is never initialized.  Later on in device_add(), if an error has
> occurred, list_del_init(&dev->node) is called; dev->node is {NULL,NULL},
> and an oops occurs.
> 
> Instead of calling device_add(), my patch makes register_disk() call
> device_register().  This appear to do the same thing as device_add(),
> but initializes the device struct before calling device_add().

Wrong.  If device-mapper doesn't create gendisk with alloc_disk() - it's
their bug; if it does - initialization is already done at alloc_disk()
time.

Fix driver instead of breaking generic code.

