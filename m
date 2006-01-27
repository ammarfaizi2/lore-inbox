Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWA0M02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWA0M02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWA0M02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:26:28 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:36586 "EHLO
	mail.shipmail.org") by vger.kernel.org with ESMTP id S964986AbWA0M01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:26:27 -0500
Message-ID: <43DA1166.4040700@tungstengraphics.com>
Date: Fri, 27 Jan 2006 13:26:14 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12)
 Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mprotect() resets caching policy
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-BitDefender-Spam: No (14)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working on an infrastructure to allow drm clients to flip arbitrary 
pages in and out of the AGP aperture (or any similar device). In order 
to avoid conflicting mappings for those pages, the caching attribute of 
both the kernel mapping and all VMA's is changed when binding / unbinding.

However, I noticed that mprotect() will, when run on a non-cached VMA, 
reset the caching policy. The line in mm/mprotect.c causing this problem is

newprot = protection_map[newflags & 0xf];

So a user could potentially run mprotect() and create a conflicting 
mapping which presumably is bad for stability on some architectures.

Since mprotect() only deals with rwx protection. I figure replacing the 
above with something like

newprot = (vm_page_prot & ~MPROT_MASK) | (protection_map[newflags & 0xf] 
& MPROT_MASK)

Where MPROT_MASK is a arch-dependent mask identifying the bits available 
to mprotect().

Alternatively, is there a way to disable mprotect() for a VMA?

Finally, is there a chance to get protection_map[] exported to modules?

Any comments would be appreciated. Please CC me since I'm not on the list.

Regards,
Thomas Hellström




