Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbUD0Eb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUD0Eb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUD0Eb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:31:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:36245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262049AbUD0Eb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:31:57 -0400
Date: Mon, 26 Apr 2004 21:31:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <408DC0E0.7090500@gmx.net>
Message-ID: <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org>
References: <408DC0E0.7090500@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Apr 2004, Carl-Daniel Hailfinger wrote:
> 
> LinuxAnt offers binary only modules without any sources. To circumvent our
> MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:
> 
> MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
> LICENSE file applies");

Hey, that is interesting in itself, since playing the above kinds of games
makes it pretty clear to everybody that any infringement was done
wilfully. They should be talking to their lawyers about things like that.

Anyway, I suspect that rather than blacklist bad people, I'd much prefer
to have the module tags be done as counted strings instead. It should be
easy enough to do by just having the macro prepend a "sizeof(xxxx)"  
thing or something.

Hmm. At least with -sdt=c99 it should be trivial, with something like

	#define __MODULE_INFO(tag, name, info)		\
	static struct { int len; const char value[] }	\
	__module_cat(name,__LINE__) __attribute_used__	\
	__attribute__((section(".modinfo"),unused)) =	\
		{ sizeof(__stringify(tag) "=" info),	\
		__stringify(tag) "=" info }

doing the job.

That should make it pretty easy to parse the .modinfo section too.

		Linus
