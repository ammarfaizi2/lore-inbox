Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTJJNq0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTJJNq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:46:26 -0400
Received: from pat.uio.no ([129.240.130.16]:8171 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262068AbTJJNqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:46:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16262.47147.943477.24070@charged.uio.no>
Date: Fri, 10 Oct 2003 09:46:19 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <20031010123732.GA28224@mail.shareable.org>
References: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
	<3F85ED01.8020207@redhat.com>
	<20031010002248.GE7665@parcelfarce.linux.theplanet.co.uk>
	<20031010044909.GB26379@mail.shareable.org>
	<16262.17185.757790.524584@charged.uio.no>
	<20031010123732.GA28224@mail.shareable.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jamie Lokier <jamie@shareable.org> writes:

     > Trond Myklebust wrote:
    >> Belongs in fcntl()... Just return ENOLCK if someone tries to
    >> set a lease or a directory notification on an NFS file...

     > It should be a filesystem hook, so that even remote filesystems
     > like SMB can implement it, although it must be understood that
     > remote notification has different ordering properties than
     > local.

Sure. We might even try actually implementing leases on NFSv4 for
delegated files.

     > I don't care about the cache semantics at all; what I care
     > about is whether a returned stat() result may be stale.

Note that this too may be a per-file property. Under NFSv4 I can
guarantee you that stat() results are correct in the case where I have
a delegation. Otherwise, you are indeed subject to inherent races.
"noac" cannot entirely resolve such races, but it sounds as if it
could in the particular cases you describe.

     > This is not ideal.  In particular, I don't know of any way to
     > _guarantee_ that I have the latest file contents from remote
     > filesystems short of F_SETLK, which way too heavy.[2]

Err... open() should normally suffice to do that...

Unless you are simultaneously writing to the file on a remote system,
in which case you really need mandatory locking rather than NFSv2/v3's
weaker advisory model. Or possibly something like CIFS/SMB's open
"share" model (which can also be implemented in NFSv4).



...so I would argue that the caching models both can and do make a
difference to your example cases (contrary to what you assert).

Cheers,
  Trond
