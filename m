Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAMWHX>; Sat, 13 Jan 2001 17:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbRAMWHN>; Sat, 13 Jan 2001 17:07:13 -0500
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:37117 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S129584AbRAMWHE>; Sat, 13 Jan 2001 17:07:04 -0500
From: junio@siamese.dhis.twinsun.com
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.10.10101120949040.1858-100000@penguin.transmeta.com>
	<Pine.LNX.4.10.10101121009230.1147-100000@master.linux-ide.org>
	<93njuq$21n$1@penguin.transmeta.com> <20010112204626.A2740@suse.cz>
Date: 13 Jan 2001 14:06:59 -0800
In-Reply-To: <20010112204626.A2740@suse.cz>
Message-ID: <7vvgrjm7i4.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With vt86c686b (AOpen AK73Pro) I am having a strange problem.
When accessing disks old-fashioned way (/dev/hdaN or /dev/hdcN)
I do not see corruption, but writing to a RAID-1 made out of
them produces corrupted results.

Does RAID code access the underlying block device the same way
as single partitions are accessed from the userland?

My test goes like this:

    cd /
    raidstop /dev/md2

    # Baseline: single device case seem to work OK
    # with both 2.1e and 3.11
    for dev in a7 c7
    do
        mke2fs /dev/hd$dev
        mount /dev/hd$dev /mnt
        tar cf - usr | ( cd /mnt && tar xfp - )
        sync
        umount /mnt
        mount -o ro /dev/hd$dev /mnt
        tar cf - usr | ( cd /mnt && tar df - )
        # no problem reported from `tar df'
        umount /mnt
    done

    # RAID-1 /dev/md2 is built out of /dev/hda7 and /dev/hdc7

    # not quite, but exact `force' switch withheld :-)
    mkraid /dev/md2
    # wait until /proc/mdstat says /dev/md2 is fully reconstructed

    mke2fs /dev/md2
    mount /dev/md2 /mnt
    tar cf - usr | ( cd /mnt && tar xfp - )
    sync
    umount /mnt
    mount -o ro /dev/md2 /mnt
    tar cf - usr | ( cd /mnt && tar df - )
    # many errors.
    umount /mnt
    raidstop /dev/md2
    sync
    mkdir -p /mnt/1 /mnt/2
    mount -o ro /dev/hda7 /mnt/1
    mount -o ro /dev/hdc7 /mnt/2
    tar cf - usr | ( cd /mnt/1 && tar df - )
    # many differences.
    tar cf - usr | ( cd /mnt/2 && tar df - )
    # many differences.

    umount /dev/hda7
    umount /dev/hdc7
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
