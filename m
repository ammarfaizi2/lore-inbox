Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbTB1KR3>; Fri, 28 Feb 2003 05:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbTB1KR3>; Fri, 28 Feb 2003 05:17:29 -0500
Received: from gw2-int.ensim.com ([65.164.64.254]:55044 "EHLO
	exchange-svr.exch.ensim.com") by vger.kernel.org with ESMTP
	id <S267726AbTB1KR2>; Fri, 28 Feb 2003 05:17:28 -0500
Thread-Index: AcLfFAkVDgCGGnfxTUyxkh2C4WtrAQ==
Content-Transfer-Encoding: 7bit
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
content-class: urn:content-classes:message
Importance: normal
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: "Paul Menage" <pmenage@ensim.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Linus Torvalds" <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <lse-tech@sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH] New dcache / inode hash tuning patch 
Cc: <pmenage@ensim.com>
In-Reply-To: Your message of "28 Feb 2003 09:34:24 +0100."             <p73n0kg7qi7.fsf@amdsimf.suse.de> 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 28 Feb 2003 02:27:27 -0800
Message-ID: <E18ohjj-0005ls-00@pmenage-dt.ensim.com>
X-OriginalArrivalTime: 28 Feb 2003 10:27:46.0453 (UTC) FILETIME=[09155C50:01C2DF14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>It would be possible to cache line optimize the layout of struct dentry
>in addition. May be an interesting add-on project for someone...

I played with this a few months ago, and sent a preliminary patch to
linux-kernel, but in my (fairly brief) testing on a 4-way system I
wasn't able to produce a measurable benefit from it. I think part of
this may have been due to contention on dcache_lock, so maybe dcache_rcu
will help there.

The main changes were to bring together all the data needed for checking
a non-matching dcache hash entry (modulo hash collisions) into one
cacheline, and to separate out the mostly-read-only fields from the 
change-frequently fields.

The original patch is at 

http://marc.theaimsgroup.com/?l=linux-kernel&m=102650654002932&w=2

>But for lookup walking even one cache line - the one containing d_hash -
>should be needed. Unless d_hash is unlucky enough to cross a cache
>line for its two members ... but I doubt that.

No, but on a 32-byte cache line system, d_parent, d_hash and d_name are
all on different cache lines, and they're used when checking each entry.
On 64-byte systems, d_parent and d_hash will be on the same line, but
d_name is still on a separate line and d_name.hash gets checked before
d_parent. So bringing these three fields on to the same cacheline
would theoretically be a win.

Paul


