Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWF2Dtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWF2Dtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWF2Dtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:49:49 -0400
Received: from ns.suse.de ([195.135.220.2]:7862 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932107AbWF2Dts convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:49:48 -0400
From: Neil Brown <neilb@suse.de>
To: Martin Filip <bugtraq@smoula.net>
Date: Thu, 29 Jun 2006 13:45:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Message-ID: <17571.19699.980491.970386@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS and partitioned md
In-Reply-To: message from Martin Filip on Tuesday June 27
References: <1151355145.4460.16.camel@archon.smoula-in.net>
	<17568.31894.207153.563590@cse.unsw.edu.au>
	<1151432312.11996.32.camel@reaver.netbox-in.cz>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday June 27, bugtraq@smoula.net wrote:
> Hi,
> 
> thx for your interrest,
> 
> Neil Brown pí¹e v Út 27. 06. 2006 v 10:32 +1000:
> > Odd.  It works fine for me (I've had this sort of configuration on
> > some machines for ages, and I just tested a bleeding edge kernel and
> > it still works).
> > 
> > So I suspect there is something else going on that has nothing to do
> > with the usage of partitioned md.... then again, maybe there is some
> > weird sign extension happening to '254' somewhere, though that would
> > be terribly strange.
> > 
> > So: details please.
> >  What md device exactly (major and minor)
> # mount | grep /mnt/data
> /dev/md_d64p9 on /mnt/data type ext3 (rw)
> /dev/loop/0 on /mnt/data-loop type ext3 (rw)
> 
> # ls -al /dev/md_d64p9
> brw-rw---- 1 root disk 254, 4105 2006-06-27 10:17 /dev/md_d64p9
> # ls -al /dev/loop0
> lrwxrwxrwx 1 root root 6 2006-06-27 19:44 /dev/loop0 -> loop/0
> # ls -al /dev/loop/0
> brw-rw---- 1 root disk 7, 0 2006-06-27 19:45 /dev/loop/0
> 
> (as I look on that it comes on my mind, that problem could be minor
> longer than 1 byte)
> 

Exactly.  4105 > 256.  Such devices need a different format filehandle
which didn't work until very recently due to a bug (obviously no-one
tried it until recently).

The patch below fixes the kernel so that this will work.
Alternately use md_d0 md_d1, md_d2, or md_d3.  Then it will work with
no patches.

NeilBrown

-----------------------------
Fixing missing 'expkey' support for fsid type 3

From: Frank Filz <ffilzlnx@us.ibm.com>

Type '3' is used for the fsid in filehandles when the device number
of the device holding the filesystem has more than 8 bits in either
major or minor.
Unfortunately expkey_parse doesn't recognise type 3.  Fix this.

(Slighty modified from Frank's original)

Signed-Off-By: Frank Filz <ffilzlnx@us.ibm.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/nfsd/export.c ./fs/nfsd/export.c
--- .prev/fs/nfsd/export.c	2006-06-29 11:07:21.000000000 +1000
+++ ./fs/nfsd/export.c	2006-06-27 18:27:49.000000000 +1000
@@ -126,7 +126,7 @@ static int expkey_parse(struct cache_det
 	if (*ep)
 		goto out;
 	dprintk("found fsidtype %d\n", fsidtype);
-	if (fsidtype > 2)
+	if (key_len(fsidtype)==0) /* invalid type */
 		goto out;
 	if ((len=qword_get(&mesg, buf, PAGE_SIZE)) <= 0)
 		goto out;
