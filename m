Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270436AbTHSO1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTHSO1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:27:42 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:63477 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S270436AbTHSOYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:24:01 -0400
Subject: Re: [PATCH] fix for htree corruption. Was: [2.6] Perl weirdness
	with ext3 and HTREE
From: Martin Schlemmer <azarah@gentoo.org>
To: chrisl@vmware.com
Cc: KML <linux-kernel@vger.kernel.org>, akpm@digeo.com, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org,
       Ext2 Devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20030819104026.GA25402@vmware.com>
References: <68F326C497FDB743B5F844B776C9B146097700@pa-exch4.vmware.com>
	 <1060208887.12477.31.camel@nosferatu.lan>
	 <20030819104026.GA25402@vmware.com>
Content-Type: text/plain
Message-Id: <1061302675.4605.15.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Aug 2003 16:17:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 12:40, chrisl@vmware.com wrote:
> Martin,
> 

Hiya Chris

> The first patch should fix it. The bug is trigger by creating the index.
> Coping out the index we assume the dirents start with the first entry
> after "." "..".
> 
> It can make the first previous deleted entry reappear.
> In the past we set inode to zero for empty entry so this is not
> a problem. That is not true any more.
> 

Thanks a lot!  I will test as soon as I get home.  If maybe delayed,
sorry, but I have currently only working inet at work.

