Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbUL0UXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUL0UXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUL0UXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:23:07 -0500
Received: from havoc.gtf.org ([63.115.148.101]:35489 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261975AbUL0UXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:23:01 -0500
Date: Mon, 27 Dec 2004 15:22:58 -0500
From: David Eger <eger@havoc.gtf.org>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to understand flow of kernel code
Message-ID: <20041227202258.GA530@havoc.gtf.org>
References: <41AE9E3E.9020307@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AE9E3E.9020307@globaledgesoft.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more bizarre details of kernel initialization is in
do_initcalls().  It's one of the last things in the initialization
sequence that you see code for, and it does some odd function-pointer
table assembly hackery.  You don't actually see a list of the functions
that do_initcalls() calls because *it's generated at compile time*.
Each module/filesystem/arch/etc can register an initialization function
with the build system through a declaration like the following in
"binfmt_elf.c":

core_initcall(init_elf_binfmt);

This macro is defined in init.h, along with several others:

#define core_initcall(fn)               __define_initcall("1",fn)
#define postcore_initcall(fn)           __define_initcall("2",fn)
#define arch_initcall(fn)               __define_initcall("3",fn)
#define subsys_initcall(fn)             __define_initcall("4",fn)
#define fs_initcall(fn)                 __define_initcall("5",fn)
#define device_initcall(fn)             __define_initcall("6",fn)
#define late_initcall(fn)               __define_initcall("7",fn)

When the build system is done building all the files, it gathers together
all of the special initcall declarations and links them into one table:
the one that do_initcalls() iterates over.

-dte
