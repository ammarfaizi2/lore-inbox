Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUACS27 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUACS2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:28:43 -0500
Received: from cpc1-cosh4-5-0-cust84.cos2.cable.ntl.com ([81.96.30.84]:47236
	"EHLO slut.local.munted.org.uk") by vger.kernel.org with ESMTP
	id S263734AbUACS2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:28:17 -0500
Date: Sat, 3 Jan 2004 18:27:42 +0000 (GMT)
From: Alex Buell <alex.buell@munted.org.uk>
X-X-Sender: alex@slut.local.munted.org.uk
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively
 enough  on low-memory PCs
In-Reply-To: <20040103103023.77bf91b5.jlash@speakeasy.net>
Message-ID: <Pine.LNX.4.58.0401031823010.3488@slut.local.munted.org.uk>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
 <20040103103023.77bf91b5.jlash@speakeasy.net>
X-no-archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004, John Lash wrote:

> Check on your system, /proc/sys/fs/dentry-state, first two values appear
> to be nr_dentry and nr_unused. Plug those values into the above code and
> if you get something around zero, that's why the memory is stuck.

Right, I put together this simple C program as follows:
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
        int dentries_used, dentries_unused;
        int inodes_used, inodes_unused;
        int ratio = 1, used;
        char entries[80];
        FILE *fh;

        fh = fopen("/proc/sys/fs/dentry-state", "r");
        fgets(entries, 4096, fh);
        fclose(fh);

        dentries_used = atoi(entries);
        dentries_unused = atoi(&entries[6]);

        printf("nr_dentry: %d\nnr_unused: %d\n\n", dentries_used, dentries_unused);

        used = dentries_used - dentries_unused;
        printf("%d < %d * %d = %d\n", dentries_unused, used, ratio, (dentries_unused < used * ratio));

        return 0;
}

This gives me interesting results:

1) On a box with humuguous dentries:
./fs_cache 
nr_dentry: 76637
nr_unused: 67869

67869 < 8768 * 1 = 0

2) On a box with not so many:
./fs_cache
nr_dentry: 7950
nr_unused: 572

572 < 7378 * 1 = 1

So it seems you're quite right.

> A couple of solutions come to mind. The one I like best would be to
> adjust the above code to make it conscious of the total memory in the
> system and keep nr_unused to a reasonable percentage. Another is to
> allow unused_ratio to be less than 1, Possibly some/proc entry to lower
> it (.5, .25, whatever), or to avoid the float, provide another parameter
> to do an integer divisor for unused_ratio. Something like:
> 
> 	nr_unused - nr_used * unused_ratio / ratio_fraction

That solution does seem be the best answer.

-- 
http://www.munted.org.uk

Your mother cooks socks in hell
