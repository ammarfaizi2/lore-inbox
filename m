Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314987AbSECSOg>; Fri, 3 May 2002 14:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314998AbSECSOe>; Fri, 3 May 2002 14:14:34 -0400
Received: from mons.uio.no ([129.240.130.14]:7069 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S314987AbSECSOc>;
	Fri, 3 May 2002 14:14:32 -0400
To: Paul Menage <pmenage@ensim.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace exec_permission_lite() with inlined vfs_permission()
In-Reply-To: <E173gmF-0005eC-00@pmenage-dt.ensim.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 May 2002 20:14:17 +0200
Message-ID: <shs8z71aykm.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Paul Menage <pmenage@ensim.com> writes:

     > Is something like this more acceptable? It actually struck me
     > how few fs-specific directory permission() methods there were
     > in the tree - almost all directories leave it NULL and let
     > vfs_permission() do the work. The only common place where this
     > patch is potentially going to make a noticeable difference is
     > the case of a non-root user accessing NFS. I'm not sure whether
     > this is going to outweigh the cost of having to check two
     > mostly-NULL methods instead of one, compared to just inlining
     > vfs_permission().

The NFS permission method *will* change. Currently we violate the
NFSv3 specs when we call vfs_permission().

Ideally, the NFS permission method would be empty. There is little
point in doing any permissions checking before making another RPC call
--whether you do it using ACCESS or *NIX permission bits-- since
whatever you do will be prone to races. (BTW: that redundancy argument
also applies to things like doing lookup() before exclusive file
create etc...)

The only places where we would need to explicitly check access
permissions are when we do

  - File open() without creation.
  - Changing the current directory.
  - Walking a pathname.

For the latter case, but not the former two, we definitely want to
cache the ACCESS RPC call results for efficiency.

Cheers,
  Trond
