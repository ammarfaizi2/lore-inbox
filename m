Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWAEBsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWAEBsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWAEBsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:48:54 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:44770 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1751154AbWAEBsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:48:54 -0500
Date: Wed, 4 Jan 2006 17:48:35 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect remove_proc_entry
Message-ID: <20060105014835.GB84622@gaz.sfgoth.com>
References: <1135973075.6039.63.camel@localhost.localdomain> <1135978110.6039.81.camel@localhost.localdomain> <20051230215544.GI27284@gaz.sfgoth.com> <1135980542.6039.84.camel@localhost.localdomain> <1135981124.6039.90.camel@localhost.localdomain> <20060104012105.64e0e5cf.akpm@osdl.org> <Pine.LNX.4.58.0601040716190.3052@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601040716190.3052@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Wed, 04 Jan 2006 17:48:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> > I guess the lock_kernel() approach is the way to go.  Fixing a race and
> > de-BKLing procfs are separate exercises...
> >
> > Did the patch work?
> 
> Sorry, I forgot to respond, because the test is still running ;)
> 
> So yes, it not only ran for three days, it ran for six. I just killed it.

Have you looked at the other paths that touch ->subdir?  Namely:
  proc_devtree.c:
    proc_device_tree_add_node() -- plays games with ->subdir directly
  generic.c:
    proc_create() -- calls xlate_proc_name() which touches ->subdir and
      should therefore probably be called under BKL
    proc_register() -- both the call to xlate_proc_name() and the
      following accesses to ->subdir should be under BKL

-Mitch
