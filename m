Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUHRMBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUHRMBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUHRMBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:01:23 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:18916
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266009AbUHRMBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:01:06 -0400
Message-ID: <41234500.5080500@bio.ifi.lmu.de>
Date: Wed, 18 Aug 2004 14:01:04 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Messer <andreas.messer@gmx.de>
Cc: linux-kernel@vger.kernel.org, Ballarin.Marc@gmx.de, christer@weinigel.se
Subject: Re: [PATCH] 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <200408171311.06222.satura@proton> <20040817155927.GA19546@proton-satura-home>
In-Reply-To: <20040817155927.GA19546@proton-satura-home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I guess I'm just a bit stupid, but I need some help to find out why :-)
I took Andreas patch and tried to add the commands that growisofs and
cdrecord need here on my system so that users could write cds again.

The resulting scsi_ioctl.c now looks like this:
...
                /* read-mode */
                safe_for_read(GPCMD_GET_CONFIGURATION),
                safe_for_read(GPCMD_GET_EVENT_STATUS_NOTIFICATION),
                safe_for_read(GPCMD_GET_PERFORMANCE),
                safe_for_read(GPCMD_MECHANISM_STATUS),
                safe_for_read(GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL),
                safe_for_read(REZERO_UNIT),
                safe_for_read(0xe9),
                safe_for_read(0xed),
                safe_for_read(GPCMD_MODE_SELECT_10),
                safe_for_read(GPCMD_READ_FORMAT_CAPACITIES),

                /* should this allowed for read ? */

where the last 6 safe_for_read commands were added. To make sure that
I really used this new scsi_ioctl.c I also changed the debugging output to

printk(KERN_WARNING "THIS IS MY NEW PATCH SCSI-CMD Filter...)

and compiled a new kernel from these sources. Booting it, I still cannot
use cdrecord or growisofs, although the new kernel is running. Trying
growisofs tells me again:

Aug 18 13:52:21 aiken kernel: THIS IS MY NEW PATCH SCSI-CMD Filter: 0x23 not allowed with read-mode

although 0x23 should be GPCMD_READ_FORMAT_CAPACITIES according to cdrom.h,
and that command is definitely allowed by (see above)

                safe_for_read(GPCMD_READ_FORMAT_CAPACITIES),

So it seems that the new commands that I added are just ignored and have
no effect when running growisofs as user.

How can that be? Am I missing sth? Is the order in which the commands
are added via safe_for_read important?

Any hints appreciated :-)
cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

