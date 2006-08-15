Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965322AbWHOJOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322AbWHOJOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965321AbWHOJOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:14:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:11744 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965318AbWHOJOC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:14:02 -0400
Date: Tue, 15 Aug 2006 10:13:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Josh Boyer <jwboyer@gmail.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] Use 64-bit inode numbers internally in the kernel
Message-ID: <20060815091358.GW29920@ftp.linux.org.uk>
References: <625fc13d0608141736q50dea86dh94cdf4ef19fe56d9@mail.gmail.com> <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <7329.1155630113@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7329.1155630113@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:21:53AM +0100, David Howells wrote:
> Josh Boyer <jwboyer@gmail.com> wrote:
> 
> > Out of curiosity, is there a performance hit for 32-bit systems?  Have
> > you done any minimal benchmarks to see?
> 
> Yes, I'm sure there is, but we're talking performance vs correctness.

ITYM performance vs. slightly different patch.  Let me put all pieces
in one place:
	* kstat gets u64 ino
	* filesystems that want to report 64bit st_ino do it in their
->getattr(); the rest is unchanged.
	* ino_t is left as-is
	* filldir() callbacks get u64 ino in arguments.  Filesystem may
pass 64bit value if it cares to; otherwise it's left unchanged.
	* filesystem that wants unusual search key can use iget5() (as
it can do right now)
	* filesystem that wants to use the values it'd put into st_ino in
its printks should use appropriate format
	* any printk in generic code that happens to use i_ino should
be hunted down and shot for utter uselessness for too many filesystems
(not sure if we actually _have_ any such printk these days).
