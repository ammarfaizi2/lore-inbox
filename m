Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVLMOf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVLMOf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVLMOf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:35:57 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:56625 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964951AbVLMOf5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:35:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GKcMOHArjawyVx1kK5BJqBbMe0VSwS6TGsJpIQ6zz+xo0xJznqGXHe5kLQeJbFZkgL1glpUwNqmM6F0MsF0n4lf+OLnJSk+S+6Qnaqz8EOust6zKMduntDZ+BWHTshcxxX1YfXsZ4kfjWtncR2HDEJa148K7MT/Ul2C65TCA9oQ=
Message-ID: <41840b750512130635p45591633ya1df731f24a87658@mail.gmail.com>
Date: Tue, 13 Dec 2005 16:35:54 +0200
From: Shem Multinymous <multinymous@gmail.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: tp_smapi conflict with IDE, hdaps
Cc: Jeff Garzik <jgarzik@pobox.com>, Rovert Love <rlove@rlove.org>,
       Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm developing a new kernel module, tp_smapi, for providing access to
special features of ThinkPad laptops via a sysfs interface. See [1]
for details and [2] for the GPL sourcecode.

This module conflicts with two other systems, due to use of common IO resource.

Conflict with IDE system:
One of the functions provided by tp_smapi is setting the CD-ROM
speed+spindown ("hdparm -E" and "eject -x" have no effect on these
laptops). This is achieved by sending an appropriate command to the
laptop's SMAPI BIOS, whose implementation is totally opaque [3].
Evidently, the SMAPI BIOS sends some ATA command to the drive. If the
kernel is accessing the drive at the same time (e.g., an ongoing "cat
/dev/scd0"), the machine hangs. The ideal solution would be to figure
out the relevant ATA commands and add them to libata/ata_piix/ide, but
it's not clear how to do that. So tp_smapi needs to obtain some lock
guaranteeing there is no access (or ongoing transaction) to that ATA
device.

Conflict with the "hdaps" module:
Another function provided by tp_smapi is reporting extended battery
status, including some data not provided through ACPI. This conflict
with the recently added HDAPS accelerometer driver. Both drivers read
their data from the same ports (0x1604-0x161F), which implement a
query-reponse transaction interface, so both drivers talking to the
hardware simultaneously will wreak havoc. Some synchronization is
needed, and a way to address the request_region conflict.

What is standard procedure for resolving such conflicts?

  Shem

[1] http://thinkwiki.org/wiki/SMAPI_support_for_Linux
[2] Current: http://tpctl.sourceforge.net/rel/tp_smapi-0.09.tgz
    Future: http://sf.net/project/showfiles.php?group_id=1212&package_id=171579
[3] The SMAPI BIOS runs in SMM and thus cannot be debugged by mere mortals.
     See tp_smapi's README for known details:
    http://sourceforge.net/project/shownotes.php?release_id=377806&group_id=1212
