Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVARIUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVARIUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVARIUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:20:50 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:5817 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261179AbVARIUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:20:32 -0500
Date: Tue, 18 Jan 2005 09:20:22 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118082022.GA2839@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20050115233530.GA2803@darkside.22.kls.lan> <20050117194635.GD22202@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117194635.GD22202@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 05:46:35PM -0200, Marcelo Tosatti wrote:
> On Sun, Jan 16, 2005 at 12:35:30AM +0100, Mario Holbe wrote:
> > Could somebody please explain this to me? Is this intentional?
> No

Thanks :)

> Can you please turn readahead off (hdparm -a 0 /dev/hdg) and repeat the tests?
> The kernel is trying to read one block after EOD.

The same happens.

root@darkside:~# dd if=/dev/hdg7 of=/dev/null
9992366+0 records in
9992366+0 records out
5116091392 bytes transferred in 117,573365 seconds (43514034 bytes/sec)
root@darkside:~# hdparm -a 0 /dev/hdg

/dev/hdg:
 setting fs readahead to 0
 readahead    =  0 (off)
root@darkside:~# mount -t ext3 -o ro /dev/hdg7 /mnt
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
root@darkside:~# umount /dev/hdg7
root@darkside:~# hdparm -a 0 /dev/hdg

/dev/hdg:
 setting fs readahead to 0
 readahead    =  0 (off)
root@darkside:~# dd if=/dev/hdg7 of=/dev/null
attempt to access beyond end of device
22:07: rw=0, want=4996184, limit=4996183
dd: reading `/dev/hdg7': Input/output error
9992360+0 records in
9992360+0 records out
5116088320 bytes transferred in 100,455251 seconds (50929028 bytes/sec)
root@darkside:~#

> So maybe an off-by-one read-ahead?

Please also note dd's output: 9992366 vs. 9992360 records.

root@darkside:~# cat /proc/partitions
...
  34     7    4996183 hdg7 156620 6088613 19984760 368240 3 0 24 0 0 190720 368240
...
root@darkside:~# bc
4996183 * 2
9992366
root@darkside:~# tune2fs -l /dev/hdg7
...
Block count:              1249045
...
root@darkside:~# bc
4096 * 1249045 / 512
9992360

The block device (the partition) is 4996183 kB or 9992366 sectors,
while the ext3 fs is 9992360 sectors. Exactly these 9992360 sectors
could be read by dd in the second pass.

root@darkside:~# dd if=/dev/hdg7 of=/dev/null bs=512
attempt to access beyond end of device
22:07: rw=0, want=4996184, limit=4996183
dd: reading `/dev/hdg7': Input/output error
9992360+0 records in
9992360+0 records out
5116088320 bytes transferred in 92,603241 seconds (55247400 bytes/sec)
root@darkside:~#

Fixing dd's blocksize to 512 doesn't help either.

> Also I suggest a dump_stack() to see where the read is coming
> from.

I have no idea, how and where to do a dump_stack().


regards
   Mario
-- 
() Ascii Ribbon Campaign
/\ Support plain text e-mail
