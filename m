Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSHHN5L>; Thu, 8 Aug 2002 09:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317572AbSHHN5L>; Thu, 8 Aug 2002 09:57:11 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:23884 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S317571AbSHHN5K>; Thu, 8 Aug 2002 09:57:10 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114E5@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Cc: "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'pollard@tomcat.admin.navo.hpc.mil'" 
	<pollard@tomcat.admin.navo.hpc.mil>,
       "'bcrl@redhat.com'" <bcrl@redhat.com>,
       "'cks@utcc.utoronto.ca'" <cks@utcc.utoronto.ca>
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
Date: Thu, 8 Aug 2002 16:57:59 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I wanted to thank you All for your patience and help. As I have triggered
this discussion, I would like to summarize it by listing my findings, so it
can help others having same/similar questions.

I want to mention that I was looking for a way to make the best out of NFS
with regard to reading/writing files while not breaking the consistency of
data. I wasn't implying to get rid of locking as some of you suggested (I
fully understand the stateless nature of NFS protocol), instead I was
looking for a mix (both application and OS options) that will make Linux
systems behave similarly to other UN*X colleagues. In my opinion, any
standard behavior would greatly affect the strategic decision of large
companies to move to Linux with all the benefits from this to all of us. I'm
sorry if I wasn't clear enough.

Most of the current UN*X systems provide you with the mentioned
functionality by using the strictest NFS mount options as default (sync,
noac, etc.). Linux, on the contrary, strives to achieve maximum performance
on the expense of data consistency, which is not the most expected behavior
(BTW, the performance is great anyway!).

OS options:
===========
- The directories should be exported with "sync" option, which is not
default.
- The directories should be NFS mounted using "sync" and "noac" options,
which are not default.

Application code (per read/write transaction):
==============================================
- lock_file (doesn't have to be a lockd lock)
- open_file (O_SYNC)
- read/write file
- close_file
- unlock_file

The above sequence works OK, but it's still problematic since it doesn't
ensure that the data is coming from the server instead of NFS cache. In one
of my previous discussions on this list, I was told to use the following
technique to flush NFS buffers. It turns out that acquiring write lock using
fcntl (F_SETLK) interface acts as NFS write barrier and flushes all the file
NFS buffers. So, the above sequence would result in the following one:

- lock_file (doesn't have to be a lockd lock)
- open_file (O_SYNC)
- if (read) fcntl (F_SETLK) (doing lock/unlock here to flush NFS buffers)
- read/write file
- if (write) fcntl (F_SETLK) (doing lock/unlock here to flush NFS buffers)
- close_file
- unlock_file

FCNTL Unexpected behavior (Possible BUG?):
==========================================
There is a catch when using fcntl system call. It appears not to flush NFS
buffers when _FILE_OFFSET_BITS=64 is defined. This is because F_SETLK is
redefined for 64 bit version to be equal to 13, which makes fcntl call
behave differently. Passing hard-coded 6 to the call would produce the
expected results (one can see all this in strace).

Summary:
========
Using the fcntl dirty trick I finally achieved the expected behavior. BTW, I
don't understand why open/close calls do not flush NFS buffers - this seems
like a natural thing to do. 
Anyway, I'm looking forward to your comments on this. I might have arrived
to some wrong conclusions, which I hope you'll help me to correct.

Best regards,
Giga














