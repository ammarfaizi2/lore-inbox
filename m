Return-Path: <linux-kernel-owner+w=401wt.eu-S1030277AbWLOWoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWLOWoB (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWLOWoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:44:01 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:39956 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030277AbWLOWoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:44:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EuChcH9IeNfMBYnw/Tw6J4uYIuptbpdV27SBlZ0YnnJ48zM89doZryKuYLvb1pAcEhoJLWiekuEKadlr5bXeC8D1D+PaRjGNOFotielMAy/khn9qxodg44egN3oPlAN3JSeZ6qWGDlOmcUDRqvyrt/d39Q2SZm99S4vodFRfxu4=
Message-ID: <5c49b0ed0612151443t3a6cad53u29575a3b9b0ac1fb@mail.gmail.com>
Date: Fri, 15 Dec 2006 14:43:59 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: generic_file_buffered_write and O_SYNC
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm trying to get an understanding of the interactions between the
various aio_read/aio_write paths, and I ran across this gem at the end
of generic_file_buffered_write:

        /*
         * For now, when the user asks for O_SYNC, we'll actually give O_DSYNC
         */
        if (likely(status >= 0)) {
                if (unlikely((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
                        if (!a_ops->writepage || !is_sync_kiocb(iocb))
                                status = generic_osync_inode(inode, mapping,
                                                OSYNC_METADATA|OSYNC_DATA);
                }
        }

        /*
         * If we get here for O_DIRECT writes then we must have fallen through
         * to buffered writes (block instantiation inside i_size).  So we sync
         * the file data here, to try to honour O_DIRECT expectations.
         */
        if (unlikely(file->f_flags & O_DIRECT) && written)
                status = filemap_write_and_wait(mapping);

So if there's a writepage function AND we're doing async i/o, then
skip the writeout for O_SYNC files.  But always do writeout for dio,
synchronously.  Why do we check for the existence of ->writepage, but
not ->writepages?  Why do we ever skip writeback at all?

in addition to being poorly documented, this code looks to me like it
has a high likelyhood of being incorrect.  can anyone clarify?

thanks

NATE
