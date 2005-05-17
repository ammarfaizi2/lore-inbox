Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVEQXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVEQXbw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVEQXb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:31:29 -0400
Received: from [195.23.16.24] ([195.23.16.24]:30601 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261970AbVEQX3q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:29:46 -0400
Message-ID: <1116372428.428a7dccec930@webmail.grupopie.com>
Date: Wed, 18 May 2005 00:27:08 +0100
From: "" <pmarques@grupopie.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_KALLSYMS_EXTRA_PASS
References: <1116365006.9737.42.camel@localhost.localdomain>
In-Reply-To: <1116365006.9737.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.142.236
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt <rostedt@goodmis.org>:
> OK, I'm working on a custom kernel, and suddenly I'm getting the compile
> error "Try setting CONFIG_KALLSYMS_EXTRA_PASS".  I've also just did a
> debian update, but that doesn't seem to bother the vanilla kernel.

This is probably the same problem that me and other people are having.

It seems that sometimes the symbol that marks the end of a section changes
position with the symbol that marks the beggining of the next section if they
happen to on the same address (they might be on different addresses due to
alignment issues).

In this case the compression algorithm might produce different compression
ratios and the kallsyms compressed data changes size.

You can try the very crude (but effective) way to check if this is your problem
or not. Go to scripts/kallsyms.c and change:

#define WORKING_SET             1024

to:

#define WORKING_SET             65536

This will force kallsyms to use *all* the symbols for the compression, and the
size of the result won't be affected by the symbol positions.

Don't forget to turn off KALLSYMS_EXTRA_PASS to test this.

If this turns out to be the problem _again_, I'll post a patch to fix this for
good by storing the token data from the first pass and use it on the second
pass. This will not only speed up compression, it will also guarantee that this
kind of problems will never bite us again.

--
Paulo Marques

