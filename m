Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264963AbUEQLbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUEQLbn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 07:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264967AbUEQLbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 07:31:43 -0400
Received: from mail.zrz.TU-Berlin.DE ([130.149.4.15]:36073 "EHLO
	mail.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S264963AbUEQLbi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 07:31:38 -0400
From: Andreas Amann <amann@physik.tu-berlin.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.6 breaks kmail (nfs related?)
Date: Mon, 17 May 2004 13:31:34 +0200
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405131411.52336.amann@physik.tu-berlin.de> <Pine.LNX.4.58.0405161149430.25502@ppc970.osdl.org> <1084734612.6331.8.camel@lade.trondhjem.org>
In-Reply-To: <1084734612.6331.8.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405171331.35688.amann@physik.tu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 21:10, Trond Myklebust wrote:
> På su , 16/05/2004 klokka 14:50, skreiv Linus Torvalds:
> > Agreed. But the kmail message is apparently "(No space left on device?)",
> > which may be just kmail itself reacting to a truncated write rather than
> > any actual ENOSPC error.  A "strace" would help clarify exactly what goes
> > wrong..
>
> Right...
>
> One possible suspect might be open(O_EXCL) since, AFAICS, Andreas is
> using maildir-style mailboxes. Perhaps that SETATTR call in
> nfs3_proc_create() is failing? We recently fixed so that it always sets
> MTIME/ATIME...
>
> Andreas: when you do the "strace" could you first run
>
> echo "16" >/proc/sys/sunrpc/nfs_debug
>
> and then record the output from "dmesg" immediately after the kmail
> crash?

Ok, I produced the "strace"s and "dmesg"s for the kernels 2.6.4, 2.6.5 and 
2.6.6 and made them available at 

http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/dmesg_kmail_2.6.4
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/dmesg_kmail_2.6.5
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/dmesg_kmail_2.6.6
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/kmail_trace_2.6.4
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/kmail_trace_2.6.5
http://wwwnlds.physik.tu-berlin.de/~amann/kmail_bug/kmail_trace_2.6.6

Some further information:

My problem occurs already with kernel 2.6.5, and it is indeed NFS related (It 
does not appear on a local home partition). 

I  reproduced the crash with a server exporting an ext2 partition and one 
which exports a reiserfs partition. So far I  only tested servers running  on 
vanilla 2.4.25. Should I check others?

The mount options according to /proc/mount are
viola:/tmp /net/viola/tmp nfs 
rw,nosuid,nodev,v3,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=viola 0 0

The traces were produced by the command lines
strace  2>/tmp/kmail_trace_2.6.x /usr/linux-local/kde/bin/kmail --nofork -s 
test --msg test_mail amann@physik.tu-berlin.de
dmesg > /tmp/dmesg_kmail_2.6.x

(I also tried "strace -f", but apparently exim does not like to be traced?)

>From my (limited) point of view, the problem is the ESTALE of an fstat64 call 
in the 2.6.5 trace:
>
access("/net/viola/tmp/amann/home_tmp/Mail/outbox/cur/1084784925.736.utEix:2,S", 
F_OK) = -1 ENOENT (No such file or directory)
rename("/net/viola/tmp/amann/home_tmp/Mail/outbox/tmp/1084784925.736.utEix:2,S", 
"/net/viola/tmp/amann/home_tmp/Mail/outbox/cur/1084784925
.736.utEix:2,S") = 0
fstat64(8, 0xbfffe650)                  = -1 ESTALE (Stale NFS file handle)
_llseek(8, 0, [373], SEEK_END)          = 0
write(8, "X\1\0\0", 4)                  = -1 ESTALE (Stale NFS file handle)
write(8, "\5\0\0\0,\0\0a\0z\0/\0w\0t\0z\0t\0+\0N\0S\0+\0001\0s"..., 344) = -1 
ESTALE (Stale NFS file handle)
<

This succeeds in the 2.6.4 trace:
>
access("/net/viola/tmp/amann/home_tmp/Mail/outbox/cur/1084785768.460.mTWwO:2,S", 
F_OK) = -1 ENOENT (No such file or directory)
rename("/net/viola/tmp/amann/home_tmp/Mail/outbox/tmp/1084785768.460.mTWwO:2,S", 
"/net/viola/tmp/amann/home_tmp/Mail/outbox/cur/1084785768
.460.mTWwO:2,S") = 0
fstat64(8, {st_mode=S_IFREG|0600, st_size=373, ...}) = 0
_llseek(8, 0, [0], SEEK_SET)            = 0
read(8, "# KMail-Index V1506\n\0\10\0\0\0xV4\22\4\0\0"..., 373) = 373
write(8, "X\1\0\0", 4)                  = 4
write(8, "\5\0\0\0,\0\0j\0w\0N\0O\0S\0g\0p\0x\0j\0003\0o\0l\0S"..., 344) = 344
<

In both cases filehandle 8 was generated before by 
>
open("/net/viola/tmp/amann/home_tmp/Mail/.outbox.index", O_RDWR|O_LARGEFILE) = 
8
<

No idea what causes the difference. 


I hope this is the information you expected. Please let me know what further 
checks  I can do. 

 Andreas

