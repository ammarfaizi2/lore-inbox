Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWBVXHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWBVXHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWBVXHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:07:08 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:53204 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751512AbWBVXHG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:07:06 -0500
Date: Wed, 22 Feb 2006 16:07:03 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: question about possibility of data loss in Ext2/3 file system
Message-ID: <20060222230703.GM26809@schatzie.adilger.int>
Mail-Followup-To: Xin Zhao <uszhaoxin@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <4ae3c140602221356x15015171h5aa4a3d7bb6034e0@mail.gmail.com> <1140645651.2979.79.camel@laptopd505.fenrus.org> <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140602221434v6ec583a7yf04df5fa7a4948fc@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 22, 2006  17:34 -0500, Xin Zhao wrote:
> Apparently the scheme you described helps improve the file integrity.
> But still not good enough. For example, if all data blocks are
> flushed, then you will update the metadata. But right after you update
> the block bitmap and before you update the inode, you lose power. You
> will get some dead blocks.  Right? Do you know how ext2/3 deal with
> this situation?

ext3 journals changes to the filesystem metadata, and if the journal
update is not fully written to disk (committed) then the change to
the filesystem _metadata_ is NOT actually performed.  Only if the
metadata change is committed to the journal does it actually continue
and update the filesystem metatada.  If that is interrupted then journal
replay will re-do the operation.

> Also, the scheme you mentioned is just for new file creation. What
> will happen if I want to update an existing file? Say, I open file A,
> seek to offset 5000, write 4096 bytes, and then close. Do you know how
> ext2/3 handle this situation?

The above is not relevant to any _data_ changes, just metadata, unless
the file(system) is running in data-journal mode.  In that case the write
is written to the journal before being written into the filesystem.  There
is a limitation on how large such a write can be before it is split into
smaller (non-atomic) transactions in the journal.  The data-journal mode
also writes twice as much data to disk so can impact performance if you
are already using more than 1/2 of your disk bandwidth.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

