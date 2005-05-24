Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVEXSQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVEXSQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVEXSQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:16:34 -0400
Received: from mail.shareable.org ([81.29.64.88]:55515 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261425AbVEXSQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:16:22 -0400
Date: Tue, 24 May 2005 19:15:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mike Waychison <mikew@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
Message-ID: <20050524181554.GA13760@mail.shareable.org>
References: <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com> <E1DaVYK-0003ko-00@dorka.pomaz.szeredi.hu> <4293612F.3000708@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4293612F.3000708@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> >No need to hijack, it's already done.  Removing calls to
> >proc_check_root() will allow access to different namespaces detached
> >mounts, etc.  It's been tried and actually works.
> 
> See previous message as why we don't want to allow this.

If you can ptrace any process which is in another namespace, then you
_effectively_ have full access to that namespace.  It's quite easy to
do, and negates the supposed security of namespaces.

Because of that, there's _no_ real security benefit from denying
access to /proc/NNN/fd/ if you are able to ptrace task NNN.

What I think makes sense is this:

   1. Deny access to /proc/NNN/fd/, /proc/NNN/cwd, /proc/NNN/root
      if task NNN cannot be ptraced.

   3. Allow entry to /proc/NNN/fd/, /proc/NNN/cwd, /proc/NNN/root
      if ptrace is allowed; the namespace being irrelevant.

   3. Use _exactly_ the same condition as for ptracing,
      i.e. MAY_PTRACE in fs/proc/base.c.  Ensure that condition is
      consistent with the tests in kernel/ptrace.c, possibly putting
      the condition in a common header file to keep it consistent in
      future.

   4. If further restrictions are desired, to make namespaces more
      strict, those should be implemented by further restrictions on
      which tasks are allowed to ptrace other tasks.

-- Jamie
