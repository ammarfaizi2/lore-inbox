Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291049AbSBLUEo>; Tue, 12 Feb 2002 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291061AbSBLUEf>; Tue, 12 Feb 2002 15:04:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53521 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291049AbSBLUES>;
	Tue, 12 Feb 2002 15:04:18 -0500
Message-ID: <3C69750E.8BA2C6AB@zip.com.au>
Date: Tue, 12 Feb 2002 12:03:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Pavel Machek <pavel@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020211221102.GA131@elf.ucw.cz> <3C68F3F3.8030709@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> If you are already at it, I would like to ask to you consider seriously
> the removal of the
> following entries in the ide drivers /proc control files:
> 
>     ide_add_setting(drive,    "breada_readahead",    ...         1,
> 2,    &read_ahead[major],        NULL);
>     ide_add_setting(drive,    "file_readahead",   ...
> &max_readahead[major][minor],    NULL);
>
> Those calls can be found in ide-cd.c, ide-disk,c and ide-floppy.c

I suspect that if we remove these, we'll one day end up putting them back.
It is appropriate that we be able to control readahead characteristics
on a per-device and per-technology basis.

> The second of them is trying to control a file-system level constant
> inside the actual block device driver.
> This is a blatant violation of the layering principle in software
> design, and should go as soon as
> possible.

Well, the whole design of filesystems and the VM are a blatant
layering violation: all the stuff we do at all levels to try to
perform block-contiguous reads and writes, and to keep related
data at related LBAs is making implicit assumptions about the
underlying physical storage technology.  We've been doing that
for 30 years - if a constant access time storage technology
takes over from rotating and seeking disks, we have a lot of stuff
to toss out.

That being said, it is a horrid user interface wart that IDE readhead
is controlled from /proc/ide/hda/settings:file_readhead, and that IDE
ignores /proc/sys/vm/max-readahead, whereas devices which forget to
set up their max_readhead entries are controlled by /proc/sys/vm/max-readhead.

My vote would be to remove both of them.  Move the readhead controls
into the filemap level, but implement per-device controls.  Say,
/proc/sys/vm/readhead/hda, /proc/sys/vm/readhead/sdc, etc.

-
