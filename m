Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264368AbUEDNw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUEDNw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUEDNw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:52:29 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:31879 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264368AbUEDNw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:52:27 -0400
Subject: Re: Possible permissions bug on NFSv3 kernel client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Colin Paton <colin.paton@etvinteractive.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1083664520.4538.42.camel@colinp>
References: <1QqNJ-4QH-37@gated-at.bofh.it> <1QqNJ-4QH-39@gated-at.bofh.it>
	 <1QqNJ-4QH-35@gated-at.bofh.it> <1Qrhg-5hH-29@gated-at.bofh.it>
	 <E1BJeSB-0000Gk-V2@localhost>
	 <1083357597.13656.37.camel@lade.trondhjem.org>
	 <1083664520.4538.42.camel@colinp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083678737.3529.85.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 04 May 2004 09:52:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-04 at 05:55, Colin Paton wrote:
> As writing to a char/block device does not perform a write
> operation *on the server* then the client should not be asking the
> server for modify/extend permission in the case of char/block devices.

Sure it should: you are asking it for write permission! If you didn't
check the for modify/extend, then you be allowing world write permission
by default.

I just checked that Sun's NFS client indeed checks both "extend" and
"modify" when attempting to write to a character device.

> > The read-only mount option does *not apply* to char/block devices such
> > as /dev/hd[a-z]*, /dev/tty*. Permission checks on open() for those
> > devices are done on the server *only* via the ACCESS rpc call.
> 
> Should vfs_permission() (as called from nfs_permission) be sufficient to
> perform this check?

No! I repeat: vfs_permission() knows nothing about any uid/gid
mapping/squashing. You cannot rely exclusively on the mode bits in NFS.

> I don't believe that it is... it is possible to write to a block device
> on a filesystem that is mounted read-only, but not to write to a block
> device on an NFS filesystem that is *exported* read-only. 

That sounds like a server bug, then.

Cheers,
  Trond
