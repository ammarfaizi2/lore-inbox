Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUIPXuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUIPXuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268348AbUIPXuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:50:04 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:38888 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268206AbUIPXtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:49:35 -0400
Subject: [PATCH] Suspend2 Merge: Supress various actions/errors while
	suspending [0/5]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095378659.5897.96.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 09:50:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew et al.

The following patches suppress various actions and errors while we're
suspending.

Patch 1 disables the OOM killer and patch 3 complaining when no memory
is available for an allocation. These are needed because swsusp and
suspend2 both reduce the size of an image by allocating all the memory
they can get, thus inciting the vm to free/swap out memory. This in turn
can lead to processes being OOM killed and/or errors in the logs about
not being able to allocate pages.

Patch 2 disables the SMP call for flushing tlbs while we have other SMP
processors frozen. It is needed because while making and restoring our
atomic copy of the image, we freeze other processors (call an smp
function in which they spin) while atomically mapping highmem pages and
copying data. If we tried to flush tlbs on other processors at this
point, we would deadlock. We thus only flush local tlbs and leave other
processors to flush their local tlbs when exiting from the freezer
function.

Patch 4 disables pdflush during suspend. It needs special handling
because it runs off a timer, which we want to keep going while
supressing the actual work. We don't want to pdflush to run because it
may cause pages overwritten with the image to be synced to disk, thus
corrupting the drive image if the user uses noresume later (if they
don't, the original data is restored and no damage is done. Better safe
than sorry though).

Patch 5 disables slab reaping during suspend in a similar manner, but
for different reasons. The reaping can lead to inconsistencies in the
image and thus crashes post-resume. It is needed mainly because we don't
make a single atomic snapshot, but instead save the LRU pages
separately. I have to admit I don't fully understand the link, but this
makes the difference.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

