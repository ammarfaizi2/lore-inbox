Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130200AbRAXDPX>; Tue, 23 Jan 2001 22:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRAXDPN>; Tue, 23 Jan 2001 22:15:13 -0500
Received: from p3EE3CBDA.dip.t-dialin.net ([62.227.203.218]:27141 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S130200AbRAXDOz>; Tue, 23 Jan 2001 22:14:55 -0500
Date: Wed, 24 Jan 2001 04:14:37 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: FreeBSD Stable <freebsd-stable@FreeBSD.ORG>,
        Linux NFS mailing list <nfs@lists.sourceforge.net>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Linux 2.2.18 nfs v3 server bug (was: Incompatible: FreeBSD 4.2 client, Linux 2.2.18 nfsv3 server, read-only export)
Message-ID: <20010124041437.A28212@emma1.emma.line.org>
In-Reply-To: <20010123015612.H345@quadrajet.flashcom.com> <20010123162930.B5443@emma1.emma.line.org> <wuofwynsj5.fsf_-_@bg.sics.se> <20010123105350.B344@quadrajet.flashcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010123105350.B344@quadrajet.flashcom.com>; from gharris@flashcom.net on Tue, Jan 23, 2001 at 10:53:50 -0800
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please consider removing FreeBSD-stable from the recipient list when
replying.)

Summary:

The Linux 2.2.18 NFS v3 server returns bogus and as per RFC-1813 invalid
NFS3ERR_ROFS to ACCESS procedure calls when exporting a file system
read-only, when it should instead return "OK" along with the actual
permissions the client has, ANDed with the permissions the client
queried. 

The bug is visible on FreeBSD 4.2-STABLE client which cannot ls The
mounted file system (NFS v2 is fine since it does not have ACCESS).
There is no related log entry in the 2.2.19pre7 change log.  I did not
check Linux 2.4.0, 2.4.0-acX or 2.4.1-preX either.

On Tue, 23 Jan 2001, Guy Harris wrote:

> Yes - for one thing, that means that if some client decides, while it's
> asking whether the server whether it can write to a file, to check also
> whether it can read from the file, it can get back an answer to both of
> those questions, even if the file is on a read-only file system.

Yup. Looks like a Linux kernel bug, so I'm cc'ing Alan Cox as kernel
release maintainer as well as linux-kernel to make this a known issue.

I got libpcap 0.6.1 and ethereal 0.8.15 and that's what I found:

FreeBSD 4.2-STABLE sends three NFSPROC3_ACCESS requests, with 0x3f
argument (meaning READ|LOOKUP|MODIFY|EXTEND|DELETE|EXECUTE), and to
each, Linux 2.2.18 sends NFS3ERR_ROFS back, obj_attributes contains the
stat data. ERR_ROFS is invalid here and makes indeed no sense, proper
behaviour would be NFS3_OK with just READ|LOOKUP|EXECUTE set, since the
server can actually access or stat the exported FS. Please correct me if
I'm mistaking what RFC 1813 demands.

client: $ mount server:/space /mnt
        $ ls /mnt
        ls: mnt: Read-only file system
        (FreeBSD 4.2-STABLE)

server: $ ls -ld /space/
        drwxrwxrwt  23 root     root          706 Jan  2 11:53 /space/
        $ grep /space /etc/exports
        /space 192.168.0.0/255.255.255.0(ro)
        (Linux 2.2.18, nfs-utils 0.2.1)

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
