Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289975AbSAKPH4>; Fri, 11 Jan 2002 10:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289976AbSAKPHq>; Fri, 11 Jan 2002 10:07:46 -0500
Received: from pat.uio.no ([129.240.130.16]:13001 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S289975AbSAKPHi>;
	Fri, 11 Jan 2002 10:07:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15422.65459.871735.203004@charged.uio.no>
Date: Fri, 11 Jan 2002 16:07:31 +0100
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: [NFS] some strangeness (at least) with linux-2.4.17-NFS_ALL patch
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de>
In-Reply-To: <20020111131528.44F8613E6@shrek.lisa.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:

     > The problem is, ls on the client side complains about an I/O
     > error, when listing the conf/ dir.

What server is this?

     > After removing this symlink (within the server), ls is OK
     > within the client. Trying to copy servers /etc/ou.conf file to
     > /usr/share/openuniverse within the client, cp complains about
     > to many levels of symlinks?!? (/usr is shared)

That can happen, yes. The symlink is still in the dcache, and so the
VFS thinks that we want to open whatever it is that the symlink is
pointing to (not the symlink itself). For this reason, less strict
checking is performed, and so the client does not immediately see the
change.

If, however, you had first done 'ls -l' or something that tries to
read the symlink itself, more strict revalidation checks are
performed, and the stale dentry would have been detected.

I can tighten the checks on this sort of thing a bit, but if so, it
needs to be done carefully. It is important to make sure that
operations like
   'ls /usr/lib/*'
(in which you want the system to repeatedly look up the same path) are
efficient by caching the '/usr/lib' bit even if that /usr/lib is a
symlink.
Of course every time we do open("/usr/lib/libc.so"), we *do* want to
make sure that we perform strict checks when we do the lookup of the
last element of the path (on the actual file "libc.so").

Cheers,
  Trond
