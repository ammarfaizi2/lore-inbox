Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWH2FmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWH2FmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 01:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWH2FmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 01:42:12 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45192 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751180AbWH2FmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 01:42:10 -0400
Subject: Re: Reiser4 und LZO compression
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Edward Shishkin <edward@namesys.com>,
       Stefan Traby <stefan@hello-penguin.com>,
       Hans Reiser <reiser@namesys.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0608290603330.8045@yvahk01.tjqt.qr>
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>
	 <44F322A6.9020200@namesys.com> <20060828173721.GA11332@hello-penguin.com>
	 <44F332D6.6040209@namesys.com> <1156801705.2969.6.camel@nigel.suspend2.net>
	 <Pine.LNX.4.61.0608290603330.8045@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 15:41:42 +1000
Message-Id: <1156830102.3790.15.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2006-08-29 at 06:05 +0200, Jan Engelhardt wrote:
> >> >>Hmm.  LZO is the best compression algorithm for the task as measured by
> >> >>the objectives of good compression effectiveness while still having very
> >> >>low CPU usage (the best of those written and GPL'd, there is a slightly
> >> >>better one which is proprietary and uses more CPU, LZRW if I remember
> >> >>right.  The gzip code base uses too much CPU, though I think Edward made
> >> > 
> >> > I don't think that LZO beats LZF in both speed and compression ratio.
> >> > 
> >> > LZF is also available under GPL (dual-licensed BSD) and was choosen in favor
> >> > of LZO for the next generation suspend-to-disk code of the Linux kernel.
> >> > 
> >> > see: http://www.goof.com/pcg/marc/liblzf.html
> >> 
> >> thanks for the info, we will compare them
> >
> >For Suspend2, we ended up converting the LZF support to a cryptoapi
> >plugin. Is there any chance that you could use cryptoapi modules? We
> >could then have a hope of sharing the support.
> 
> I am throwing in gzip: would it be meaningful to use that instead? The 
> decoder (inflate.c) is already there.
> 
> 06:04 shanghai:~/liblzf-1.6 > l configure*
> -rwxr-xr-x  1 jengelh users 154894 Mar  3  2005 configure
> -rwxr-xr-x  1 jengelh users  26810 Mar  3  2005 configure.bz2
> -rw-r--r--  1 jengelh users  30611 Aug 28 20:32 configure.gz-z9
> -rw-r--r--  1 jengelh users  30693 Aug 28 20:32 configure.gz-z6
> -rw-r--r--  1 jengelh users  53077 Aug 28 20:32 configure.lzf

We used gzip when we first implemented compression support, and found it
to be far too slow. Even with the fastest compression options, we were
only getting a few megabytes per second. Perhaps I did something wrong
in configuring it, but there's not that many things to get wrong!

In contrast, with LZF, we get very high throughput. My current laptop is
an 1.8MHz Turion with a 7200 RPM (PATA) drive. Without LZF compression,
my throughput in writing an image is the maximum the drive & interface
can manage - 38MB/s. With LZF, I get roughly that divided by compression
ratio achieved, so if the compression ratio is ~50%, as it generally is,
I'm reading and writing the image at 75-80MB/s. During this time, all
the computer is doing is compressing pages using LZF and submitting
bios, with the odd message being send to the userspace interface app via
netlink. I realise this is very different to the workload you'll be
doing, but hopefully the numbers are somewhat useful:

nigel@nigel:~$ cat /sys/power/suspend2/debug_info
Suspend2 debugging info:
- SUSPEND core   : 2.2.7.4
- Kernel Version : 2.6.18-rc4
- Compiler vers. : 4.1
- Attempt number : 1
- Parameters     : 0 32785 0 0 0 0
- Overall expected compression percentage: 0.
- Compressor is 'lzf'.
  Compressed 820006912 bytes into 430426371 (47 percent compression).
- Swapwriter active.
  Swap available for image: 487964 pages.
- Filewriter inactive.
- I/O speed: Write 74 MB/s, Read 70 MB/s.
- Extra pages    : 1913 used/2100.
nigel@nigel:~$

(Modify hibernate.conf to disable compression, suspend again...)

nigel@nigel:~$ cat /sys/power/suspend2/debug_info
Suspend2 debugging info:
- SUSPEND core   : 2.2.7.4
- Kernel Version : 2.6.18-rc4
- Compiler vers. : 4.1
- Attempt number : 2
- Parameters     : 0 32785 0 0 0 0
- Overall expected compression percentage: 0.
- Swapwriter active.
  Swap available for image: 487964 pages.
- Filewriter inactive.
- I/O speed: Write 38 MB/s, Read 39 MB/s.
- Extra pages    : 1907 used/2100.
nigel@nigel:~$

Oh, I also have a debugging mode where I can get Suspend2 to just
compress the pages but not actually write anything. If I do that, it
says it can do 80MB/s on my kernel image, so the disk is still the
bottleneck, it seems.

Hope this all helps (and isn't information overload!)

Nigel

