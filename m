Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268151AbTBYRdD>; Tue, 25 Feb 2003 12:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268152AbTBYRdD>; Tue, 25 Feb 2003 12:33:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268151AbTBYRdA>; Tue, 25 Feb 2003 12:33:00 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Minutes from Feb 21 LSE Call
Date: Tue, 25 Feb 2003 17:38:31 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3g9mn$27s$1@penguin.transmeta.com>
References: <mbligh@aracnet.com> <200302251711.h1PHBct16624@mail.osdl.org>
X-Trace: palladium.transmeta.com 1046194982 32154 127.0.0.1 (25 Feb 2003 17:43:02 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 25 Feb 2003 17:43:02 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200302251711.h1PHBct16624@mail.osdl.org>,
Cliff White  <cliffw@osdl.org> wrote:
>
>Well, here's one bit of data. Easy enough to do if you have a web browser.
>LMBench 2.0 on 1-way and 2-way, kernels 2.4.18 and 2.5.60 
>1-way (stp1-003 stp1-002) 
>2.4.18 http://khack.osdl.org/stp/7443/
>2.5.60 http://khack.osdl.org/stp/265622/ 
>
>2-way (stp2-003 stp2-000)
>2.4.18 http://khack.osdl.org/stp/3165/
>2.5.60 http://khack.osdl.org/stp/265643/
>
>Interesting items for me are the fork/exec/sh times and some of the file + VM 
>numbers
>LMBench 2.0 Data ( items selected from total of five runs )
>
>Processor, Processes - times in microseconds - smaller is better
>----------------------------------------------------------------
>Host                 OS  Mhz null null      open selct sig  sig  fork exec sh
>                             call  I/O stat clos TCP   inst hndl proc proc proc
>--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
>stp2-003.  Linux 2.4.18 1000 0.39 0.67 3.89 4.99  30.4 0.93 3.06 344. 1403 4465
>stp2-000.  Linux 2.5.60 1000 0.41 0.77 4.34 5.57  32.6 1.15 3.59 245. 1406 5795

Note that those numbers will look quite different (at least on a P4) if
you use a modern library that uses the "sysenter" stuff. The difference
ends up being something like this:

Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos       inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
i686-linu  Linux 2.5.30 2380  0.8  1.1    3    5 0.04K  1.1    3 0.2K   1K   3K
i686-linu  Linux 2.5.62 2380  0.2  0.6    3    4 0.04K  0.7    3 0.2K   1K   3K

(Yeah, I've never run a 2.4.x kernel on this machine, so..) In other
words, the system call has been speeded up quite noticeably. 

Yes, if you don't take advantage of sysenter, then all the sysenter
support will just make us look worse ;(

I'm surprised by your "sh proc" changes, they are quite big. I guess
it's rmap and highmem that bites us, and yes, we've gotten slower there.

		Linus
