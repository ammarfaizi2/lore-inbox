Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSCSSYf>; Tue, 19 Mar 2002 13:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSCSSY0>; Tue, 19 Mar 2002 13:24:26 -0500
Received: from morrison.empeg.co.uk ([193.119.19.130]:59887 "EHLO
	fatboy.internal.empeg.com") by vger.kernel.org with ESMTP
	id <S288953AbSCSSYR>; Tue, 19 Mar 2002 13:24:17 -0500
Message-ID: <008301c1cf72$ce5801a0$2701230a@electronic>
From: "Peter Hartley" <pdh@utter.chaos.org.uk>
To: "Andreas Dilger" <adilger@clusterfs.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <006701c1cf6d$d9701230$2701230a@electronic> <20020319141554.GL470@turbolinux.com>
Subject: Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
Date: Tue, 19 Mar 2002 18:20:53 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Mar 19, 2002  17:45 -0000, Peter Hartley wrote:
> > In particular, this means that an e2fsck 1.27 built against such a glibc
> > will fail with SIGXFS every time on any block device bigger than
2Gbytes.
> > This is because:
> >
> >  * e2fsck calls setrlimit(RLIMIT_FSIZE, RLIM_INFINITY) in
> >    an attempt to unset the limit. RLIM_INFINITY here is
> >    0xFFFFFFFF. This is IMO the Right Thing.
>
> It is only the right thing if the original limit was not 0xFFFFFFFF.
> Otherwise, it is just adding to the problem, because the problem only
> happens when you try to SET the limit.

True. (Old programs *will* perceive the value as 0xFFFFFFFF if it is
RLIM_INFINITY; the kernel clips it to 0x7FFFFFFF in sys_old_getrlimit() but
glibc expands it again in __new_getrlimit().)

> > Surely the only Right Things to do in the kernel are (a) invent a new
> > setrlimit call that corrects the RLIM_INFINITY value, or (b) have the
> > current setrlimit call correct the RLIM_INFINITY value unconditionally.
>
> (c) rlimit should not apply to block devices.
>
> There were patches for this floating around, and I thought they made it
> into 2.4.18, but they did not.

Looking a bit closer at the particular SIGXFS that kills fsck (in
generic_file_write) there's some S_ISBLK stuff going on just below.

Is the fix just as simple as: (untested) (and with a mailer than mangles
tabs)

--- filemap.c~ Mon Feb 25 19:38:13 2002
+++ filemap.c Tue Mar 19 18:20:40 2002
@@ -2885,9 +2885,9 @@
   * Check whether we've reached the file size limit.
   */
  err = -EFBIG;

- if (limit != RLIM_INFINITY) {
+ if (limit != RLIM_INFINITY && !S_ISBLK(inode->i_mode)) {
   if (pos >= limit) {
    send_sig(SIGXFSZ, current, 0);
    goto out;
   }

All this rlimit stuff is a bit wonky in the presence of 64-bit file sizes
anyway. Perhaps if we fix just the block-device case we can brush the rest
under the carpet?

        Peter


