Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWGCHtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWGCHtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWGCHtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:49:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:62300 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750707AbWGCHts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:49:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EcZltVqad1yIWKfUZiAYbr2I7dbNpig0sth1r0kBt8VLedONe+sGKc5bvT7zFfwbbA0SzgD08q4tSJJkSyz6eRnQFGH8F6BkyyDcdWkFgnCjNwt4UmESKGUEYRxrbUNMEdPyjkbcVotpDWkdmfvRSsuWawT+qitmE7Q/0jJopv4=
Message-ID: <aec7e5c30607030049j30444da9h563f8246547400f3@mail.gmail.com>
Date: Mon, 3 Jul 2006 16:49:46 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 8250_pci.c, parport_serial.c, __devinit and !CONFIG_HOTPLUG
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've spotted a case where functions marked as __devinit may be used
after being freed.

8250_pci.c contains find_quirk() which is accessing
pci_serial_quirks[]. The functions pointed to by
pci_serial_quirks[x].init are marked as __devinit.

8250_pci.c exports pciserial_init_ports() which is using find_quirk().
pciserial_init_ports() may be used after __devinit data has been freed
from the module.

If parport_serial gets loaded after 8250_pci and CONFIG_HOTPLUG is
disabled and the quirk table is matching then we might call a
non-existing function.

I may of course be wrong, but it does look like a use-after-free
problem to me. I discovered this by running modpost on a vmlinux that
contains relocation information.

/ magnus
