Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUDELrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 07:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUDELrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 07:47:13 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:28833 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S262052AbUDELrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 07:47:06 -0400
Date: Mon, 5 Apr 2004 13:46:50 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Marco Fais <marco.fais@abbeynet.it>
Cc: Marco Roeland <marco.roeland@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040405114650.GA16079@localhost>
References: <406D3E8F.20902@abbeynet.it> <20040402131551.GA10920@localhost> <6.0.0.22.2.20040402163334.02abe7d8@pop.localnet> <20040402150535.GA13340@localhost> <407137FD.3040407@abbeynet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <407137FD.3040407@abbeynet.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday April 5th 2004 Marco Fais wrote:

> I was not saying *this is the problem*, just noticing that all the 
> systems that show this problem have this network card, while the other 
> systems that are working perfectly are using other network hardware 
> (e100 driver) :)

Yes, my conclusion was too hasty, it *is* driver related! ;-)

With hindsight we also should have tried, of course, a 'strace distccd
--no-detach' in a crashing and a non-crashing situation. This would
probably have shown that 'sendfile()' was the first missing system call
(and therefore likely the culprit) in the crashing situation. Oh, well...
 
> If you read Andrew's message, seems that distcc uses a function that 
> trigger the problem -- sendfile() -- so, if netcat doesn't use it, it's 
> clear why doesn't panic the kernel.

Yes, sendfile() in combination with the 8139too driver seems to be
causing the trouble. Until that will hopefully be fixed, it doesn't seem
easy to workaround against. At the moment it looks like it is not an
easy configurable option to *not* want to use zero_copy functionality,
either in the kernel, nor in distcc.

There is an '8139cp' driver too, it's supposed to be working better
as well, perhaps that one might not free the pages that are to be
zero_copied across the network before they are sent?! That is the real
problem if I understand Andrew's mail correctly.

You might send a 'linux 8139too sendfile() panic' kind of bugreport
to the 'netdev@oss.sgi.com' mailing list. That is the list where the
networking gurus are supposed to be hanging out. Although IMVHO this bug
is more on the kernel than on the network side. Also filing an entry to
bugzilla.kernel.org might speed up someone fixing the real problem.

Easiest workaround might be to just use a customised distcc for the
machines involved: just download the source from 'distcc.samba.org', do
a regular './configure', and then in the generated 'src/config.h' hand
edit '#undef HAVE_SENDFILE' and '#undef HAVE_SYS_SENDFILE_H'. That
should stop distcc from using sendfile().
-- 
Marco Roeland
