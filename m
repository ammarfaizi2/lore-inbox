Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbTA0EYn>; Sun, 26 Jan 2003 23:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbTA0EYn>; Sun, 26 Jan 2003 23:24:43 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:11478 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267122AbTA0EYm>; Sun, 26 Jan 2003 23:24:42 -0500
Date: Mon, 27 Jan 2003 17:32:56 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: David Ashley <dash@xdr.com>, linux-kernel@vger.kernel.org
Subject: Re: Serious filesystem bug in linux
Message-ID: <21300000.1043641976@localhost.localdomain>
In-Reply-To: <200301262318.h0QNInq10032@xdr.com>
References: <200301262318.h0QNInq10032@xdr.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Sunday, January 26, 2003 15:18:49 -0800 David Ashley <dash@xdr.com> 
wrote:

> This problem has happened on 2.4.4 and 2.4.20, on an ext2 filesystem as
> well as a jfs filesystem. Through normal file operations a file is
> operated on and its size becomes something way too large, like this:
> -rw-r--r--    1 root     root     1965107636224 Jan 26 14:59 output1.iso
>
> The file should be 4.5 gb or so.
> It is opened with this:
> 	fd=open(savename,O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE,0644);
>
> Operations done on the file handle are read,write, lseek64 and close.
> All reads/writes to the file are in units of 2048 bytes. First something
> like 4+ gigs is written to the file. Then without closing the file it
> is all read out again 2048 bytes at a time. Before every read is an
> lseek64, almost always right to where the file position would have been
> anyway. Finally some fraction of the sectors are rewritten, on the order
> of 1/150, spread pretty much evenly thoughout the file. Before every
> write there is an lseek64. Then the file is closed.

Are you sure you are not lseek64'ing to a position corresponding to the new 
size?  If you do that and then write, the write will succeed and you get a 
sparse file.  To test for that, what does ls -lsk say for that file?  The 
first column will be the number of kilobytes actually stored in the file. 
If that is different from the length, it's a sparse file.

> I'm not certain but it may be that if I do this operation as root then
> sometimes the problem occurs. I'm not certain if the problem has ever
> occured when not running as root.
>
> The resultant file can be read out beyond the actual size of the file.
> What can it be reading? I'm assuming the contents of the hard drive in
> other areas not part of the original file, as in other user's files.
> As such it is a very real security risk.

Or it could just be sparse, and reading synthetic zeros that don't really 
exist anywhere, which is no problem.

> The hard drives are IDE in both cases. 2.4.4 was ext2, and 2.4.20 was jfs.
> I figure it must relate to the O_LARGEFILE since that probably hasn't been
> exercised as much.
>
> -Dave

Andrew
