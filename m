Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318191AbSHZSnJ>; Mon, 26 Aug 2002 14:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318194AbSHZSnI>; Mon, 26 Aug 2002 14:43:08 -0400
Received: from pat.uio.no ([129.240.130.16]:58556 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318191AbSHZSnI>;
	Mon, 26 Aug 2002 14:43:08 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
References: <Pine.LNX.4.44.0208260855480.3234-100000@hawkeye.luckynet.adm>
	<1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 26 Aug 2002 20:47:02 +0200
In-Reply-To: <1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
Message-ID: <shs4rdho3tl.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > On Mon, 2002-08-26 at 15:58, Thunder from the hill wrote:
    >> I personally like the task->cred->cr_uid, etc. approach. Helps
    >> a lot.

     > It changes the whole semantics of every security test in Linux,
     > and breaks most of them totally. Our syscalls know the uid is
     > constant during the call

Right. Most people appear to prefer to make a lunge straight for
CLONE_CRED.

One of the first steps should rather be to build up support for a
copy-on-write BSD-style 'ucred' struct that can be passed around the
VFS.
Without the latter there is no way to ensure that the compound VFS
operations such as, say, lookup(), followed by a call to permission()
followed by a call to dentry_open(), ->readpage(), etc. all use the
same creds. This they *have* to do irrespective of whether or not the
process is using CLONE_CRED, or you might end up using one set of
privileges for the security checks and a different set for the actual
file/device ops...

Once those VFS changes have been done and audited, then one can start
to add support for 'pcreds' a.k.a. process credentials and then
finally CLONE_CRED...

Cheers,
  Trond
