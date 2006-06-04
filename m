Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWFDE5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWFDE5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jun 2006 00:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWFDE5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 00:57:33 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:31723 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751473AbWFDE5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 00:57:33 -0400
Date: Sun, 4 Jun 2006 00:54:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG: unable to handle kernel paging request at virtual
  address feededed
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Kara <jack@suse.cz>, Jeff Mahoney <jeffm@suse.com>,
       Alexander Zarochentzev <zam@namesys.com>
Message-ID: <200606040056_MC3-1-C18D-69ED@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0605301132180.5623@g5.osdl.org>

On Tue, 30 May 2006 11:44:03 -0700, Linus Torvalds wrote:

> On Sun, 28 May 2006, Tomasz Torcz wrote:
> >
> >   After 2 days and few hours uptime, during updatedb run I got:
> > 
> > BUG: unable to handle kernel paging request at virtual address feededed
> 
> Looks like one of the magic numbers ("0xfee1dead", "0xfeedbeef", 
> 0xfeedface"), but that's not it.
> 
> >  It never happened before. d_splice_alias in bt is very strange, as I don't
> > think anything on my system uses splice(). It's too new, and my system is
> > Slackware -current (which seems to return ENOSUPORTED even for old stuff
> > like posix_fadvise()).
> 
> No, d_splice_alias() is a different kind of splicing: it splices a dentry 
> entry into the alias list.

Oops happened here:

static struct dentry * __d_find_alias(struct inode *inode, int want_discon)
{
        struct list_head *head, *next, *tmp;
        struct dentry *alias, *discon_alias=NULL;

        head = &inode->i_dentry;
        next = inode->i_dentry.next;
        while (next != head) {
                tmp = next;
====>           next = tmp->next;
                prefetch(next);


tmp contained 0xfeededed, which was an invalid kernel address.

So while walking the dentry list for the inode, an invalid next pointer was
found, and it wasn't the very first one, i.e. it wasn't from the head
(if it were, then eax and ebp would be identical.)

want_discon (arg 2) was 1


Original oops message:

BUG: unable to handle kernel paging request at virtual address feededed
 printing eip:
c0160fb1
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: mga drm ipv6 sha256 dm_crypt binfmt_misc uhci_hcd i2c_nforce2 eth1394 ohci_hcd ehci_hcd forcedeth snd_intel8x0 snd_ac97_codec snd_ac97_bus sata_nv ohci1394 ieee1394 tuner tvaudio bttv video_buf firmware_class ir_common btcx_risc tv
CPU:    0
EIP:    0060:[<c0160fb1>]    Not tainted VLI
EFLAGS: 00010206   (2.6.17-rc5 #63)
EIP is at __d_find_alias+0x1c/0xa2
eax: 00008000   ebx: feededed   ecx: feededed   edx: cfe98954
esi: cde98918   edi: cde98918   ebp: cfe9893c   esp: c4d27d10
ds: 007b   es: 007b   ss: 0068
Process updatedb (pid: 18083, threadinfo=c4d27000 task=d92b7570)
Stack: 00000001 cfe9893c dc3ed190 00000000 d509e42c c0161825 00000001 c4d27d3c
       cfe9893c c0180050 dc3ed190 00000001 00000000 00000000 00000000 00000000
       00000000 df4d39f4 00000000 df4d39c4 00000070 c66b8154 00000003 c599e784
Call Trace:
 <c0161825> d_splice_alias+0x17/0x86  <c0180050> reiserfs_lookup+0xe2/0xf1
 <c01597a3> real_lookup+0x53/0xad  <c01599c0> do_lookup+0x49/0x78
 <c015a00c> __link_path_walk+0x61d/0x9d6  <c0191d9b> pathrelse+0x1b/0x26
 <c0188909> reiserfs_readdir+0x3db/0x3ea  <c015a406> link_path_walk+0x41/0xaa
 <c01de7cc> strncpy_from_user+0x2d/0x4c  <c015a770> do_path_lookup+0x199/0x1e4
 <c015a9cb> __user_walk_fd+0x29/0x3a  <c0156448> vfs_lstat_fd+0x12/0x39
 <c01569d4> sys_lstat64+0xf/0x23  <c0102933> syscall_call+0x7/0xb
Code: 89 50 04 89 02 89 5b 04 89 59 24 5b 89 c8 c3 55 89 c5 57 56 31 f6 53 51 89 14 24 8b 48 18 8d 50 18 39 d1 0f 84 80 00 00 00 89 cb <8b> 09 0f 18 01 90 0f b7 45 28 8d 7b c4 25 00 f0 00 00 3d 00 40

   f:   55                        push   %ebp
  10:   89 c5                     mov    %eax,%ebp
  12:   57                        push   %edi
  13:   56                        push   %esi
  14:   31 f6                     xor    %esi,%esi
  16:   53                        push   %ebx
  17:   51                        push   %ecx
  18:   89 14 24                  mov    %edx,(%esp)
  1b:   8b 48 18                  mov    0x18(%eax),%ecx
  1e:   8d 50 18                  lea    0x18(%eax),%edx
  21:   39 d1                     cmp    %edx,%ecx
  23:   0f 84 80 00 00 00         je     a9 <_EIP+0xa9>
  29:   89 cb                     mov    %ecx,%ebx
00000000 <_EIP>:
   0:   8b 09                     mov    (%ecx),%ecx   <=====
   2:   0f 18 01                  prefetchnta (%ecx)
   5:   90                        nop
   6:   0f b7 45 28               movzwl 0x28(%ebp),%eax
   a:   8d 7b c4                  lea    0xffffffc4(%ebx),%edi
   d:   25 00 f0 00 00            and    $0xf000,%eax


> I don't see anything suspicious anywhere, and this doesn't ring a bell. 
> It is probably a good idea to open a bugzilla entry on it, so that it 
> doesn't get lost. And perhaps cc the reiserfs people (there's been a few 
> reiserfs changes since 2.6.16, but none of them looks suspicious to me: 
> however, maybe this makes somebody else go "Aaah!").
> 
> Try Jan Kara <jack@suse.cz>, Jeff Mahoney <jeffm@suse.com> and 
> Alexander Zarochentzev <zam@namesys.com>.

-- 
Chuck
