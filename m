Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbVJaVZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbVJaVZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVJaVZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:25:39 -0500
Received: from iptel.by ([80.94.225.5]:33976 "EHLO iptel.by")
	by vger.kernel.org with ESMTP id S932531AbVJaVZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:25:38 -0500
Subject: Re: [Linux-NTFS-Dev] [2.6-GIT] NTFS: Release 2.1.25.
From: Yura Pakhuchiy <pakhuchiy@iptel.by>
Reply-To: Yura Pakhuchiy <pakhuchiy@gmail.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0510312040010.10190@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
	 <1130790267.2276.8.camel@localhost>
	 <Pine.LNX.4.64.0510312040010.10190@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 23:25:39 +0200
Message-Id: <1130793939.2104.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 20:49 +0000, Anton Altaparmakov wrote:
> On Mon, 31 Oct 2005, Yura Pakhuchiy wrote:
> > On Mon, 2005-10-31 at 14:22 +0000, Anton Altaparmakov wrote:
> > > And people: please try it before Linus releases 2.6.15 and report back 
> > > (especially if you find bugs but even a "it works" would be nice to hear 
> > > from a few more people)...
> > 
> > One more bug, steps to reproduce:
> > 1) Create fragmented file with DATA attribute split on several records.
> > (using windows or ntfsmount)
> 
> That is just evil.  Attribute list attribute is not supported yet!  And 
> majority of files are not fragmented like that...

It seems you forgot to place somewhere "return -EOPNOTSUPP;", if I was
able to overwrite them.

> btw. Did you run a chkdsk fter using ntfsmount and before mounting with 
> the ntfs driver?  I keep finding that chkdsk finds lots of (minor) 
> problems after ntfsmount has written to a drive (I haven't investigated 
> since then only times I have done it I was also messing with "strange" 
> filenames and things like that so I was not expecting it to necessarily 
> work and I haven't had time since to do it again on a clean volume).

Yes, I was forced to do that, because after I received NULL pointer
dereference first time umount failed and thus dirty bit was on the
volume.

BTW, ntfsmount in almost all truncating cases leave absolutely clean
volume chkdsk happy with, except one case with updating length of
resident file length in index. About file creation/deletion yes, volume
sometimes have minor inconsistencies, but windows driver itself often
leave them (in case file have 2 names, when you change size for one,
windows does not update another size in index).

> Not that that is any excuse for the ntfs driver to crash...  It should 
> deal with corruption...
> 
> > 2) Overwrite this file with some small (few bytes, but non-zero) file.
> > (using kernel driver)
> 
> Again, the required truncate is not supported so this cannot work.

Again, it works, but not in such way as it should.

> > After this cp segfaults on my system and I receive following in dmesg:
> 
> Ouch!  It certainly should not do that!  )-:
> 
> > NTFS-fs error (device hda4): ntfs_truncate(): Cannot truncate inode 
> > 0x169e, attribute type 0x80, because the attribute is highly fragmented 
> > (it consists of multiple extents) and this case is not implemented yet.
> 
> That is correct.  Attribute list attribute is not supported yet.
> 
> > Unable to handle kernel NULL pointer dereference at virtual address 00000029
> >  printing eip:
> > c01ece9e
> > *pde = 00000000
> > Oops: 0000 [#1]
> > PREEMPT 
> > Modules linked in: ltserial ltmodem fglrx vmmon subfs
> > CPU:    0
> > EIP:    0060:[<c01ece9e>]    Tainted: P      VLI
> > EFLAGS: 00010246   (2.6.14-ck1) 
> > EIP is at ntfs_prepare_pages_for_non_resident_write+0x4ce/0x1f70
> > eax: 00000200   ebx: 00000000   ecx: c78ebcd8   edx: 00000029
> > esi: c774e9c4   edi: 00000000   ebp: 00000000   esp: c78ebbec
> > ds: 007b   es: 007b   ss: 0068
> > Process cp (pid: 2420, threadinfo=c78ea000 task=c9178ad0)
> > Stack: c87c1b44 c774e9c4 00000000 ceee43c0 cf596030 c04fd960 00000001 00000000 
> >        00000096 00000000 cf603f3c 00000001 c78ebc5c c90bbc54 c78ea000 00000000 
> >        00001000 00000000 c90bbc20 09003200 00000000 00000000 00000000 00000000 
> > Call Trace:
> >  [<c01c40c7>] journal_end+0xa7/0x100
> >  [<c01218f1>] current_fs_time+0x51/0x70
> >  [<c017d453>] inode_update_time+0xb3/0xe0
> >  [<c01f04d6>] ntfs_file_aio_write_nolock+0x216/0x260
> >  [<c013f5e1>] __generic_file_aio_read+0x1f1/0x230
> >  [<c013f310>] file_read_actor+0x0/0xe0
> >  [<c01f06c2>] ntfs_file_writev+0xc2/0x140
> >  [<c01320e0>] autoremove_wake_function+0x0/0x60
> >  [<c01f0777>] ntfs_file_write+0x37/0x40
> >  [<c0160c57>] vfs_write+0xa7/0x180
> >  [<c0160e01>] sys_write+0x51/0x80
> >  [<c01032e1>] syscall_call+0x7/0xb
> > Code: 00 00 00 39 4c 24 74 0f 87 66 ff ff ff 8b 6c 24 58 85 ed 75 69 c7 44 24 5c 00 00 00 00 8b 5c 24 5c 8b b4 24 08 01 00 00 8b 14 9e <8b> 02 f6 c4 08 74 42 8b 52 0c 89 54 24 78 89 d5 89 f6 8b 45 00 
> 
> Hmm.  Looks like error handling gone wrong.  Will investigate tomorrow.  
> It is osx evening now.
> 
> > BTW, great work, but IMHO to early for mainline.
> 
> Too late!  (-;  It it there already.  Also it really is not too early!  
> Look yourself: you tested it only when I sent it to mainline, you must 
> have seen the posts when I asked for testers and also when it was in 
> -mm but you didn't test it then.  And I imagine neither did anyone else 
> except for me and one other person who reported a bug which I fixed 
> prompty...

Anyway mainline is not place for unstable code IMHO, or people will
simply stop trust it. You have test your code better (at least such
obvious cases), even if no one except you do not want to test it. BTW,
when I implemented file creation in libntfs, almost no one except
several persons tested it too.

About me, I did not tested this code before, at least because you had
not posted patches to mailing list when you send it to -mm. Sorry, but I
do not have git repository.

-- 
Best regards,
        Yura

