Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263431AbTDGNOE (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTDGNOE (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:14:04 -0400
Received: from hercules.egenera.com ([208.254.46.135]:60164 "EHLO
	coyote.egenera.com") by vger.kernel.org with ESMTP id S263431AbTDGNOD (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 09:14:03 -0400
Date: Mon, 7 Apr 2003 09:20:12 -0400
From: "Philip R. Auld" <pauld@egenera.com>
To: linux-kernel@vger.kernel.org
Subject: Deadlock in sd_open/revalidate [lk <= 2.4]
Message-ID: <20030407092012.C13667@vienna.EGENERA.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Razor-id: e831463132f9ed17e049cbdf3601de6b2c28bb12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
	There seems to be a potential deadlock in the sd_open path. The problem
is this while loop:

	...
	while (rscsi_disks[target].device->busy) {
                barrier();
                cpu_relax();
        }
	...

In revalidate_scsidisk we do this:
	
	...
	device->busy = 1;
	...
	almost certain schedule();
	...
	device-busy = 0;

Both paths hold the kernel lock so if sd_open gets into the while loop when 
the revalidate is sleeping it's all over.

As a simple preventative fix I'd say put a schedule in the while loop. It's
a little ugly, but less intrusive that adding a wait queue to the device.

Anoyone see anything wrong with doing that? Other solutions?

This seems to be present in 2.0, 2.2. and 2.4 (where we hit it).
The while-forever-loop-with -kernel-lock seems to be gone in 2.5.


Cheers,

Phil

-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
