Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267982AbUGaRtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267982AbUGaRtl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267981AbUGaRtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:49:41 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:45224 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S267982AbUGaRtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:49:39 -0400
Subject: Re: uid of user who mounts
From: Steve French <smfrench@austin.rr.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1Bqxhg-0004pi-00@dorka.pomaz.szeredi.hu>
References: <1091239509.3894.11.camel@smfhome.smfdom>
	 <20040730190825.7a447429.rddunlap@osdl.org>
	 <1091244841.2742.8.camel@smfhome1.smfdom>
	 <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu>
	 <1091287308.2337.6.camel@smfhome.smfdom>
	 <E1Bqxhg-0004pi-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Message-Id: <1091296185.2856.11.camel@smfhome1.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Sat, 31 Jul 2004 12:49:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 19:31 +0200, Miklos Szeredi wrote:
> Steve French wrote:
> >
> > I confirmed what Randy had mantioned about the user= entries in mtab
> > allowing umounts (at least it works that way for a few of the local
> > filesystems I tried) but did not seem to work so well on other
> > filesystems - I had odd results on umounting my cifs mounts e.g. - after
> > adding at mount time "user=someuser" to /etc/mtab (by a minor change to
> > the mount helper mount.cifs.c, when running mount.cifs suid).  umount of
> > those mounts failed
> 
> I've seen failure to unmount only if there is no matching entry in
> /etc/fstab.  It sounds a bit too much paranoia, but who knows.
> 
> Miklos

This is getting hard to debug because the mount and umount that ship
with Fedora doesn't match the behavior of mount & umount current source
on kernel.org for the mount utils.  What I have discovered so far is
that the failure in unmount is the check in sys_umount in fs/namespace.c

        if (!capable(CAP_SYS_ADMIN))

which fails presumably because mount did not find a match in /etc/fstab
although I have tried various experiments and it looks like the umount
should have matched the /etc/mtab entry.  My guess is that the matching
rules don't work very well for filesystems unless they specify either a
physical device or name (I had been specifying a UNC name as the device,
but am experimenting with having cifs use the nfs server:export format
to see if that will make umount happier).

