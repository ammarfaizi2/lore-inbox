Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264939AbSL0OMS>; Fri, 27 Dec 2002 09:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSL0OMS>; Fri, 27 Dec 2002 09:12:18 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:27327 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264939AbSL0OMQ>;
	Fri, 27 Dec 2002 09:12:16 -0500
Date: Fri, 27 Dec 2002 15:20:33 +0100
From: bert hubert <ahu@ds9a.nl>
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: swsusp in 2.5.53 BUG on kernel/suspend.c line 718
Message-ID: <20021227142032.GA6945@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, pavel@suse.cz,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I wanted to try software suspend again in Linux as 2.5 is doing almost
everything pretty well for me already.

I boot my uniprocessor Pentium III laptop with:

kernel (hd0,0)/boot/vmlinuz-2.5.53 root=/dev/hda1 resume=/dev/hda2

# swapon -s
Filename				Type		Size	Used Priority
/dev/hda2                               partition	489972	0    -1

$ cat /proc/meminfo 
MemTotal:       191240 kB

When I suspend, things proceed swimmingly, I see a lot of dots printed and
processes entering the refrigerator, until line 718 is hit in
kernel/suspend.c:

   if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave)) /* copy */
       BUG();

When I aded some printks, it turns out that count_and_copy_data pages
returns 5440 (decimal) and that nr_copy_pages is 5458, 18 more. Before this
function is called, the address c034c000 was printed twice prefixed with
'nosave', once during each call of count_and_copy_data_pages it appears.

So it appears some pages were freed in the critical section!

Another interesting note is that pdflush reported 'Bogus wakeup' twice
during the refrigeration phase. I also see two pdflushes running.

If I remove the BUG();, on resume it crashes on an unhandled NULL pointer,
the EIP is in a function aptly named do_magic() at +0x9e.

Compiler is gcc 3.2.1. Anything I can do to help, just let me know!

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
