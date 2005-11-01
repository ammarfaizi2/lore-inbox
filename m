Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVKAIZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVKAIZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbVKAIZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:25:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:5309 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964989AbVKAIY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:24:59 -0500
X-Authenticated: #1700068
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/*/smaps
Date: Tue, 1 Nov 2005 09:24:56 +0100
User-Agent: KMail/1.7.1
References: <787b0d920510312113v715b22e0m8e25dbf0aac317b@mail.gmail.com>
In-Reply-To: <787b0d920510312113v715b22e0m8e25dbf0aac317b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010924.56783.torsten.foertsch@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 06:13, Albert Cahalan wrote:
> Take a look at those files, trying not to crack up laughing
> at the file format. Maybe you will cry. Imagine that some
> apps try to parse those... all of them, repeatedly, while
> being tolerant of unspecified future changes.

The Perl module Linux::Smaps already parses it.

r2@s93:~> cp /bin/bash 'b
a
:s:h'
r2@s93:~> ./'b
> a
> :s:h'
s93:~$ more /proc/$$/smaps
08048000-080ba000 r-xp 00000000 08:02 152476     /home/r2/b\012a\012:s:h
Size:               456 kB
Rss:                368 kB
Shared_Clean:       368 kB
Shared_Dirty:         0 kB
Private_Clean:        0 kB
Private_Dirty:        0 kB
080ba000-080bd000 rwxp 00072000 08:02 152476     /home/r2/b\012a\012:s:h
Size:                12 kB
Rss:                 12 kB
Shared_Clean:         0 kB
Shared_Dirty:         0 kB
Private_Clean:        0 kB
Private_Dirty:       12 kB
080bd000-08126000 rwxp 080bd000 00:00 0          [heap]
Size:               420 kB
Rss:                312 kB
...

s93:~$ perl -MLinux::Smaps -e 'foreach (Linux::Smaps->new('$$')->names) {print 
"$_\n"}'
...
/lib/libdl.so.2
/home/r2/b\012a\012:s:h
/usr/lib/locale/en_US.utf8/LC_NUMERIC

Where is your problem? You see, the vma names are properly parsed.

Here is my parser:
    if( $l=~/([\da-f]+)-([\da-f]+)\s                # range
             ([r\-])([w\-])([x\-])([sp])\s          # access mode
             ([\da-f]+)\s                           # page offset in file
             ([\da-f]+):([\da-f]+)\s                # device
             (\d+)\s*                               # inode
             (.*)		                    # file name
	    /xi ) {
      push @{$I->_elem}, $current=Linux::Smaps::VMA->new;
      $current->vma_start=hex $1;
      $current->vma_end=hex $2;
      $current->r=($3 eq 'r');
      $current->w=($4 eq 'w');
      $current->x=($5 eq 'x');
      $current->mayshare=($6 eq 's');
      $current->file_off=hex $7;
      $current->dev_major=hex $8;
      $current->dev_minor=hex $9;
      $current->inode=$10;
      $current->file_name=$11;
    } elsif( $l=~/^(\w+):\s*(\d+) kB$/ ) {
      my $m=lc $1;
      $current->$m=$2;
    } else {
      die __PACKAGE__.":: not parsed: $l\n";
    }

Torsten

> (remember that a filename may have a colon, new fields
> may be added, new lines may differ in unknown ways, etc.)
>
> Could we fix this ASAP? How about just commenting it
> out right now, so nothing important starts to rely on it.
> CONFIG_EXPERIMENTAL would do I guess.
>
> I'll gladly do something sane, but not tonight. I'm sorry I
> did not catch this earlier; I've been rather sick and I never
> imagined that this thing would get accepted without a
> major rework of the file format.
>
> -------- unbelievable example follows --------
>
> 08048000-080dc000 r-xp /bin/bash
> Size:               592 KB
> Rss:                500 KB
> Shared_Clean:       500 KB
> Shared_Dirty:         0 KB
> Private_Clean:        0 KB
> Private_Dirty:        0 KB
> 080dc000-080e2000 rw-p /bin/bash
> Size:                24 KB
> Rss:                 24 KB
> Shared_Clean:         0 KB
> Shared_Dirty:         0 KB
> Private_Clean:        0 KB
> Private_Dirty:       24 KB
> 080e2000-08116000 rw-p
> Size:               208 KB
> Rss:                208 KB
> Shared_Clean:         0 KB
> Shared_Dirty:         0 KB
> Private_Clean:        0 KB
> Private_Dirty:      208 KB
> b7e2b000-b7e34000 r-xp /lib/tls/libnss_files-2.3.2.so
> Size:                36 KB
> Rss:                 12 KB
> Shared_Clean:        12 KB
> Shared_Dirty:         0 KB
> Private_Clean:        0 KB
> Private_Dirty:        0 KB
> ...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
