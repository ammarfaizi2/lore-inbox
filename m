Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270721AbTGUUgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270696AbTGUUgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:36:16 -0400
Received: from nouse194035.ris.at ([212.52.194.36]:18899 "EHLO
	mail.gibraltar.at") by vger.kernel.org with ESMTP id S270721AbTGUUfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:35:54 -0400
Message-ID: <3F1C52B7.3040308@gibraltar.at>
Date: Mon, 21 Jul 2003 22:53:11 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.3.1-3 StumbleUpon/1.73
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pivot_root seems to be broken in 2.4.21-ac4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

[Please CC me in replies, I am currently not subsribed to this list.]

I am currently using 2.4.21-ac4 (with a few other patches, but none of 
them seems to touch pivot_root in any way) on a VIA EPIA M6000 board, 
with works pretty fine and seems more stable than the previsouly used 
2.4.21-rc2. However, there is one problem that I am unable to solve:

When switching the root filesystem on the fly basically with:

<prepare the new root fs, which is in fact a cramfs>
mount -t cramfs /dev/rd/0 $mntpoint
cd $mntpoint
mount -nt proc none proc/
mount -nt devfs none dev/
/sbin/pivot_root . mnt <dev/console >dev/console 2>&1
<snip, some further preparations on the new root fs>
/usr/sbin/chroot . /sbin/telinit u <dev/console >/dev/console 2>&1
<snip>
exit 0

it no longer works as expected. I should probably note that the 
redirections to /dev/console were not necessary for 2.4.21-rc2, I tried 
them with 2.4.21-ac4. While the above commands did the trick for 
2.4.21-rc2, with 2.4.21-ac4 the kernel processes leave the console on 
the old root fs open:

lsof -n | grep mnt
keventd     2   root    0u   CHR        5,1               16 
/mnt/dev/console
keventd     2   root    1u   CHR        5,1               16 
/mnt/dev/console
keventd     2   root    2u   CHR        5,1               16 
/mnt/dev/console
ksoftirqd   3   root    0u   CHR        5,1               16 
/mnt/dev/console
ksoftirqd   3   root    1u   CHR        5,1               16 
/mnt/dev/console
ksoftirqd   3   root    2u   CHR        5,1               16 
/mnt/dev/console
kswapd      4   root    0u   CHR        5,1               16 
/mnt/dev/console
kswapd      4   root    1u   CHR        5,1               16 
/mnt/dev/console
kswapd      4   root    2u   CHR        5,1               16 
/mnt/dev/console
bdflush     5   root    0u   CHR        5,1               16 
/mnt/dev/console
bdflush     5   root    1u   CHR        5,1               16 
/mnt/dev/console
bdflush     5   root    2u   CHR        5,1               16 
/mnt/dev/console
kupdated    6   root    0u   CHR        5,1               16 
/mnt/dev/console
kupdated    6   root    1u   CHR        5,1               16 
/mnt/dev/console
kupdated    6   root    2u   CHR        5,1               16 
/mnt/dev/console
kjournald   7   root    0u   CHR        5,1               16 
/mnt/dev/console
kjournald   7   root    1u   CHR        5,1               16 
/mnt/dev/console
kjournald   7   root    2u   CHR        5,1               16 
/mnt/dev/console
scsi_eh_0  81   root    0u   CHR        5,1               16 
/mnt/dev/console
scsi_eh_0  81   root    1u   CHR        5,1               16 
/mnt/dev/console
scsi_eh_0  81   root    2u   CHR        5,1               16 
/mnt/dev/console

Does anybody have an idea what might be wrong here ?

best regards,
Rene

