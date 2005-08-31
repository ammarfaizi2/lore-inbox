Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVHaNc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVHaNc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVHaNc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:32:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60070 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964799AbVHaNc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:32:58 -0400
Subject: Re: [PATCH] Ext3 online resizing locking issue
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Glauber de Oliveira Costa <gocosta@br.ibm.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       ext2resize-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050831113506.GM23782@br.ibm.com>
References: <20050824210325.GK23782@br.ibm.com>
	 <1124996561.1884.212.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050825204335.GA1674@br.ibm.com>
	 <1125410818.1910.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050831113506.GM23782@br.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1125495031.1900.60.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 31 Aug 2005 14:30:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2005-08-31 at 12:35, Glauber de Oliveira Costa wrote:

> At a first look, i thought about locking gdt-related data. But in a
> closer one, it seemed to me that we're in fact modifying a little bit
> more than that in the resize code. But all these modifications seem to
> be somehow related to the ext3 super block specific data in
> ext3_sb_info. My first naive approach would be adding a lock to that
> struct

I took great care when making that code SMP-safe to avoid such locks,
for performance reasons.  See the comments at

	 * We need to protect s_groups_count against other CPUs seeing
	 * inconsistent state in the superblock.

in fs/ext3/resize.c for the rules.  But basically the way it works is
that we only usually modify data that cannot be in use by other parts of
the kernel --- and that's fairly easy to guarantee, since by definition
extending the fs is something that is touching bits that aren't already
in use.  Only once all the new data is safely installed do we atomically
update the s_groups_count field, which instantly makes the new data
visible.  We enforce this ordering via smp read barriers before reading
s_groups_count and write barriers after modifying it, but we don't
actually have locks as such.

The only use of locking in the resize is hence the superblock lock,
which is not really there to protect the resize from the rest of the fs
--- the s_groups_count barriers do that.  All the sb lock is needed for
is to prevent two resizes from progressing at the same time; and that
could easily be abstracted into a separate resize lock.

Cheers,
 Stephen

