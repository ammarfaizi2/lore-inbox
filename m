Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbTH1AWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 20:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTH1AWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 20:22:48 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:5274 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S262803AbTH1AWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 20:22:47 -0400
Date: Wed, 27 Aug 2003 20:22:29 -0400 (EDT)
From: "S. Baker" <bakers@erols.com>
X-X-Sender: sbaker@missjune.home.none
To: linux-kernel@vger.kernel.org
Subject: PCI resource allocation bug
Message-ID: <Pine.LNX.4.44.0308272008090.3611-100000@missjune.home.none>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Could someone tell me if this is a bug, or if this should
be used in a different manner?  I am using 
pci_assign_resource(dev, 7);
Where:
dev->resource[7].start = 0
dev->resource[7].end = size to allocate
dev->resource[7].flags = IORESOURCE_MEM

In pci_assign_resource, 'min' gets assigned to PCIBIOS_MIN_MEM
(all that is important here is that it is not 0).
Also, 'align' gets assigned to 'res->start' (resource[7].start
from above).  which is 0.

This routine calls allocate_resource, which calls find_resource,
in which we find that new->start (again resource[7].start above)
gets set to min.  Then, there is the fateful line:
new->start = (new->start + align - 1) & ~(align - 1);
Since we know that align = 0, then ~(align-1) = 0, thus
new->start get assigned 0 again.  This doesn't work, it 
should be left to be min.

In kernel 2.4.18, the align variable was set to size, and thus
this all works.  I can get it to be set to size again by using
resource 6 instead of 7, but I don't think that is the correct
solution here.

I would propose a patch, but I'm not sure what the intent here
is.

Could responses please be CC'd to me?

Thanks,
S. Baker
bakers@erols.com

