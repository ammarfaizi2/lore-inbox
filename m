Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWHDPgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWHDPgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161234AbWHDPgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:36:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161246AbWHDPga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:36:30 -0400
Message-ID: <44D36946.7020601@redhat.com>
Date: Fri, 04 Aug 2006 10:35:34 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, Eric Sandeen <esandeen@redhat.com>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jack@suse.cz, neilb@suse.de,
       Marcel Holtmann <marcel@holtmann.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [patch 16/23] ext3: avoid triggering ext3_error on bad NFS file
 handle
References: <20060804053258.391158155@quad.kroah.org> <20060804054010.GQ769@kroah.com> <44D35DA0.4060403@redhat.com> <20060804145254.GA20640@infradead.org>
In-Reply-To: <20060804145254.GA20640@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------070000030706090800080201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000030706090800080201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
> On Fri, Aug 04, 2006 at 09:45:52AM -0500, Eric Sandeen wrote:
>> Greg KH wrote:
>>> -stable review patch.  If anyone has any objections, please let us know.
>>>
>>> ------------------
>>> From: Neil Brown <neilb@suse.de>
>>>
>>> The inode number out of an NFS file handle gets passed eventually to
>>> ext3_get_inode_block() without any checking.  If ext3_get_inode_block()
>>> allows it to trigger an error, then bad filehandles can have unpleasant
>>> effect - ext3_error() will usually cause a forced read-only remount, or a
>>> panic if `errors=panic' was used.
>>>
>>> So remove the call to ext3_error there and put a matching check in
>>> ext3/namei.c where inode numbers are read off storage.
>> This patch and the ext2 patch (23/23) are accomplishing the same thing in 2 
>> different ways, I think, and introducing unnecessary differences between 
>> ext2 and ext3.  I'd personally prefer to see both ext2 and ext3 handled 
>> with the get_dentry op addition, and I'd be happy to quickly whip up the 
>> ext3 patch to do this if there's agreement on this path.
> 
> I completly agree with Eric here.  Also pushing out only the fix for one
> (and today probably the lesser used) filesystems to -stable seems wrong.

so how's this? (compile tested)

Thanks,
-Eric

--------------070000030706090800080201
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name*0="have-ext3-reject-file-handles-with-bad-inode-numbers-early.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="have-ext3-reject-file-handles-with-bad-inode-numbers-early.p";
 filename*1="atch"

Signed-off-by: Eric Sandeen <sandeen@sandeen.net>

(tho blatantly ripped off from Neil Brown's ext2 patch)

Index: linux-2.6.17/fs/ext3/super.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/super.c
+++ linux-2.6.17/fs/ext3/super.c
@@ -620,8 +620,48 @@ static struct super_operations ext3_sops
 #endif
 };
 
+static struct dentry *ext3_get_dentry(struct super_block *sb, void *vobjp)
+{
+	__u32 *objp = vobjp;
+	unsigned long ino = objp[0];
+	__u32 generation = objp[1];
+	struct inode *inode;
+	struct dentry *result;
+
+	if (ino != EXT3_ROOT_INO && ino < EXT3_FIRST_INO(sb))
+		return ERR_PTR(-ESTALE);
+	if (ino > le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count))
+		return ERR_PTR(-ESTALE);
+
+	/* iget isn't really right if the inode is currently unallocated!!
+	 * ext3_read_inode currently does appropriate checks, but
+	 * it might be "neater" to call ext3_get_inode first and check
+	 * if the inode is valid.....
+	 */
+	inode = iget(sb, ino);
+	if (inode == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (!result) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	return result;
+}
+
 static struct export_operations ext3_export_ops = {
 	.get_parent = ext3_get_parent,
+	.get_dentry = ext3_get_dentry,
 };
 
 enum {

--------------070000030706090800080201--
