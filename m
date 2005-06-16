Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVFPLhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFPLhq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 07:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVFPLhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 07:37:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8682 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261576AbVFPLhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 07:37:24 -0400
Date: Thu, 16 Jun 2005 12:38:12 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "Theodore Ts'o" <tytso@mit.edu>, Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
       Hans Reiser <reiser@namesys.com>,
       Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
Message-ID: <20050616113812.GD11655@parcelfarce.linux.theplanet.co.uk>
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp> <20050615140105.GE4228@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615140105.GE4228@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 10:01:05AM -0400, Theodore Ts'o wrote:
> We can only return EIO or EROFS.  And while the write()
> which causes an I/O error that remounts the filesystem read/only can
> (and probably does) return EIO, any subsequent writes will return
> EROFS, and changing this would be hard, hackish, and probably wouldn't
> be accepted.

I wasn't quite sure why this would be so hard, so I took a look.  Here's
how it works:

In fs/ext2/super.c, we do:
        if (test_opt(sb, ERRORS_RO)) {
                printk("Remounting filesystem read-only\n");
                sb->s_flags |= MS_RDONLY;
        }

>From here on, the VFS handles returning -EROFS (except for a couple
of ioctls and an xattr call).  So it's not under the control of the
individual filesystem.  One way of handling this would be to introduce a
new MS_ERRORS flag that allows the VFS to return -EIO instead of -EROFS
for a filesystem that contains errors.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
