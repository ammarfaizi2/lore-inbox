Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUIETqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUIETqi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUIETqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:46:02 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:40345 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267186AbUIETpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:45:05 -0400
From: Borislav Petkov <bbpetkov@yahoo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: voluntary-preempt-2.6.7-vanilla-H4 function sleeps inside a spinlock, SOLVED?
Date: Sun, 5 Sep 2004 21:15:40 +0200
User-Agent: KMail/1.7
References: <200409051653.02355.bbpetkov@yahoo.de>
In-Reply-To: <200409051653.02355.bbpetkov@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1794317.mIN1tSaY3f";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409052115.44361.bbpetkov@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1794317.mIN1tSaY3f
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 05 September 2004 16:52, you wrote:
> Hi,
>
> I've applied the patch in the subject line and everything was running fine
> for several  but today day, during heavy hd activity, i got the following:
>
> Sep  5 16:34:13 gollum kernel: Debug: sleeping function called from inval=
id
> context pdflush(41) at fs/inode.c:245
> Sep  5 16:34:13 gollum kernel: in_atomic():1, irqs_disabled():0
> Sep  5 16:34:13 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
> Sep  5 16:34:13 gollum kernel:  [__might_sleep+205/256]
> __might_sleep+0xcd/0x100
> Sep  5 16:34:13 gollum kernel:  [clear_inode+31/240] clear_inode+0x1f/0xf0
> Sep  5 16:34:13 gollum kernel:  [generic_delete_inode+206/768]
> generic_delete_inode+0xce/0x300
> Sep  5 16:34:13 gollum kernel:  [iput+100/144] iput+0x64/0x90
> Sep  5 16:34:13 gollum kernel:  [dput+554/1840] dput+0x22a/0x730
> Sep  5 16:34:13 gollum kernel:  [release_task+548/880]
> release_task+0x224/0x370
> Sep  5 16:34:13 gollum kernel:  [do_exit+1369/2528] do_exit+0x559/0x9e0
> Sep  5 16:34:13 gollum kernel:  [kernel_thread_helper+11/16]
> kernel_thread_helper+0xb/0x10
> Sep  5 16:34:13 gollum kernel:
> Sep  5 16:34:50 gollum kernel: Debug: sleeping function called from inval=
id
> context pdflush(42) at fs/inode.c:245
> Sep  5 16:34:50 gollum kernel: in_atomic():1, irqs_disabled():0
> Sep  5 16:34:50 gollum kernel:  [dump_stack+30/48] dump_stack+0x1e/0x30
> Sep  5 16:34:50 gollum kernel:  [__might_sleep+205/256]
> __might_sleep+0xcd/0x100
> Sep  5 16:34:50 gollum kernel:  [clear_inode+31/240] clear_inode+0x1f/0xf0
> Sep  5 16:34:50 gollum kernel:  [generic_delete_inode+206/768]
> generic_delete_inode+0xce/0x300
> Sep  5 16:34:50 gollum kernel:  [iput+100/144] iput+0x64/0x90
> Sep  5 16:34:50 gollum kernel:  [dput+554/1840] dput+0x22a/0x730
> Sep  5 16:34:50 gollum kernel:  [release_task+548/880]
> release_task+0x224/0x370
> Sep  5 16:34:50 gollum kernel:  [do_exit+1369/2528] do_exit+0x559/0x9e0
> Sep  5 16:34:50 gollum kernel:  [kernel_thread_helper+11/16]
> kernel_thread_helper+0xb/0x10
> Sep  5 16:34:50 gollum kernel:
>
> I have also several ACPI patches applied but I think this is
> unrelated. .config attached.
>
> Regards,
> Boris.

Ok, since I'm no expert I went for the obvious solution and removed the=20
preemption point in fs/inode.c,245:

void clear_inode(struct inode *inode)
{
    /* might_sleep(); */
    invalidate_inode_buffers(inode);

    if (inode->i_data.nrpages)

However, maybe a more elegant solution would be preferrable. In addition, I=
=20
don't see the same preemption point in the latest patch - =20
voluntary-preempt-2.6.9-rc1-bk4-R4.patch.

Regards,
Boris.

--nextPart1794317.mIN1tSaY3f
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBO2XgQ6NBq1iMuxERAiVdAKCkXQ8129PpgC6GpsvhopWOC/gsXgCfVX0m
LCEABNUNm+2D+tUYTJOeX5Q=
=Sp10
-----END PGP SIGNATURE-----

--nextPart1794317.mIN1tSaY3f--
