Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTGHRoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265073AbTGHRoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:44:54 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:52745 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265062AbTGHRox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:44:53 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined patch
Date: Tue, 8 Jul 2003 21:49:17 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, devfs@oss.sgi.com
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru> <200307072306.15995.arvidjaar@mail.ru> <20030707140010.4268159f.akpm@osdl.org>
In-Reply-To: <20030707140010.4268159f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307082149.17918.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 July 2003 01:00, Andrew Morton wrote:
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> > I finally hit a painfully trivial way to reproduce another long standing
> > devfs problem - deadlock between devfs_lookup and
> > devfs_d_revalidate_wait.
>
> uh.
>
> > The current fix is to move re-acquire of i_sem after all
> > devfs_d_revalidate_wait waiters have been waked up.
>
> Directory modifications appear to be under write_lock(&dir->u.dir.lock); so
> that obvious problem is covered.  Your patch might introduce a race around
> _devfs_get_vfs_inode() - two CPUs running that against the same inode at
> the same time?
>

Actually it just makes it marginally more probable.

Normal open without O_CREATE runs ->d_revalidate outside of i_sem i.e. neither 
devfs_lookup vs. devfs_d_revalidate_wait nor devfs_d_revalidate_wait vs. 
itself are protected  by i_sem and this is (should be) the most common case 
for /dev access.

This race happens under non-trivial conditions. devfsd descendant (i.e. some 
action) should be involved; and action triggered by devfs_lookup does not 
race with it by definition because devfs_lookup waits for action to finish. 
I.e. it needs another devfsd action that would access /dev entry after it 
just has been created or two concurrent lookups in LOOKUP action itself. 
Quite unlikely in real life and race window is very small.

I do not want to sound like it has to be ignored - but devfs code is so messy 
that no trivial fix exists that would not make code even more messy. So I 
would still apply original fixes and let this problem be solved later - it is 
not so important as to delay two other.

-andrey
