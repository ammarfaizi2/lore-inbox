Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318891AbSH1S1R>; Wed, 28 Aug 2002 14:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSH1S1Q>; Wed, 28 Aug 2002 14:27:16 -0400
Received: from pat.uio.no ([129.240.130.16]:42884 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318626AbSH1S0i>;
	Wed, 28 Aug 2002 14:26:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15725.5853.229315.140365@charged.uio.no>
Date: Wed, 28 Aug 2002 20:30:53 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
In-Reply-To: <19220000.1030544663@baldur.austin.ibm.com>
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
	<shsvg5wqemp.fsf@charged.uio.no>
	<20020827200110.GB8985@tapu.f00f.org>
	<200208280009.03090.trond.myklebust@fys.uio.no>
	<19220000.1030544663@baldur.austin.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

     > Shouldn't the Linux cred structure include the capabilities, as
     > well?  What about places that want to see both uid and euid?
     > Shouldn't euid/egid also be in the structure?  I realize that
     > for file operations they're not strictly necessary, but we
     > should make the structure useful across all parts of the kernel
     > that want to see credentials.

The BSD approach is to split out the user credentials, since they are
used all over the place in the filesystems, and often need to be
cached. The uid, euid, ... are kept in a reference-counted 'process'
credential of the form

struct pcred {
       struct ucred *ucred;
       uid_t uid, euid, suid;
       gid_t gid, egid, sgid;
       int count;
};

In Linux, we should probably also include the capabilities as part of
the pcred. They sort of fall outside the BSD model, so it's hard to
tell exactly where they belong...
That said, I'm motivated to move away from thinking that they belong
in the ucred, by the fact that capabilities contain information about
whether or not you are allowed to change those user credentials. That
just doesn't fit with the idea of copy on write.

     > BTW, you've convinced me that your approach is the right way to
     > go.  I'll make another stab at CLONE_CRED after the VFS changes
     > are made, which will make it a 2.7 item, I'm sure.

Great. As I said, I've resumed working on the ucred stuff. Expect the
first patches to be announced for 2.5.x soon. The first few patches
are ready, I just need to test them with a post-2.5.32 kernel (as soon
as I find one that will actually boot on my laptop even without the
patches applied).

Note: If you'd like to take a peek at what I've got (and help me with
some feedback), see the directory

  http://www.fys.uio.no/~trondmy/src/2.5.32-alpha

Cheers,
  Trond
