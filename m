Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946599AbWKJNQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946599AbWKJNQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946601AbWKJNQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:16:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:16671 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946599AbWKJNQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:16:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hjbu5mV/CRP0+IPJY4CsjrF8luK1QBH8UjtUK3mkDuzaG0CXa+Ayp4Rf0YEYmx7BQOHHMvS1j6df7xmZdpwHbuU1i7Ki+kAMj3XotB32OGz1MOXYjt9UQWeLveLvpArfaCrSTvq1FvY3121ClQL62q7V4ov2exnSLI5ViT5smZ8=
Message-ID: <bde600590611100516u7b8ca1bfs74d3cc8b78eb3520@mail.gmail.com>
Date: Fri, 10 Nov 2006 16:16:27 +0300
From: "Igor A. Valcov" <viaprog@gmail.com>
To: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
In-Reply-To: <Pine.LNX.4.61.0611101259490.6068@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
	 <4553F3C6.2030807@sandeen.net>
	 <Pine.LNX.4.61.0611101259490.6068@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a simplified version of the test program, and results of
testing different kernels/filesystems/mount options. The results are a
little different from the ones described in the initial post (this
time performance decreased "only" 2 times), but the general tendency
is clearly the same.


============ 2.6.19-rc5-git2 ============

mount -t xfs -o noatime,barrier /dev/sdc1 /mnt/disc

real    16m40.516s
user    0m17.989s
sys    9m36.320s

mount -t xfs -o noatime,nobarrier /dev/sdc1 /mnt/disc

real    15m40.212s
user    0m17.549s
sys    9m29.692s

mount -t ext3 -o noatime /dev/sdc1 /mnt/disc

real    49m44.728s
user    0m27.678s
sys    14m15.689s

============ 2.6.14.6 ============

mount -t xfs -o noatime /dev/sdc1 /mnt/disc

real    9m58.974s
user    0m17.373s
sys    8m4.850s

mount -t ext3 -o noatime /dev/sdc1 /mnt/disc

real    49m7.526s
user    0m26.278s
sys    12m37.627s

========================================

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define __BYTES        8192
#define __FILES        1000

char    buf [__BYTES];

int main ()
{
    char    fname [1024];
    int        nFiles [__FILES];
    int     f, i;

    /* Fill buf */
    for (i = 0; i < __BYTES; i++)
        buf [i] = i % 128;

    /* Create and open files */
    for (f = 0; f < __FILES; f++) {
        sprintf (fname, "/mnt/disc/storage/file-%d", f);
        nFiles [f] = open (fname, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    }

    for (i = 0; i < 262144; i++) {
        /* Write data to a big file */
        write (nFiles [0], buf, __BYTES);

        /* Write data to small files */
        for (f = 1; f < __FILES; f++)
            write (nFiles [f], &f, sizeof (f));
    }

    for (f = 0; f < __FILES; f++) {
        fsync (nFiles [f]);
        close (nFiles [f]);
    }

    return 0;
}

========================================

-- 
Igor A. Valcov
