Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbSK3Akg>; Fri, 29 Nov 2002 19:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267214AbSK3Akg>; Fri, 29 Nov 2002 19:40:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:59619 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267208AbSK3Akd>;
	Fri, 29 Nov 2002 19:40:33 -0500
Message-ID: <3DE80AB6.611F3A8C@digeo.com>
Date: Fri, 29 Nov 2002 16:47:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
References: <20021129233807.GA1610@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Nov 2002 00:47:50.0921 (UTC) FILETIME=[1C270790:01C2980A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> - Orlov inode allocator for 2.4

The Orlov allocator in 2.5 has caused a tremendous performance regression
in dbench-on-ext3/ordered-on-scsi.

I don't know why yet - I doubt if it's due to the allocator itself - more
likely an IO scheduling bug in ext3, or a bug in the 2.5 elevator.

There is no such regression on IDE - presumably write caching is covering
up the problem.

So that's something to watch out for.

(where did your Orlov patch from?  All the tabs are mangled)

You'll need to port this missing bit, which provides the `oldalloc'
and `orlov' mount options.


 fs/ext3/super.c |    4 ++++
 1 files changed, 4 insertions(+)

--- 25/fs/ext3/super.c~ext3-oldalloc	Fri Nov 29 02:21:20 2002
+++ 25-akpm/fs/ext3/super.c	Fri Nov 29 02:22:03 2002
@@ -662,6 +662,10 @@ static int parse_options (char * options
 				return 0;
 			sbi->s_resuid = v;
 		}
+		else if (!strcmp (this_char, "oldalloc"))
+			set_opt (sbi->s_mount_opt, OLDALLOC);
+		else if (!strcmp (this_char, "orlov"))
+			clear_opt (sbi->s_mount_opt, OLDALLOC);
 #ifdef CONFIG_JBD_DEBUG
 		else if (!strcmp (this_char, "ro-after")) {
 			unsigned long v;

_
