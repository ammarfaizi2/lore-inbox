Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161282AbWHDQW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161282AbWHDQW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbWHDQW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:22:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161282AbWHDQWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:22:25 -0400
Message-ID: <44D37440.9080100@redhat.com>
Date: Fri, 04 Aug 2006 11:22:24 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix sun partition overflow over 1T
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although sun partition labels aren't supposed to support > 1T, apparently
linux partition editors will allow up to 2T.  This can cause problems
in the kernel when these larger partitions are read, due to a signed
int container.

num_sectors in the sun_disklabel struct is marked as __u32 in 2.4, and 
as __be32 in 2.6.  However, this is assigned to a signed int in
sun_partition():

                int num_sectors;

                st_sector = be32_to_cpu(p->start_cylinder) * spc;
                num_sectors = be32_to_cpu(p->num_sectors);

Changing num_sectors to an unsigned int avoids this problem.

Thanks,

-Eric

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6.17/fs/partitions/sun.c
===================================================================
--- linux-2.6.17.orig/fs/partitions/sun.c
+++ linux-2.6.17/fs/partitions/sun.c
@@ -74,7 +74,7 @@ int sun_partition(struct parsed_partitio
 	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
 	for (i = 0; i < 8; i++, p++) {
 		unsigned long st_sector;
-		int num_sectors;
+		unsigned int num_sectors;
 
 		st_sector = be32_to_cpu(p->start_cylinder) * spc;
 		num_sectors = be32_to_cpu(p->num_sectors);