> Andrew, I assume touch inode->i_ctime after
> ext3_mark_inode_dirty is a bug? The second patch is for that.
> 
> 
> Chris
> 
> ===== namei.c 1.44 vs edited =====
> --- 1.44/fs/ext3/namei.c        Sun Jun 29 23:49:04 2003
> +++ edited/namei.c      Tue Aug 19 03:28:52 2003
> @@ -1304,7 +1304,8 @@
>         data1 = bh2->b_data;
> 
>         /* The 0th block becomes the root, move the dirents out */
> -       de = (struct ext3_dir_entry_2 *) &root->info;
> +       de = &root->dotdot;
> +       de = (struct ext3_dir_entry_2 *) ((char *)de + de->rec_len);
>         len = ((char *) root) + blocksize - (char *) de;
>         memcpy (data1, de, len);
>         de = (struct ext3_dir_entry_2 *) data1;
> 
> 
> 
> 
> ===== namei.c 1.44 vs edited =====
> --- 1.44/fs/ext3/namei.c        Sun Jun 29 23:49:04 2003
> +++ edited/namei.c      Tue Aug 19 03:28:52 2003
> @@ -2006,9 +2007,9 @@
>          * recovery. */
>         inode->i_size = 0;
>         ext3_orphan_add(handle, inode);
> +       inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
>         ext3_mark_inode_dirty(handle, inode);
>         dir->i_nlink--;
> -       inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
>         ext3_update_dx_flag(dir);
>         ext3_mark_inode_dirty(handle, dir);
> 
> @@ -2060,8 +2061,8 @@
>         inode->i_nlink--;
>         if (!inode->i_nlink)
>                 ext3_orphan_add(handle, inode);
> -       ext3_mark_inode_dirty(handle, inode);
>         inode->i_ctime = dir->i_ctime;
> +       ext3_mark_inode_dirty(handle, inode);
>         retval = 0;
> 
>  end_unlink:
> @@ -2220,7 +2221,6 @@
>                         goto end_rename;
>         } else {
>                 BUFFER_TRACE(new_bh, "get write access");
> -               BUFFER_TRACE(new_bh, "get_write_access");
>                 ext3_journal_get_write_access(handle, new_bh);
>                 new_de->inode = le32_to_cpu(old_inode->i_ino);
>                 if (EXT3_HAS_INCOMPAT_FEATURE(new_dir->i_sb,
> 
> 
> On Thu, Aug 07, 2003 at 12:28:07AM +0200, Martin Schlemmer wrote:
> > On Wed, 2003-08-06 at 22:22, Christopher Li wrote:
> > 
> > > > Just grab the perl source, if you want, I can mail you the ebuild that
> > > > should give some direction in how to compile it, or grab your local
> > > > .spec, configure it (maybe with install location not in /), and then
> > > > just compile and finally install to a ext3 FS with HTREE enabled. 
> > > > Usually over here, it keeps on leaving an invalid entry to
> > > > ..usr/share/man/man3/Hash::Util.tmp.
> > > > 
> > > 
> > > I am running 2.6-test2 kernel. Download the perl 5.8.0 (stable.tar.gz).
> > > ./Configure --prefix=/mnt/hdc3; make; make install.
> > > 
> > > It did not happen for me. Hash::Util.3 was installed correctly.
> > > (Of course, I did turn on directory index)
> > > 
> > > Can you send me more infomation how you build the perl package
> > > and install it? I guess I have to do more gentoo like step to duplicate
> > > it :-)
> > > 
> > 
> > I have gotten a few of these while testing:
> > 
> > -----------------------------------------
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file
> > (4759186), 0
> > Slab corruption: start=cb147184, expend=cb14736f, problemat=cb1471f8
> > Last user: [<c019ae7f>](ext3_destroy_inode+0x1d/0x21)
> > Data:
> > ********************************************************************************************************************F4 F1 15 F6 ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
> > Next: 71 F0 2C .7F AE 19 C0 71 F0 2C .********************
> > slab error in check_poison_obj(): cache `ext3_inode_cache': object was
> > modified after freeing
> > Call Trace:
> >  [<c0141634>] check_poison_obj+0x161/0x1a1
> >  [<c0143128>] kmem_cache_alloc+0x11f/0x159
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c0171f74>] alloc_inode+0x1c/0x14d
> >  [<c01729db>] new_inode+0x1a/0xa2
> >  [<c0192207>] ext3_new_inode+0x41/0x6d8
> >  [<c014313c>] kmem_cache_alloc+0x133/0x159
> >  [<c01a0244>] new_handle+0x1c/0x4e
> >  [<c01992e4>] ext3_mkdir+0x74/0x2b6
> >  [<c01665dc>] permission+0x2f/0x4b
> >  [<c0168555>] vfs_mkdir+0x6d/0xbf
> >  [<c016865e>] sys_mkdir+0xb7/0xf7
> >  [<c010aaa5>] sysenter_past_esp+0x52/0x71
> >   
> > -----------------------------------------
> > 
> > A more complete one is attached (just more similar ones).
> > 
> > Attached is a script (test.sh) and a list of man page names (list) that
> > I can recreate it without needing perl.  The list may or may not be
> > pruned some more, but I will try tonight again after some sleep ;)
> > 
> > Here is a test run (note that it do the same with symlinks instead of
> > hard links):
> > 
> > -----------------------------------------
> > nosferatu space # uname -a
> > Linux nosferatu 2.6.0-test2-bk5 #2 SMP Wed Aug 6 00:21:15 SAST 2003 i686
> > Intel(R) Pentium(R) 4 CPU 2.40GHz GenuineIntel GNU/Linux
> > nosferatu space # dumpe2fs /dev/hdc1 | grep features
> > dumpe2fs 1.34 (25-Jul-2003)
> > Filesystem features:      has_journal dir_index filetype needs_recovery
> > sparse_super large_file
> > nosferatu space # pwd
> > /space
> > nosferatu space # mount | grep `pwd`
> > /dev/hdc1 on /space type ext3 (rw,noatime)
> > nosferatu space # ls foo/
> > ls: foo/: No such file or directory
> > nosferatu space # cat test.sh
> > #!/bin/bash
> >  
> > i=1
> >  
> > testdir="`pwd`/foo"
> >  
> > (rm -rf "$testdir"; rm -rf "$testdir") &>/dev/null
> > mkdir -p "$testdir"
> >  
> > for x in $(cat list)
> > do
> >         temp="$testdir/${x/3pm/tmp}"
> >         x="$testdir/${x}"
> >  
> >         touch "$temp"
> >         ln "$temp" "$x"
> >         rm -f "$temp"
> >  
> > #       echo "Pass $i"
> >  
> > #       i=$((i+1))
> > done
> >  
> > nosferatu space # ./test.sh
> > nosferatu space # ls foo/
> > ls: foo/Win32.tmp: No such file or directory
> > Fcntl.3pm                    PerlIO::via.3pm
> > Hash::Util.3pm               PerlIO::via::QuotedPrint.3pm
> > I18N::Collate.3pm            Pod::Checker.3pm
> > I18N::LangTags.3pm           Pod::Find.3pm
> > I18N::LangTags::List.3pm     Pod::Html.3pm
> > I18N::Langinfo.3pm           Pod::InputObjects.3pm
> > IO.3pm                       Pod::LaTeX.3pm
> > IO::Dir.3pm                  Pod::Man.3pm
> > IO::File.3pm                 Pod::ParseLink.3pm
> > IO::Handle.3pm               Pod::ParseUtils.3pm
> > IO::Pipe.3pm                 Pod::Parser.3pm
> > IO::Poll.3pm                 Pod::Plainer.3pm
> > IO::Seekable.3pm             Pod::Select.3pm
> > IO::Select.3pm               Pod::Text.3pm
> > IO::Socket.3pm               Pod::Text::Color.3pm
> > IO::Socket::INET.3pm         Pod::Text::Overstrike.3pm
> > IO::Socket::UNIX.3pm         Pod::Text::Termcap.3pm
> > IPC::Msg.3pm                 Pod::Usage.3pm
> > IPC::Open2.3pm               SDBM_File.3pm
> > IPC::Open3.3pm               Safe.3pm
> > IPC::Semaphore.3pm           Scalar::Util.3pm
> > IPC::SysV.3pm                Search::Dict.3pm
> > List::Util.3pm               SelectSaver.3pm
> > Locale::Constants.3pm        SelfLoader.3pm
> > Locale::Country.3pm          Shell.3pm
> > Locale::Currency.3pm         Socket.3pm
> > Locale::Language.3pm         Storable.3pm
> > Locale::Maketext.3pm         Switch.3pm
> > Locale::Maketext::TPJ13.3pm  Symbol.3pm
> > Locale::Script.3pm           Sys::Hostname.3pm
> > MIME::Base64.3pm             Sys::Syslog.3pm
> > MIME::QuotedPrint.3pm        Term::ANSIColor.3pm
> > Math::BigFloat.3pm           Term::Cap.3pm
> > Math::BigFloat::Trace.3pm    Term::Complete.3pm
> > Math::BigInt.3pm             Term::ReadLine.3pm
> > Math::BigInt::Calc.3pm       Test.3pm
> > Math::BigInt::Trace.3pm      Test::Builder.3pm
> > Math::BigRat.3pm             Test::Harness.3pm
> > Math::Complex.3pm            Test::Harness::Assert.3pm
> > Math::Trig.3pm               Test::Harness::Iterator.3pm
> > Memoize.3pm                  Test::Harness::Straps.3pm
> > Memoize::AnyDBM_File.3pm     Test::More.3pm
> > Memoize::Expire.3pm          Test::Simple.3pm
> > Memoize::ExpireFile.3pm      Test::Tutorial.3pm
> > Memoize::ExpireTest.3pm      Text::Abbrev.3pm
> > Memoize::NDBM_File.3pm       Text::Balanced.3pm
> > Memoize::SDBM_File.3pm       Text::ParseWords.3pm
> > Memoize::Storable.3pm        Text::Soundex.3pm
> > NDBM_File.3pm                Text::Tabs.3pm
> > NEXT.3pm                     Text::Wrap.3pm
> > Net::Cmd.3pm                 Thread.3pm
> > Net::Config.3pm              Thread::Queue.3pm
> > Net::Domain.3pm              Thread::Semaphore.3pm
> > Net::FTP.3pm                 Tie::Array.3pm
> > Net::FTP::A.3pm              Tie::File.3pm
> > Net::FTP::E.3pm              Tie::Handle.3pm
> > Net::FTP::I.3pm              Tie::Hash.3pm
> > Net::FTP::L.3pm              Tie::Memoize.3pm
> > Net::FTP::dataconn.3pm       Tie::RefHash.3pm
> > Net::NNTP.3pm                Tie::Scalar.3pm
> > Net::Netrc.3pm               Tie::SubstrHash.3pm
> > Net::POP3.3pm                Time::HiRes.3pm
> > Net::Ping.3pm                Time::Local.3pm
> > Net::SMTP.3pm                Time::gmtime.3pm
> > Net::Time.3pm                Time::localtime.3pm
> > Net::hostent.3pm             Time::tm.3pm
> > Net::libnetFAQ.3pm           UNIVERSAL.3pm
> > Net::netent.3pm              Unicode::Collate.3pm
> > Net::protoent.3pm            Unicode::Normalize.3pm
> > Net::servent.3pm             Unicode::UCD.3pm
> > O.3pm                        User::grent.3pm
> > Opcode.3pm                   User::pwent.3pm
> > POSIX.3pm                    Win32.3pm
> > PerlIO.3pm                   XS::APItest.3pm
> > PerlIO::encoding.3pm         XS::Typemap.3pm
> > PerlIO::scalar.3pm           XSLoader.3pm
> > nosferatu space #
> > ----------------------------------
> > 
> > 
> > Thanks,
> > 
> > -- 
> > 
> > Martin Schlemmer
> > 
> > 
> > 
> 
> > kjournald starting.  Commit interval 5 seconds
> > EXT3 FS on hdc1, internal journal
> > EXT3-fs: mounted filesystem with ordered data mode.
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (2961487), 0
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (2944744), 0
> > Slab corruption: start=d230e184, expend=d230e36f, problemat=d230e1f8
> > Last user: [<c019ae7f>](ext3_destroy_inode+0x1d/0x21)
> > Data: ********************************************************************************************************************08 89 A1 C6 ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
> > Next: 71 F0 2C .7F AE 19 C0 71 F0 2C .********************
> > slab error in check_poison_obj(): cache `ext3_inode_cache': object was modified after freeing
> > Call Trace:
> >  [<c0141634>] check_poison_obj+0x161/0x1a1
> >  [<c0143128>] kmem_cache_alloc+0x11f/0x159
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c0171f74>] alloc_inode+0x1c/0x14d
> >  [<c01729db>] new_inode+0x1a/0xa2
> >  [<c0192207>] ext3_new_inode+0x41/0x6d8
> >  [<c014313c>] kmem_cache_alloc+0x133/0x159
> >  [<c01a0244>] new_handle+0x1c/0x4e
> >  [<c0199154>] ext3_create+0x55/0xb0
> >  [<c0167be9>] vfs_create+0x79/0xce
> >  [<c0168179>] open_namei+0x39a/0x3ee
> >  [<c0157976>] filp_open+0x3e/0x64
> >  [<c0157edc>] sys_open+0x5b/0x8b
> >  [<c010aaa5>] sysenter_past_esp+0x52/0x71
> >  
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (2944744), 0
> > Slab corruption: start=e2b7c27c, expend=e2b7c467, problemat=e2b7c2f0
> > Last user: [<c019ae7f>](ext3_destroy_inode+0x1d/0x21)
> > Data: ********************************************************************************************************************08 89 A1 C6 ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
> > Next: 71 F0 2C .7F AE 19 C0 71 F0 2C .********************
> > slab error in check_poison_obj(): cache `ext3_inode_cache': object was modified after freeing
> > Call Trace:
> >  [<c0141634>] check_poison_obj+0x161/0x1a1
> >  [<c0143128>] kmem_cache_alloc+0x11f/0x159
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c0171f74>] alloc_inode+0x1c/0x14d
> >  [<c01729db>] new_inode+0x1a/0xa2
> >  [<c0192207>] ext3_new_inode+0x41/0x6d8
> >  [<c014313c>] kmem_cache_alloc+0x133/0x159
> >  [<c01a0244>] new_handle+0x1c/0x4e
> >  [<c0199154>] ext3_create+0x55/0xb0
> >  [<c0167be9>] vfs_create+0x79/0xce
> >  [<c0168179>] open_namei+0x39a/0x3ee
> >  [<c0157976>] filp_open+0x3e/0x64
> >  [<c0157edc>] sys_open+0x5b/0x8b
> >  [<c010aaa5>] sysenter_past_esp+0x52/0x71
> >  
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (2944744), 0
> > Slab corruption: start=e2b7c27c, expend=e2b7c467, problemat=e2b7c2f0
> > Last user: [<c019ae7f>](ext3_destroy_inode+0x1d/0x21)
> > Data: ********************************************************************************************************************44 BD 8F F6 ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
> > Next: 71 F0 2C .7F AE 19 C0 71 F0 2C .********************
> > slab error in check_poison_obj(): cache `ext3_inode_cache': object was modified after freeing
> > Call Trace:
> >  [<c0141634>] check_poison_obj+0x161/0x1a1
> >  [<c0143128>] kmem_cache_alloc+0x11f/0x159
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c0171f74>] alloc_inode+0x1c/0x14d
> >  [<c01729db>] new_inode+0x1a/0xa2
> >  [<c0192207>] ext3_new_inode+0x41/0x6d8
> >  [<c014313c>] kmem_cache_alloc+0x133/0x159
> >  [<c01a0244>] new_handle+0x1c/0x4e
> >  [<c0199154>] ext3_create+0x55/0xb0
> >  [<c0167be9>] vfs_create+0x79/0xce
> >  [<c0168179>] open_namei+0x39a/0x3ee
> >  [<c0157976>] filp_open+0x3e/0x64
> >  [<c0157edc>] sys_open+0x5b/0x8b
> >  [<c010aaa5>] sysenter_past_esp+0x52/0x71
> >  
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (4759152), 0
> > Slab corruption: start=cb147184, expend=cb14736f, problemat=cb1471f8
> > Last user: [<c019ae7f>](ext3_destroy_inode+0x1d/0x21)
> > Data: ********************************************************************************************************************08 89 A1 C6 ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
> > Next: 71 F0 2C .7F AE 19 C0 71 F0 2C .********************
> > slab error in check_poison_obj(): cache `ext3_inode_cache': object was modified after freeing
> > Call Trace:
> >  [<c0141634>] check_poison_obj+0x161/0x1a1
> >  [<c0143128>] kmem_cache_alloc+0x11f/0x159
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c0171f74>] alloc_inode+0x1c/0x14d
> >  [<c01729db>] new_inode+0x1a/0xa2
> >  [<c0192207>] ext3_new_inode+0x41/0x6d8
> >  [<c014313c>] kmem_cache_alloc+0x133/0x159
> >  [<c01a0244>] new_handle+0x1c/0x4e
> >  [<c0199154>] ext3_create+0x55/0xb0
> >  [<c0167be9>] vfs_create+0x79/0xce
> >  [<c0168179>] open_namei+0x39a/0x3ee
> >  [<c0157976>] filp_open+0x3e/0x64
> >  [<c0157edc>] sys_open+0x5b/0x8b
> >  [<c010aaa5>] sysenter_past_esp+0x52/0x71
> >  
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (4759186), 0
> > Slab corruption: start=cb147184, expend=cb14736f, problemat=cb1471f8
> > Last user: [<c019ae7f>](ext3_destroy_inode+0x1d/0x21)
> > Data: ********************************************************************************************************************F4 F1 15 F6 ***********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************A5
> > Next: 71 F0 2C .7F AE 19 C0 71 F0 2C .********************
> > slab error in check_poison_obj(): cache `ext3_inode_cache': object was modified after freeing
> > Call Trace:
> >  [<c0141634>] check_poison_obj+0x161/0x1a1
> >  [<c0143128>] kmem_cache_alloc+0x11f/0x159
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c019ae46>] ext3_alloc_inode+0x18/0x34
> >  [<c0171f74>] alloc_inode+0x1c/0x14d
> >  [<c01729db>] new_inode+0x1a/0xa2
> >  [<c0192207>] ext3_new_inode+0x41/0x6d8
> >  [<c014313c>] kmem_cache_alloc+0x133/0x159
> >  [<c01a0244>] new_handle+0x1c/0x4e
> >  [<c01992e4>] ext3_mkdir+0x74/0x2b6
> >  [<c01665dc>] permission+0x2f/0x4b
> >  [<c0168555>] vfs_mkdir+0x6d/0xbf
> >  [<c016865e>] sys_mkdir+0xb7/0xf7
> >  [<c010aaa5>] sysenter_past_esp+0x52/0x71
> >  
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (4759122), 0
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (4759194), 0
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (4710637), 0
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (4710637), 0
> > EXT3-fs warning (device hdc1): ext3_unlink: Deleting nonexistent file (4710637), 0
> > 
> 
> 
> > Fcntl.3pm
> > Hash::Util.3pm
> > I18N::Collate.3pm
> > I18N::LangTags.3pm
> > I18N::LangTags::List.3pm
> > I18N::Langinfo.3pm
> > IO.3pm
> > IO::Dir.3pm
> > IO::File.3pm
> > IO::Handle.3pm
> > IO::Pipe.3pm
> > IO::Poll.3pm
> > IO::Seekable.3pm
> > IO::Select.3pm
> > IO::Socket.3pm
> > IO::Socket::INET.3pm
> > IO::Socket::UNIX.3pm
> > IPC::Msg.3pm
> > IPC::Open2.3pm
> > IPC::Open3.3pm
> > IPC::Semaphore.3pm
> > IPC::SysV.3pm
> > List::Util.3pm
> > Locale::Constants.3pm
> > Locale::Country.3pm
> > Locale::Currency.3pm
> > Locale::Language.3pm
> > Locale::Maketext.3pm
> > Locale::Maketext::TPJ13.3pm
> > Locale::Script.3pm
> > MIME::Base64.3pm
> > MIME::QuotedPrint.3pm
> > Math::BigFloat.3pm
> > Math::BigFloat::Trace.3pm
> > Math::BigInt.3pm
> > Math::BigInt::Calc.3pm
> > Math::BigInt::Trace.3pm
> > Math::BigRat.3pm
> > Math::Complex.3pm
> > Math::Trig.3pm
> > Memoize.3pm
> > Memoize::AnyDBM_File.3pm
> > Memoize::Expire.3pm
> > Memoize::ExpireFile.3pm
> > Memoize::ExpireTest.3pm
> > Memoize::NDBM_File.3pm
> > Memoize::SDBM_File.3pm
> > Memoize::Storable.3pm
> > NDBM_File.3pm
> > NEXT.3pm
> > Net::Cmd.3pm
> > Net::Config.3pm
> > Net::Domain.3pm
> > Net::FTP.3pm
> > Net::FTP::A.3pm
> > Net::FTP::E.3pm
> > Net::FTP::I.3pm
> > Net::FTP::L.3pm
> > Net::FTP::dataconn.3pm
> > Net::NNTP.3pm
> > Net::Netrc.3pm
> > Net::POP3.3pm
> > Net::Ping.3pm
> > Net::SMTP.3pm
> > Net::Time.3pm
> > Net::hostent.3pm
> > Net::libnetFAQ.3pm
> > Net::netent.3pm
> > Net::protoent.3pm
> > Net::servent.3pm
> > O.3pm
> > Opcode.3pm
> > POSIX.3pm
> > PerlIO.3pm
> > PerlIO::encoding.3pm
> > PerlIO::scalar.3pm
> > PerlIO::via.3pm
> > PerlIO::via::QuotedPrint.3pm
> > Pod::Checker.3pm
> > Pod::Find.3pm
> > Pod::Html.3pm
> > Pod::InputObjects.3pm
> > Pod::LaTeX.3pm
> > Pod::Man.3pm
> > Pod::ParseLink.3pm
> > Pod::ParseUtils.3pm
> > Pod::Parser.3pm
> > Pod::Plainer.3pm
> > Pod::Select.3pm
> > Pod::Text.3pm
> > Pod::Text::Color.3pm
> > Pod::Text::Overstrike.3pm
> > Pod::Text::Termcap.3pm
> > Pod::Usage.3pm
> > SDBM_File.3pm
> > Safe.3pm
> > Scalar::Util.3pm
> > Search::Dict.3pm
> > SelectSaver.3pm
> > SelfLoader.3pm
> > Shell.3pm
> > Socket.3pm
> > Storable.3pm
> > Switch.3pm
> > Symbol.3pm
> > Sys::Hostname.3pm
> > Sys::Syslog.3pm
> > Term::ANSIColor.3pm
> > Term::Cap.3pm
> > Term::Complete.3pm
> > Term::ReadLine.3pm
> > Test.3pm
> > Test::Builder.3pm
> > Test::Harness.3pm
> > Test::Harness::Assert.3pm
> > Test::Harness::Iterator.3pm
> > Test::Harness::Straps.3pm
> > Test::More.3pm
> > Test::Simple.3pm
> > Test::Tutorial.3pm
> > Text::Abbrev.3pm
> > Text::Balanced.3pm
> > Text::ParseWords.3pm
> > Text::Soundex.3pm
> > Text::Tabs.3pm
> > Text::Wrap.3pm
> > Thread.3pm
> > Thread::Queue.3pm
> > Thread::Semaphore.3pm
> > Tie::Array.3pm
> > Tie::File.3pm
> > Tie::Handle.3pm
> > Tie::Hash.3pm
> > Tie::Memoize.3pm
> > Tie::RefHash.3pm
> > Tie::Scalar.3pm
> > Tie::SubstrHash.3pm
> > Time::HiRes.3pm
> > Time::Local.3pm
> > Time::gmtime.3pm
> > Time::localtime.3pm
> > Time::tm.3pm
> > UNIVERSAL.3pm
> > Unicode::Collate.3pm
> > Unicode::Normalize.3pm
> > Unicode::UCD.3pm
> > User::grent.3pm
> > User::pwent.3pm
> > Win32.3pm
> > XS::APItest.3pm
> > XS::Typemap.3pm
> > XSLoader.3pm
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Martin Schlemmer


